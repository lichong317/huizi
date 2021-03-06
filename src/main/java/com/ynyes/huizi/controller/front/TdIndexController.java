package com.ynyes.huizi.controller.front;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdArticleCategory;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdArticleCategoryService;
import com.ynyes.huizi.service.TdArticleService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdProductCategoryService;
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
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }
        
        // 首页浮动窗口广告
        tdAdType = tdAdTypeService.findByTitle("首页浮动窗口广告");
        
        if (null != tdAdType) {
            map.addAttribute("float_window_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }
        
        /**
		 * @author lc
		 * @注释：首页楼层顶楼广告
		 */
        tdAdType = tdAdTypeService.findByTitle("首页楼层顶楼广告");
        
        if (null != tdAdType) {
            map.addAttribute("top_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(tdAdType.getId()));
        }
        
        /*****1F家用电器******/ 
        //家用电器分类 取两级
        TdProductCategory domesticAppliance = tdProductCategoryService.findByTitle("平板电视");
 
        if (null != domesticAppliance) {
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
		}        
        
        //1F小广告
        TdAdType OneFtdAdType = tdAdTypeService.findByTitle("1F小广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFlittle_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(OneFtdAdType.getId()));
        }
        
        //1F 4个横向广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F4个横向广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFtransverse_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(OneFtdAdType.getId()));
        }
        
        //1F 竖向广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F竖向广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFvertical_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(OneFtdAdType.getId()));
        }
        //1F 底层广告
        OneFtdAdType = tdAdTypeService.findByTitle("1F底层广告");

        if (null != OneFtdAdType) {
            map.addAttribute("OneFbottom_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(OneFtdAdType.getId()));
        }
        /*****1F家用电器******/
        
        /*****2F电脑******/ 
        //电脑办公分类 取两级
        TdProductCategory computer = tdProductCategoryService.findByTitle("冰箱/冷柜");
        
        if (null != computer) {
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
		}
               
        
        //2F小广告
        TdAdType twoFtdAdType = tdAdTypeService.findByTitle("2F小广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFlittle_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(twoFtdAdType.getId()));
        }
        
        //2F 4个横向广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F4个横向广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFtransverse_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(twoFtdAdType.getId()));
        }
        
        //2F 竖向广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F竖向广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFvertical_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(twoFtdAdType.getId()));
        }
        //2F 底层广告
        twoFtdAdType = tdAdTypeService.findByTitle("2F底层广告");

        if (null != twoFtdAdType) {
            map.addAttribute("twoFbottom_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(twoFtdAdType.getId()));
        }
        /*****2F电脑******/
        
        /*****3F摄影******/ 
        //摄影分类 取两级
        TdProductCategory shoot = tdProductCategoryService.findByTitle("洗衣机");
 
        if (null != shoot) {
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
		}
        
        
        //3F小广告
        TdAdType threeFtdAdType = tdAdTypeService.findByTitle("3F小广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFlittle_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(threeFtdAdType.getId()));
        }
        
        //3F 4个横向广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F4个横向广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFtransverse_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(threeFtdAdType.getId()));
        }
        
        //3F 竖向广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F竖向广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFvertical_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(threeFtdAdType.getId()));
        }
        //3F 底层广告
        threeFtdAdType = tdAdTypeService.findByTitle("3F底层广告");

        if (null != threeFtdAdType) {
            map.addAttribute("threeFbottom_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(threeFtdAdType.getId()));
        }
        /*****3F电脑******/
        
        /*****4F食品酒水******/ 
        //食品酒水分类 取两级
        TdProductCategory FoodDrinks = tdProductCategoryService.findByTitle("生活电器");
 
        if (null != FoodDrinks) {
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
		}
        
        
        //4F小广告
        TdAdType FourtdAdType = tdAdTypeService.findByTitle("4F小广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFlittle_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(FourtdAdType.getId()));
        }
        
        //4F 4个横向广告
        FourtdAdType = tdAdTypeService.findByTitle("4F4个横向广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFtransverse_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(FourtdAdType.getId()));
        }
        
        //4F 竖向广告
        FourtdAdType = tdAdTypeService.findByTitle("4F竖向广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFvertical_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(FourtdAdType.getId()));
        }
        //4F 底层广告
        FourtdAdType = tdAdTypeService.findByTitle("4F底层广告");

        if (null != FourtdAdType) {
            map.addAttribute("fourFbottom_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(FourtdAdType.getId()));
        }
        /*****4F食品酒水******/
        
        /*****5F手机******/ 
        //摄影分类 取两级
        TdProductCategory phone = tdProductCategoryService.findByTitle("厨房电器");
 
        if (null != phone) {
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
		}        
        
        //5F小广告
        TdAdType fiveFtdAdType = tdAdTypeService.findByTitle("5F小广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFlittle_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(fiveFtdAdType.getId()));
        }
        
        //5F 4个横向广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F4个横向广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFtransverse_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(fiveFtdAdType.getId()));
        }
        
        //5F 竖向广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F竖向广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFvertical_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(fiveFtdAdType.getId()));
        }
        //5F 底层广告
        fiveFtdAdType = tdAdTypeService.findByTitle("5F底层广告");

        if (null != fiveFtdAdType) {
            map.addAttribute("fiveFbottom_ad_list",
                    tdAdService.findByTypeIdAndEndtimeAfter(fiveFtdAdType.getId()));
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
