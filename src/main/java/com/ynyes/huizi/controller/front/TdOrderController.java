package com.ynyes.huizi.controller.front;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ynyes.huizi.entity.TdCartGoods;
import com.ynyes.huizi.entity.TdDeliveryType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdPayType;
import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.service.TdCartGoodsService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdDeliveryTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdOrderGoodsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdPayTypeService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.ClientConstant;

/**
 * 订单
 *
 */
@Controller
@RequestMapping("/order")
public class TdOrderController {

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

    @RequestMapping(value = "/info")
    public String orderInfo(HttpServletRequest req, HttpServletResponse resp,
            ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

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

        // 积分限制总和
        if (null != selectedGoodsList) {
            for (TdCartGoods cg : selectedGoodsList) {
                TdGoods goods = tdGoodsService.findOne(cg.getGoodsId());

                if (null != goods && null != goods.getPointLimited()) {
                    totalPointLimited += goods.getPointLimited()
                            * cg.getQuantity();
                }
            }
        }

        map.addAttribute("total_point_limit", totalPointLimited);
        map.addAttribute("pay_type_list", tdPayTypeService.findByIsEnableTrue());
        map.addAttribute("delivery_type_list",
                tdDeliveryTypeService.findByIsEnableTrue());
        map.addAttribute("selected_goods_list", selectedGoodsList);

        tdCommonService.setHeader(map, req);

        return "/client/order_info";
    }

    @RequestMapping(value = "/goods/{type}")
    public String orderEdit(HttpServletRequest req, HttpServletResponse resp,
            @PathVariable String type, Long gid, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        // 把所有的购物车项转到该登陆用户下
        List<TdCartGoods> cgList = tdCartGoodsService
                .findByUsernameAndIsSelectedTrue(username);

        if (null != cgList && null != type && null != gid) {
            for (TdCartGoods cg : cgList) {
                if (gid.equals(cg.getGoodsId())) {
                	/**
					 * @author lc
					 * @注释：如果是抢购数量不变
					 */
                	if (1==cg.getQiang()) {
						break;
					}else{
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
                }
            }
        }
//        
//        List<TdCartGoods> selectedGoodsList = tdCartGoodsService.findByUsernameAndIsSelectedTrue(username);
//        map.addAttribute("selected_goods_list", selectedGoodsList);

        return "redirect:/order/info";
    }

    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public String submit(Long addressId, Long payTypeId, Long deliveryTypeId,
            Long pointUse, Boolean isNeedInvoice, String invoiceTitle,
            HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }

        if (null == addressId || null == payTypeId || null == deliveryTypeId
                || null == isNeedInvoice) {
            return "redirect:/order/info";
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        TdPayType payType = tdPayTypeService.findOne(payTypeId);
        TdDeliveryType deliveryType = tdDeliveryTypeService
                .findOne(deliveryTypeId);
        TdShippingAddress address = null;

        if (null == pointUse) {
            pointUse = 0L;
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

        if (null != cartGoodsList) {
            for (TdCartGoods cartGoods : cartGoodsList) {
                if (cartGoods.getIsSelected()) {
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
        tdOrder.setDeliverTypeId(deliveryType.getId());
        tdOrder.setDeliverTypeTitle(deliveryType.getTitle());
        tdOrder.setDeliverTypeFee(deliveryType.getFee());

        // 发票
        tdOrder.setIsNeedInvoice(isNeedInvoice);
        tdOrder.setInvoiceTitle(invoiceTitle);

        // 订单商品
        tdOrder.setOrderGoodsList(orderGoodsList);
        tdOrder.setTotalGoodsPrice(totalPrice);
        // 使用积分
        tdOrder.setPointUse(pointUse);
        tdOrder.setTotalPrice(totalPrice + deliveryType.getFee() - pointUse);

        // 积分奖励
        tdOrder.setPoints(0L);

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
}
