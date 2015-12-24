package com.ynyes.huizi.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.startup.HomesUserDatabase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdArticleCategory;
import com.ynyes.huizi.entity.TdGoods;
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

/**
 * 前端首页控制
 *
 */
@Controller
@RequestMapping("/")
public class TdIndexController {

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
    private TdAdTypeService tdAdTypeService;

    @Autowired
    private TdAdService tdAdService;

    // 新品推荐
    @RequestMapping(value="index/getNewProduct")
    @ResponseBody
    public Map<String, Object> getNewProduct(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        res.put("data", tdGoodsService.findByIsNewTrueAndIsOnSaleTrueOrderByIdDesc(0, 4));
        
        res.put("code", 0);
        
        return res;
    }
    
    //团购秒杀
    @RequestMapping(value="index/getPromotion")
    @ResponseBody
    public Map<String, Object> getPromotion(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        res.put("groupSalingdata", tdGoodsService.findByGroupSalingOrderByGroupSaleStartTimeAsc(0, 3));
        
        res.put("flashSalingdata", tdGoodsService.findByFlashSalingOrderByFlashSaleStartTimeAsc(0, 3));
        
        res.put("code", 0);
        
        return res;
    }
    
    //广告
    @RequestMapping(value="index/getAdvertisement")
    @ResponseBody
    public Map<String, Object> getAdvertisement(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        TdAdType tdAdType = tdAdTypeService.findByTitle("App首页顶部广告");
        // 顶部广告
        if (null != tdAdType) {
        	res.put("top_ad", tdAdService.findByTypeId(tdAdType.getId()));
		}
               
        // 中部竖向广告
        tdAdType = tdAdTypeService.findByTitle("App首页中部竖向广告");
        if (null != tdAdType) {
        	 res.put("middle_vertical_ad", tdAdService.findByTypeId(tdAdType.getId()));
		}
             
        // 中部横向广告
        tdAdType = tdAdTypeService.findByTitle("App首页中部横向广告");
        if (null != tdAdType) {
        	 res.put("middle_horizontal_ad", tdAdService.findByTypeId(tdAdType.getId()));
		}
               
        // 两个底部长广告
        tdAdType = tdAdTypeService.findByTitle("App首页底部长广告");
        if (null != tdAdType) {
        	 res.put("bottom_ad", tdAdService.findByTypeId(tdAdType.getId()));
		}
               
        //分类精选广告
        tdAdType = tdAdTypeService.findByTitle("App首页分类精选广告");
        if (null != tdAdType) {
        	res.put("category_ad", tdAdService.findByTypeId(tdAdType.getId()));
		}
                
        res.put("code", 0);
        
        return res;
    }       
    
    //分类
    @RequestMapping(value="index/getCategory")
    @ResponseBody
    public Map<String, Object> getCategory(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        // 全部商品分类，取三级
        List<TdProductCategory> topCatList = tdProductCategoryService
                .findByParentIdIsNullOrderBySortIdAsc();
        res.put("top_cat_list", topCatList);

        if (null != topCatList && topCatList.size() > 0) 
        {
            for (int i = 0; i < topCatList.size(); i++) 
            {
                TdProductCategory topCat = topCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                res.put("second_level_" + i + "_cat_list", secondLevelList);

                if (null != secondLevelList && secondLevelList.size() > 0) 
                {
                    for (int j=0; j<secondLevelList.size(); j++)
                    {
                        TdProductCategory secondLevelCat = secondLevelList.get(j);
                        List<TdProductCategory> thirdLevelList = tdProductCategoryService
                                .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());
                        res.put("third_level_" + i + j + "_cat_list", thirdLevelList);
                    }
                }
            }
        }
        // 分类                              
        res.put("code", 0);
        
