package com.ynyes.huizi.controller.app;

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
public class TdAppSearchController {
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdKeywordsService tdKeywordsService;

    // app 接口
    @RequestMapping(value="/index/appSearch",method = RequestMethod.GET)
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
            
            res.put("data", tdGoodsService.searchGoods(keywords.trim(), page, ClientConstant.pageSize));
        }
        
        res.put("pageId", page);
        res.put("keywords", keywords);
        res.put("code", 0);       
        return res;      
    }
    
    
}
