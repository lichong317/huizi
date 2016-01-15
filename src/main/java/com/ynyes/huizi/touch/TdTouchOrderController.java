package com.ynyes.huizi.touch;

import static org.apache.commons.lang3.StringUtils.leftPad;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.huizhidian.payment.alipay.AlipayConfig;
import com.huizhidian.payment.alipay.PaymentChannelAlipay;
import com.huizhidian.payment.ceb.CEBPayConfig;
import com.ibm.icu.util.Calendar;
import com.tencent.common.Configure;
import com.tencent.common.MD5;
import com.tencent.common.RandomStringGenerator;
import com.tencent.common.Signature;
import com.ynyes.huizi.entity.TdCartGoods;
import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.entity.TdDeliveryType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdGoodsCombination;
import com.ynyes.huizi.entity.TdGoodsDto;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdPayRecord;
import com.ynyes.huizi.entity.TdPayType;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.service.TdCartGoodsService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdDeliveryTypeService;
import com.ynyes.huizi.service.TdGoodsCombinationService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdOrderGoodsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdPayRecordService;
import com.ynyes.huizi.service.TdPayTypeService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.ClientConstant;
import com.ynyes.huizi.util.HttpRequest;

import net.sf.json.JSONObject;

/**
 * 订单
 *
 */
@Controller
@RequestMapping("/touch/order")
public class TdTouchOrderController {
    private static final String PAYMENT_ALI = "ALI";
    private static final String PAYMENT_WX = "WX";
	
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
    private TdDeliveryTypeService tdDeliveryTypeService;

    @Autowired
    private TdCommonService tdCommonService;

    @Autowired
    private TdUserPointService tdUserPointService;

    @Autowired
    private TdGoodsCombinationService tdGoodsCombinationService;
    
    @Autowired
    private TdCouponTypeService tdCouponTypeService;
    
    @Autowired
    private TdCouponService tdCouponService;
    
    @Autowired
    private TdSettingService tdSettingService;
    
    @Autowired
    private TdProductCategoryService tdProductCategoryService;
    
    @Autowired
    private TdPayRecordService payRecordService;
    /**
     * 立即购买
     * 
     * @param type
     *            购买类型 (comb: 组合购买)
     * @param gid
     *            商品ID
     * @param zhid
     *            组合ID，多个组合商品以","分开
     * @param req
     * @param map
     * @return
     */
    @RequestMapping(value = "/buy/{type}")
    public String orderBuy(@PathVariable String type, Long gid, String zhid,Long shareId,
            HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null !=  shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
//        if (null == quantity || quantity < 0)
//        {
//        	quantity = 1L;
//        }
        
        if (null == username) {
            return "redirect:/touch/login";
        }

        if (null == type || null == gid) {
            return "/touch/error_404";
        }

        List<TdGoodsDto> tdGoodsList = new ArrayList<TdGoodsDto>();

        // 组合购买
        if (type.equalsIgnoreCase("comb")) {
            // 购买商品
            TdGoods goods = tdGoodsService.findOne(gid);

            if (null == goods) {
                return "/touch/error_404";
            }

            // 优惠券
//            map.addAttribute("coupon_list",
//                    tdCouponService.findByUsernameAndIsUseable(username));
            
            
            // 积分限额
            TdUser tdUser = tdUserService.findByUsername(username);
            if (null != tdUser ) {
				if (null != tdUser.getTotalPoints() ) {
					if (goods.getPointLimited() > tdUser.getTotalPoints()) {
						map.addAttribute("total_point_limit", tdUser.getTotalPoints());
					}
					else{
						map.addAttribute("total_point_limit", goods.getPointLimited());
					}
				}
			}
            

            TdGoodsDto buyGoods = new TdGoodsDto();

            buyGoods.setGoodsId(goods.getId());
            if (null != goods.getTitle()) {
            	buyGoods.setGoodsTitle(goods.getTitle());
			}
            if (null != goods.getCoverImageUri()) {
            	buyGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
			}
            if (null != goods.getSalePrice()) {
            	buyGoods.setPrice(goods.getSalePrice());
			}
            buyGoods.setQuantity(1L);
            buyGoods.setSaleId(1);

            tdGoodsList.add(buyGoods);

            // 添加组合商品
            if (null != zhid && !zhid.isEmpty()) {
              
                String[] zhidArray = zhid.split(",");

                for (String idStr : zhidArray) {
                    if (!idStr.isEmpty()) {
                        Long zid = Long.parseLong(idStr);
    
                        if (null == zid) {
                            continue;
                        }
    
                        TdGoodsCombination combGoods = tdGoodsCombinationService
                                .findOne(zid);
    
                        if (null == combGoods) {
                            continue;
                        }
    
                        TdGoodsDto buyZhGoods = new TdGoodsDto();
    
                        buyZhGoods.setGoodsId(combGoods.getGoodsId());
                        if (null != combGoods.getGoodsTitle()) {
                        	buyZhGoods.setGoodsTitle(combGoods.getGoodsTitle());
						}
                        if (null != combGoods.getCoverImageUri()) {
                        	buyZhGoods.setGoodsCoverImageUri(combGoods.getCoverImageUri());
						}
                        if (null != combGoods.getCurrentPrice()) {
                        	buyZhGoods.setPrice(combGoods.getCurrentPrice());
						}
                        buyZhGoods.setQuantity(1L);
                        buyZhGoods.setSaleId(1);
    
                        tdGoodsList.add(buyZhGoods);
                    }
                }
            }
            
        }
        // 抢购
        else if (type.equalsIgnoreCase("qiang")) {
            // 购买商品
            TdGoods goods = tdGoodsService.findOne(gid);

            // 检查是否在秒杀
            if (null == goods || null == goods.getIsOnSale()
                    || !goods.getIsOnSale()
                    || !tdGoodsService.isFlashSaleTrue(goods)) {
                return "/touch/error_404";
            }

            TdGoodsDto buyGoods = new TdGoodsDto();

            buyGoods.setGoodsId(goods.getId());
            if (null != goods.getTitle()) {
            	buyGoods.setGoodsTitle(goods.getTitle());
			}
            if (null != goods.getCoverImageUri()) {
            	buyGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
			}
            Double flashSalePrice = tdGoodsService.getFlashPrice(goods);
            
            if (null == flashSalePrice)
            {
                return "/touch/error_404";
            }
            
            buyGoods.setPrice(flashSalePrice);
            buyGoods.setQuantity(1L);
            buyGoods.setSaleId(2);

            tdGoodsList.add(buyGoods);
            
        }
        // 团购
        else if (type.equalsIgnoreCase("tuan")) {
            // 购买商品
            TdGoods goods = tdGoodsService.findOne(gid);

            // 检查是否在十人团
            if (null == goods || null == goods.getIsOnSale()
                    || !goods.getIsOnSale()
                    || !tdGoodsService.isGroupSaleTrue(goods)) {
                return "/touch/error_404";
            }

            TdGoodsDto buyGoods = new TdGoodsDto();

            buyGoods.setGoodsId(goods.getId());
            if (null != goods.getTitle()) {
            	buyGoods.setGoodsTitle(goods.getTitle());
			}
            if (null != goods.getCoverImageUri()) {
            	buyGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
			}
            if (null != goods.getGroupSalePrice()) {
            	buyGoods.setPrice(goods.getGroupSalePrice());
			}
            buyGoods.setQuantity(1L);
            buyGoods.setSaleId(3);

            tdGoodsList.add(buyGoods);
        }
//        // 正常立即购买
//        else {
//        	 // 购买商品
//            TdGoods goods = tdGoodsService.findOne(gid);
//
//            if (null == goods) {
//                return "/client/error_404";
//            }
//
//            // 优惠券
////            map.addAttribute("coupon_list",
////                    tdCouponService.findByUsernameAndIsUseable(username));
//            
//            
//            // 积分限额
//            TdUser tdUser = tdUserService.findByUsername(username);
//            if (null != tdUser ) {
//				if (null != tdUser.getTotalPoints() ) {
//					if (goods.getPointLimited() > tdUser.getTotalPoints()) {
//						map.addAttribute("total_point_limit", tdUser.getTotalPoints());
//					}
//					else{
//						map.addAttribute("total_point_limit", goods.getPointLimited());
//					}
//				}
//			}
//            
//
//            TdGoodsDto buyGoods = new TdGoodsDto();
//
//            buyGoods.setGoodsId(goods.getId());
//            buyGoods.setGoodsTitle(goods.getTitle());
//            buyGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
//            buyGoods.setPrice(goods.getSalePrice());
//            buyGoods.setQuantity(1L);
//            buyGoods.setSaleId(0);
//
//            tdGoodsList.add(buyGoods);
//            map.addAttribute("selected_goods_list", tdGoodsList);
//                                  
//        }

        // 购买商品表
        map.addAttribute("buy_goods_list", tdGoodsList);

        // 将购买的商品保存到session
        req.getSession().setAttribute("buy_goods_list", tdGoodsList);
        // 购买类型
        req.getSession().setAttribute("buyType", type);

        map.addAttribute("selected_goods_list", tdGoodsList);
        // 线下同盟店
        //map.addAttribute("shop_list", tdDiySiteService.findByIsEnableTrue());

        // 支付方式列表
        //setPayTypes(map, true, false, req);
        map.addAttribute("pay_type_list", tdPayTypeService.findByIsEnableTrue());
        
        map.addAttribute("delivery_type_list",
                tdDeliveryTypeService.findByIsEnableTrue());
        
        //用户分享
        map.addAttribute("shareId", shareId);
        
        tdCommonService.setHeader(map, req);

        // 邮费计算
        Double totalPostage = 0.0; 
        Double totalPostagefeenot = 0.0; //免邮计算
        Double totalPrice = 0.0; // 购物总额
        TdGoods tdGoods = null;
        for(TdGoodsDto tdGoodsDto : tdGoodsList){
        	tdGoods = tdGoodsService.findOne(tdGoodsDto.getGoodsId());
        	if (null != tdGoods.getIsFeeNot()) {
        		if (!tdGoods.getIsFeeNot()) {
        			if (null != tdGoods.getPostage()) {
    					totalPostage += tdGoods.getPostage() * tdGoodsDto.getQuantity();
    				}
				}else {
					if (null != tdGoods.getPostage()) {
						totalPostagefeenot += tdGoods.getPostage() * tdGoodsDto.getQuantity();
    				}
				}
				        		
			}
        	totalPrice += tdGoodsDto.getPrice() * tdGoodsDto.getQuantity();
        }
        TdSetting tdSetting = tdSettingService.findTopBy();
        if (null != tdSetting.getMaxPostage()) {
			if (totalPrice > tdSetting.getMaxPostage()) {
				totalPostagefeenot += totalPostage;
				totalPostage = 0.0;				
			}
		}
        map.addAttribute("totalPostage", totalPostage);
        if (totalPostage == 0) {
        	 map.addAttribute("totalPostagefeenot", totalPostagefeenot);
		}
        
      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        if (type.equalsIgnoreCase("comb"))
        {
            return "/touch/order_buy_zh";
        }
        else if (type.equalsIgnoreCase("qiang"))
        {
            return "/touch/order_buy_qiang";
        }
        else if (type.equalsIgnoreCase("tuan"))
        {
            return "/touch/order_buy_tuan";
        }
        else
        {
            return "/touch/order_info";
        }
    }
    