        return res;
    }
    
    @RequestMapping(value="app/index/getCategory")
    @ResponseBody
    public Map<String, Object> androidgetCategory(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("status", 1);
        
        // 新建二维数组
        TdProductCategory [][] tdProductCategory;
        
        // 全部商品分类，取三级
        List<TdProductCategory> topCatList = tdProductCategoryService
                .findByParentIdIsNullOrderBySortIdAsc();
        res.put("top_cat_list", topCatList);

        tdProductCategory = new TdProductCategory[topCatList.size()][];
        
        if (null != topCatList && topCatList.size() > 0) 
        {
            for (int i = 0; i < 4; i++) 
            {
                TdProductCategory topCat = topCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());             
                if (null != secondLevelList && secondLevelList.size() > 0) 
                {      
                	tdProductCategory[i] = new TdProductCategory[secondLevelList.size()] ;
                    for (int j=0; j<secondLevelList.size(); j++)
                    {
                        TdProductCategory secondLevelCat = secondLevelList.get(j);
//                        List<TdProductCategory> thirdLevelList = tdProductCategoryService
//                                .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());                    	
                        tdProductCategory[i][j] = secondLevelCat ;
                    }
                }
            }
        }
        res.put("data", tdProductCategory);
        
        // 分类                              
        res.put("status", 0);
        
        return res;
    }
    
    /**
     * ios 接口
     * @return
     */
    @RequestMapping("api/get")
    @ResponseBody
    public Map<String, Object>HomeData()
    {
    	Map<String, Object> res = new HashMap<String, Object>();
    	
    	res.put("code", 1);
        
    	Page<TdGoods> goodsPage = tdGoodsService.findByIsNewTrueAndIsOnSaleTrueOrderByIdDesc(0, 4);
    	List<TdGoods> goodsList = goodsPage.getContent();
    	// 新品推荐
        res.put("good", goodsList);
        
        // 团购
        Page<TdGoods> GroupPage = tdGoodsService.findByGroupSalingOrderByGroupSaleStartTimeAsc(0, 3);
    	List<TdGoods> groupList = GroupPage.getContent();
        res.put("group", groupList);
        // 秒杀
        Page<TdGoods> FlashPage = tdGoodsService.findByFlashSalingOrderByFlashSaleStartTimeAsc(0, 3);
    	List<TdGoods> FlashList = FlashPage.getContent();
    	
        res.put("flash",FlashList);
        
     // 全部商品分类，取三级
        List<TdProductCategory> topCatList = tdProductCategoryService
                .findByParentIdIsNullOrderBySortIdAsc();
        res.put("top_cat_list", topCatList);

        if (null != topCatList && topCatList.size() > 0) 
        {
            for (int i = 0; i < topCatList.size(); i++) 
            {
                TdProductCategory topCat = topCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                res.put("second_level_" + i + "_cat_list", secondLevelList);

                if (null != secondLevelList && secondLevelList.size() > 0) 
                {
                    for (int j=0; j<secondLevelList.size(); j++)
                    {
                        TdProductCategory secondLevelCat = secondLevelList.get(j);
                        List<TdProductCategory> thirdLevelList = tdProductCategoryService
                                .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());
                        res.put("third_level_" + i + j + "_cat_list", thirdLevelList);
                    }
                }
            }
        }
        
        //广告
        TdAdType tdAdType = tdAdTypeService.findByTitle("App首页顶部广告");
//        
//        // 顶部广告
//        res.put("top_ad", tdAdService.findByTypeId(tdAdType.getId()));
//        
//        // 中部竖向广告
//        tdAdType = tdAdTypeService.findByTitle("App首页中部竖向广告");
//        res.put("middle_vertical_ad", tdAdService.findByTypeId(tdAdType.getId()));
//        
//        // 中部横向广告
//        tdAdType = tdAdTypeService.findByTitle("App首页中部横向广告");
//        res.put("middle_horizontal_ad", tdAdService.findByTypeId(tdAdType.getId()));
//        
//        // 两个底部长广告
//        tdAdType = tdAdTypeService.findByTitle("App首页底部长广告");
//        res.put("bottom_ad", tdAdService.findByTypeId(tdAdType.getId()));
//        
        //分类精选广告
