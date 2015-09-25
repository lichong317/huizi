package com.ynyes.huizi.touch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdArticle;
import com.ynyes.huizi.entity.TdArticleCategory;
import com.ynyes.huizi.entity.TdNavigationMenu;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdArticleCategoryService;
import com.ynyes.huizi.service.TdArticleService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdNavigationMenuService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.util.ClientConstant;

@Controller
@RequestMapping("/touch/info")
public class TdTouchInfoController {
	@Autowired 
	private TdArticleService tdArticleService;
	
	@Autowired 
    private TdArticleCategoryService tdArticleCategoryService;
	
	@Autowired 
    private TdNavigationMenuService tdNavigationMenuService;
	
	@Autowired
    private TdCommonService tdCommonService;
	
	@Autowired
    private TdAdTypeService tdAdTypeService;
	
	@Autowired
    private TdAdService tdAdService;
	
	@Autowired
    private TdUserRecentVisitService tdUserRecentVisitService;
    
	@RequestMapping("/list/{mid}")
    public String infoList(@PathVariable Long mid, 
                            Long catId, 
                            Integer page, 
                            ModelMap map,
                            HttpServletRequest req){
	    
	    tdCommonService.setHeader(map, req);
        
        String username = (String) req.getSession().getAttribute("username");
        
        // 读取浏览记录
        if (null == username)
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(req.getSession().getId(), 0, ClientConstant.pageSize));
        }
        else
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, 0, ClientConstant.pageSize));
        }
        
	    if (null == mid)
	    {
	        return "/touch/error_404";
	    }
	    
	    if (null == page)
	    {
	        page = 0;
	    }
	    
	    TdNavigationMenu menu = tdNavigationMenuService.findOne(mid);
	    
	    map.addAttribute("menu_name", menu.getTitle());
	    
	    List<TdArticleCategory> catList = tdArticleCategoryService.findByMenuId(mid);
	    
	    if (null !=catList && catList.size() > 0)
	    {
	        if (null == catId)
	        {
	            catId = catList.get(0).getId();
	        }
	        
	        map.addAttribute("info_page", tdArticleService.findByMenuIdAndCategoryIdAndIsEnableOrderBySortIdAsc(mid, catId, page, ClientConstant.pageSize));
	    }
        
	    //资讯类别
	    List<TdArticleCategory> informationcatList = tdArticleCategoryService.findByMenuId(10L);
	    map.addAttribute("informationcatList", informationcatList);
	    //帮助中心类别
	    List<TdArticleCategory> helpcatList = tdArticleCategoryService.findByMenuId(12L);
	    map.addAttribute("helpcatList", helpcatList);
	    //关于我们类别
	    List<TdArticleCategory> aboutuscatList = tdArticleCategoryService.findByMenuId(8L);
	    map.addAttribute("aboutuscatList", aboutuscatList);
	    //联系我们类别
	    List<TdArticleCategory> contactuscatList = tdArticleCategoryService.findByMenuId(13L);
	    map.addAttribute("contactuscatList", contactuscatList);
	    
//	    /**
//		* @author lc
//	    * @注释：
//		*/
//		// 文章列表页面广告
//	    TdAdType adType = tdAdTypeService.findByTitle("文章列表页面广告");
//
//	    if (null != adType) {
//	            map.addAttribute("Article_scroll_ad_list", tdAdService
//	                    .findByTypeIdAndIsValidTrueOrderBySortIdAsc(adType.getId()));
//	    }  
	    map.addAttribute("pageId", page);
	    map.addAttribute("catId", catId);
	    map.addAttribute("mid", mid);
	    map.addAttribute("info_category_list", catList);
	    map.addAttribute("latest_info_page", tdArticleService.findByMenuIdAndIsEnableOrderByIdDesc(mid, page, ClientConstant.pageSize));
	    
        return "/touch/info_list";
    }
	
	@RequestMapping("/content/{id}")
    public String content(@PathVariable Long id, Long mid, ModelMap map, HttpServletRequest req){
        
	    tdCommonService.setHeader(map, req);
	    
        if (null == id || null == mid)
        {
            return "/touch/error_404";
        }
        
        String username = (String) req.getSession().getAttribute("username");
        
        // 读取浏览记录
        if (null == username)
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(req.getSession().getId(), 0, ClientConstant.pageSize));
        }
        else
        {
            map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, 0, ClientConstant.pageSize));
        }
        
        TdNavigationMenu menu = tdNavigationMenuService.findOne(mid);
        
        map.addAttribute("menu_name", menu.getTitle());
        
        List<TdArticleCategory> catList = tdArticleCategoryService.findByMenuId(mid);
        
        map.addAttribute("info_category_list", catList);
        map.addAttribute("mid", mid);
        
        TdArticle tdArticle = tdArticleService.findOne(id);
        
        if (null != tdArticle)
        {
            map.addAttribute("info", tdArticle);
            map.addAttribute("prev_info", tdArticleService.findPrevOne(id, tdArticle.getCategoryId(), tdArticle.getMenuId()));
            map.addAttribute("next_info", tdArticleService.findNextOne(id, tdArticle.getCategoryId(), tdArticle.getMenuId()));
        }
        
        // 最近添加
        map.addAttribute("latest_info_page", tdArticleService.findByMenuIdAndIsEnableOrderByIdDesc(mid, 0, ClientConstant.pageSize));
        
        return "/touch/info_detail";
    }
}