    /**
     * 
     * @param addressId
     * @param shopId
     * @param payTypeId
     * @param deliveryTypeId
     * @param isNeedInvoice
     * @param invoiceTitle
     * @param userMessage
     * @param appointmentTime
     * @param req
     * @param map
     * @return
     */
    @RequestMapping(value = "/buysubmit", method = RequestMethod.POST)
    public String buySubmit(Long addressId, // 送货地址
            Long shopId, Long payTypeId, // 支付方式ID
            Long couponId, Long deliveryTypeId, // 配送方式ID
            Long pointUse, // 使用粮草
            Boolean isNeedInvoice, // 是否需要发票
            String invoiceTitle, // 发票抬头
            String userMessage, // 用户留言
            Long shareId,// 分享用户id
            Double totalPostage,
            String appointmentTime, HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/touch/login";
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        if (null == user) {
            return "/touch/error_404";
        }

        String buyType = (String) req.getSession().getAttribute("buyType");

        if (null == buyType) {
            return "/touch/error_404";
        }

        double payTypeFee = 0.0;
        double deliveryTypeFee = 0.0;
        double pointFee = 0.0;
        double couponFee = 0.0;

        // 订单商品
        List<TdOrderGoods> orderGoodsList = new ArrayList<TdOrderGoods>();

        // 商品总价
        Double totalGoodsPrice = 0.0;

        // 商品总尾款
        Double totalLeftPrice = 0.0;

        if (null ==totalPostage) {
        	totalPostage = 0.0;
		}
        
        // 返粮草总额
        Long totalPointReturn = 0L;

        // 组合购买
        if (buyType.equalsIgnoreCase("comb")) {
            @SuppressWarnings("unchecked")
            List<TdGoodsDto> tdGoodsList = (List<TdGoodsDto>) req.getSession()
                    .getAttribute("buy_goods_list");

            if (null != tdGoodsList && tdGoodsList.size() > 0) {
                for (TdGoodsDto buyGoods : tdGoodsList) {
                    // 原商品
                    TdGoods goods = tdGoodsService.findOne(buyGoods
                            .getGoodsId());

                    // 不存在该商品或已下架或已售罄，则跳过
                    if (null == goods || !goods.getIsOnSale()
                            || null == goods.getLeftNumber()
                            || goods.getLeftNumber().compareTo(1L) < 0) {
                        return "/touch/error_404";
                    }

                    TdOrderGoods orderGoods = new TdOrderGoods();

                    // 商品信息
                    orderGoods.setGoodsId(goods.getId());
                    if (null != goods.getTitle()) {
                    	orderGoods.setGoodsTitle(goods.getTitle());
					}
                    if (null != goods.getSubTitle()) {
                    	orderGoods.setGoodsSubTitle(goods.getSubTitle());
					}
                    if (null != goods.getCoverImageUri()) {
                    	orderGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
					}

                    // 是否已申请退货
                    orderGoods.setIsReturnApplied(false);

                    // 正常销售
                    if (0 == buyGoods.getSaleId()) {
                        orderGoods.setPrice(goods.getSalePrice());

                        // 销售方式
                        orderGoods.setGoodsSaleType(0);

                        // 商品总价
                        totalGoodsPrice += goods.getSalePrice();

                    } else { // 组合销售
                        orderGoods.setPrice(buyGoods.getPrice());

                        // 销售方式
                        orderGoods.setGoodsSaleType(1);

                        // 商品总价
                        totalGoodsPrice += buyGoods.getPrice();
                    }

                    // 数量
                    orderGoods.setQuantity(1L);

                    // 获得积分
                    if (null != goods.getReturnPoints()) {
                        totalPointReturn += goods.getReturnPoints();
                        orderGoods.setPoints(goods.getReturnPoints());
                    }

                    orderGoodsList.add(orderGoods);

                    // 更新销量
                    Long soldNumber = 0L;
                    if (null != goods.getSoldNumber()) {
						soldNumber = goods.getSoldNumber();
					}
                    		
                    Long leftNumber = 0L;
                    if (null != goods.getLeftNumber()) {
						leftNumber = goods.getLeftNumber();
					}     

                    soldNumber += 1L;
                    goods.setSoldNumber(soldNumber);
                    goods.setLeftNumber(leftNumber - 1);

                    // 保存商品
                    tdGoodsService.save(goods, username);
                }
            }

            // 使用粮草
            if (null != user.getTotalPoints()) {
            	if (null == pointUse) {
					pointUse = 0L;
				}
                if (pointUse.compareTo(user.getTotalPoints()) >= 0) {
                    pointUse = user.getTotalPoints();
                }
            }
        }
        // 秒杀
        else if (buyType.equalsIgnoreCase("qiang")) {
            @SuppressWarnings("unchecked")
            List<TdGoodsDto> tdGoodsList = (List<TdGoodsDto>) req.getSession()
                    .getAttribute("buy_goods_list");

            if (null != tdGoodsList && tdGoodsList.size() > 0) {
                for (TdGoodsDto buyGoods : tdGoodsList) {
                    // 原商品
                    TdGoods goods = tdGoodsService.findOne(buyGoods
                            .getGoodsId());

                    // 不存在该商品或已下架或已不在秒杀，则跳过
                    if (null == goods || !goods.getIsOnSale()
                            || !tdGoodsService.isFlashSaleTrue(goods)) {
                        return "/touch/error_404";
                    }

                    TdOrderGoods orderGoods = new TdOrderGoods();

                    // 商品信息
                    orderGoods.setGoodsId(goods.getId());
                    if (null != goods.getTitle()) {
                    	orderGoods.setGoodsTitle(goods.getTitle());
					}
                    if (null != goods.getSubTitle()) {
                    	orderGoods.setGoodsSubTitle(goods.getSubTitle());
					}
                    if (null != goods.getCoverImageUri()) {
                    	orderGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
					}

                    // 是否已申请退货
                    orderGoods.setIsReturnApplied(false);

                    // 抢购销售
                    Double flashSalePrice = tdGoodsService.getFlashPrice(goods);
                    
                    if (null == flashSalePrice)
                    {
                        return "/touch/error_404";
                    }
                    
                    orderGoods.setPrice(flashSalePrice);

                    // 抢购
                    orderGoods.setGoodsSaleType(2);

                    // 商品总价
                    totalGoodsPrice += flashSalePrice;

                    // 数量
                    orderGoods.setQuantity(1L);

                    orderGoodsList.add(orderGoods);

                    // 更新销量
                    Long flashSoldNumber = 0L;
                    if (null != goods.getFlashSaleSoldNumber()) {
                    	flashSoldNumber = goods.getFlashSaleSoldNumber();
					}
                    		
                    Long flashLeftNumber = 0L;
                    if (null != goods.getFlashSaleLeftNumber()) {
                    	flashLeftNumber = goods.getFlashSaleLeftNumber();
					}   

                    flashSoldNumber += 1L;
                    goods.setFlashSaleSoldNumber(flashSoldNumber);
                    goods.setFlashSaleLeftNumber(flashLeftNumber - 1);
                    
                    //保存成交价
                    goods.setFlashSaleTransactionPrice(flashSalePrice);
                    // 保存商品
                    tdGoodsService.save(goods, username);
                }
            }
        }
        // 团购
        else if (buyType.equalsIgnoreCase("tuan")) {
            @SuppressWarnings("unchecked")
            List<TdGoodsDto> tdGoodsList = (List<TdGoodsDto>) req.getSession()
                    .getAttribute("buy_goods_list");

            if (null != tdGoodsList && tdGoodsList.size() > 0) {
                for (TdGoodsDto buyGoods : tdGoodsList) {
                    // 原商品
                    TdGoods goods = tdGoodsService.findOne(buyGoods
                            .getGoodsId());

                    // 不存在该商品或已下架或已不在秒杀，则跳过
                    if (null == goods || !goods.getIsOnSale()
                            || !tdGoodsService.isGroupSaleTrue(goods)) {
                        return "/touch/error_404";
                    }

                    TdOrderGoods orderGoods = new TdOrderGoods();

                    // 商品信息
                    orderGoods.setGoodsId(goods.getId());
                    if (null != goods.getTitle()) {
                    	orderGoods.setGoodsTitle(goods.getTitle());
					}
                    if (null != goods.getSubTitle()) {
                    	orderGoods.setGoodsSubTitle(goods.getSubTitle());
					}
                    if (null != goods.getCoverImageUri()) {
                    	orderGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
					}

                    // 是否已申请退货
                    orderGoods.setIsReturnApplied(false);

                    // 团价格
                    if (null != goods.getGroupSalePrice()) {
                    	orderGoods.setPrice(goods.getGroupSalePrice());
                    	// 商品总价
                        totalGoodsPrice += goods.getGroupSalePrice() * buyGoods.getQuantity();
					}

                    // 团
                    orderGoods.setGoodsSaleType(3);

                    // 尾款
//                    totalLeftPrice = goods.getGroupSaleTenPrice()
//                            - goods.getGroupSalePrice();
                    
                    if (totalLeftPrice < 0) {
                        totalLeftPrice = 0.0;
                    }

                    // 数量
                    orderGoods.setQuantity(1L);

                    orderGoodsList.add(orderGoods);

                    // 更新销量
                    Long groupSoldNumber = 0L;
                    if (null != goods.getGroupSaleSoldNumber()) {
						groupSoldNumber = goods.getGroupSaleSoldNumber();
					}                    		
                    Long groupLeftNumber = 0L;
                    if (null != goods.getGroupSaleLeftNumber()) {
                    	groupLeftNumber = goods.getGroupSaleLeftNumber();
					}

                    groupSoldNumber += 1L;
                    goods.setGroupSaleSoldNumber(groupSoldNumber);
                    goods.setGroupSaleLeftNumber(groupLeftNumber - 1);

                    // 保存商品
                    tdGoodsService.save(goods, username);
                }
            }
        }      
       
        if (null == orderGoodsList || orderGoodsList.size() <= 0) {
            return "/touch/error_404";
        }

        // 安装信息
        TdShippingAddress address = null;

        if (null != addressId) {

            List<TdShippingAddress> addressList = user.getShippingAddressList();

            for (TdShippingAddress add : addressList) {
                if (add.getId().equals(addressId)) {
                    address = add;
                    break;
                }
            }
        }

        TdOrder tdOrder = new TdOrder();

        Date current = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String curStr = sdf.format(current);
        Random random = new Random();

        // 基本信息
        tdOrder.setUsername(user.getUsername());
        tdOrder.setOrderTime(current);

        // 订单号
        tdOrder.setOrderNumber("T" + curStr
                + leftPad(Integer.toString(random.nextInt(999)), 3, "0"));

        // 安装信息
        if (null != address) {
//            // 增加车牌 by zhangji
//            tdOrder.setCarCode(address.getReceiverCarcode());
//            // 增加车型 by zhangji
//            tdOrder.setCarType(address.getReceiverCartype());

            tdOrder.setPostalCode(address.getPostcode());

            tdOrder.setShippingName(address.getReceiverName());
            tdOrder.setShippingPhone(address.getReceiverMobile());
            tdOrder.setShippingAddress(address.getProvince()
                    + address.getCity() + address.getDisctrict()
                    + address.getDetailAddress());
        }

        if (null != payTypeId) {
            TdPayType payType = tdPayTypeService.findOne(payTypeId);

            // 支付类型
            payTypeFee = payType.getFee();
            tdOrder.setPayTypeId(payType.getId());
            tdOrder.setPayTypeTitle(payType.getTitle());
            tdOrder.setPayTypeFee(payTypeFee);
            tdOrder.setIsOnlinePay(payType.getIsOnlinePay());
        }

        // 配送方式
        tdOrder.setDeliverTypeFee(totalPostage);
        
        // 用户留言
        tdOrder.setUserRemarkInfo(userMessage);

        if (buyType.equalsIgnoreCase("comb"))
        {
            // 使用积分
            tdOrder.setPointUse(pointUse);

            // 优惠券
//            if (null != couponId) {
//                TdCoupon coupon = tdCouponService.findOne(couponId);
//
//                if (null != coupon) {
//                    TdCouponType couponType = tdCouponTypeService
//                            .findOne(coupon.getId());
//
//                    couponFee = couponType.getPrice();
//                    coupon.setIsUsed(true);
//                    tdCouponService.save(coupon);
//                }
//            }

            // 粮草奖励
            tdOrder.setPoints(totalPointReturn);

            pointFee = pointUse / 1;

            // 总价
            tdOrder.setTotalPrice(totalGoodsPrice + payTypeFee
                    + deliveryTypeFee - pointFee - couponFee);
            
            // 添加积分使用记录
            if (null != user) {
                if (null == user.getTotalPoints())
                {
                    user.setTotalPoints(0L);
                    
                    user = tdUserService.save(user);
                }
                
                if (pointUse.compareTo(0L) >= 0
                        && null != user.getTotalPoints()
                        && user.getTotalPoints().compareTo(pointUse) >= 0) {
                    TdUserPoint userPoint = new TdUserPoint();
                    userPoint.setDetail("购买商品使用积分抵扣");
                    userPoint.setOrderNumber(tdOrder.getOrderNumber());
                    userPoint.setPoint(0 - pointUse);
                    userPoint.setPointTime(new Date());
                    userPoint.setUsername(username);
                    userPoint.setTotalPoint(user.getTotalPoints() - pointUse);
                    tdUserPointService.save(userPoint);

                    user.setTotalPoints(user.getTotalPoints() - pointUse);
                    tdUserService.save(user);
                }
            }
        }
        else
        {
         // 总价
            tdOrder.setTotalPrice(totalGoodsPrice + payTypeFee + deliveryTypeFee + totalPostage);
        }

        // 待付款
        tdOrder.setStatusId(2L);

//        // 需付尾款额
//        tdOrder.setTotalLeftPrice(totalLeftPrice);

        // 发票
        if (null != isNeedInvoice) {
            tdOrder.setIsNeedInvoice(isNeedInvoice);
            tdOrder.setInvoiceTitle(invoiceTitle);
        } else {
            tdOrder.setIsNeedInvoice(false);
        }

        // 订单商品
        tdOrder.setOrderGoodsList(orderGoodsList);
        tdOrder.setTotalGoodsPrice(totalGoodsPrice);

        // 保存订单商品及订单
        tdOrderGoodsService.save(orderGoodsList);
        /**
		 * @author lc
		 * @注释：订单类型设置 
		 */
        tdOrder.setTypeId(0L);
        for(TdOrderGoods tdOrderGoods : orderGoodsList){
        	if (tdOrderGoods.getGoodsSaleType() == 1) {
				tdOrder.setTypeId(2L);
			}       	
        }
        //抢购 团购 都只有一个商品
        for(TdOrderGoods tdOrderGoods : orderGoodsList){
        	if (tdOrderGoods.getGoodsSaleType() == 2) {
				tdOrder.setTypeId(3L);
			}
        	else if (tdOrderGoods.getGoodsSaleType() == 3) {
        		tdOrder.setTypeId(4L);
			}       	
        }
        
        //分享用户id
        if (null != shareId) {
			tdOrder.setShareId(shareId);
			TdUser sharedUser = tdUserService.findOne(shareId);
            TdSetting setting = tdSettingService.findTopBy();
          
            if (null != sharedUser && null != setting) {
                    if (null == sharedUser.getPointGetByShareGoods()) {
                        sharedUser.setPointGetByShareGoods(0L);
                    }

                    if (null == setting.getGoodsShareLimits()) {
                        setting.setGoodsShareLimits(50L); // 设定一个默认值
                    }

                    // 小于积分限额，进行积分
                    if (sharedUser.getPointGetByShareGoods().compareTo(setting.getGoodsShareLimits()) < 0) {
                    	if (!user.getId().equals(shareId)) {
                     		 TdUserPoint point = new TdUserPoint();
                              point.setDetail("分享商品获得积分");
                              point.setPoint(setting.getGoodsSharePoints());
                              point.setPointTime(new Date());
                              point.setUsername(sharedUser.getUsername());

                              if (null != sharedUser.getTotalPoints()) {
                                  point.setTotalPoint(sharedUser.getTotalPoints()
                                          + point.getPoint());
                              } else {
                                  point.setTotalPoint(point.getPoint());
                              }

                              point = tdUserPointService.save(point);

                              sharedUser.setTotalPoints(point.getTotalPoint()); // 积分
                              tdUserService.save(sharedUser);
 						}
                  }
              }
		}
        
        tdOrder = tdOrderService.save(tdOrder);
        
      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
         if (tdOrder.getIsOnlinePay()) {
        return "redirect:/touch/order/pay?orderId=" + tdOrder.getId();
         }

        return "redirect:/touch/order/success?orderId=" + tdOrder.getId();
    }
    
