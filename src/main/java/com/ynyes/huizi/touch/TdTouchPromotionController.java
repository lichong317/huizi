package com.ynyes.huizi.touch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.util.ClientConstant;

@Controller
public class TdTouchPromotionController {
	 	@Autowired
	    TdGoodsService tdGoodsService;
	    
	    @Autowired
	    TdCommonService tdCommonService;
	    
	    @RequestMapping("/touch/promotion/{promotionType}")
	    public String list(@PathVariable String promotionType, String type, Integer page, ModelMap map, HttpServletRequest req){
	        
	        tdCommonService.setHeader(map, req);
	        
	        if (null == promotionType)
	        {
	            return "/touch/error_404";
	        }
	        
	        if (null == page)
	        {
	            page = 0;
	        }
	        
	        map.addAttribute("type", type);
	        
	      //判断是否为app链接
	        Integer isApp = (Integer) req.getSession().getAttribute("app");
	        if (null != isApp) {
	        	map.addAttribute("app", isApp);
			}
	        
	        if (promotionType.equalsIgnoreCase("tuan")) // 团购
	        {
	        	
	        	 if (null == type)
	             {
	                 type = "";
	             }
	             
	             switch (type)
	             {
	             case "all":
	                 // 所有团购
	                 map.addAttribute("tuan_goods_page", tdGoodsService
	                         .findByGroupSaleAllOrderByGroupSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                 break;
	             case "passed":
	                 // 已经结束团购
	                 map.addAttribute("tuan_goods_page", tdGoodsService
	                         .findByGroupSaleEndedOrderByGroupSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                 break;
	             case "ongoing":
	                 // 即将开始团购
	                 map.addAttribute(
	                         "tuan_goods_page",
	                         tdGoodsService
	                                 .findByGroupSaleGoingToStartOrderByGroupSaleStartTimeAsc(
	                                         page, ClientConstant.pageSize));
	                 break;
	             default:
	                 // 正在团购
	                 map.addAttribute("tuan_goods_page", tdGoodsService
	                         .findByGroupSalingOrderByGroupSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                     break;
	             }
	            
	            return "/touch/tuan_list";
	        }
	        else if (promotionType.equalsIgnoreCase("miao")) // 秒杀
	        {
	        	 if (null == type)
	             {
	                 type = "";
	             }
	             
	             switch (type)
	             {
	             case "all":
	                 // 所有秒杀
	                 map.addAttribute("miao_goods_page", tdGoodsService
	                         .findByFlashSaleAllOrderByFlashSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                 break;
	             case "passed":
	                 // 已经结束秒杀
	                 map.addAttribute("miao_goods_page", tdGoodsService
	                         .findByFlashSaleEndedOrderByFlashSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                 break;
	             case "ongoing":
	                 // 即将开始秒杀
	                 map.addAttribute(
	                         "miao_goods_page",
	                         tdGoodsService
	                                 .findByFlashSaleGoingToStartOrderByFlashSaleStartTimeAsc(
	                                         page, ClientConstant.pageSize));
	                 break;
	             default:

	                 // 正在秒杀
	                 map.addAttribute("miao_goods_page", tdGoodsService
	                         .findByFlashSalingOrderByFlashSaleStartTimeAsc(page,
	                                 ClientConstant.pageSize));
	                     break;
	             }
	        	 return "/touch/miao_list";
	        }
	        else
	        {
	            return "/touch/error_404";
	        }
	        
	       
	    }
}
