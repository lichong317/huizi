package com.ynyes.huizi.touch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdDiySite;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.service.TdArticleCategoryService;
import com.ynyes.huizi.service.TdArticleService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdDiySiteService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
@RequestMapping("/touch/shop")
public class TdTouchShopController {
	
	@Autowired 
    private TdDiySiteService tdDiySiteService;
	
	@Autowired 
    private TdOrderService tdOrderService;
		
	@Autowired
    private TdCommonService tdCommonService;
	
	@Autowired
    private TdUserRecentVisitService tdUserRecentVisitService;
    
	@RequestMapping("/list")
    public String infoList(Integer page, 
                            ModelMap map,
                            Integer cid,
                            HttpServletRequest req){
	    
	    tdCommonService.setHeader(map, req);
        
        if (null == cid)
        {
            cid = 0;
        }
        
        if (null == page) {
			page = 0;
		}
        
        map.addAttribute("cid", cid);        
        
        map.addAttribute("shop_list", tdDiySiteService.findAllOrderBySortIdAsc(page, SiteMagConstant.pageSize));
       
        
        
        return "/touch/shop_list";
    }
	
	@RequestMapping("/{id}")
    public String shop(@PathVariable Long id, ModelMap map, HttpServletRequest req){
	    tdCommonService.setHeader(map, req);
	    
	    map.addAttribute("shop", tdDiySiteService.findOne(id));
	    
        return "/touch/shop_detail";
    }
}