    @RequestMapping(value = "/info")
    public String orderInfo(HttpServletRequest req, HttpServletResponse resp, Long shareId,
            ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null !=  shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
        if (null == username) {
            return "redirect:/touch/login";
        }

        // 把所有的购物车项转到该登陆用户下
        String sessionId = req.getSession().getId();

        List<TdCartGoods> cartGoodsList = tdCartGoodsService
                .findByUsername(sessionId);

        if (null != cartGoodsList && cartGoodsList.size() > 0) {
            for (TdCartGoods cartGoods : cartGoodsList) {
                cartGoods.setUsername(username);
                cartGoods.setIsLoggedIn(true);
            }
            tdCartGoodsService.save(cartGoodsList);
        }
       
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        if (null != user) {
            map.addAttribute("user", user);
        }

        // 触屏结算目前为所有购物车商品        
        List<TdCartGoods> cartGoodslist = tdCartGoodsService.findByUsername(username);
        if (null != cartGoodslist && !cartGoodslist.isEmpty()) {
			for(TdCartGoods tdCartGoods : cartGoodslist){
				tdCartGoods.setIsSelected(true);
				tdCartGoodsService.save(tdCartGoods);
			}
		}
               
        List<TdCartGoods> selectedGoodsList = tdCartGoodsService
                .findByUsernameAndIsSelectedTrue(username);
        
        Long totalPointLimited = 0L;
        Double totalPrice = 0.0; // 购物总额
        Double totalQuantity =0.0;
        // 积分限制总和
        if (null != selectedGoodsList) {
            for (TdCartGoods cg : selectedGoodsList) {
                TdGoods goods = tdGoodsService.findOne(cg.getGoodsId());

                if (null != goods && null != goods.getPointLimited()) {
                    totalPointLimited += goods.getPointLimited()
                            * cg.getQuantity();
                    totalPrice += cg.getPrice() * cg.getQuantity();
                    totalQuantity += cg.getQuantity();
                }
            }
        }

     // 查询购物车的所有种类
        List<String> productIds = new ArrayList<>();
        for (TdCartGoods cg : selectedGoodsList) {
            TdGoods goods = tdGoodsService.findOne(cg.getGoodsId());
            if (productIds.isEmpty()) {
                productIds.add(goods.getCategoryIdTree().split(",")[0]);// 根类别
            } else {
                if (!productIds
                        .contains(goods.getCategoryIdTree().split(",")[0])) {
                    productIds.add(goods.getCategoryIdTree().split(",")[0]);
                }
            }
        }
        
     // 如果有不同种类的商品则不能使用优惠券
        if (productIds.size() < 2) {
            List<TdCoupon> userCoupons = null;
            if (null != user.getMobile()) {
                userCoupons = tdCouponService.findByMobileAndIsUseable(user
                        .getMobile());// 根据账号查询所有优惠券
            }

            if (null != userCoupons) {
                List<TdCoupon> userCouponList = new ArrayList<>(); // 可用券
                TdCouponType couponType = null;
                for (int i = 0; i < userCoupons.size(); i++) {
                    couponType = tdCouponTypeService.findOne(userCoupons.get(i)
                            .getTypeId());
                    if (null != couponType) {
                        if (couponType.getCategoryId().equals(1L)) {
                            TdProductCategory tpc = tdProductCategoryService
                                    .findOne(couponType.getProductTypeId());
                            List<String> templist = new ArrayList<>();
                            for (String cid : tpc.getParentTree().split(",")) {
                                templist.add(cid);
                            }
                            // 判断购物总价>满购券使用金额
                            if (totalPrice > couponType.getCanUsePrice()
                                    && templist.contains(productIds.get(0))) {
                                userCouponList.add(userCoupons.get(i));
                            }
                        } else if (couponType.getCategoryId().equals(0L)) {
                            userCouponList.add(userCoupons.get(i));
                        } else if (couponType.getCategoryId().equals(2L)) {
                            if (totalPrice > couponType.getCanUsePrice()) {
                                userCouponList.add(userCoupons.get(i));
                            }
                        }
                    }
                }
                map.addAttribute("coupon_list", userCouponList);
            }
        }
        
        // 积分限额
        if (null != user.getTotalPoints()) {
            if (totalPointLimited > user.getTotalPoints()) {
                map.addAttribute("total_point_limit", user.getTotalPoints());
            } else {
                map.addAttribute("total_point_limit", totalPointLimited);
            }
        }
        
        // 邮费计算
        Double totalPostage = 0.0;  
        Double totalPostagefeenot = 0.0; //免邮计算
        TdGoods tdGoods = null;
        for(TdCartGoods tdCartGoods : selectedGoodsList){
        	tdGoods = tdGoodsService.findOne(tdCartGoods.getGoodsId());
        	if (null != tdGoods.getIsFeeNot()) {
        		if (!tdGoods.getIsFeeNot()) {
        			if (null != tdGoods.getPostage()) {
    					totalPostage += tdGoods.getPostage() * tdCartGoods.getQuantity();
    				}
				}else {
					if (null != tdGoods.getPostage()) {
						totalPostagefeenot += tdGoods.getPostage() * tdCartGoods.getQuantity();
    				}
				}
				        		
			}
        }
        TdSetting tdSetting = tdSettingService.findTopBy();
        if (null != tdSetting.getMaxPostage()) {
			if (totalPrice > tdSetting.getMaxPostage()) {
				totalPostagefeenot += totalPostage;
				totalPostage = 0.0;
			}
		}
        map.addAttribute("totalPostage", totalPostage);
        if (totalPostage == 0) {
       	 map.addAttribute("totalPostagefeenot", totalPostagefeenot);
		}
        
        map.addAttribute("pay_type_list", tdPayTypeService.findByIsEnableTrue());
        map.addAttribute("delivery_type_list",
                tdDeliveryTypeService.findByIsEnableTrue());
        map.addAttribute("selected_goods_list", selectedGoodsList);
        map.addAttribute("totalPrice", totalPrice);
        map.addAttribute("totalQuantity", totalQuantity);
        
        tdCommonService.setHeader(map, req);

      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        return "/touch/order_info";
    }

