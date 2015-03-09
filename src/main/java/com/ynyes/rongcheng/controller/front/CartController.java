package com.ynyes.rongcheng.controller.front;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ynyes.rongcheng.entity.OrderItem;
import com.ynyes.rongcheng.entity.Product;
import com.ynyes.rongcheng.entity.ProductVersion;
import com.ynyes.rongcheng.entity.ShoppingCart;
import com.ynyes.rongcheng.entity.SiteInfo;
import com.ynyes.rongcheng.entity.User;
import com.ynyes.rongcheng.service.OrderItemService;
import com.ynyes.rongcheng.service.ProductService;
import com.ynyes.rongcheng.service.ProductVersionService;
import com.ynyes.rongcheng.service.ShoppingCartService;
import com.ynyes.rongcheng.service.SiteInfoService;
import com.ynyes.rongcheng.util.StringUtils;

/**
 * 购物车
 * 
 * CartController<BR>
 * 创建人:guozhengyang <BR>
 * 时间：2015年1月30日-上午9:24:04 <BR>
 * @version 1.0.0
 *
 */
@Controller

public class CartController {
    @Autowired
    private ShoppingCartService shoppingCartService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductVersionService productVers;
    @Autowired
    private OrderItemService orderItemService;
    
    @Autowired
    private SiteInfoService siteInfoService;
    
    private String flag;
    /**
     * 
     * 跳转购物车<BR>
     * 方法名：cart<BR>
     * 创建人：guozhengyang <BR>
     * 时间：2015年1月30日-上午9:35:24 <BR>
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     */
    @RequestMapping("/cart")
    public String cart(String sum,HttpServletRequest request,String pid, ModelMap map){
        // 页脚数据
        List<SiteInfo> infoList = siteInfoService.findByType("帮助中心");
        
        map.addAttribute("help_info_list", infoList);
        
        infoList = siteInfoService.findByType("支付配送");
        
        map.addAttribute("delivery_info_list", infoList);
        
        infoList = siteInfoService.findByType("售后服务");
        
        map.addAttribute("service_info_list", infoList);
        
        infoList = siteInfoService.findByType("关于荣诚");
        
        map.addAttribute("about_info_list", infoList);
        
        infoList = siteInfoService.findByType("免费热线电话");
        
        map.addAttribute("phone_info_list", infoList);
        // 页脚数据结束
        
        User user =(User) request.getSession().getAttribute("user");
        if(user!=null){
            
                String username=user.getUsername();
                if(StringUtils.isNotEmpty(username)){
                    /*modelAndView.addObject("cartId",shoppingCartService.findOne(username, Long.parseLong(sum)));*/
                    
                    map.addAttribute("carts",shoppingCartService.findByUsername(username));
                    map.addAttribute("count",shoppingCartService.countByUsername(username));/*数量*/
                    
                    return "/front/cart/cart";
                }else {
                    return "/front/login"; 
                }
       
        }else {
            return "/front/login"; 
        }
    }
    /**
     * 
     * 跳转订单信息填写<BR>
     * 方法名：cartStep<BR>
     * 创建人：guozhengyang <BR>
     * 时间：2015年1月30日-上午9:36:01 <BR>
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     *  productId (必选)商品ID
     */
    
    @RequestMapping("/cartStep")
    public ModelAndView cartStep(){
        ModelAndView modelAndView=new ModelAndView();
           modelAndView.setViewName("/front/cart/cartStep");
       
        return modelAndView;
    }
    /**
     * 
     * 添加订单<BR>
     * 方法名：cartStep<BR>
     * 创建人：guozhengyang <BR>
     * 时间：2015年3月9日-下午5:09:58 <BR>
     * @param productId
     * @param productName
     * @param productVerId
     * @param productVerColor
     * @param productVerCap
     * @param productVerName
     * @param deliveryQuantity
     * @param price
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     */
    @RequestMapping("/addcartStep")
    @ResponseBody
    public String cartStep(String productId,
            String productName,
            String productVerId,
            String productVerColor,
            String productVerCap,
            String productVerName,
            String deliveryQuantity,
            String price,HttpServletRequest request){
        /*空判断*/
        OrderItem item=null;
        User user=(User) request.getSession().getAttribute("user");
        if(user!=null){
            if(StringUtils.isNotEmpty(productName) &&
                    StringUtils.isNotEmpty(deliveryQuantity) &&
                    StringUtils.isNotEmpty(price)){
                item=new OrderItem();
                /*新增订单*/
                item.setProductName(productName);
                item.setDeliveryQuantity(Long.parseLong(deliveryQuantity));
                item.setPrice(Double.parseDouble(price));
//                orderItemService.save(item);
              
                List<ShoppingCart> carts=shoppingCartService.findByUsername(user.getUsername());
                for (ShoppingCart shoppingCart : carts) {
                   shoppingCartService.delete(user.getUsername(), shoppingCart.getId());
                    
                }
               flag="success";
               
               return flag;
            }else{
                flag="false";
                return flag;
            }
        }else{
            flag="nullUser";
            return flag;
        }
    }
    /**
     * 
     * 跳转支付页面<BR>
     * 方法名：cartFinish<BR>
     * 创建人：guozhengyang <BR>
     * 时间：2015年1月30日-上午9:44:55 <BR>
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     */
    @RequestMapping("/cartFinish")
    public String cartFinish(){
        return "/front/cart/cartFinish";
    }
    @RequestMapping("/paysuccess")
    public String paysuccess(){
        return "/front/cart/paysuccess";
    }
    /**
     * 
     * 添加购物车<BR>
     * 方法名：add<BR>
     * 创建人：guozhengyang <BR>
     * 时间：2015年3月9日-上午10:37:25 <BR>
     * @param pid
     * @param vid
     * @param quantity
     * @param request
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     */
    @RequestMapping(value="/add",method=RequestMethod.POST)
    @ResponseBody
    public String add(Long[] pid,Long[] vid,Long[] quantity,HttpServletRequest request){
       
        User user =(User)request.getSession().getAttribute("user");
       if(user!=null){
           String username=user.getUsername();
           if(StringUtils.isNotEmpty(username)){
               if(pid!=null && pid.length>0 && vid!=null && vid.length>0 && quantity!=null && quantity.length>0){
                   for (int i=0;i<pid.length;i++) {
                       Product product=  productService.findOne(pid[i]);
                      List<ProductVersion> versions= product.getVersionList();
                      for (ProductVersion productVersion : versions) {
                          if(productVersion.getId()==vid[i]){
                              Map<String, Object> map= shoppingCartService.add(username, pid[i], vid[i],quantity[i], product.getFlashSalePrice());
                              if(map.get("code").equals(0)){
                                  flag="success";
                                  return flag;
                              }
//                              else if(map.get("message").equals("参数错误")){
//                                  flag="messaee";
//                                
//                              }
                              else{
                                  flag="false";
                                  return flag;
                              }
                          }
                      }
                   }
              
               }else {
                   flag="nullfalse";
                   return flag;
            }
           }else{
               flag="false";
               return flag;
           }
       }else{
         flag="nulluser";
           return flag;
       }
    return flag;
    }
    @RequestMapping("delete")
    @ResponseBody
    public String delete(String id,HttpServletRequest request){
        User user=(User) request.getSession().getAttribute("user");
        if(user!=null){
            shoppingCartService.delete(user.getUsername(), Long.parseLong(id));
            flag="success";
            return flag;
        }else{
            flag="flase";
            return flag;
        }
        
    }
    public String getFlag() {
        return flag;
    }
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    
}
