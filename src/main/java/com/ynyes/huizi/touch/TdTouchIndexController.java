package com.ynyes.huizi.touch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdArticleCategory;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdArticleCategoryService;
import com.ynyes.huizi.service.TdArticleService;
import com.ynyes.huizi.service.TdBrandService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdSiteLinkService;
import com.ynyes.huizi.util.ClientConstant;

@Controller
@RequestMapping("/touch")
public class TdTouchIndexController {
	@Autowired
    private TdCommonService tdCommonService;

    @Autowired
    private TdGoodsService tdGoodsService;

    @Autowired
    private TdArticleService tdArticleService;

    @Autowired
    private TdArticleCategoryService tdArticleCategoryService;

    @Autowired
    private TdProductCategoryService tdProductCategoryService;

    @Autowired
    private TdSiteLinkService tdSiteLinkService;

    @Autowired
    private TdAdTypeService tdAdTypeService;

    @Autowired
    private TdAdService tdAdService;

    @Autowired
    private TdBrandService tdBrandService;

    @RequestMapping
    public String index(HttpServletRequest req, ModelMap map) {
    	        
        tdCommonService.setHeader(map, req);
           

        // 首页顶部轮播广告
        TdAdType tdAdType = tdAdTypeService.findByTitle("触屏首页轮播广告");

        if (null != tdAdType) {
            map.addAttribute("banner_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }
        
        // 顶部广告1
        tdAdType = tdAdTypeService.findByTitle("触屏首页顶部广告");
        
        if (null != tdAdType) {
            map.addAttribute("top_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }                      
        
        // 热卖推荐商品
        map.addAttribute("hot_sale_list", tdGoodsService.findTop10ByIsOnSaleTrueOrderBySoldNumberDesc());
        
        // 商品推荐广告位
        tdAdType = tdAdTypeService.findByTitle("触屏商品推荐广告");
        
        if (null != tdAdType) {
            map.addAttribute("goodsRecommend_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }                 
        
        // 精选分类广告位
        tdAdType = tdAdTypeService.findByTitle("触屏精选分类广告");
        
        if (null != tdAdType) {
            map.addAttribute("selection_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }   
                
        
        return "/touch/index";
    }
    
    @RequestMapping("/category/list")
    public String product(
            ModelMap map, HttpServletRequest req) {

        tdCommonService.setHeader(map, req);
        
        return "/touch/category_list";
    }
}