    @RequestMapping(value = "/goods/{type}")
    public String orderEdit(HttpServletRequest req, HttpServletResponse resp,
            @PathVariable String type, Long gid, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/touch/login";
        }

        // 把所有的购物车项转到该登陆用户下
        List<TdCartGoods> cgList = tdCartGoodsService
                .findByUsernameAndIsSelectedTrue(username);
        Double totalPrice = 0.0; // 购物总额
        if (null != cgList && null != type && null != gid) {
            for (TdCartGoods cg : cgList) {
                if (gid.equals(cg.getGoodsId())) {
                	
                    TdGoods goods = tdGoodsService.findOne(cg.getGoodsId());

                    if (null != goods) {
                        if (type.equalsIgnoreCase("plus")) 
                        {
                            // 团购
                            if (goods.getIsGroupSale()
                                    && goods.getGroupSaleStartTime().before(new Date())
                                    && goods.getGroupSaleStopTime().after(new Date())
                                    && cg.getPrice().equals(goods.getGroupSalePrice())) 
                            {
                                if (cg.getQuantity().compareTo(goods.getGroupSaleLeftNumber()) < 0) {
                                    cg.setQuantity(cg.getQuantity() + 1L);
                                }
                            }
                            else
                            {
                                if (cg.getQuantity().compareTo(goods.getLeftNumber()) < 0) {
                                    cg.setQuantity(cg.getQuantity() + 1L);
                                }
                            }
                        } else {
                            if (cg.getQuantity().compareTo(1L) > 0) {
                                cg.setQuantity(cg.getQuantity() - 1L);
                            }
                        }

                        tdCartGoodsService.save(cg);
                        break;
                    }
				  
                }
                
             // 总价
                totalPrice += cg.getPrice() * cg.getQuantity();
            }
        }
//        
//        List<TdCartGoods> selectedGoodsList = tdCartGoodsService.findByUsernameAndIsSelectedTrue(username);
//        map.addAttribute("selected_goods_list", selectedGoodsList);
        
