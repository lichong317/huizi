package com.ynyes.huizi.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserCashReward;
import com.ynyes.huizi.entity.TdUserPoint;

/**
 * 用于返利的公共方法
 * 
 * @author 作者：DengXiao
 * @version 创建时间：2016年4月23日下午1:14:38
 */
@Service
@Transactional
public class TdReturnCashService {

	@Autowired
	private TdUserService tdUserService;

	@Autowired
	private TdOrderService tdOrderService;

	@Autowired
	private TdSettingService tdSettingService;

	@Autowired
	private TdUserCashRewardService tdUserCashRewardService;

	@Autowired
	private TdGoodsService tdGoodsService;

	@Autowired
	private TdProductCategoryService tdProductCategoryService;

	@Autowired
	private TdUserPointService tdUserPointService;

	public void afterPaySuccess(TdOrder tdOrder) {
		if (null == tdOrder) {
			return;
		}

		// 用户
		TdUser tdUser = tdUserService.findByUsername(tdOrder.getUsername());

		if (null == tdUser) {
			return;
		}

		// 设置消费总额
		if (null != tdUser.getTotalSpendCash()) {
			tdUser.setTotalSpendCash(tdUser.getTotalSpendCash() + tdOrder.getTotalPrice());
		} else {
			tdUser.setTotalSpendCash(tdOrder.getTotalPrice());
		}

		// 设置抢购最后时间
		if (null != tdOrder.getTypeId() && tdOrder.getTypeId().equals(3L)) {
			Date nextTime = new Date();

			Calendar calendar = Calendar.getInstance();

			calendar.setTime(nextTime);

			calendar.add(Calendar.DATE, 30);

			tdUser.setLastFlashBuyTime(calendar.getTime());
			tdUser = tdUserService.save(tdUser);
		}

		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setPayTime(new Date()); // 设置付款时间
		}

