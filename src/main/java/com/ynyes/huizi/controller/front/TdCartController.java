package com.ynyes.huizi.controller.front;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ynyes.huizi.entity.TdCartGoods;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdGoodsCombination;
import com.ynyes.huizi.service.TdCartGoodsService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsCombinationService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.util.ClientConstant;

/**
 * 购物车
 *
 */
@Controller
public class TdCartController {

    @Autowired
    private TdCartGoodsService tdCartGoodsService;

    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdGoodsCombinationService tdGoodsCombinationService;

    @Autowired
    private TdCommonService tdCommonService;

    @RequestMapping(value = "/cart/init")
    public String addCart(Long id, Long quantity, String zpid, Integer qiang,
            HttpServletRequest req) {
        // 是否已登录
        boolean isLoggedIn = true;

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            isLoggedIn = false;
            username = req.getSession().getId();
        }
        
        if (null == quantity || quantity.compareTo(1L) < 0)
        {
            quantity = 1L;
        }

        if (null == qiang) {
            qiang = 0;
        }

        if (null != id) {
            TdGoods goods = tdGoodsService.findOne(id);

            if (null != goods) {
                
            	Date curr = new Date();
            	if (qiang.equals(1))
                {
                    if (null != goods.getIsFlashSale() 
                            && null != goods.getFlashSaleStartTime()
                            && null != goods.getFlashSaleStopTime()
                            && null != goods.getFlashSalePrice()
                            && goods.getIsFlashSale()
                            && goods.getFlashSaleStopTime().after(curr)
                            && goods.getFlashSaleStartTime().before(curr))
                    {
                     
                    }
                    else
                    {
                        qiang = 0;
                    }
                }
                List<TdCartGoods> oldCartGoodsList = null;
                
                // 抢购
                if (qiang.equals(1))
                {
                    if (goods.getIsGroupSale()
                            && goods.getFlashSaleStopTime().after(new Date())
                            && goods.getFlashSaleStartTime().before(new Date())) 
                    {
                        oldCartGoodsList = tdCartGoodsService
                                .findByGoodsIdAndPriceAndUsername(id, goods.getFlashSalePrice(), username);
                    }
                }
                else if (qiang.equals(3) || qiang.equals(7) || qiang.equals(10)) 
                {
                	if (goods.getIsGroupSale()
                            && goods.getGroupSaleStopTime().after(new Date())
                            && goods.getGroupSaleStartTime().before(new Date())) 
                    {
                        oldCartGoodsList = tdCartGoodsService
                                .findByGoodsIdAndPriceAndUsername(id, goods.getGroupSalePrice(), username);
                    }
				}
                else
                {
                    oldCartGoodsList = tdCartGoodsService
                        .findByGoodsIdAndPriceAndUsername(id, goods.getSalePrice(), username);
                }
                
                // 有多项，则删除
                if (null != oldCartGoodsList && oldCartGoodsList.size() > 1) {
                    tdCartGoodsService.delete(oldCartGoodsList);
                }
                // 仅有一项，数量相加
                else if (null != oldCartGoodsList && oldCartGoodsList.size() == 1)
                {
                	/**
					 * @author lc
					 * @注释：抢购数量不变
					 */
                	if (!qiang.equals(1)) {			
	                    long oldQuantity = oldCartGoodsList.get(0).getQuantity();
	                    oldCartGoodsList.get(0).setQuantity(oldQuantity + quantity);
	                    tdCartGoodsService.save(oldCartGoodsList.get(0));
                	}
                }
                else
                {

                    TdCartGoods cartGoods = new TdCartGoods();
    
                    cartGoods.setIsLoggedIn(isLoggedIn);
                    cartGoods.setUsername(username);
    
                    cartGoods.setIsSelected(true);
                    cartGoods.setGoodsId(goods.getId());
                    cartGoods.setGoodsCoverImageUri(goods.getCoverImageUri());
                    cartGoods.setGoodsTitle(goods.getTitle());
    
                    if (qiang.equals(1)) // 抢购价
                    {
                        if (goods.getIsFlashSale()
                                && goods.getFlashSaleStopTime().after(new Date())
                                && goods.getFlashSaleStartTime().before(new Date())) 
                        {
                            cartGoods.setPrice(goods.getFlashSalePrice());
                        }
                    }
                    else if (qiang.equals(3) || qiang.equals(7) || qiang.equals(10))
                    {
                        if (goods.getIsGroupSale()
                                && goods.getGroupSaleStopTime().after(new Date())
                                && goods.getGroupSaleStartTime().before(new Date())) 
                        {
                            cartGoods.setPrice(goods.getGroupSalePrice());
                        }
                    }
                    else // 正常价
                    {
                        cartGoods.setPrice(goods.getSalePrice());
                    }
                    /**
					 * @author lc
					 * @注释：抢购限量
					 */
                    if (qiang.equals(1)) {
                    	cartGoods.setQuantity(ClientConstant.qiangSize);
					}else{
						cartGoods.setQuantity(quantity);
					}
                    cartGoods.setQiang(qiang);
    
                    tdCartGoodsService.save(cartGoods);
                }
            }
            
            if (null != zpid && !zpid.isEmpty())
            {
                String[] zpidArray = zpid.split(",");
                
                for (String idStr : zpidArray)
                {
                    if (!idStr.isEmpty())
                    {
                        Long zid = Long.parseLong(idStr);
                        
                        if (null == zid)
                        {
                            continue;
                        }
                        
                        TdGoodsCombination combGoods = tdGoodsCombinationService.findOne(zid);
                        
                        if (null == combGoods)
                        {
                            continue;
                        }

                        TdCartGoods oldCartGoods = tdCartGoodsService
                                .findTopByGoodsIdAndPriceAndUsername(combGoods.getGoodsId(),
                                                                    combGoods.getCurrentPrice(),
                                                                    username);

                        if (null != oldCartGoods) 
                        {
                            oldCartGoods.setQuantity(oldCartGoods.getQuantity().longValue() + 1L);
                            tdCartGoodsService.save(oldCartGoods);
                        }
                        else
                        {
                            TdCartGoods cartGoods = new TdCartGoods();
    
                            cartGoods.setIsLoggedIn(isLoggedIn);
                            cartGoods.setUsername(username);
                            cartGoods.setIsSelected(true);
                            cartGoods.setGoodsId(combGoods.getGoodsId());
                            cartGoods.setGoodsCoverImageUri(combGoods.getCoverImageUri());
                            cartGoods.setGoodsTitle(combGoods.getGoodsTitle());
                            cartGoods.setPrice(combGoods.getCurrentPrice());
                            cartGoods.setQuantity(1L);
    
                            tdCartGoodsService.save(cartGoods);
                        }
                    }
                }
            }
        }