     // 运费计算
        Double totalPostage = 0.0;      
        TdGoods tdGoods = null;
        for(TdCartGoods tdCartGoods : cgList){
        	tdGoods = tdGoodsService.findOne(tdCartGoods.getGoodsId());
        	if (null != tdGoods.getIsFeeNot() && !tdGoods.getIsFeeNot()) {
				if (null != tdGoods.getPostage()) {
					totalPostage += tdGoods.getPostage() * tdCartGoods.getQuantity();
				}
        		
			}
        }
        TdSetting tdSetting = tdSettingService.findTopBy();
        if (null != tdSetting.getMaxPostage()) {
			if (totalPrice > tdSetting.getMaxPostage()) {
				totalPostage = 0.0;
			}
		}
        map.addAttribute("totalPostage", totalPostage);
        
        return "redirect:/touch/order/info";
    }

    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public String submit(Long addressId, Long payTypeId, Long deliveryTypeId,Long couponId,
            Long pointUse, Boolean isNeedInvoice, String invoiceTitle,Double virtualCurrency,Double totalPostage,
            HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/touch/login";
        }

        if (null == addressId || null == payTypeId 
                || null == isNeedInvoice) {
            return "redirect:/touch/order/info";
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        TdPayType payType = tdPayTypeService.findOne(payTypeId);
        TdDeliveryType deliveryType = tdDeliveryTypeService
                .findOne(1L);
        TdShippingAddress address = null;

        if (null == pointUse) {
            pointUse = 0L;
        }

        if (null == virtualCurrency) {
        	virtualCurrency = 0.0;
		}
        
     // 邮费
        if (null == totalPostage) {
			totalPostage = 0.0;
		}
        
        if (pointUse.compareTo(user.getTotalPoints()) >= 0) {
            pointUse = user.getTotalPoints();
        }

        List<TdShippingAddress> addressList = user.getShippingAddressList();

        for (TdShippingAddress add : addressList) {
            if (add.getId().equals(addressId)) {
                address = add;
                break;
            }
        }

        List<TdCartGoods> cartGoodsList = tdCartGoodsService
                .findByUsernameAndIsSelectedTrue(username);
        List<TdOrderGoods> orderGoodsList = new ArrayList<TdOrderGoods>();

        Double totalPrice = 0.0;
        Long totalSharePoints = 0L;
        if (null != cartGoodsList) {
            for (TdCartGoods cartGoods : cartGoodsList) {
                if (cartGoods.getIsSelected()) {
                	
                	//分享用户积分奖励
                	if (null != cartGoods.getShareId()) {
                		  TdUser sharedUser = tdUserService.findOne(cartGoods.getShareId());
	                      TdSetting setting = tdSettingService.findTopBy();

	                      if (null != sharedUser && null != setting) {
	                           if (null == sharedUser.getPointGetByShareGoods()) {
	                               sharedUser.setPointGetByShareGoods(0L);
	                           }
	          
	                           if (null == setting.getGoodsShareLimits()) {
	                               setting.setGoodsShareLimits(50L); // 设定一个默认值
	                           }
	          
	                           // 小于积分限额，进行积分
	                           if (sharedUser.getPointGetByShareGoods().compareTo(setting.getGoodsShareLimits()) < 0) {
	                               totalSharePoints += setting.getGoodsSharePoints();
	                               
	                               if (!user.getId().equals(cartGoods.getShareId())) {
	                              		 TdUserPoint point = new TdUserPoint();
	                                       point.setDetail("分享商品获得积分");
	                                       point.setPoint(setting.getGoodsSharePoints());
	                                       point.setPointTime(new Date());
	                                       point.setUsername(sharedUser.getUsername());

	                                       if (null != sharedUser.getTotalPoints()) {
	                                           point.setTotalPoint(sharedUser.getTotalPoints()
	                                                   + point.getPoint());
	                                       } else {
	                                           point.setTotalPoint(point.getPoint());
	                                       }

	                                       point = tdUserPointService.save(point);

	                                       sharedUser.setTotalPoints(point.getTotalPoint()); // 积分
	                                       tdUserService.save(sharedUser);
	          						}
	                           }
	                      }
	                      
					}
                	
                    TdGoods goods = tdGoodsService.findOne(cartGoods
                            .getGoodsId());

                    if (null == goods) {
                        continue;
                    }

                    TdOrderGoods orderGoods = new TdOrderGoods();
                    orderGoods.setGoodsId(goods.getId());
                    orderGoods.setGoodsTitle(goods.getTitle());
                    orderGoods.setGoodsSubTitle(goods.getSubTitle());
                    orderGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
                    orderGoods.setPrice(cartGoods.getPrice());
                    orderGoods.setIsReturnApplied(false);

                    long quantity = 0;
                    
                    // 团购
                    if (goods.getIsGroupSale()
                            && goods.getGroupSaleStartTime().before(new Date())
                            && goods.getGroupSaleStopTime().after(new Date())
                            && cartGoods.getPrice().equals(goods.getGroupSalePrice())) 
                    {
                        quantity = Math.min(cartGoods.getQuantity(), goods.getGroupSaleLeftNumber());
                    } 
                    else 
                    {
                        quantity = Math.min(cartGoods.getQuantity(), goods.getLeftNumber());
                    }

                    orderGoods.setQuantity(quantity);
                    orderGoods.setPoints(goods.getReturnPoints());

                    totalPrice += cartGoods.getPrice()
                            * cartGoods.getQuantity();

                    orderGoodsList.add(orderGoods);
                    tdGoodsService.save(goods, username);
                }
            }
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
        
        tdOrder.setOrderNumber("T" + curStr + random.nextInt(999));

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
//        tdOrder.setDeliverTypeId(deliveryType.getId());
//        tdOrder.setDeliverTypeTitle(deliveryType.getTitle());
        tdOrder.setDeliverTypeFee(totalPostage);

        // 发票
        tdOrder.setIsNeedInvoice(isNeedInvoice);
        tdOrder.setInvoiceTitle(invoiceTitle);

        // 订单商品
        tdOrder.setOrderGoodsList(orderGoodsList);
        tdOrder.setTotalGoodsPrice(totalPrice);
        // 使用积分
        tdOrder.setPointUse(pointUse);
        
        //优惠券使用
        if (null != couponId) {
			TdCoupon tdCoupon = tdCouponService.findOne(couponId);
			tdCoupon.setIsUsed(true);
			tdCouponService.save(tdCoupon);
			tdOrder.setCouponTitle(tdCoupon.getTypeTitle());
			if (null != tdCoupon.getPrice()) {
				tdOrder.setCouponUse(tdCoupon.getPrice());
				if (totalPrice + totalPostage > pointUse + tdCoupon.getPrice() + virtualCurrency) {
					tdOrder.setTotalPrice(totalPrice + totalPostage - pointUse - tdCoupon.getPrice() - virtualCurrency);
				}else{
					tdOrder.setTotalPrice(0.0);
				}				
			}
		}else{
			//订单总价
			if (totalPrice + totalPostage > pointUse + virtualCurrency) {
				tdOrder.setTotalPrice(totalPrice + totalPostage - pointUse - virtualCurrency);
			}
			else {
				tdOrder.setTotalPrice(0.0);
			}
		}

        // 积分奖励
        tdOrder.setPoints(0L);

        //保存分享商品用户可获取积分
        tdOrder.setTotalSharePoints(totalSharePoints);
        
        // 保存订单
        tdOrderGoodsService.save(orderGoodsList);
        tdOrder = tdOrderService.save(tdOrder);

        if (null != user) {
            if (pointUse.compareTo(0L) >= 0
                    && user.getTotalPoints().compareTo(pointUse) >= 0) {
                TdUserPoint userPoint = new TdUserPoint();
                userPoint.setDetail("购买商品使用积分抵扣");
                userPoint.setOrderNumber(tdOrder.getOrderNumber());
                userPoint.setPoint(0 - pointUse);
                userPoint.setPointTime(new Date());
                userPoint.setUsername(username);
                userPoint.setTotalPoint(user.getTotalPoints() - pointUse);
                tdUserPointService.save(userPoint);

                user.setTotalPoints(user.getTotalPoints() - pointUse);
                tdUserService.save(user);
            }
        }

        // 删除已生成订单的购物车项
        tdCartGoodsService.delete(cartGoodsList);

        //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        if (tdOrder.getIsOnlinePay()) {
        	if (tdOrder.getTotalPrice() == 0) {
    			afterPaySuccess(tdOrder);
    		}
            return "redirect:/touch/order/pay?orderId=" + tdOrder.getId();
        }

        return "redirect:/touch/order/success?orderId=" + tdOrder.getId();
    }

    @RequestMapping(value = "/pay")
    public String pay(Long orderId, ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

        if (null == orderId) {
            return "/touch/error_404";
        }

        map.addAttribute("order", tdOrderService.findOne(orderId));

      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        return "/touch/order_pay";
    }

    @RequestMapping(value = "/success")
    public String success(Long orderId, ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

        if (null == orderId) {
            return "/touch/error_404";
        }

        map.addAttribute("order", tdOrderService.findOne(orderId));
        
        /**
		 * @author lc
		 * @注释：添加同种商品推荐 取订单第一个商品
		 */
        List<TdOrderGoods> orderGoodsList = (tdOrderService.findOne(orderId)).getOrderGoodsList();
        TdOrderGoods tdOrderGoods = orderGoodsList.get(0);
        TdGoods tdGoods = tdGoodsService.findOne(tdOrderGoods.getGoodsId());
        map.addAttribute("recommend_goods_page", tdGoodsService.findByCategoryIdTreeContainingOrderBySortIdAsc(tdGoods.getCategoryId(), 0, ClientConstant.pageSize));
        
      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        return "/touch/order_success";
    }

    @RequestMapping(value = "/pay/success")
    public String paySuccess(ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

      //判断是否为app链接
        Integer isApp = (Integer) req.getSession().getAttribute("app");
        if (null != isApp) {
        	map.addAttribute("app", isApp);
		}
        
        return "/touch/order_pay_success";
    }
    
