package com.ynyes.huizi.controller.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdBrand;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdParameter;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdBrandService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdParameterService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.util.ClientConstant;


@Controller
public class TdAppListController {
    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdBrandService tdBrandService;
    
    @Autowired
    private TdProductCategoryService tdProductCategoryService;
    
    @Autowired
    private TdParameterService tdParameterService;
    
    // app 获取顶级类别接口
    @RequestMapping(value="/app/getTopcategory",method = RequestMethod.GET)
    @ResponseBody
    public  Map<String, Object> getTopcategory(){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        List<TdProductCategory> topCatList = tdProductCategoryService
                .findByParentIdIsNullOrderBySortIdAsc();
        
        res.put("data", topCatList);
        
        res.put("code", 0);
        
        return res;
    }
    
    // app 通过类别id获取子类别
    @RequestMapping(value="/app/getCategorybyId",method = RequestMethod.GET)
    @ResponseBody
    public  Map<String, Object> getCategorybyId(Long catId){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        if (null == catId) {
			res.put("message", "类别id不存在");
			return res;
		}
        
        List<TdProductCategory> secondLevelList = tdProductCategoryService
                .findByParentIdOrderBySortIdAsc(catId);
        res.put("data", secondLevelList);
        
        res.put("code", 0);
        
        return res;
    }
    
    // app 接口
    @RequestMapping(value="/applist/{listStr}",method = RequestMethod.GET)
    @ResponseBody
    // 筛选排序组成： 商品类别-[排序字段取值]-{排序字段}-[页数]
    public  Map<String, Object> applist(@PathVariable String listStr, HttpServletRequest req){
    	 Map<String, Object> res = new HashMap<String, Object>();
         
         res.put("code", 1);
         
         if (null == listStr || "".equals(listStr)) {
			res.put("message", "无商品类别");
			return res;
		 }
         
         // 排序字段个数
         int totalSorts = 3;
         
         // 4个排序字段 综合-人气-价格-评价
         String[] sortName = {"id",  "salePrice", "soldNumber"}; 
         
         String[] numberGroup = listStr.split("-");
         
         // 分类id
         Long categoryId = null ;
         
         if (numberGroup.length <= 0)
         {
        	res.put("message", "无商品类别");
 			return res;
         }
         
         categoryId = Long.parseLong(numberGroup[0]);
         
         TdProductCategory tdProductCategory = tdProductCategoryService.findOne(categoryId);
         
         res.put("categoryId", categoryId);
         
         // 品牌
         Integer brandIndex = 0;
         
         if (numberGroup.length > 1) // 解析品牌
         {
             brandIndex = Integer.parseInt(numberGroup[1]);
         }
         
         res.put("brandIndex", brandIndex);
         
         // 品牌列表
         List<TdBrand> brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, categoryId);
         
         res.put("brand_list", brandList);
         
         // 品牌ID
         Long brandId = null;
         
         if (brandIndex.intValue() > 0 && brandList.size() >= brandIndex.intValue())
         {
             TdBrand brand = brandList.get(brandIndex - 1);
             brandId = brand.getId();
         }
         
      // 筛选参数个数
         Integer paramCount = 0;
         List<Integer> paramIndexList = new ArrayList<Integer>();
         List<String> paramValueList = new ArrayList<String>();
         
         // 参数列表
         if (null != tdProductCategory.getParamCategoryId())
         {
             Long paramCategoryId = tdProductCategory.getParamCategoryId();
             
             List<TdParameter> paramList = tdParameterService.findByCategoryTreeContainingAndIsSearchableTrue(paramCategoryId);
         
             paramCount = paramList.size();
             
             if (numberGroup.length >= paramCount + 2) // 解析参数
             {
                 for (int i=0; i<paramCount; i++)
                 {
                     String indexStr = numberGroup[2 + i];
                     TdParameter param = paramList.get(i);
                     
                     if (null != indexStr)
                     {
                         Integer paramIndex = Integer.parseInt(indexStr);
                         paramIndexList.add(paramIndex);
                         
                         if (paramIndex > 0 && null != param.getValueList() && !"".equals(param.getValueList()))
                         {
                             String[] values = param.getValueList().split(",");
                             
                             if (values.length >= paramIndex)
                             {
                                 String value = values[paramIndex-1].trim();
                                 paramValueList.add(value);
                             }
                         }
                     }
                 }
             }
             else
             {
                 for (int i=0; i<paramCount; i++)
                 {
                     paramIndexList.add(0);
                 }
             }
             
             res.put("param_list", paramList);
         }
         
