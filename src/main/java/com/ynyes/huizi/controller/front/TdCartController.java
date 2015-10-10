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
    public String addCart(Long id, Long quantity, String zpid, Integer qiang, Integer m, Long  shareId,
            HttpServletRequest req) {
        // 是否已登录
        boolean isLoggedIn = true;

        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            isLoggedIn = false;
            username = req.getSession().getId();
        }
        
        if (null == m)
        {
            m = 0;
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

                
                // 购物车项目
                List<TdCartGoods> oldCartGoodsList = null;
                
                // 购物车是否已有该商品
                oldCartGoodsList = tdCartGoodsService
                                .findByGoodsIdAndUsername(id, username);
                
                // 有多项，则在第一项上数量进行相加
                if (null != oldCartGoodsList && oldCartGoodsList.size() > 0) {
                    long oldQuantity = oldCartGoodsList.get(0).getQuantity();
                    oldCartGoodsList.get(0).setQuantity(oldQuantity + quantity);
                    //添加分享用户id
                    if (null != shareId) {
                    	oldCartGoodsList.get(0).setShareId(shareId);;
					}
                    tdCartGoodsService.save(oldCartGoodsList.get(0));
                }
                // 新增购物车项
                else
                {
                    TdCartGoods cartGoods = new TdCartGoods();
                    
                    cartGoods.setIsLoggedIn(isLoggedIn);
                    cartGoods.setUsername(username);

                    cartGoods.setIsSelected(true);
                    cartGoods.setGoodsId(goods.getId());
    
                    cartGoods.setQuantity(quantity);
                    
                    //添加分享用户id
                    if (null != shareId) {
                    	cartGoods.setShareId(shareId);;
					}
                    
                    tdCartGoodsService.save(cartGoods);
                }
            }
                        
        }
        
        if (null != shareId) {
        	return "redirect:/cart/add?id=" + id + "&m=" + m + "&shareId=" + shareId;
		}else{
			return "redirect:/cart/add?id=" + id + "&m=" + m;
		}       
    }

    @RequestMapping(value = "/cart/add")
    public String cartInit(Long id, Long shareId, Integer m, HttpServletRequest req, ModelMap map) {
        tdCommonService.setHeader(map, req);
        if (null == m)
        {
            m = 0;
        }
        
        if (null != shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
        if (m.equals(1)) { // 移动端浏览器
            
            return "/touch/cart_add_res";
        }
        return "/client/cart_add_res";
    }
    
    @RequestMapping(value = "/cart")
    public String cart(HttpServletRequest req, Long shareId, ModelMap map) {

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

        if (null != shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
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