//    @RequestMapping(value = "/dopay/{orderId}")
//    public String payOrder(@PathVariable Long orderId, ModelMap map,
//            HttpServletRequest req) {
//        String username = (String) req.getSession().getAttribute("username");
//
//        if (null == username) {
//            return "redirect:/touch/login";
//        }
//
//        tdCommonService.setHeader(map, req);
//
//        if (null == orderId) {
//            return "/touch/error_404";
//        }
//
//        TdOrder order = tdOrderService.findOne(orderId);
//
//        if (null == order) {
//            return "/touch/error_404";
//        }
//
//        // 根据订单类型来判断支付时间是否过期
////        if (order.getTypeId().equals(3L)) { // 抢拍 订单提交后30分钟内
////            Date cur = new Date();
////            long temp = cur.getTime() - order.getOrderTime().getTime();
////            // System.out.println(temp);
////            if (temp > 1000 * 60 * 30) {
////                return "/touch/overtime";
////            }
////        } else if (order.getTypeId().equals(4L) || order.getTypeId().equals(5L)) { // 团购
////                                                                                   // 
////            Date cur = new Date();
////            long temp = 0L;
////           
////            TdGoods tdGoods = tdGoodsService.findOne(order.getOrderGoodsList().get(0).getGoodsId());
////            if (null != tdGoods) {
////				if (order.getTypeId().equals(4L)) {
////					temp = cur.getTime() - tdGoods.getGroupSaleStopTime().getTime();
////				}else if (order.getTypeId().equals(5L)) {
////					temp = cur.getTime() - tdGoods.getGroupSaleHundredStopTime().getTime();
////				}
////				if (temp > 0) {
////                    return "/client/overtime";
////                }
////			}
////        } else { // 普通 订单提交后24小时内
////            Date cur = new Date();
////            long temp = cur.getTime() - order.getOrderTime().getTime();
////            if (temp > 1000 * 3600 * 24) {
////                return "/touch/overtime";
////            }
////        }
//
//        // 待付款
//        if (!order.getStatusId().equals(2L)) {
//            return "/touch/error_404";
//        }
//
//        String amount = order.getTotalPrice().toString();
//        req.setAttribute("totalPrice", amount);
//
//        String payForm = "";
//
//        Long payId = order.getPayTypeId();
//        TdPayType payType = tdPayTypeService.findOne(payId);
//        if (payType != null) {
//            TdPayRecord record = new TdPayRecord();
//            record.setCreateTime(new Date());
//            record.setOrderId(order.getId());
//            record.setPayTypeId(payType.getId());
//            record.setStatusCode(1);
//            record.setCreateTime(new Date());
//            record = payRecordService.save(record);
//
//            String payRecordId = record.getId().toString();
//            int recordLength = payRecordId.length();
//            if (recordLength > 6) {
//                payRecordId = payRecordId.substring(recordLength - 6);
//            } else {
//                payRecordId = leftPad(payRecordId, 6, "0");
//            }
//            req.setAttribute("payRecordId", payRecordId);
//
//            req.setAttribute("orderNumber", order.getOrderNumber());
//
//            String payCode = payType.getCode();
//            if (PAYMENT_ALI.equals(payCode)) {
//            	PaymentChannelAlipay payChannelAlipay = new PaymentChannelAlipay();
//                payForm = payChannelAlipay.getPayFormData(req);
//                map.addAttribute("charset", AlipayConfig.CHARSET);
//            } else if (PAYMENT_WX.equals(payCode)) {
//                map.addAttribute("order_number", order.getOrderNumber());
//                map.addAttribute("total_price", order.getTotalPrice());
//
//                String sa = "appid=" + Configure.getAppid() + "&mch_id="
//                        + Configure.getMchid() + "&nonce_str="
//                        + RandomStringGenerator.getRandomStringByLength(32)
//                        + "&product_id=" + order.getId() + "&time_stamp="
//                        + System.currentTimeMillis() / 1000;
//
//                String sign = MD5.MD5Encode(
//                        sa + "&key=192006250b4c09247ec02edce69f6acy")
//                        .toUpperCase();
//
//                System.out.print("Sharon: weixin://wxpay/bizpayurl?" + sa
//                        + "&sign=" + sign + "\n");
//
//                req.getSession().setAttribute("WXPAYURLSESSEION",
//                        "weixin://wxpay/bizpayurl?" + sa + "&sign=" + sign);
//                // "weixin://wxpay/bizpayurl?appid=wx2421b1c4370ec43b&mch_id=10000100&nonce_str=f6808210402125e30663234f94c87a8c&product_id=1&time_stamp=1415949957&sign=512F68131DD251DA4A45DA79CC7EFE9D");
//                return "/touch/order_pay_wx";
////            } 
////            else if (CEBPayConfig.INTER_B2C_BANK_CONFIG.keySet().contains(
////                    payCode)) {
////                req.setAttribute("payMethod", payCode);
////                payForm = payChannelCEB.getPayFormData(req);
////                map.addAttribute("charset", "GBK");
//            } else {
//                // 其他目前未实现的支付方式
//                return "/touch/error_404";
//            }
//        } else {
//            return "/touch/error_404";
//        }
//
//        order.setPayTime(new Date());
//
//        tdOrderService.save(order);
//
//        map.addAttribute("payForm", payForm);
//
//        return "/touch/order_pay_form";
//    }
    
    @RequestMapping(value = "/pay/notify")
    public String payNotify(ModelMap map, HttpServletRequest req) {
        // String username = (String) req.getSession().getAttribute("username");
        //
        // if (null == username) {
        // return "redirect:/login";
        // }

        tdCommonService.setHeader(map, req);

        return "/touch/order_pay";
    }

    /*
     * 
     */
    @RequestMapping(value = "/pay/notify_alipay")
    public void payNotifyAlipay(ModelMap map, HttpServletRequest req,
            HttpServletResponse resp) {
    	PaymentChannelAlipay payChannelAlipay = new PaymentChannelAlipay();
        payChannelAlipay.doResponse(req, resp);
    }

    /*
     * 
     */
