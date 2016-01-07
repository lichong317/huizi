package com.ynyes.huizi.controller.app;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 前端首页控制
 *
 */
@Controller
@RequestMapping("/")
public class TdAppIndexController {


    @Autowired
    private TdGoodsService tdGoodsService;

    @Autowired
    private TdProductCategoryService tdProductCategoryService;

    @Autowired
    private TdAdTypeService tdAdTypeService;

    @Autowired
    private TdAdService tdAdService;
    
    @Autowired
    private TdSettingService tdSettingService;

    // app引导页
    @RequestMapping(value="index/getGuideImg")
    @ResponseBody
    public Map<String, Object> getGuideImg(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        TdAdType tdAdType = tdAdTypeService.findByTitle("App引导广告");

        if (null != tdAdType) {
        	res.put("data", tdAdService.findByTypeId(tdAdType.getId()));
		}
        
        res.put("code", 0);
        
        return res;
    }
    
    // ios版本更新    
    @RequestMapping(value="app/update")
    @ResponseBody
    public Map<String, Object> update(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
//        res.put("code", 1);
//        
//        res.put("data", tdGoodsService.findByIsNewTrueAndIsOnSaleTrueOrderByIdDesc(0, 4));
        
        res.put("code", 0);
        
        return res;
    }
    
    // android 版本更新
    @RequestMapping(value="android/update")
    @ResponseBody
    public Map<String, Object> androidupdate(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);

        TdSetting tdSetting = tdSettingService.findTopBy();
        
        if (null != tdSetting.getAndroidVersion()) {
			res.put("version", tdSetting.getAndroidVersion());
		}
        if (null != tdSetting.getAndroidApk()) {
        	res.put("downloadUrl", "/android/apk/"+ tdSetting.getAndroidApk());
		}
               
        res.put("code", 0);
        
        return res;
    }
    
    // 获取Android apk
    @RequestMapping(value="android/apk/{filename}")    
    public String getApk(@PathVariable String filename, HttpServletRequest req, ModelMap map, HttpServletResponse resp){
    	
    	String url = SiteMagConstant.apkPath;
    	if (download(filename, url, resp)) {
			return null;
		}    	
    	return null ;
    }
    
    /**
   	 * @author lc
   	 * @注释：文件下载
   	 */
    public Boolean download(String filename, String exportUrl, HttpServletResponse resp){
       
       	 OutputStream os;
   		 try {
   				os = resp.getOutputStream();
   				File file = new File(exportUrl + filename +".apk");   				
                if (file.exists())
                    {
                      try {
                            resp.reset();
                            resp.setHeader("Content-Disposition", "attachment; filename="
                                    + filename +".apk");
                            resp.setContentType("application/octet-stream; charset=utf-8");
                            os.write(FileUtils.readFileToByteArray(file));
                            os.flush();
                        } finally {
                            if (os != null) {
                                os.close();
                            }
                        }
                }
   			} catch (IOException e) {
   				// TODO Auto-generated catch block
   				e.printStackTrace();
   		 }
   		 return true;	
    }
    
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
    
    // 热卖推荐
    @RequestMapping(value="index/getHotsaleProduct")
    @ResponseBody
    public Map<String, Object> getHotProduct(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        res.put("data", tdGoodsService.findByIsOnSaleTrueOrderBySoldNumberDesc(0, 10).getContent());
        
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
        res.put("data", topCatList);
        res.put("top_cat_list", tdProductCategory);
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
	
}