        return "redirect:/cart/add?id=" + id;
    }

    @RequestMapping(value = "/cart/add")
    public String cartInit(Long id, HttpServletRequest req, ModelMap map) {
        tdCommonService.setHeader(map, req);
        return "/client/cart_add_res";
    }
    
    @RequestMapping(value = "/cart")
    public String cart(HttpServletRequest req, ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        List<TdCartGoods> cartSessionGoodsList = tdCartGoodsService
                .findByUsername(req.getSession().getId());

        if (null == username) {
            username = req.getSession().getId();
        } else {
            // 合并商品
            List<TdCartGoods> cartUserGoodsList = tdCartGoodsService
                    .findByUsername(username);

            for (TdCartGoods cg : cartSessionGoodsList) {
                cg.setUsername(username);
                cartUserGoodsList.add(cg);
            }

            tdCartGoodsService.save(cartUserGoodsList);

            for (TdCartGoods cg1 : cartUserGoodsList) {
                List<TdCartGoods> findList = tdCartGoodsService
                        .findByGoodsIdAndPriceAndUsername(cg1.getGoodsId(), cg1.getPrice(), username);

                if (findList.size() > 1) {
                    tdCartGoodsService.delete(findList.subList(1,
                            findList.size()));
                }
            }
        }

        List<TdCartGoods> resList = tdCartGoodsService.findByUsername(username);
        map.addAttribute("cart_goods_list", resList);

        tdCommonService.setHeader(map, req);

        if (null == resList || resList.size() == 0) {
            return "/client/cart_null";
        }

        return "/client/cart";
    }

    @RequestMapping(value = "/cart/toggleSelect", method = RequestMethod.POST)
    public String cartToggle(Long id, HttpServletRequest req, ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            username = req.getSession().getId();
        }

        List<TdCartGoods> cartGoodsList = tdCartGoodsService
                .findByUsername(username);

        if (null != id) {
            for (TdCartGoods cartGoods : cartGoodsList) {
                if (cartGoods.getId().equals(id)) {
                    cartGoods.setIsSelected(!cartGoods.getIsSelected());
                    cartGoods = tdCartGoodsService.save(cartGoods);
                    break;
                }
            }
        }

        map.addAttribute("cart_goods_list", cartGoodsList);

        return "/client/cart_goods";
    }

    @RequestMapping(value = "/cart/toggleAll", method = RequestMethod.POST)
    public String cartToggleAll(Integer sid, HttpServletRequest req,
            ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            username = req.getSession().getId();
        }

        List<TdCartGoods> cartGoodsList = tdCartGoodsService
                .findByUsername(username);

        if (null != sid) {
            if (sid.equals(0)) // 全选
            {
                for (TdCartGoods cartGoods : cartGoodsList) {
                    cartGoods.setIsSelected(true);
                }
            } else // 取消全选
            {
                for (TdCartGoods cartGoods : cartGoodsList) {
                    cartGoods.setIsSelected(false);
                }
            }
            tdCartGoodsService.save(cartGoodsList);
        }

        map.addAttribute("cart_goods_list", cartGoodsList);

        return "/client/cart_goods";
    }

    @RequestMapping(value = "/cart/numberAdd", method = RequestMethod.POST)
    public String cartNumberAdd(Long id, HttpServletRequest req, ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            username = req.getSession().getId();
        }

        if (null != id) {
            TdCartGoods cartGoods = tdCartGoodsService.findOne(id);
            
            if (cartGoods.getUsername().equalsIgnoreCase(username)) {
                long quantity = cartGoods.getQuantity();
                /**
				 * @author lc
				 * @注释：数量限制
				 */
                TdGoods goods = tdGoodsService.findOne(cartGoods.getGoodsId());
                if (goods.getIsGroupSale()
                        && goods.getGroupSaleStartTime().before(new Date())
                        && goods.getGroupSaleStopTime().after(new Date())
                        && cartGoods.getPrice().equals(goods.getGroupSalePrice())) 
                {
                    if (cartGoods.getQuantity().compareTo(goods.getGroupSaleLeftNumber()) < 0) {
                    	cartGoods.setQuantity(cartGoods.getQuantity() + 1L);
                    }
                }
                else
                {
                    if (cartGoods.getQuantity().compareTo(goods.getLeftNumber()) < 0) {
                    	cartGoods.setQuantity(cartGoods.getQuantity() + 1L);
                    }
                }
                
                tdCartGoodsService.save(cartGoods);
            }
        }

        map.addAttribute("cart_goods_list",
                tdCartGoodsService.findByUsername(username));

        return "/client/cart_goods";
    }

    @RequestMapping(value = "/cart/numberMinus", method = RequestMethod.POST)
    public String cartNumberMinus(Long id, HttpServletRequest req, ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            username = req.getSession().getId();
        }

        if (null != id) {
            TdCartGoods cartGoods = tdCartGoodsService.findOne(id);

            if (cartGoods.getUsername().equalsIgnoreCase(username)) {
                long quantity = cartGoods.getQuantity();

                quantity = quantity > 1 ? quantity - 1 : quantity;

                cartGoods.setQuantity(quantity);
                tdCartGoodsService.save(cartGoods);
            }
        }

        map.addAttribute("cart_goods_list",
                tdCartGoodsService.findByUsername(username));

        return "/client/cart_goods";
    }

    @RequestMapping(value = "/cart/del", method = RequestMethod.POST)
    public String cartDel(Long id, HttpServletRequest req, ModelMap map) {

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            username = req.getSession().getId();
        }

        if (null != id) {
            TdCartGoods cartGoods = tdCartGoodsService.findOne(id);

            if (cartGoods.getUsername().equalsIgnoreCase(username)) {
                tdCartGoodsService.delete(cartGoods);
            }
        }

        map.addAttribute("cart_goods_list",
                tdCartGoodsService.findByUsername(username));

        return "/client/cart_goods";
    }
}