//    @RequestMapping(value = "/pay/notify_cebpay")
//    public void payNotifyCEBPay(ModelMap map, HttpServletRequest req,
//            HttpServletResponse resp) {
//        payChannelCEB.doResponse(req, resp);
//    }
  
    /**
     * 触屏微信支付
     * 
     * @param orderId
     * @param map
     * @param req
     * @return
     */
    @RequestMapping(value = "/dopay")
    public String payOrder(Long orderId, ModelMap map,HttpServletRequest req,Long state,String code)
    {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username)
        {
            return "redirect:/touch/login";
        }
        TdUser user = tdUserService.findByUsername(username);

        tdCommonService.setHeader(map, req);

        String openId = "";
        if (null == state) 
        {
            return "/touch/error_404";
        }
        if (user.getOpenid() == null)
        {
            if (code != null)
        	{
        		System.out.println("Madejing: code = " + code);
        		
    			String accessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + Configure.getAppid() +"&secret=" + Configure.getKey() +"&code=" + code + "&grant_type=authorization_code";
    			
    			System.out.println("Madejing: accessTokenUrl = " + accessTokenUrl);
    			
    			String result = HttpRequest.sendGet(accessTokenUrl, null);
    			
    			System.out.println("madjeing: result =" + result);
    			
    		    openId = JSONObject.fromObject(result).getString("openid");
    		    TdUser user2 = tdUserService.findByOpenid(openId);
    		    if (user2 == null && user.getOpenid() == null)
    		    {
    		    	user.setOpenid(JSONObject.fromObject(result).getString("openid"));
				}
    		    
    		    System.out.println("Madejing: openid = " + openId);
    		}
		}


        TdOrder order = tdOrderService.findOne(state);

        if (null == order)
        {
            return "/client/error_404";
        }

        // 根据订单类型来判断支付时间是否过期
        // 普通 订单提交后30分钟内
