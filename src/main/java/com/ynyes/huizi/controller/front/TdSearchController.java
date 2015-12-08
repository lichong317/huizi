package com.ynyes.huizi.controller.front;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdKeywords;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdKeywordsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.util.ClientConstant;

/**
 * 商品检索
 * @author Sharon
 *
 */
@Controller
public class TdSearchController {
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdKeywordsService tdKeywordsService;

    // app 接口
    @RequestMapping(value="/appsearch",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> appsearch(String keywords, Integer page, HttpServletRequest req){
        
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null != keywords)
        {
            TdKeywords key = tdKeywordsService.findByTitle(keywords);
            
            if (null != key)
            {
                if (null == key.getTotalSearch())
                {
                    key.setTotalSearch(1L);
                }
                else
                {
                    key.setTotalSearch(key.getTotalSearch() + 1L);
                }
                
                key.setLastSearchTime(new Date());
                
                tdKeywordsService.save(key);
            }
            
            res.put("goods_page", tdGoodsService.searchGoods(keywords.trim(), page, ClientConstant.pageSize));
        }
        
        res.put("pageId", page);
        res.put("keywords", keywords);
        res.put("code", 0);       
        return res;      
    }
    
    
    @RequestMapping(value="/search", method = RequestMethod.GET)
    public String list(String keywords, Integer page, HttpServletRequest req, ModelMap map){
        
        tdCommonService.setHeader(map, req);
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null != keywords)
        {
            TdKeywords key = tdKeywordsService.findByTitle(keywords);
            
            if (null != key)
            {
                if (null == key.getTotalSearch())
                {
                    key.setTotalSearch(1L);
                }
                else
                {
                    key.setTotalSearch(key.getTotalSearch() + 1L);
                }
                
                key.setLastSearchTime(new Date());
                
                tdKeywordsService.save(key);
            }
            
            map.addAttribute("goods_page", tdGoodsService.searchGoods(keywords.trim(), page, ClientConstant.pageSize));
        }
        
        map.addAttribute("pageId", page);
        map.addAttribute("keywords", keywords);
        
        // 热卖推荐
        map.addAttribute("hot_sale_list", tdGoodsService.findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(0, 10).getContent());   
        
        // 销量排行
        map.addAttribute("most_sold_list", tdGoodsService.findByIsOnSaleTrueOrderBySoldNumberDesc(0, 10).getContent());   
        
        // 新品推荐
        map.addAttribute("newest_list", tdGoodsService.findByIsOnSaleTrueOrderByOnSaleTimeDesc( 0, 10).getContent());  

        return "/client/search_result";      
    }
     
    // 去掉名字重复的商品
//    public Page<TdGoods> EliminatingRedundancy(Page<TdGoods> goodspage){
//    	if (null != goodspage) {
//			
//		}
//    }
}
