package com.ynyes.huizi.controller.front;

import static org.apache.commons.lang3.StringUtils.leftPad;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
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
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huizhidian.payment.alipay.AlipayConfig;
import com.huizhidian.payment.alipay.Constants;
import com.huizhidian.payment.alipay.PaymentChannelAlipay;
import com.huizhidian.payment.alipay.core.AlipayNotify;
import com.ibm.icu.util.Calendar;
import com.tencent.common.Configure;
import com.tencent.common.MD5;
import com.tencent.common.RandomStringGenerator;
import com.ynyes.huizi.entity.TdCartGoods;
import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
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
import com.ynyes.huizi.service.TdShippingAddressService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.ClientConstant;
import com.ynyes.huizi.util.QRCodeUtils;

/**
 * 订单
 *
 */
@Controller
@RequestMapping("/order")
public class TdOrderController extends AbstractPaytypeController{

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
    private TdShippingAddressService tdShippingAddressService;
    
    @Autowired
    private TdPayRecordService tdPayRecordService;
    
//    @Autowired
//    private PaymentChannelAlipay payChannelAlipay;
    
//    @Autowired
//    private PaymentChannelCEB payChannelCEB;
    
    @RequestMapping(value="/codDistrict",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(String province, String city, String disctrict, Long addressId,
                HttpServletRequest request) {
        Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        if (null == addressId) {
        	if (null == province || null == city) {
    			res.put("msg", "地址不存在");
    			return res;
    		}
            
            List<TdShippingAddress> tdShippingAddresses = tdShippingAddressService.findByIsCod();
            if (null !=tdShippingAddresses && tdShippingAddresses.size() > 0) {
    			for(TdShippingAddress tdShippingAddress : tdShippingAddresses){
    				if (null != tdShippingAddress.getDisctrict()) {
    					if (tdShippingAddress.getProvince().equals(province) && tdShippingAddress.getCity().equals(city) && tdShippingAddress.getDisctrict().equals(disctrict)) {
    						 res.put("code", 0);
    						 return res;
    					}
    				}else {
    					if (tdShippingAddress.getProvince().equals(province) && tdShippingAddress.getCity().equals(city) ) {
    						 res.put("code", 0);
    						 return res;
    					}
    				}
    			}
    		}
            res.put("msg", "已选收货地址不支持货到付款");      
            return res;
		}else {
			TdShippingAddress tdShippingAdd = tdShippingAddressService.findOne(addressId);
			
			List<TdShippingAddress> tdShippingAddresses = tdShippingAddressService.findByIsCod();
            if (null !=tdShippingAddresses && tdShippingAddresses.size() > 0) {
    			for(TdShippingAddress tdShippingAddress : tdShippingAddresses){
    				if (null != tdShippingAddress.getDisctrict()) {
    					if (tdShippingAddress.getProvince().equals(tdShippingAdd.getProvince()) && tdShippingAddress.getCity().equals(tdShippingAdd.getCity()) && tdShippingAddress.getDisctrict().equals(tdShippingAdd.getDisctrict())) {
    						 res.put("code", 0);
    						 return res;
    					}
    				}else {
    					if (tdShippingAddress.getProvince().equals(tdShippingAdd.getProvince()) && tdShippingAddress.getCity().equals(tdShippingAdd.getCity()) ) {
    						 res.put("code", 0);
    						 return res;
    					}
    				}
    			}
    		}
            res.put("msg", "已选收货地址不支持货到付款");      
            return res;
		}
        
    }
    
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
    public String orderBuy(@PathVariable String type, Long quantity, Long gid, String zhid,Long shareId,
            HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null !=  shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
        if (null == quantity || quantity < 0)
        {
        	quantity = 1L;
        }
        
        if (null == username) {
            return "redirect:/login";
        }

        if (null == type || null == gid) {
            return "/client/error_404";
        }

        List<TdGoodsDto> tdGoodsList = new ArrayList<TdGoodsDto>();

        // 组合购买
        if (type.equalsIgnoreCase("comb")) {
            // 购买商品
            TdGoods goods = tdGoodsService.findOne(gid);

            if (null == goods) {
                return "/client/error_404";
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
            
            buyGoods.setQuantity(quantity);
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
                return "/client/error_404";
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
                return "/client/error_404";
            }
            
            buyGoods.setPrice(flashSalePrice);
            buyGoods.setQuantity(quantity);
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
                return "/client/error_404";
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
            
            buyGoods.setQuantity(quantity);
            buyGoods.setSaleId(3);

            tdGoodsList.add(buyGoods);
        }
        // 正常立即购买
        else
        {
        	 // 购买商品
            TdGoods goods = tdGoodsService.findOne(gid);

            if (null == goods) {
                return "/client/error_404";
            }           
            
            // 积分限额
            TdUser tdUser = tdUserService.findByUsername(username);
            if (null != tdUser ) {
				if (null != tdUser.getTotalPoints() && null != goods.getPointLimited()) {
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
            
            buyGoods.setQuantity(quantity);
            buyGoods.setSaleId(0);

            tdGoodsList.add(buyGoods);
            map.addAttribute("selected_goods_list", tdGoodsList);
            
            // 查询购物车的所有种类
            List<String> productIds = new ArrayList<>();
          
            if (productIds.isEmpty()) {
            		if (null != goods.getCategoryIdTree()) {
            			productIds.add(goods.getCategoryIdTree().split(",")[0]);// 根类别
					}                  
            } else {
                  if (null != goods.getCategoryIdTree() && !productIds
                            .contains(goods.getCategoryIdTree().split(",")[0])) {
                        productIds.add(goods.getCategoryIdTree().split(",")[0]);
                  }
            }
            
            Double totalPrice = 0.0; // 购物总额
            
            totalPrice = buyGoods.getPrice() * buyGoods.getQuantity();
            
         // 如果有不同种类的商品则不能使用优惠券
            if (productIds.size() < 2) {
                List<TdCoupon> userCoupons = null;
                if (null != tdUser.getMobile()) {
                    userCoupons = tdCouponService.findByMobileAndIsUseable(tdUser
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

        }

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
        
        if (type.equalsIgnoreCase("comb"))
        {
            return "/client/order_buy_zh";
        }
        else if (type.equalsIgnoreCase("qiang"))
        {
            return "/client/order_buy_qiang";
        }
        else if (type.equalsIgnoreCase("tuan"))
        {
            return "/client/order_buy_tuan";
        }
        else
        {
            return "/client/order_buy_ordinary";
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
            Double totalPostage, Double virtualCurrency,
            String appointmentTime, HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        if (null == user) {
            return "/client/error_404";
        }

        String buyType = (String) req.getSession().getAttribute("buyType");

        if (null == buyType) {
            return "/client/error_404";
        }

        // 虚拟货币
        if (null == virtualCurrency) {
        	virtualCurrency = 0.0;
		}     
        
        double payTypeFee = 0.0;
        double deliveryTypeFee = 0.0;
        double pointFee = 0.0;
        double couponFee = 0.0;

        // 订单商品
        List<TdOrderGoods> orderGoodsList = new ArrayList<TdOrderGoods>();

        // 商品总价
        Double totalGoodsPrice = 0.0;
        
        // 总运费
        Double totalFeePrice = 0.0;
        if (null ==totalPostage) {
        	totalPostage = 0.0;
		}
        
        // 商品总尾款
        Double totalLeftPrice = 0.0;

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
                        return "/client/error_404";
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
                        totalGoodsPrice += buyGoods.getPrice() * buyGoods.getQuantity();
                    }

                    // 是否免邮
                   if(null !=goods.getIsFeeNot() && !goods.getIsFeeNot() && null != goods.getPostage())
                   {
                	   // 邮费
                	   totalFeePrice += goods.getPostage() * buyGoods.getQuantity();
                   }
                    
                    // 数量
                    orderGoods.setQuantity( buyGoods.getQuantity());

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

                    soldNumber += buyGoods.getQuantity();
                    goods.setSoldNumber(soldNumber);
                    goods.setLeftNumber(leftNumber - buyGoods.getQuantity());

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
                        return "/client/error_404";
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
                        return "/client/error_404";
                    }
                    
                    orderGoods.setPrice(flashSalePrice);

                    // 抢购
                    orderGoods.setGoodsSaleType(2);

                    // 商品总价
                    totalGoodsPrice += flashSalePrice;

                    // 是否免邮
                    if(null != goods.getIsFeeNot() && !goods.getIsFeeNot() && null != goods.getPostage())
                    {
                 	   // 邮费
                 	   totalFeePrice += goods.getPostage();
                    }
                    
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
                        return "/client/error_404";
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

             
                    if (null != goods.getGroupSalePrice()) {
                    	orderGoods.setPrice(goods.getGroupSalePrice());
                    	// 商品总价
                        totalGoodsPrice += goods.getGroupSalePrice() * buyGoods.getQuantity();
					}
                    
                    // 十人团
                    orderGoods.setGoodsSaleType(3);

                    
                    
                    // 是否免邮
                    if(null != goods.getIsFeeNot() && !goods.getIsFeeNot() && null != goods.getPostage())
                    {
                 	   // 邮费
                 	   totalFeePrice += goods.getPostage() * buyGoods.getQuantity();
                    }

                    // 尾款
//                    totalLeftPrice = goods.getGroupSaleTenPrice()
//                            - goods.getGroupSalePrice();
                    
                    if (totalLeftPrice < 0) {
                        totalLeftPrice = 0.0;
                    }

                    // 数量
                    orderGoods.setQuantity(buyGoods.getQuantity());

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

                    groupSoldNumber += buyGoods.getQuantity();
                    goods.setGroupSaleSoldNumber(groupSoldNumber);
                    goods.setGroupSaleLeftNumber(groupLeftNumber - buyGoods.getQuantity());

                    // 保存商品
                    tdGoodsService.save(goods, username);
                }
            }
        }else {  //普通立即购买
        	@SuppressWarnings("unchecked")
            List<TdGoodsDto> tdGoodsList = (List<TdGoodsDto>) req.getSession()
                    .getAttribute("buy_goods_list");

            if (null != tdGoodsList && tdGoodsList.size() > 0) {
                for (TdGoodsDto buyGoods : tdGoodsList) {
                    // 原商品
                    TdGoods goods = tdGoodsService.findOne(buyGoods
                            .getGoodsId());

                    // 不存在该商品或已下架或已不在秒杀，则跳过
                    if (null == goods || !goods.getIsOnSale() ) {
                        return "/client/error_404";
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
                    
                    // 价格 
                    if (null != goods.getSalePrice()) {
                    	orderGoods.setPrice(goods.getSalePrice());
                    	 // 商品总价
                        totalGoodsPrice += (goods.getSalePrice() * buyGoods.getQuantity());
					}
                    
                    // 普通购买
                    orderGoods.setGoodsSaleType(0);

                   
                    // 是否免邮
                    if(null != goods.getIsFeeNot() && !goods.getIsFeeNot() && null != goods.getPostage())
                    {
                 	   // 邮费
                 	   totalFeePrice += goods.getPostage() * buyGoods.getQuantity();
                    }
                    
                    // 数量
                    orderGoods.setQuantity(buyGoods.getQuantity());

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

                    soldNumber += buyGoods.getQuantity();
                    goods.setSoldNumber(soldNumber);
                    goods.setLeftNumber(leftNumber - buyGoods.getQuantity());

                    // 保存商品
                    tdGoodsService.save(goods, username);
                    
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
            }
		}      
       
        if (null == orderGoodsList || orderGoodsList.size() <= 0) {
            return "/client/error_404";
        }

        // 配送信息
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
        tdOrder.setOrderNumber("P" + curStr
                + leftPad(Integer.toString(random.nextInt(999)), 3, "0"));

        // 配送信息
        if (null != address) {
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
//        if (null != deliveryTypeId) {
//            TdDeliveryType deliveryType = tdDeliveryTypeService
//                    .findOne(deliveryTypeId);
//            tdOrder.setDeliverTypeId(deliveryType.getId());
//            tdOrder.setDeliverTypeTitle(deliveryType.getTitle());
//            tdOrder.setDeliverTypeFee(deliveryType.getFee());
//            deliveryTypeFee = deliveryType.getFee();
//        }
        tdOrder.setDeliverTypeFee(totalPostage);
        
        
        // 用户留言
        tdOrder.setUserRemarkInfo(userMessage);

        if (buyType.equalsIgnoreCase("normal"))
        {
            // 使用积分
            tdOrder.setPointUse(pointUse);

            // 优惠券
            if (null != couponId) {
                TdCoupon coupon = tdCouponService.findOne(couponId);

                if (null != coupon) {
                    TdCouponType couponType = tdCouponTypeService
                            .findOne(coupon.getId());

                    couponFee = couponType.getPrice();
                    coupon.setIsUsed(true);
                    tdCouponService.save(coupon);
                }
            }

            // 粮草奖励
            tdOrder.setPoints(totalPointReturn);

            pointFee = pointUse / 1;

            // 总价
            tdOrder.setTotalPrice(totalGoodsPrice + payTypeFee
                    + deliveryTypeFee + totalPostage - pointFee - couponFee - virtualCurrency);
            
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

//    	// 总价
//        
//        tdOrder.setTotalPrice(totalGoodsPrice + payTypeFee + deliveryTypeFee + totalPostage);
        
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
        tdOrder.setTypeId(1L);
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
        	else if (tdOrderGoods.getGoodsSaleType() == 0) {
        		tdOrder.setTypeId(1L);
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

         if (tdOrder.getIsOnlinePay()) {
        	 if (tdOrder.getTotalPrice() == 0) {
     			afterPaySuccess(tdOrder);
     		}
        	 return "redirect:/order/pay?orderId=" + tdOrder.getId();
         }

        return "redirect:/order/success?orderId=" + tdOrder.getId();
    }
    
    @RequestMapping(value = "/info")
    public String orderInfo(HttpServletRequest req, HttpServletResponse resp, Long shareId,
            ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null !=  shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
        if (null == username) {
            return "redirect:/login";
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

        List<TdCartGoods> selectedGoodsList = tdCartGoodsService
                .findByUsernameAndIsSelectedTrue(username);

        Long totalPointLimited = 0L;
        Double totalPrice = 0.0; // 购物总额
        // 积分限制总和
        if (null != selectedGoodsList) {
            for (TdCartGoods cg : selectedGoodsList) {
                TdGoods goods = tdGoodsService.findOne(cg.getGoodsId());

                if (null != goods && null != goods.getPointLimited()) {
                    totalPointLimited += goods.getPointLimited()
                            * cg.getQuantity();
                    totalPrice += cg.getPrice() * cg.getQuantity();
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
        map.addAttribute("pay_type_list", tdPayTypeService.findByIsEnableTrue());
        
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
               
        map.addAttribute("delivery_type_list",
                tdDeliveryTypeService.findByIsEnableTrue());
        map.addAttribute("selected_goods_list", selectedGoodsList);

        tdCommonService.setHeader(map, req);

        return "/client/order_info";
    }

    @RequestMapping(value = "/goods/{type}")
    public String orderEdit(HttpServletRequest req, HttpServletResponse resp,Long shareId,
            @PathVariable String type, Long gid, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
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
//        
//        List<TdCartGoods> selectedGoodsList = tdCartGoodsService.findByUsernameAndIsSelectedTrue(username);
//        map.addAttribute("selected_goods_list", selectedGoodsList);

        return "redirect:/order/info";
    }

    /**
	 * @author lc
	 * @注释：立即购买商品数量加减
	 */
    @RequestMapping(value = "/buygoods/{type}")
    public String orderBuyEdit(HttpServletRequest req, HttpServletResponse resp,Long shareId,
            @PathVariable String type, Long gid, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        // 把所有的购物车项转到该登陆用户下
//        List<TdCartGoods> cgList = tdCartGoodsService
//                .findByUsernameAndIsSelectedTrue(username);

        @SuppressWarnings("unchecked")
		List<TdGoodsDto> cgList = (List<TdGoodsDto>) req.getSession()
                .getAttribute("buy_goods_list");
        
        if (null != cgList && null != type && null != gid) {
            for (TdGoodsDto cg : cgList) {
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

                        return "redirect:/order/buy/normal?gid=" + cg.getGoodsId() +"&quantity=" + cg.getQuantity() + "&shareId="  ;

                    }
				  
                }
            }
        }
               
//        
//        List<TdCartGoods> selectedGoodsList = tdCartGoodsService.findByUsernameAndIsSelectedTrue(username);
//        map.addAttribute("selected_goods_list", selectedGoodsList);

        return "redirect:/order/info";
    }
    
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public String submit(Long addressId, Long payTypeId, Long deliveryTypeId, Long couponId,
            Long pointUse, Boolean isNeedInvoice, String invoiceTitle,String userRemarkInfo, Double virtualCurrency, Double totalPostage,
            HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        if (null == addressId || null == payTypeId 
                || null == isNeedInvoice) {
            return "redirect:/order/info";
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        TdPayType payType = tdPayTypeService.findOne(payTypeId);
//        TdDeliveryType deliveryType = tdDeliveryTypeService
//                .findOne(1L);
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
	                        	   if ((sharedUser.getPointGetByShareGoods()+totalSharePoints) < setting.getGoodsShareLimits()) {
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

        //订单配送备注
        if (null != userRemarkInfo) {
        	tdOrder.setUserRemarkInfo(userRemarkInfo);
		}
        
        //保存分享商品用户可获取积分
        tdOrder.setTotalSharePoints(totalSharePoints);
        
        // 虚拟币使用
        tdOrder.setVirtualCurrencyUse(virtualCurrency);
        
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

        if (tdOrder.getIsOnlinePay()) {
        	
        	if (tdOrder.getTotalPrice() == 0) {
    			afterPaySuccess(tdOrder);
    		}
            return "redirect:/order/pay?orderId=" + tdOrder.getId();
        }

        return "redirect:/order/success?orderId=" + tdOrder.getId();
    }

    @RequestMapping(value = "/pay")
    public String pay(Long orderId, ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

        if (null == orderId) {
            return "/client/error_404";
        }

        map.addAttribute("order", tdOrderService.findOne(orderId));

        return "/client/order_pay";
    }

    @RequestMapping(value = "/success")
    public String success(Long orderId, ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

        if (null == orderId) {
            return "/client/error_404";
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
        
        return "/client/order_success";
    }

    @RequestMapping(value = "/pay/success")
    public String paySuccess(ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);

        return "/client/order_pay_success";
    }
    
    /**
     * 支付
     * 
     * @param orderId
     * @param map
     * @param req
     * @return
     */
    @RequestMapping(value = "/dopay/{orderId}")
    public String payOrder(@PathVariable Long orderId, ModelMap map,
            HttpServletRequest req) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        tdCommonService.setHeader(map, req);

        if (null == orderId) {
            return "/client/error_404";
        }

        TdOrder order = tdOrderService.findOne(orderId);

        if (null == order) {
            return "/client/error_404";
        }

        // 根据订单类型来判断支付时间是否过期
//        if (order.getTypeId().equals(3L)) { // 抢拍 订单提交后30分钟内
//            Date cur = new Date();
//            long temp = cur.getTime() - order.getOrderTime().getTime();
//            // System.out.println(temp);
//            if (temp > 1000 * 60 * 30) {
//                return "/client/overtime";
//            }
//        }
//        else if (order.getTypeId().equals(4L) || order.getTypeId().equals(5L)) { // 团购
//                                                                                   // 预付是团购结束前，
//            Date cur = new Date();
//            long temp = 0L;
////            if (temp > 1000 * 3600 * 12) {
////                return "/client/overtime";
////            }
//            TdGoods tdGoods = tdGoodsService.findOne(order.getOrderGoodsList().get(0).getGoodsId());
//            if (null != tdGoods) {
//				if (order.getTypeId().equals(4L)) {
//					temp = cur.getTime() - tdGoods.getGroupSaleStopTime().getTime();
//				}else if (order.getTypeId().equals(5L)) {
//					temp = cur.getTime() - tdGoods.getGroupSaleHundredStopTime().getTime();
//				}
//				if (temp > 0) {
//                    return "/client/overtime";
//                }
//			}
//
//        } else { // 普通 订单提交后24小时内
//            Date cur = new Date();
//            long temp = cur.getTime() - order.getOrderTime().getTime();
//            if (temp > 1000 * 3600 * 24) {
//                return "/client/overtime";
//            }
//        }

        // 待付款
        if (!order.getStatusId().equals(2L)) {
            return "/client/error_404";
        }

        String amount = order.getTotalPrice().toString();
        req.setAttribute("totalPrice", amount);

        String payForm = "";

        Long payId = order.getPayTypeId();
        TdPayType payType = tdPayTypeService.findOne(payId);
        if (payType != null) {
            TdPayRecord record = new TdPayRecord();
            record.setCreateTime(new Date());
            record.setOrderId(order.getId());
            record.setPayTypeId(payType.getId());
            record.setStatusCode(1);
            record.setCreateTime(new Date());
            record = tdPayRecordService.save(record);

            String payRecordId = record.getId().toString();
            int recordLength = payRecordId.length();
            if (recordLength > 6) {
                payRecordId = payRecordId.substring(recordLength - 6);
            } else {
                payRecordId = leftPad(payRecordId, 6, "0");
            }
            req.setAttribute("payRecordId", payRecordId);

            req.setAttribute("orderNumber", order.getOrderNumber());

            String payCode = payType.getCode();
            if (PAYMENT_ALI.equals(payCode)) {
            	PaymentChannelAlipay payChannelAlipay = new PaymentChannelAlipay();
                payForm = payChannelAlipay.getPayFormData(req);
                map.addAttribute("charset", AlipayConfig.CHARSET);
            } else if (PAYMENT_WX.equals(payCode)) {
                map.addAttribute("order_number", order.getOrderNumber());
                map.addAttribute("total_price", order.getTotalPrice());

                String sa = "appid=" + Configure.getAppid() + "&mch_id="
                        + Configure.getMchid() + "&nonce_str="
                        + RandomStringGenerator.getRandomStringByLength(32)
                        + "&product_id=" + order.getId() + "&time_stamp="
                        + System.currentTimeMillis() / 1000;

                String sign = MD5.MD5Encode(
                        sa + "&key=192006250b4c09247ec02edce69f6acy")
                        .toUpperCase();

                System.out.print("Sharon: weixin://wxpay/bizpayurl?" + sa
                        + "&sign=" + sign + "\n");

                req.getSession().setAttribute("WXPAYURLSESSEION",
                        "weixin://wxpay/bizpayurl?" + sa + "&sign=" + sign);
                // "weixin://wxpay/bizpayurl?appid=wx2421b1c4370ec43b&mch_id=10000100&nonce_str=f6808210402125e30663234f94c87a8c&product_id=1&time_stamp=1415949957&sign=512F68131DD251DA4A45DA79CC7EFE9D");
                return "/client/order_pay_wx";
//            }
//                else if (CEBPayConfig.INTER_B2C_BANK_CONFIG.keySet().contains(
//                    payCode)) {
//                req.setAttribute("payMethod", payCode);
//                payForm = payChannelCEB.getPayFormData(req);
//                map.addAttribute("charset", "GBK");
          } else {
                // 其他目前未实现的支付方式
                return "/client/error_404";
            }
        } else {
            return "/client/error_404";
        }

        tdOrderService.save(order);

        map.addAttribute("payForm", payForm);

        return "/client/order_pay_form";
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
    @RequestMapping(value = "/pay/result_alipay")
    public String payResultAlipay(Device device, ModelMap map, HttpServletRequest req,
            HttpServletResponse resp) {
        Map<String, String> params = new HashMap<String, String>();
        Map<String, String[]> requestParams = req.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter
                .hasNext();) {
            String name = iter.next();
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            // 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
            try {
                valueStr = new String(valueStr.getBytes("ISO-8859-1"),
                        AlipayConfig.CHARSET);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            params.put(name, valueStr);
        }

        // 获取支付宝的返回参数
        String orderNo = "";
        String trade_status = "";
        try {
            // 商户订单号
            orderNo = new String(req.getParameter(Constants.KEY_OUT_TRADE_NO)
                    .getBytes("ISO-8859-1"), AlipayConfig.CHARSET);
            // 交易状态
            trade_status = new String(req.getParameter("trade_status")
                    .getBytes("ISO-8859-1"), AlipayConfig.CHARSET);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 计算得出通知验证结果
        boolean verify_result = AlipayNotify.verify(params);

        tdCommonService.setHeader(map, req);
        orderNo = (orderNo == null) ? "" : (orderNo.length() < 6) ? orderNo
                : orderNo.substring(0, orderNo.length() - 6);
        TdOrder order = tdOrderService.findByOrderNumber(orderNo);
        if (order == null) {
            // 订单不存在
        	// 触屏
            if (device.isMobile() || device.isTablet()) {
                return "/touch/order_pay_failed";
            }
            return "/client/order_pay_failed";
        }
        map.put("order", order);
        if (verify_result) {// 验证成功
            if ("TRADE_SUCCESS".equals(trade_status)) {

                // 订单支付成功
                afterPaySuccess(order);
                // 触屏
                if (device.isMobile() || device.isTablet()) {
                    return "/touch/order_pay_success";
                }
                return "/client/order_pay_success";
            }
        }

        // 验证失败或者支付失败
        // 触屏
        if (device.isMobile() || device.isTablet()) {
            return "/touch/order_pay_failed";
        }
        return "/client/order_pay_failed";
    }
    
    @RequestMapping(value = "/wx_return")
    public void wx_return(HttpServletResponse response,
            HttpServletRequest request) throws Exception {
        /**
         * <xml> <appid><![CDATA[wx8a4517e0f1b3536a]]></appid>
         * <openid><![CDATA[od6bXt6a8VHV7cjB21j8O6zwVOIU]]></openid>
         * <mch_id><![CDATA[1265095501]]></mch_id>
         * <is_subscribe><![CDATA[N]]></is_subscribe>
         * <nonce_str><![CDATA[XyodZmN32CcaPoub]]></nonce_str>
         * <product_id><![CDATA[b15091419521303]]></product_id>
         * <sign><![CDATA[CDF42D34EE39FBDADD3A0B0951AC2F4B]]></sign> </xml>
         */

        BufferedReader br = new BufferedReader(new InputStreamReader(
                request.getInputStream()));

        String line = null;
        String result = "";
        String productid = null;
        String openid = null;

        try {
            while ((line = br.readLine()) != null) {
                if (line.contains("<openid>")) {
                    openid = line.replaceAll("<openid><\\!\\[CDATA\\[", "")
                            .replaceAll("\\]\\]></openid>", "");
                } else if (line.contains("<product_id>")) {
                    productid = line.replaceAll("<product_id><\\!\\[CDATA\\[",
                            "").replaceAll("\\]\\]></product_id>", "");
                }

                result += line + "\r\n";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            br.close();
        }

        System.out.print("Sharon: xml->" + result + "\n");

        System.out.print("Sharon: openid:" + openid + "----productid:"
                + productid + "\n");

        if (null == productid) {
            return;
        }

        Long orderId = Long.parseLong(productid);

        System.out.println("Sharon: orderId:" + orderId);

        TdOrder order = tdOrderService.findOne(orderId);

        if (null == order) {
            return;
        }

        // SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calExpire = Calendar.getInstance();
        calExpire.setTime(order.getOrderTime());

        // 根据订单类型来判断支付时间是否过期
        if (order.getTypeId().equals(3L)) { // 抢拍 订单提交后30分钟内
            calExpire.add(Calendar.MINUTE, 30);
        } else if (order.getTypeId().equals(4L) || order.getTypeId().equals(5L)) { // 团购
                                                                                   // 预付是订单提交后12小时内，尾款支付也是12小时
            calExpire.add(Calendar.HOUR, 12);
        } else { // 普通 订单提交后24小时内
            calExpire.add(Calendar.DATE, 1);
        }

        String noncestr = RandomStringGenerator.getRandomStringByLength(32);
        
        long priceToPay = 0L;
        
        if (order.getStatusId().equals(2L) && null != order.getTotalPrice())
        {
            priceToPay = Math.round(order.getTotalPrice() * 100);
        }
//        else if (order.getStatusId().equals(3L) && null != order.getTotalLeftPrice())
//        {
//            priceToPay = Math.round(order.getTotalLeftPrice() * 100);
//        }

        String sa = "appid=" + Configure.getAppid() + "&attach=订单支付"
                + "&body=支付订单" + order.getOrderNumber() + "&mch_id="
                + Configure.getMchid() + "&nonce_str=" + noncestr
                + "&notify_url=http://www.huizhidian.com/order/wx_notify"
                + "&openid=" + openid + "&out_trade_no="
                + order.getOrderNumber() + order.getStatusId() + "&spbill_create_ip=116.55.230.207"
                + "&total_fee=" + priceToPay
                + "&trade_type=NATIVE";

        String sign = MD5.MD5Encode(
                sa + "&key=192006250b4c09247ec02edce69f6acy").toUpperCase();

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
                + "<notify_url>http://www.huizhidian.com/order/wx_notify</notify_url>\n"
                + "<openid>" + openid + "</openid>\n" 
                + "<out_trade_no>"
                + order.getOrderNumber() + order.getStatusId() 
                + "</out_trade_no>\n"
                + "<spbill_create_ip>116.55.230.207</spbill_create_ip>\n"
                + "<total_fee>" + priceToPay
                + "</total_fee>\n" + "<trade_type>NATIVE</trade_type>\n"
                + "<sign>" + sign + "</sign>\n" + "</xml>\n";

        System.out.print("Sharon: xml=" + content);

        String return_code = null;
        String prepay_id = null;
        String result_code = null;

        HttpsURLConnection urlCon = null;
        try {
            urlCon = (HttpsURLConnection) (new URL(
                    "https://api.mch.weixin.qq.com/pay/unifiedorder"))
                    .openConnection();
            urlCon.setDoInput(true);
            urlCon.setDoOutput(true);
            urlCon.setRequestMethod("POST");
            urlCon.setRequestProperty("Content-Length",
                    String.valueOf(content.getBytes().length));
            urlCon.setUseCaches(false);
            // 设置为gbk可以解决服务器接收时读取的数据中文乱码问题
            urlCon.getOutputStream().write(content.getBytes("utf-8"));
            urlCon.getOutputStream().flush();
            urlCon.getOutputStream().close();
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    urlCon.getInputStream()));

            while ((line = in.readLine()) != null) {
                System.out.println("Sharon: rline: " + line);
                if (line.contains("<return_code>")) {
                    return_code = line.replaceAll(
                            "<xml><return_code><\\!\\[CDATA\\[", "")
                            .replaceAll("\\]\\]></return_code>", "");
                } else if (line.contains("<prepay_id>")) {
                    prepay_id = line.replaceAll("<prepay_id><\\!\\[CDATA\\[",
                            "").replaceAll("\\]\\]></prepay_id>", "");
                } else if (line.contains("<result_code>")) {
                    result_code = line.replaceAll(
                            "<result_code><\\!\\[CDATA\\[", "").replaceAll(
                            "\\]\\]></result_code>", "");
                }
            }

            System.out.println("Sharon: return_code: " + return_code);
            System.out.println("Sharon: prepay_id: " + prepay_id);
            System.out.println("Sharon: result_code: " + result_code);

            if ("SUCCESS".equalsIgnoreCase(return_code)
                    && "SUCCESS".equalsIgnoreCase(result_code)
                    && null != prepay_id) {
                noncestr = RandomStringGenerator.getRandomStringByLength(32);
                sa = "appid=" + Configure.getAppid() + "&mch_id="
                        + Configure.getMchid() + "&nonce_str=" + noncestr
                        + "&prepay_id=" + prepay_id + "&result_code=SUCCESS"
                        + "&return_code=SUCCESS";

                sign = MD5.MD5Encode(
                        sa + "&key=192006250b4c09247ec02edce69f6acy")
                        .toUpperCase();

                content = "<xml>\n" + "<appid>" + Configure.getAppid()
                        + "</appid>\n" + "<mch_id>" + Configure.getMchid()
                        + "</mch_id>\n" + "<nonce_str>" + noncestr
                        + "</nonce_str>\n" + "<prepay_id>" + prepay_id
                        + "</prepay_id>\n"
                        + "<result_code>SUCCESS</result_code>\n"
                        + "<return_code>SUCCESS</return_code>\n" + "<sign>"
                        + sign + "</sign>\n" + "</xml>\n";

                System.out.print("Sharon: return xml=" + content);

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
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/wx_notify")
    public void wx_notify(HttpServletResponse response,
            HttpServletRequest request) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(
                request.getInputStream()));

        String line = null;
        String return_code = null;
        String result_code = null;
        String noncestr = null;
        String out_trade_no = null;

        try {
            while ((line = br.readLine()) != null) {
                System.out.print("Sharon: notify" + line + "\n");
                
                if (line.contains("<return_code>")) {
                    return_code = line.replaceAll("<return_code><\\!\\[CDATA\\[", "") .replaceAll("\\]\\]></return_code>", "");
                } else if (line.contains("<out_trade_no>")) {
                    out_trade_no = line.replaceAll("<out_trade_no><\\!\\[CDATA\\[", "").replaceAll("\\]\\]></out_trade_no>", "");
                } else if (line.contains("<result_code>")) {
                    result_code = line.replaceAll("<result_code><\\!\\[CDATA\\[", "").replaceAll("\\]\\]></result_code>", "");
                }
            }
            
            System.out.println("Sharon: notify return_code: " + return_code);
            System.out.println("Sharon: notify out_trade_no: " + out_trade_no);
            System.out.println("Sharon: notify result_code: " + result_code);
            
            if (return_code.contains("SUCCESS") && 
                    result_code.contains("SUCCESS") && 
                    null != out_trade_no)
            {
                TdOrder order = tdOrderService.findByOrderNumber(out_trade_no.substring(0, out_trade_no.length() - 1));
                
                if (null != order)
                {
                    afterPaySuccess(order);
                }
                
                noncestr = RandomStringGenerator.getRandomStringByLength(32);
                String sa = "appid=" + Configure.getAppid()
                        + "&mch_id=" + Configure.getMchid()
                        + "&nonce_str=" + noncestr
                        + "&result_code=SUCCESS"
                        + "&return_code=SUCCESS";
                
                String sign = MD5.MD5Encode(
                        sa + "&key=192006250b4c09247ec02edce69f6acy")
                        .toUpperCase();
                
                String content = "<xml>\n"
                        + "<appid>" + Configure.getAppid() + "</appid>\n"
                        + "<mch_id>" + Configure.getMchid() + "</mch_id>\n"
                        + "<nonce_str>" + noncestr + "</nonce_str>\n"
                        + "<result_code>SUCCESS</result_code>\n"
                        + "<return_code>SUCCESS</return_code>\n"
                        + "<sign>" + sign + "</sign>\n"
                        + "</xml>\n";
                
                System.out.print("Sharon: return xml=" + content);

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

    @RequestMapping(value = "/payqrcode", method = RequestMethod.GET)
    public void verify(HttpServletResponse response, HttpServletRequest request) {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);

        QRCodeUtils qr = new QRCodeUtils();
        String url = (String) request.getSession().getAttribute(
                "WXPAYURLSESSEION");
        qr.getQRCode(url, 300, response);
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
       
      
        // 待发货
        tdOrder.setStatusId(3L);
        tdOrder = tdOrderService.save(tdOrder);
       

        // 虚拟货币扣除
        
        // 分销用户返利
        
    }
}