//        Date cur = new Date();
//        long temp = cur.getTime() - order.getOrderTime().getTime();

        // 待付款
        if (!order.getStatusId().equals(2L))
        {
            return "/touch/error_404";
        }

        String amount = order.getTotalPrice().toString();
        req.setAttribute("totalPrice", amount);

        String payForm = "";
        map.addAttribute("order", order);
        map.addAttribute("order_number", order.getOrderNumber());
		map.addAttribute("total_price", order.getTotalPrice());

		Calendar calExpire = Calendar.getInstance();
		calExpire.setTime(order.getOrderTime());


		//统一支付接口
		String noncestr = RandomStringGenerator.getRandomStringByLength(32);
		ModelMap signMap = new ModelMap();
		signMap.addAttribute("appid", Configure.getAppid());
		signMap.addAttribute("attach", "订单支付");
		signMap.addAttribute("body", "支付订单" + order.getOrderNumber());
		signMap.addAttribute("mch_id", Configure.getMchid());
		signMap.addAttribute("nonce_str",noncestr);
		signMap.addAttribute("out_trade_no", order.getOrderNumber());
		signMap.addAttribute("total_fee", Math.round(order.getTotalPrice() * 100));
		signMap.addAttribute("spbill_create_ip", "116.55.230.207");
		signMap.addAttribute("notify_url", "http://www.huizhidian.com/touch/order/wx_notify");
		signMap.addAttribute("trade_type", "JSAPI");
		signMap.addAttribute("openid", user.getOpenid());

		String mysign = Signature.getSign(signMap);

		String content = "<xml>\n" + "<appid>"
				+ Configure.getAppid()
				+ "</appid>\n"
				+ "<attach>订单支付</attach>\n"
				+ "<body>支付订单"
				+ order.getOrderNumber()
				+ "</body>\n"
				+ "<mch_id>"
				+ Configure.getMchid()
				+ "</mch_id>\n"
				+ "<nonce_str>"
				+ noncestr
				+ "</nonce_str>\n"
				+ "<notify_url>http://www.huizhidian.com/touch/order/wx_notify</notify_url>\n"
				+ "<out_trade_no>" + order.getOrderNumber() + "</out_trade_no>\n"
				+ "<spbill_create_ip>116.55.230.207</spbill_create_ip>\n"
				+ "<total_fee>" + Math.round(order.getTotalPrice() * 100)
				+ "</total_fee>\n" + "<trade_type>JSAPI</trade_type>\n"
				+ "<sign>" + mysign + "</sign>\n"
				+ "<openid>" + user.getOpenid() + "</openid>\n" + "</xml>\n";
		System.out.print("MDJ: xml=" + content + "\n");

		String return_code = null;
		String prepay_id = null;
		String result_code = null;
		String line = null;
		HttpsURLConnection urlCon = null;
		try
		{
			urlCon = (HttpsURLConnection) (new URL("https://api.mch.weixin.qq.com/pay/unifiedorder")).openConnection();
			urlCon.setDoInput(true);
			urlCon.setDoOutput(true);
			urlCon.setRequestMethod("POST");
			urlCon.setRequestProperty("Content-Length",String.valueOf(content.getBytes().length));
			urlCon.setUseCaches(false);
			// 设置为gbk可以解决服务器接收时读取的数据中文乱码问题
			urlCon.getOutputStream().write(content.getBytes("utf-8"));
			urlCon.getOutputStream().flush();
			urlCon.getOutputStream().close();
			BufferedReader in = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));

			while ((line = in.readLine()) != null)
			{
				System.out.println(": rline: " + line);
				if (line.contains("<return_code>"))
				{
					return_code = line.replaceAll(
							"<xml><return_code><\\!\\[CDATA\\[", "")
							.replaceAll("\\]\\]></return_code>", "");
				} 
				else if (line.contains("<prepay_id>")) 
				{
					prepay_id = line.replaceAll("<prepay_id><\\!\\[CDATA\\[",
							"").replaceAll("\\]\\]></prepay_id>", "");
				}
				else if (line.contains("<result_code>"))
				{
					result_code = line.replaceAll(
							"<result_code><\\!\\[CDATA\\[", "").replaceAll(
									"\\]\\]></result_code>", "");
				}
			}

			System.out.println("MDJ: return_code: " + return_code + "\n");
			System.out.println("MDJ: prepay_id: " + prepay_id + "\n");
			System.out.println("MDJ: result_code: " + result_code + "\n");

			if ("SUCCESS".equalsIgnoreCase(return_code)
					&& "SUCCESS".equalsIgnoreCase(result_code)
					&& null != prepay_id)
			{
				noncestr = RandomStringGenerator.getRandomStringByLength(32);

				String timeStamp = String.valueOf(System.currentTimeMillis() / 1000);
				String packageString = "prepay_id=" + prepay_id;
				String signType = "MD5";
				ModelMap returnsignmap = new ModelMap();
				returnsignmap.addAttribute("appId", Configure.getAppid());
				returnsignmap.addAttribute("timeStamp", timeStamp);
				returnsignmap.addAttribute("nonceStr", noncestr);
				returnsignmap.addAttribute("package", packageString);
				returnsignmap.addAttribute("signType", signType);

				
				String returnsign = Signature.getSign(returnsignmap);
				content = "<xml>\n" + 
				"<appid>" + Configure.getAppid() + "</appid>\n" + 
				"<timeStamp>" + timeStamp + "</timeStamp>\n" +
				"<nonceStr>" + noncestr + "</nonceStr>\n" + 
				"<package>" + packageString + "</package>\n" + 
				"<signType>" + signType + "</signType>\n" + 
				"<signType>" + returnsign + "</signType>\n" + 
				"</xml>\n";

				System.out.print(": returnPayData xml=" + content);
				map.addAttribute("appId", Configure.getAppid());
				map.addAttribute("timeStamp", timeStamp);
				map.addAttribute("nonceStr", noncestr);
				map.addAttribute("package", packageString);
				map.addAttribute("signType", signType);
				map.addAttribute("paySign", returnsign);
				map.addAttribute("orderId", state);
			}
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
        tdOrderService.save(order);

        map.addAttribute("payForm", payForm);

        return "/touch/pay_order";
    }
    
    @RequestMapping(value = "/wx_notify")
    public void wx_notify(HttpServletResponse response,HttpServletRequest request) throws IOException
    {
    	System.out.println("MDJ: 回调方法触发！\n");
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));

		String line = null;
		String return_code = null;
		String result_code = null;
		String noncestr = null;
		String out_trade_no = null;

		try {
			while ((line = br.readLine()) != null) {
				System.out.print("MDJ: notify" + line + "\n");

				if (line.contains("<return_code>")) {
					return_code = line.replaceAll("<return_code><\\!\\[CDATA\\[", "") .replaceAll("\\]\\]></return_code>", "");
				} else if (line.contains("<out_trade_no>")) {
					out_trade_no = line.replaceAll("<out_trade_no><\\!\\[CDATA\\[", "").replaceAll("\\]\\]></out_trade_no>", "");
				} else if (line.contains("<result_code>")) {
					result_code = line.replaceAll("<result_code><\\!\\[CDATA\\[", "").replaceAll("\\]\\]></result_code>", "");
				}
			}

			System.out.println("MDJ: notify return_code: " + return_code + "\n");
			System.out.println("MDJ: notify out_trade_no: " + out_trade_no + "\n");
			System.out.println("MDJ: notify result_code: " + result_code + "\n");

			if (return_code.contains("SUCCESS") && 
					result_code.contains("SUCCESS") && 
					null != out_trade_no)
			{
				TdOrder order = tdOrderService.findByOrderNumber(out_trade_no);

				if (null != order)
				{
					afterPaySuccess(order);
				}
				
				String content = "<xml>\n"
						+ "<result_code>SUCCESS</result_code>\n"
						+ "<return_code></return_code>\n"
						+ "</xml>\n";

				System.out.print("MDJ: return xml=" + content + "\n");

				try {
					// 把xml字符串写入响应
					byte[] xmlData = content.getBytes();

					response.setContentType("text/xml");
					response.setContentLength(xmlData.length);

					ServletOutputStream os = response.getOutputStream();
					os.write(xmlData);

					os.flush();
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			br.close();
		}
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
        if (null != tdOrder.getTypeId() && tdOrder.getTypeId().equals(3L))
        {
            Date nextTime = new Date();

            Calendar calendar = Calendar.getInstance();

            calendar.setTime(nextTime);

            calendar.add(Calendar.DATE, 30); 
            
            tdUser.setLastFlashBuyTime(calendar.getTime());
            tdUser = tdUserService.save(tdUser);
        }
        
        if (tdOrder.getStatusId().equals(2L))
        {
            tdOrder.setPayTime(new Date()); // 设置付款时间
        }
        else
        {
//            tdOrder.setPayLeftTime(new Date()); // 设置付尾款时间
        }

      
        // 待发货
        tdOrder.setStatusId(3L);
        tdOrder = tdOrderService.save(tdOrder);
       

        // 虚拟货币扣除
        if (null != tdOrder.getVirtualCurrencyUse() && null != tdUser.getVirtualCurrency()) {
        	if (tdUser.getVirtualCurrency() > tdOrder.getVirtualCurrencyUse()) {
				tdUser.setVirtualCurrency(tdUser.getVirtualCurrency() - tdOrder.getVirtualCurrencyUse());
			}else {
				tdUser.setVirtualCurrency(0.0);
			}
        	tdUserService.save(tdUser);
		}
        
        // 分享用户
        
        // 分销用户返利（下级用户返利给上级用户）
        if (null != tdUser.getUpperUsername()) {
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation()) {
				Double totalReturn = tdOrder.getTotalPrice() * tdSetting.getReturnRation();
				
				if (totalReturn < 0) {
					totalReturn = 0.0;
				}
				
				TdUser upperuser = tdUserService.findByUsername(tdUser.getUpperUsername());
				if (null != upperuser) {
					// 返现总笔数
					if (null != upperuser.getTotalCashRewardsNumber()) {
						upperuser.setTotalCashRewardsNumber(upperuser.getTotalCashRewardsNumber() + 1);
					}else {
						upperuser.setTotalCashRewardsNumber(1L);
					}
					
					// 返现金额
					if (null != upperuser.getTotalCashRewards()) {
						upperuser.setTotalCashRewards((long) (upperuser.getTotalCashRewards() + totalReturn));
					}else {
						upperuser.setTotalCashRewards((long) (totalReturn + 0L));
					}
				}
				// 返现给上级用户总数
				if (null != tdUser.getTotalCashRewardsToUpuser()) {
					tdUser.setTotalCashRewardsToUpuser((long) (tdUser.getTotalCashRewardsToUpuser() + totalReturn));
				}else {
					tdUser.setTotalCashRewardsToUpuser((long) (totalReturn + 0L));
				}
			}			
		}

       
    }
}
