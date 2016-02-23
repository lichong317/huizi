package com.ynyes.huizi.controller.front;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibm.icu.util.Calendar;
import com.ynyes.huizi.entity.TdCartGoods;
import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdPayType;
import com.ynyes.huizi.entity.TdPointGoods;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserCashReward;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.service.TdCartGoodsService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdDeliveryTypeService;
import com.ynyes.huizi.service.TdGoodsCombinationService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdManagerService;
import com.ynyes.huizi.service.TdOrderGoodsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdPayRecordService;
import com.ynyes.huizi.service.TdPayTypeService;
import com.ynyes.huizi.service.TdPointGoodsService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdShippingAddressService;
import com.ynyes.huizi.service.TdUserCashRewardService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.ClientConstant;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
public class TdPointGoodsController {
	@Autowired
	TdPointGoodsService tdPointGoodsService;
    
	@Autowired
    private TdCartGoodsService tdCartGoodsService;

    @Autowired
    private TdUserService tdUserService;

    @Autowired
    private TdGoodsService tdGoodsService;

    @Autowired
    private TdPayTypeService tdPayTypeService;

    @Autowired
    private TdOrderGoodsService tdOrderGoodsService;

    @Autowired
    private TdOrderService tdOrderService;

    @Autowired
    private TdCommonService tdCommonService;

    @Autowired
    private TdUserPointService tdUserPointService;
    
    @Autowired
    TdUserCashRewardService tdUserCashRewardService;

    @Autowired
    TdUserRecentVisitService tdUserRecentVisitService;
    
    @Autowired
    TdManagerService tdManagerService;
    