         res.put("param_count", paramCount);
         res.put("param_index_list", paramIndexList);
         
         // 排序字段，可能的取值范围为[0...totalSorts-1]
         Integer orderId = 0;
         
         if (numberGroup.length >= paramCount + 3) {
			String orderIdStr = numberGroup[2 + paramCount];
			if (null != orderIdStr) {
				orderId = Integer.parseInt(orderIdStr);
			}
		 }
         
         if (orderId >= totalSorts) {
			orderId = 0;
		 }
         
         res.put("orderId", orderId);
         
         // 排序字段
         int[] sortIds = new int[totalSorts];
         
         //  排序字段0标志位，0：降序，1：升序
         if (numberGroup.length >= paramCount + 4)
         {
             String sortIdStr = numberGroup[3 + paramCount];
             
             if (null != sortIdStr)
             {
                 sortIds[0] = Integer.parseInt(sortIdStr);
             }
         }
         
         // 排序字段1标志位，0：降序，1：升序
         if (numberGroup.length >= paramCount + 5)
         {
             String sortIdStr = numberGroup[4 + paramCount];
             
             if (null != sortIdStr)
             {
                 sortIds[1] = Integer.parseInt(sortIdStr);
             }
         }
         
         // 排序字段2标志位，0：降序，1：升序
         if (numberGroup.length >= paramCount + 6)
         {
             String sortIdStr = numberGroup[5 + paramCount];
             
             if (null != sortIdStr)
             {
                 sortIds[2] = Integer.parseInt(sortIdStr);
             }
         }
         
//         // 排序字段3标志位，0：降序，1：升序
//         if (numberGroup.length >= 6)
//         {
//             String sortIdStr = numberGroup[5];
//             
//             if (null != sortIdStr)
//             {
//                 sortIds[3] = Integer.parseInt(sortIdStr);
//             }
//         }
         
         res.put("sort_id_list", sortIds);
         
         // 页号
         Integer pageId = 0;
         
         if (numberGroup.length >= paramCount + 7)
         {
             String pageIdStr = numberGroup[6 + paramCount];
             
             if (null != pageIdStr)
             {
                 pageId = Integer.parseInt(pageIdStr);
             }
         }
         
         res.put("pageId", pageId);
         
         PageRequest pageRequest;
                 
         // 0: 降序 1: 升序
         if (0 == sortIds[orderId])
         {
             pageRequest = new PageRequest(pageId, ClientConstant.pageSize, new Sort(
                 Direction.DESC, sortName[orderId]));
         }
         else
         {
             pageRequest = new PageRequest(pageId, ClientConstant.pageSize, new Sort(
                     Direction.ASC, sortName[orderId]));
         }
         
         // 查找商品
         Page<TdGoods> goodsPage = null;
         
         //goodsPage = tdGoodsService.findByCategoryIdAndIsOnSaleTrue(categoryId, pageRequest);
         
         // 全部品牌
         if (0 == brandIndex.intValue())
         {
             goodsPage = tdGoodsService.findByCategoryIdAndParamsLikeAndIsOnSaleTrue(
                                 categoryId, paramValueList, pageRequest);
         }
         else
         {
             // 品牌
             goodsPage = tdGoodsService.findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrue(
                                 categoryId, brandId, paramValueList, pageRequest);
         }
         
         res.put("data", goodsPage);
         
         res.put("code", 0);
         return res;
    }
 
    
}
