package com.ynyes.huizi.touch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdNaviBarItemService;
import com.ynyes.huizi.service.TdProductCategoryService;

@Controller
@RequestMapping("/touch")
public class TdTouchIndexController {
	@Autowired
    private TdCommonService tdCommonService;

    @Autowired
    private TdGoodsService tdGoodsService;

    @Autowired
    private TdAdTypeService tdAdTypeService;

    @Autowired
    private TdAdService tdAdService;
    
    @Autowired
    private TdNaviBarItemService tdNaviBarItemService;
    
    @Autowired
    TdProductCategoryService tdProductCategoryService;

    @RequestMapping
    public String index(HttpServletRequest req, ModelMap map, String username, Integer app) {
    	
    	tdCommonService.setHeader(map, req);
    	if (null != username) {
    		req.getSession().setAttribute("username", username);
		}        
        
    	 // 导航菜单
        map.addAttribute("touch_navi_item_list",
                tdNaviBarItemService.findByIsEnableTrueAndIsTouchShowTrueOrderBySortIdAsc());
    	
        // 首页顶部轮播广告
        TdAdType tdAdType = tdAdTypeService.findByTitle("触屏首页轮播广告");

        if (null != tdAdType) {
            map.addAttribute("banner_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }
        
        // 闪购
        tdAdType = tdAdTypeService.findByTitle("触屏首页闪购广告");
        
        if (null != tdAdType) {
            map.addAttribute("top_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }                      
        
        // 热卖推荐商品
//        map.addAttribute("hot_recommend_list", tdGoodsService.findByIshotTrueAndIsOnSaleTrueOrderBySortIdAsc(0,ClientConstant.pageSize).getContent());
//        
//        // 热卖排行商品
//        map.addAttribute("hot_sale_list", tdGoodsService.findTop10ByIsOnSaleTrueOrderBySoldNumberDesc());
        
        // 商品推荐广告位

        tdAdType = tdAdTypeService.findByTitle("触屏商品分类广告");
        
        if (null != tdAdType) {
            map.addAttribute("goodsCategory_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        } 
        
        // 商品推荐广告位

        tdAdType = tdAdTypeService.findByTitle("触屏商品推荐广告");
        
        if (null != tdAdType) {
            map.addAttribute("goodsRecommend_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }                 
        
        // 人气新品广告位

        tdAdType = tdAdTypeService.findByTitle("触屏人气新品广告");
        
        if (null != tdAdType) {
            map.addAttribute("goodsHot_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }  
        
        // 精选分类广告位
        tdAdType = tdAdTypeService.findByTitle("触屏精选分类广告");
        
        if (null != tdAdType) {
            map.addAttribute("selection_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }   
        
        // app标志位
        if (null != app) {
        	map.addAttribute("app", app);
        	req.getSession().setAttribute("app", app);
		}
        
        return "/touch/index";
    }
    
    @RequestMapping("/category/list")
    public String product(Long categoryId,
            ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);
        
        // 通过一级分类id查找对应类别
        if (null != categoryId) {
             List<TdProductCategory> secondLevelList = tdProductCategoryService
                     .findByParentIdOrderBySortIdAsc(categoryId);
             map.addAttribute("second_level_cat_list", secondLevelList); 
             
             if (null != secondLevelList && secondLevelList.size() > 0) 
             {
                 for (int j=0; j<secondLevelList.size(); j++)
                 {
                     TdProductCategory secondLevelCat = secondLevelList.get(j);
                     List<TdProductCategory> thirdLevelList = tdProductCategoryService
                             .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());
                     map.addAttribute("third_level_" + j + "_cat_list", thirdLevelList);
                 }
             }
		}else {
			List<TdProductCategory> topCatList = tdProductCategoryService
	                .findByParentIdIsNullOrderBySortIdAsc();
	        if (null != topCatList && topCatList.size() > 0) 
	        {
	        	List<TdProductCategory> secondLevelList = tdProductCategoryService
	                    .findByParentIdOrderBySortIdAsc(topCatList.get(0).getId());
	            map.addAttribute("second_level_cat_list", secondLevelList); 
	            
	            if (null != secondLevelList && secondLevelList.size() > 0) 
	            {
	                for (int j=0; j<secondLevelList.size(); j++)
	                {
	                    TdProductCategory secondLevelCat = secondLevelList.get(j);
	                    List<TdProductCategory> thirdLevelList = tdProductCategoryService
	                            .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());
	                    map.addAttribute("third_level_" + j + "_cat_list", thirdLevelList);
	                }
	            }
	        }
			
		}
        
        
        map.addAttribute("categoryId", categoryId);
        
        return "/touch/category_list";
    }
}