	@RequestMapping("/pointGoods/{goodsId}")
	public String product(@PathVariable Long goodsId, Long shareId, Integer qiang,
	            ModelMap map, HttpServletRequest req) {
		tdCommonService.setHeader(map, req);
		
		String username = (String) req.getSession().getAttribute("username");
		 
		TdPointGoods tdPointGoods = tdPointGoodsService.findOneAndIsOnsaleTrue(goodsId);
		
		if (null == tdPointGoods) {
			return "/client/error_404";
		}
		
		// 读取浏览记录
        if (null == username)
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(req.getSession().getId(), 0, ClientConstant.pageSize));
        }
        else
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, 0, ClientConstant.pageSize));
        }
		
        // 热卖
        map.addAttribute("hot_list",
                tdGoodsService.findTop10ByIsOnSaleTrueOrderBySoldNumberDesc());
        
		map.addAttribute("goods", tdPointGoods);
		
		return "/client/pointGoods";
    }
	
	@RequestMapping("/pointGoods/list")
	public String goodslist(ModelMap map, HttpServletRequest req, Integer page, Integer size){
		tdCommonService.setHeader(map, req);
		
		if (null == page) {
			page = 0;
		}
		
		if (null == size) {
			size = SiteMagConstant.pageSize;
		}
		
		map.addAttribute("goods_page", tdPointGoodsService.findByIsOnsaleTrueOrderBySortIdAsc(page, size));
		
		map.addAttribute("pageId", page);
		
		return "/client/pointGoods_list";
	}
	
	@RequestMapping("/pointGoods/order/info")
	public String pointGoodsOrder(Long pointGoodsId, ModelMap map, HttpServletRequest req){
		String username = (String) req.getSession().getAttribute("username");
		if (null == username) {
            return "redirect:/login";
        }
		
		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        if (null != user) {
            map.addAttribute("user", user);
        }
        
        TdPointGoods tdPointGoods = tdPointGoodsService.findOneAndIsOnsaleTrue(pointGoodsId);
        
        if (null == tdPointGoods) {
        	return "/client/error_404";
		}
        
        // 邮费计算
        Double totalPostage = 0.0;
        
        if (null != tdPointGoods.getIsFeeNot() && !tdPointGoods.getIsFeeNot()) {
			if (null != tdPointGoods.getPostage()) {
				totalPostage = tdPointGoods.getPostage();
			}
		}
        
        map.addAttribute("totalPostage", totalPostage);
        map.addAttribute("goods", tdPointGoods);
        map.addAttribute("pay_type_list", tdPayTypeService.findByIsEnableTrue());
        tdCommonService.setHeader(map, req);

        return "/client/pointGoods_order_info";
	}
	
	   @RequestMapping(value = "/pointGoods/order/submit", method = RequestMethod.POST)
	    public String submit(Long addressId, Long payTypeId, Long deliveryTypeId, 
	            Boolean isNeedInvoice, String invoiceTitle,String userRemarkInfo, Double totalPostage,Long goodsId,
	            HttpServletRequest req, ModelMap map) {
	        String username = (String) req.getSession().getAttribute("username");

	        if (null == username) {
	            return "redirect:/login";
	        }

	        if (null == addressId || null == payTypeId 
	                ) {
	            return "redirect:/pointGoods/order/info?pointGoodsId="+ goodsId;
	        }

	        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
	        TdPayType payType = tdPayTypeService.findOne(payTypeId);

	        TdShippingAddress address = null;
	        
	        // 邮费
	        if (null == totalPostage) {
				totalPostage = 0.0;
			}
	        
	        List<TdShippingAddress> addressList = user.getShippingAddressList();

	        for (TdShippingAddress add : addressList) {
	            if (add.getId().equals(addressId)) {
	                address = add;
	                break;
	            }
	        }
	        
	        List<TdOrderGoods> orderGoodsList = new ArrayList<TdOrderGoods>();
	        
	        Double totalPrice = 0.0;
	        
	        // 訂單商品 计算邮费
	        if (null != goodsId) {
	        	TdPointGoods tdPointGoods = tdPointGoodsService.findOne(goodsId);
	        	if (null == tdPointGoods) {
					return "/client/error_404";
				}
	        	if (null != tdPointGoods.getIsFeeNot() && !tdPointGoods.getIsFeeNot()) {
	     			if (null != tdPointGoods.getPostage()) {
	     				totalPostage = tdPointGoods.getPostage();
	     			}
	     		}
	        	
	        	TdOrderGoods orderGoods = new TdOrderGoods();
                orderGoods.setGoodsId(tdPointGoods.getId());
                orderGoods.setGoodsTitle(tdPointGoods.getTitle());
                orderGoods.setGoodsSubTitle(tdPointGoods.getSubTitle());
                orderGoods.setGoodsCoverImageUri(tdPointGoods.getCoverImageUri());
                orderGoods.setPrice(totalPostage);
                orderGoods.setIsReturnApplied(false);
                orderGoods.setQuantity(1L);
                //兑换积分
                if (null != tdPointGoods.getPointUse()) {
                	orderGoods.setPointUse(tdPointGoods.getPointUse());
				}else {
					orderGoods.setPointUse(0L);
				}
                
                orderGoodsList.add(orderGoods);
			}
	        
	        
	        TdOrder tdOrder = new TdOrder();

	        Date current = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	        String curStr = sdf.format(current);
	        Random random = new Random();

	        // 基本信息
	        tdOrder.setUsername(username);
	        tdOrder.setOrderTime(current);

	        if (payType.getIsOnlinePay()) {
	            tdOrder.setStatusId(2L); // 待付款
	        } else {
	            tdOrder.setStatusId(1L); // 待确认
	        }
	        
	        tdOrder.setOrderNumber("P" + curStr + random.nextInt(999));

	        // 收货地址
	        tdOrder.setPostalCode(address.getPostcode());
	        tdOrder.setShippingName(address.getReceiverName());
	        tdOrder.setShippingPhone(address.getReceiverMobile());
	        tdOrder.setShippingAddress(address.getProvince() + address.getCity()
	                + address.getDisctrict() + address.getDetailAddress());

	        // 支付类型
	        tdOrder.setPayTypeId(payType.getId());
	        tdOrder.setPayTypeTitle(payType.getTitle());
	        tdOrder.setPayTypeFee(payType.getFee());
	        tdOrder.setIsOnlinePay(payType.getIsOnlinePay());

	        // 配送方式
	        tdOrder.setDeliverTypeFee(totalPostage);

	        // 发票
	        tdOrder.setIsNeedInvoice(isNeedInvoice);
	        tdOrder.setInvoiceTitle(invoiceTitle);

	        // 订单商品
	        tdOrder.setOrderGoodsList(orderGoodsList);
	        tdOrder.setTotalGoodsPrice(totalPrice);
	        
	      
			//订单总价

			tdOrder.setTotalPrice(totalPrice + totalPostage );
	        
	        // 积分奖励
	        tdOrder.setPoints(0L);

	        //订单配送备注
	        if (null != userRemarkInfo) {
	        	tdOrder.setUserRemarkInfo(userRemarkInfo);
			}
	        
	        // 订单类型
	        tdOrder.setTypeId(5L);
	        
	        // 保存订单
	        tdOrderGoodsService.save(orderGoodsList);
	        tdOrder = tdOrderService.save(tdOrder);

	        //兑换商品积分扣除
//	        if (null != user) {
//	            if (pointUse.compareTo(0L) >= 0
//	                    && user.getTotalPoints().compareTo(pointUse) >= 0) {
//	                TdUserPoint userPoint = new TdUserPoint();
//	                userPoint.setDetail("购买商品使用积分抵扣");
//	                userPoint.setOrderNumber(tdOrder.getOrderNumber());
//	                userPoint.setPoint(0 - pointUse);
//	                userPoint.setPointTime(new Date());
//	                userPoint.setUsername(username);
//	                userPoint.setTotalPoint(user.getTotalPoints() - pointUse);
//	                tdUserPointService.save(userPoint);
//
//	                user.setTotalPoints(user.getTotalPoints() - pointUse);
//	                tdUserService.save(user);
//	            }
//	        }

	        if (tdOrder.getIsOnlinePay()) {
	        	
	        	if (tdOrder.getTotalPrice() == 0) {
	    			afterPaySuccess(tdOrder);
	    		}
	            return "redirect:/order/pay?orderId=" + tdOrder.getId();
	        }

	        return "redirect:/order/success?orderId=" + tdOrder.getId();
	    }
	   
	   /**
	     * 订单支付成功后步骤
	     * 
	     * @param tdOrder
	     *            订单
	     */
	    private void afterPaySuccess(TdOrder tdOrder) {
	        if (null == tdOrder) 
	        {
	            return;
	        }

	        // 用户
	        TdUser tdUser = tdUserService.findByUsername(tdOrder.getUsername());
	        
	        if (null == tdUser)
	        {
	            return;
	        }       
	      
	        
	        // 设置抢购最后时间
	       	        
	        if (tdOrder.getStatusId().equals(2L))
	        {
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
            if (pointUse.compareTo(0L) >= 0
                    && tdUser.getTotalPoints().compareTo(pointUse) >= 0) {
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