		// 待发货
		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setStatusId(3L);
		}
		tdOrder = tdOrderService.save(tdOrder);

		// 分享用户

		// 分销用户返利（下级用户返利给上级用户）
		if (null != tdUser.getUpperUsername()) {
			TdUser tdUser2 = tdUserService.findByUsername(tdUser.getUpperUsername());
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation() && null != tdUser2
					&& null != tdUser2.getRoleId() && tdUser2.getRoleId().equals(1L)) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUpperUsername());
				tdUserCashReward.setRewardTime(new Date());

				Double reutrnPrice = this.countDistribution(tdOrder, tdUser2, tdSetting);

				// 返现金额分情况计算
				tdUserCashReward.setCashReward(reutrnPrice);

				if (null != tdUser.getTotalCashRewards()) {
					tdUserCashReward.setTotalCashReward((tdUser.getTotalCashRewards() + reutrnPrice));
				} else {
					tdUserCashReward.setTotalCashReward(reutrnPrice);

				}
				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				TdUser upperuser = tdUserService.findByUsername(tdUser.getUpperUsername());
				if (null != upperuser) {
					// 返现总笔数
					if (null != upperuser.getTotalCashRewardsNumber()) {
						upperuser.setTotalCashRewardsNumber(upperuser.getTotalCashRewardsNumber() + 1);
					} else {
						upperuser.setTotalCashRewardsNumber(1L);
					}

					// 返现金额
					if (null != upperuser.getTotalCashRewards()) {
						upperuser.setTotalCashRewards(upperuser.getTotalCashRewards() + reutrnPrice);
					} else {
						upperuser.setTotalCashRewards(reutrnPrice);
					}
				}

				tdUserService.save(upperuser);

				// 返现给上级用户总数
				if (null != tdUser.getTotalCashRewardsToUpuser()) {
					tdUser.setTotalCashRewardsToUpuser(tdUser.getTotalCashRewardsToUpuser() + reutrnPrice);
				} else {
					tdUser.setTotalCashRewardsToUpuser(reutrnPrice);
				}

				tdUserService.save(tdUser);
			}
		}

		// 分销用户自己返利
		if (null != tdUser.getRoleId() && tdUser.getRoleId().equals(1L)) {
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation()) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUsername());
				tdUserCashReward.setRewardTime(new Date());

				Double returnPrice = this.countDistribution(tdOrder, tdUser, tdSetting);

				// 返现金额分情况计算
				tdUserCashReward.setCashReward(returnPrice);

				if (null != tdUser.getTotalCashRewards()) {
					tdUserCashReward.setTotalCashReward(tdUser.getTotalCashRewards() + returnPrice);
				} else {
					tdUserCashReward.setTotalCashReward(returnPrice);
				}

				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				// TdUser upperuser =
				// tdUserService.findByUsername(tdUser.getUpperUsername());

				// 返现总笔数
				if (null != tdUser.getTotalCashRewardsNumber()) {
					tdUser.setTotalCashRewardsNumber(tdUser.getTotalCashRewardsNumber() + 1);
				} else {
					tdUser.setTotalCashRewardsNumber(1L);
				}

				// 返现金额
				if (null != tdUser.getTotalCashRewards()) {
					tdUser.setTotalCashRewards(tdUser.getTotalCashRewards() + returnPrice);
				} else {
					tdUser.setTotalCashRewards(returnPrice);
				}

				tdUserService.save(tdUser);

				// 返现给上级用户总数
				// if (null != tdUser.getTotalCashRewardsToUpuser()) {
				// tdUser.setTotalCashRewardsToUpuser((long)
				// (tdUser.getTotalCashRewardsToUpuser() + totalReturn));
				// }else {
				// tdUser.setTotalCashRewardsToUpuser((long) (totalReturn +
				// 0L));
				// }
				//
				// tdUserService.save(tdUser);
			}
		}

		// 直营会员给自己返利
		if (null != tdUser.getRoleId() && tdUser.getRoleId().equals(3L)) {
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation()) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUsername());
				tdUserCashReward.setRewardTime(new Date());

				Double returnPrice = this.countDirection(tdOrder, tdSetting);

				// 如果所有订单商品的类别返利比例都不为空 就用商品类别返利比例计算 返利总额 否则则用平台统一返利比例
				tdUserCashReward.setCashReward(returnPrice);

				if (null != tdUser.getDirectSaleCashRewards()) {
					tdUserCashReward.setTotalCashReward(returnPrice + tdUser.getDirectSaleCashRewards());

				} else {
					tdUserCashReward.setTotalCashReward(returnPrice);

				}

				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				// 返现总笔数
				if (null != tdUser.getTotalCashRewardsNumber()) {
					tdUser.setTotalCashRewardsNumber(tdUser.getTotalCashRewardsNumber() + 1);
				} else {
					tdUser.setTotalCashRewardsNumber(1L);
				}

				// 返现金额
				if (null != tdUser.getDirectSaleCashRewards()) {
					tdUser.setDirectSaleCashRewards(tdUser.getDirectSaleCashRewards() + returnPrice);

				} else {
					tdUser.setDirectSaleCashRewards(returnPrice);
				}

				tdUserService.save(tdUser);
			}
		}
	}

	/**
	 * 分销返利的方法
	 * 
	 * @author 作者：DengXiao
	 * @version 创建时间：2016年4月23日下午2:33:03
	 * @param
	 */
	private Double countDistribution(TdOrder order, TdUser user, TdSetting setting) {
		// 创建一个Double变量用于表示返现总数
		Double total = 0.00;

		// 创建一个Double变量用于表示返现比例
		Double point = 0.00;

		if (null != user.getReturnRation()) {
			point = user.getReturnRation();
		} else {
			point = setting.getReturnRation();
		}

		// 获取订单商品
		List<TdOrderGoods> orderGoodsList = order.getOrderGoodsList();

		if (null != orderGoodsList && orderGoodsList.size() > 0) {
			for (TdOrderGoods orderGoods : orderGoodsList) {
				Long goodsId = orderGoods.getGoodsId();
				Long quantity = orderGoods.getQuantity();
				Double price = orderGoods.getPrice();

				TdGoods goods = tdGoodsService.findOne(goodsId);

				Double returnPrice = goods.getReturnPrice();

				// 计算按照比例得到的返现金额
				Double pointReturn = price * quantity * point;
				if (null != returnPrice && pointReturn > (returnPrice * quantity)) {
					total += (returnPrice * quantity);
				} else {
					total += pointReturn;
				}
			}
		}

		if (total < 0) {
			total = 0.0;
		}
		return total;
	}

	/**
	 * 直营返利的方法
	 * 
	 * @author 作者：DengXiao
	 * @version 创建时间：2016年4月23日下午2:32:32
	 */
	private Double countDirection(TdOrder order, TdSetting setting) {
		// 创建一个Double变量用于表示返现总数
		Double total = 0.00;

		// 获取订单商品
		List<TdOrderGoods> orderGoodsList = order.getOrderGoodsList();

		if (null != orderGoodsList && orderGoodsList.size() > 0) {
			for (TdOrderGoods orderGoods : orderGoodsList) {
				Long goodsId = orderGoods.getGoodsId();
				Long quantity = orderGoods.getQuantity();
				Double price = orderGoods.getPrice();

				// 创建一个Double变量用于表示返利比例
				Double point = 0.00;

				TdGoods goods = tdGoodsService.findOne(goodsId);
				// 取第一级别类别的返利比例 后续可扩展至全类别
				TdProductCategory tdProductCategory = null; // 第一级别类别
				TdProductCategory tdProductCategorytemp = null;
				tdProductCategorytemp = tdProductCategoryService.findOne(goods.getCategoryId());
				if (null == tdProductCategorytemp.getParentId()) {
					tdProductCategory = tdProductCategorytemp;
				} else {
					tdProductCategorytemp = tdProductCategoryService.findOne(tdProductCategorytemp.getParentId());
					if (null == tdProductCategorytemp.getParentId()) {
						tdProductCategory = tdProductCategorytemp;
					} else {
						tdProductCategorytemp = tdProductCategoryService.findOne(tdProductCategorytemp.getParentId());
						if (null == tdProductCategorytemp.getParentId()) {
							tdProductCategory = tdProductCategorytemp;
						}
					}
				}

				if (null != tdProductCategory.getReturnRation()) {
					point = tdProductCategory.getReturnRation();
				} else {
					point = setting.getReturnRation();
				}

				Double pointReturn = price * quantity * point;

				Double returnPrice = goods.getReturnPrice();

				if (null != returnPrice && pointReturn > (returnPrice * quantity)) {
					total += (returnPrice * quantity);
				} else {
					total += pointReturn;
				}
			}
		}

		if (total < 0) {
			total = 0.0;
		}
		return total;
	}

	/**
	 * 扣除虚拟货币的方法
	 * 
	 * @author 作者：DengXiao
	 * @version 创建时间：2016年4月23日下午2:32:17
	 */
	public void costVirtual(TdOrder tdOrder, TdUser tdUser) {
		if (null != tdOrder.getVirtualCurrencyUse()) {
			Double virtualCurrencyUse = tdOrder.getVirtualCurrencyUse();
			Double totalGoodsPrice = tdOrder.getTotalGoodsPrice();
			Double couponUse = tdOrder.getCouponUse();
			Double fee = tdOrder.getDeliverTypeFee();

			if (null == virtualCurrencyUse) {
				virtualCurrencyUse = 0.00;
			}
			if (null == totalGoodsPrice) {
				totalGoodsPrice = 0.00;
			}
			if (null == couponUse) {
				couponUse = 0.00;
			}
			if (null == fee) {
				fee = 0.00;
			}
			if (virtualCurrencyUse > (totalGoodsPrice + fee - couponUse)) {
				tdOrder.setVirtualCurrencyUse(totalGoodsPrice - couponUse);
				tdOrder = tdOrderService.save(tdOrder);
			}
			if (null != tdUser.getRoleId()) {
				if (tdUser.getRoleId().equals(1L) && null != tdUser.getTotalCashRewards()) {
					if (tdUser.getTotalCashRewards() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setTotalCashRewards((tdUser.getTotalCashRewards() - tdOrder.getVirtualCurrencyUse()));
					} else {
						tdUser.setTotalCashRewards(0.0);
					}
				} else if (tdUser.getRoleId().equals(2L) && null != tdUser.getVirtualCurrency()) {
					if (tdUser.getVirtualCurrency() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setVirtualCurrency(tdUser.getVirtualCurrency() - tdOrder.getVirtualCurrencyUse());
					} else {
						tdUser.setVirtualCurrency(0.0);
					}
				} else if (tdUser.getRoleId().equals(3L) && null != tdUser.getDirectSaleCashRewards()) {
					if (tdUser.getDirectSaleCashRewards() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setDirectSaleCashRewards(
								tdUser.getDirectSaleCashRewards() - tdOrder.getVirtualCurrencyUse());
					} else {
						tdUser.setDirectSaleCashRewards(0.0);
					}
				}
				tdUserService.save(tdUser);
			}
		}
	}

	/**
	 * 积分商品订单支付成功后步骤
	 * 
	 * @param tdOrder
	 *            订单
	 */
	public void pointOrderafterPaySuccess(TdOrder tdOrder) {
		if (null == tdOrder) {
			return;
		}

		// 用户
		TdUser tdUser = tdUserService.findByUsername(tdOrder.getUsername());

		if (null == tdUser) {
			return;
		}

		// 设置消费总额
		if (null != tdUser.getTotalSpendCash()) {
			tdUser.setTotalSpendCash(tdUser.getTotalSpendCash() + tdOrder.getTotalPrice());
		} else {
			tdUser.setTotalSpendCash(tdOrder.getTotalPrice());
		}

		// 设置抢购最后时间

		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setPayTime(new Date()); // 设置付款时间
		}

		// 待发货
		tdOrder.setStatusId(3L);
		tdOrder = tdOrderService.save(tdOrder);

		Long pointUse = 0L;

		if (null != tdOrder.getOrderGoodsList().get(0).getPointUse()) {
			pointUse = tdOrder.getOrderGoodsList().get(0).getPointUse();
		}

		// 积分扣除
		if (null != tdUser) {
			if (pointUse.compareTo(0L) >= 0 && tdUser.getTotalPoints().compareTo(pointUse) >= 0) {
				TdUserPoint userPoint = new TdUserPoint();
				userPoint.setDetail("积分兑换商品");
				userPoint.setOrderNumber(tdOrder.getOrderNumber());
				userPoint.setPoint(0 - pointUse);
				userPoint.setPointTime(new Date());
				userPoint.setUsername(tdUser.getUsername());
				userPoint.setTotalPoint(tdUser.getTotalPoints() - pointUse);
				tdUserPointService.save(userPoint);

				tdUser.setTotalPoints(tdUser.getTotalPoints() - pointUse);
				tdUserService.save(tdUser);
			}
		}

	}
}