//        tdAdType = tdAdTypeService.findByTitle("App首页分类精选广告");
        tdAdType = tdAdTypeService.findByTitle("触屏精选分类广告");
        res.put("category_ad", tdAdService.findByTypeId(tdAdType.getId()));
        
        res.put("code", 0);
    	
    	return res;
    }
    
    /*******接口结束********/
    
    @RequestMapping
    public String index(HttpServletRequest req, Device device, ModelMap map) {
    	 // 触屏 
        if (device.isMobile() || device.isTablet()) {
            return "redirect:/touch/";
        }
        
        tdCommonService.setHeader(map, req);

        map.addAttribute(
                "tuan_page",
                tdGoodsService
                        .findByIsGroupSaleTrueAndGroupSaleStartTimeBeforeAndGroupSaleStopTimeAfterAndIsOnSaleTrue(
                                0, ClientConstant.pageSize));

        map.addAttribute(
                "next_tuan_page",
                tdGoodsService
                        .findByIsGroupSaleTrueAndGroupSaleStartTimeAfterAndGroupSaleStopTimeAfterAndIsOnSaleTrue(
                                0, ClientConstant.pageSize));

              

        // 首页轮播广告
        TdAdType tdAdType = tdAdTypeService.findByTitle("首页大图广告");

        if (null != tdAdType) {
            map.addAttribute("banner_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }
        
        // 首页浮动窗口广告
        tdAdType = tdAdTypeService.findByTitle("首页浮动窗口广告");
        
        if (null != tdAdType) {
            map.addAttribute("float_window_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }
        
        /**
		 * @author lc
		 * @注释：首页楼层顶楼广告
		 */
        tdAdType = tdAdTypeService.findByTitle("首页楼层顶楼广告");
        
        if (null != tdAdType) {
            map.addAttribute("top_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }
        
        /*****1F家用电器******/ 
        //家用电器分类 取两级
        TdProductCategory domesticAppliance = tdProductCategoryService.findByTitle("家用电器");
 
        List<TdProductCategory> domesticApplianceCatList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(domesticAppliance.getId());
        map.addAttribute("domesticAppliance_cat_list", domesticApplianceCatList);

        if (null != domesticApplianceCatList && domesticApplianceCatList.size() > 0) 
        {
            for (int i = 0; i < domesticApplianceCatList.size(); i++) 
            {
                TdProductCategory topCat = domesticApplianceCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                map.addAttribute("second_level_" + i + "domesticAppliance_cat_list", secondLevelList);               
            }
        }
        
        //1F小广告
        TdAdType OneFtdAdType = tdAdTypeService.findByTitle("1F小广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFlittle_ad_list",
                    tdAdService.findByTypeId(OneFtdAdType.getId()));
        }
        
        //1F 4个横向广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F4个横向广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFtransverse_ad_list",
                    tdAdService.findByTypeId(OneFtdAdType.getId()));
        }
        
        //1F 竖向广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F竖向广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFvertical_ad_list",
                    tdAdService.findByTypeId(OneFtdAdType.getId()));
        }
        //1F 底层广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F底层广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFbottom_ad_list",
                    tdAdService.findByTypeId(OneFtdAdType.getId()));
        }
        /*****1F家用电器******/
        
        /*****2F电脑******/ 
        //电脑办公分类 取两级
        TdProductCategory computer = tdProductCategoryService.findByTitle("电脑办公");
 
        List<TdProductCategory> computerCatList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(computer.getId());
        map.addAttribute("computer_cat_list", computerCatList);

        if (null != computerCatList && computerCatList.size() > 0) 
        {
            for (int i = 0; i < computerCatList.size(); i++) 
            {
                TdProductCategory topCat = computerCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                map.addAttribute("second_level_" + i + "computer_cat_list", secondLevelList);               
            }
        }
        
        //2F小广告
        TdAdType twoFtdAdType = tdAdTypeService.findByTitle("2F小广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFlittle_ad_list",
                    tdAdService.findByTypeId(twoFtdAdType.getId()));
        }
        
        //2F 4个横向广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F4个横向广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFtransverse_ad_list",
                    tdAdService.findByTypeId(twoFtdAdType.getId()));
        }
        
        //2F 竖向广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F竖向广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFvertical_ad_list",
                    tdAdService.findByTypeId(twoFtdAdType.getId()));
        }
        //2F 底层广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F底层广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFbottom_ad_list",
                    tdAdService.findByTypeId(twoFtdAdType.getId()));
        }
        /*****2F电脑******/
        
        /*****3F摄影******/ 
        //摄影分类 取两级
        TdProductCategory shoot = tdProductCategoryService.findByTitle("摄影摄像");
 
        List<TdProductCategory> shootCatList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(shoot.getId());
        map.addAttribute("shoot_cat_list", shootCatList);

        if (null != shootCatList && shootCatList.size() > 0) 
        {
            for (int i = 0; i < shootCatList.size(); i++) 
            {
                TdProductCategory topCat = shootCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                map.addAttribute("second_level_" + i + "shoot_cat_list", secondLevelList);               
            }
        }
        
        //3F小广告
        TdAdType threeFtdAdType = tdAdTypeService.findByTitle("3F小广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFlittle_ad_list",
                    tdAdService.findByTypeId(threeFtdAdType.getId()));
        }
        
        //3F 4个横向广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F4个横向广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFtransverse_ad_list",
                    tdAdService.findByTypeId(threeFtdAdType.getId()));
        }
        
        //3F 竖向广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F竖向广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFvertical_ad_list",
                    tdAdService.findByTypeId(threeFtdAdType.getId()));
        }
        //3F 底层广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F底层广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFbottom_ad_list",
                    tdAdService.findByTypeId(threeFtdAdType.getId()));
        }
        /*****3F电脑******/
        
        /*****4F食品酒水******/ 
        //食品酒水分类 取两级
        TdProductCategory FoodDrinks = tdProductCategoryService.findByTitle("食品酒水");
 
        List<TdProductCategory> FoodDrinksCatList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(FoodDrinks.getId());
        map.addAttribute("FoodDrinks_cat_list", FoodDrinksCatList);

        if (null != FoodDrinksCatList && FoodDrinksCatList.size() > 0) 
        {
            for (int i = 0; i < FoodDrinksCatList.size(); i++) 
            {
                TdProductCategory topCat = FoodDrinksCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                map.addAttribute("second_level_" + i + "FoodDrinks_cat_list", secondLevelList);               
            }
        }
        
        //4F小广告
        TdAdType FourtdAdType = tdAdTypeService.findByTitle("4F小广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFlittle_ad_list",
                    tdAdService.findByTypeId(FourtdAdType.getId()));
        }
        
        //4F 4个横向广告
        FourtdAdType = tdAdTypeService.findByTitle("4F4个横向广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFtransverse_ad_list",
                    tdAdService.findByTypeId(FourtdAdType.getId()));
        }
        
        //4F 竖向广告
        FourtdAdType = tdAdTypeService.findByTitle("4F竖向广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFvertical_ad_list",
                    tdAdService.findByTypeId(FourtdAdType.getId()));
        }
        //4F 底层广告
        FourtdAdType = tdAdTypeService.findByTitle("4F底层广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFbottom_ad_list",
                    tdAdService.findByTypeId(FourtdAdType.getId()));
        }
        /*****4F食品酒水******/
        
        /*****5F手机******/ 
        //摄影分类 取两级
        TdProductCategory phone = tdProductCategoryService.findByTitle("手机大全");
 
        List<TdProductCategory> phoneCatList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(phone.getId());
        map.addAttribute("phone_cat_list", phoneCatList);

        if (null != phoneCatList && phoneCatList.size() > 0) 
        {
            for (int i = 0; i < phoneCatList.size(); i++) 
            {
                TdProductCategory topCat = phoneCatList.get(i);
                List<TdProductCategory> secondLevelList = tdProductCategoryService
                        .findByParentIdOrderBySortIdAsc(topCat.getId());
                map.addAttribute("second_level_" + i + "phone_cat_list", secondLevelList);               
            }
        }
        
        //5F小广告
        TdAdType fiveFtdAdType = tdAdTypeService.findByTitle("5F小广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFlittle_ad_list",
                    tdAdService.findByTypeId(fiveFtdAdType.getId()));
        }
        
        //5F 4个横向广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F4个横向广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFtransverse_ad_list",
                    tdAdService.findByTypeId(fiveFtdAdType.getId()));
        }
        
        //5F 竖向广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F竖向广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFvertical_ad_list",
                    tdAdService.findByTypeId(fiveFtdAdType.getId()));
        }
        //5F 底层广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F底层广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFbottom_ad_list",
                    tdAdService.findByTypeId(fiveFtdAdType.getId()));
        }
        /*****5F手机******/
        
        // 资讯一级分类
        Long newsId = 10L;
        map.addAttribute("news_id", newsId);

        List<TdArticleCategory> level0NewsList = tdArticleCategoryService
                    .findByMenuIdAndParentId(newsId, 0L);
        map.addAttribute("news_level0_cat_list", level0NewsList);

        if (null != level0NewsList) {
            for (int i = 0; i < level0NewsList.size(); i++) {
                TdArticleCategory articleCat = level0NewsList.get(i);
                map.addAttribute("cat" + i + "_news_list",
                        tdArticleService.findByCategoryId(articleCat.getId()));
            }
        }

        // 最新资讯
        map.addAttribute("latest_news_page", tdArticleService
                .findByMenuIdAndCategoryIdAndIsEnableOrderBySortIdAsc(newsId, 1L, 0,
                        ClientConstant.pageSize));

        // 通知公告
        Long noteId = 11L;
        map.addAttribute("note_id", noteId);
        map.addAttribute("latest_note_page", tdArticleService
                .findByMenuIdAndIsEnableOrderByIdDesc(noteId, 0,
                        ClientConstant.pageSize));

        return "/client/index";
    }
}
