package com.ynyes.huizi.controller.front;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ynyes.huizi.entity.TdBrand;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdParameter;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdArticleService;
import com.ynyes.huizi.service.TdBrandService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdContrastGoodsService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdParameterService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.util.ClientConstant;


@Controller
public class TdListController {
    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdProductCategoryService tdProductCategoryService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @Autowired
    private TdBrandService tdBrandService;
    
    @Autowired
    private TdParameterService tdParameterService;
    
    @Autowired
    private TdContrastGoodsService tdContrastGoodsService;
    
    @Autowired
    private TdArticleService tdArticleService;
   
    @RequestMapping(value = "/list/changeParam",method = RequestMethod.GET)
    //@ResponseBody
    public Map<String, Object> smsCode(Integer index, HttpServletResponse response,ModelMap map, HttpServletRequest request) {
    	Map<String, Object> res = new HashMap<String, Object>();      
        
    	res.put("code", 1);
    	
    	if (null == index) {
    		res.put("msg", "参数错误");
    		return res;
		}
    	
    	map.addAttribute("paramindex", index);
    	res.put("paramindex", index);
    	res.put("code", 0);
        return res;
    }
    
    //全部分类页面
    @RequestMapping(value="/productCategory/all")
    public String allCategory(ModelMap map, HttpServletRequest req){
    	tdCommonService.setHeader(map, req);
    	   	
    	return "/client/all_productCategory_list";
    }
    
    // 分类专题页面
    @RequestMapping(value="/themes")
    public String themes(Long categoryId, ModelMap map, HttpServletRequest req){
    	tdCommonService.setHeader(map, req);
    	
    	if (null == categoryId) {
			categoryId = 7L;
		}
    	
    	// 查询分类子类别
    	map.addAttribute("categoryId", categoryId);
    	TdProductCategory topCat = tdProductCategoryService.findOne(categoryId);
    	map.addAttribute("top_cat", topCat);
    	
        List<TdProductCategory> secondLevelList = tdProductCategoryService
                 .findByParentIdOrderBySortIdAsc(topCat.getId());
        map.addAttribute("second_level_cat_list", secondLevelList);
        
        if (null != secondLevelList && secondLevelList.size() > 0) 
        {
             for (int j=0; j<secondLevelList.size(); j++)
             {
                 TdProductCategory secondLevelCat = secondLevelList.get(j);
                 List<TdProductCategory> thirdLevelList = tdProductCategoryService
                         .findByParentIdOrderBySortIdAsc(secondLevelCat.getId());
                 map.addAttribute("third_level_" + j + "_cat_list", thirdLevelList);
                 
                 // 分类推荐商品
                 map.addAttribute("second_level"+ j +"_hot_list", tdGoodsService.findByCategoryTreeAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(secondLevelCat.getId(), 0, 10).getContent());
                 
                 // 分类销量排行
                 map.addAttribute("second_level"+ j +"_sale_list", tdGoodsService.findByCategoryIdAndIsOnSaleTrueOrderBySoldNumberDesc(secondLevelCat.getId(), 0, 10).getContent());
             }
        }
        
        // 分类首页推荐商品
        map.addAttribute("index_sale_list", tdGoodsService.findByCategoryIdAndIsRecommendIndexTrueAndIsOnSaleTrueOrderBySortIdAsc(categoryId, 0, 10).getContent());
        
        
        
        // 品牌列表
        List<TdBrand> brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, categoryId);
        
        map.addAttribute("brand_list", brandList);
    	
        // 通知公告
        map.addAttribute("latest_news_page", tdArticleService
                .findByMenuIdAndCategoryIdAndIsEnableOrderBySortIdAsc(10L, 1L, 0,
                        ClientConstant.pageSize));
        
        // 装修馆知识
        map.addAttribute("fitment_page ", tdArticleService.findByMenuIdAndCategoryIdAndIsEnableOrderBySortIdAsc(10L, 21L, 00, ClientConstant.pageSize));
        
        // 限时抢购
        map.addAttribute("miao_goods_page", tdGoodsService
                .findByCategoryAndFlashSaleOrderByFlashSaleStartTimeAsc(categoryId, 0,
                        ClientConstant.pageSize));
        
    	return "/client/themes_index";
    }
    
    
    // 组成：typeID-brandIndex-[paramIndex]-[排序字段]-[销量排序标志]-[价格排序标志]-[上架时间排序标志]-[页号]_[价格低值]-[价格高值]
    //新组成：typeID-brandIndex-[paramIndex]-[排序字段]-[销量排序标志]-[价格排序标志]-[上架时间排序标志]-[人气]-[评价]-[页号]_[价格低值]-[价格高值]
    @RequestMapping("/list/{listStr}")
    public String list(@PathVariable String listStr,String showtype, ModelMap map, HttpServletRequest req){
        
        tdCommonService.setHeader(map, req);
        
        if (null == listStr || "".equals(listStr))
        {
            return "/client/error_404";
        }
        
        // 排序字段个数
        int totalSorts = 5;
        
        // 4个排序字段
        String[] sortName = {"soldNumber", "salePrice", "onSaleTime","totalCollects", "totalComments"};
        
        Integer priceLow = null; // 价格低值
        Integer priceHigh = null; // 价格高值
        
        if (listStr.contains("_")) // 包括价格区间
        {
            String[] listGroup = listStr.split("_");
            
            if (listGroup.length > 1)
            {
                String[] priceGroup = listGroup[1].split("-");
                
                if (priceGroup.length > 1)
                {
                    priceLow = Integer.parseInt(priceGroup[0]);
                    priceHigh = Integer.parseInt(priceGroup[1]);
                }
            }
            
            listStr = listGroup[0];
        }
        
        map.addAttribute("priceLow", priceLow);
        map.addAttribute("priceHigh", priceHigh);
        
        String[] numberGroup = listStr.split("-");
        
        Long categoryId = null;
        
        if (numberGroup.length <= 0)
        {
            return "/client/error_404";
        }
        
        // 分类ID
        categoryId = Long.parseLong(numberGroup[0]);
        
        map.addAttribute("categoryId", categoryId);
        
        TdProductCategory tdProductCategory = tdProductCategoryService.findOne(categoryId);
        
        if (null == tdProductCategory)
        {
            return "/client/error_404";
        }
        
        // 品牌
        Integer brandIndex = 0;
        
        if (numberGroup.length > 1) // 解析品牌
        {
            brandIndex = Integer.parseInt(numberGroup[1]);
        }
        
        map.addAttribute("brandIndex", brandIndex);
        
        // 品牌列表
        
//        List<TdBrand> brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, categoryId);
        
        // 新修改 查找出第一级别类别下的所有品牌
        List<TdBrand> brandList = new ArrayList<>();
        
        if (null == tdProductCategory.getParentId()) {
        	brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, categoryId);
		}else {
			TdProductCategory tdProductCategory1 = tdProductCategoryService.findOne(tdProductCategory.getParentId());
	        
	        if (null == tdProductCategory1.getParentId()) {
	        	brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, tdProductCategory1.getId());
			}else {
				TdProductCategory tdProductCategory2 = tdProductCategoryService.findOne(tdProductCategory1.getParentId());
				if (null == tdProductCategory2.getParentId()) {
					brandList = tdBrandService.findByStatusIdAndProductCategoryTreeContaining(1L, tdProductCategory2.getId());
				}
			}
		}                       
        
        map.addAttribute("brand_list", brandList);
        
        // 品牌ID
        Long brandId = null;
        
        if (brandIndex.intValue() > 0 && brandList.size() >= brandIndex.intValue())
        {
            TdBrand brand = brandList.get(brandIndex - 1);
            brandId = brand.getId();
            
            // 如果品牌类别树不包含当前类别 则更换类别
            if (null != brand.getProductCategoryTree()) {
            	String[] tempList = brand.getProductCategoryTree().split(",");
            	String catStr = "[" + categoryId + "]";
            	List<String> tList = new ArrayList<>();
            	for(String cat : tempList){
            		tList.add(cat);
            	}
            	
            	if (!tList.contains(catStr)) {
            		
            		// 添加规则  类别上升一级
            		if (null != tdProductCategory.getParentId()) {
            			categoryId = tdProductCategory.getParentId();
            			map.addAttribute("categoryId", categoryId);
                		tdProductCategory = tdProductCategoryService.findOne(categoryId);
					}            		
            		
				}
            	
    		}
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
            
            map.addAttribute("param_list", paramList);
        }
        
        map.addAttribute("param_count", paramCount);
        map.addAttribute("param_index_list", paramIndexList);
        
        
        
        // 排序字段  可能的取值范围为[0...totalSorts-1]
        Integer orderId = 0;
        
        if (numberGroup.length >= paramCount + 3)
        {
            String orderIdStr = numberGroup[2 + paramCount];
            
            if (null != orderIdStr)
            {
                orderId = Integer.parseInt(orderIdStr);
            }
        }
        
        map.addAttribute("orderId", orderId);
        
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
        
        // 排序字段3标志位，0：降序，1：升序
        if (numberGroup.length >= paramCount + 7)
        {
            String sortIdStr = numberGroup[6 + paramCount];
            
            if (null != sortIdStr)
            {
                sortIds[3] = Integer.parseInt(sortIdStr);
            }
        }
        
        // 排序字段4标志位，0：降序，1：升序
        if (numberGroup.length >= paramCount + 8)
        {
            String sortIdStr = numberGroup[7 + paramCount];
            
            if (null != sortIdStr)
            {
                sortIds[4] = Integer.parseInt(sortIdStr);
            }
        }
        
        map.addAttribute("sort_id_list", sortIds);

        // 页号
        Integer pageId = 0;
        
        if (numberGroup.length >= paramCount + 9)
        {
            String pageIdStr = numberGroup[8 + paramCount];
            
            if (null != pageIdStr)
            {
                pageId = Integer.parseInt(pageIdStr);
            }
        }
        
        map.addAttribute("pageId", pageId);
        
        // 是否有货
        Integer leftId = 0;
        
        if (numberGroup.length >= paramCount + 10)
        {
            String leftIdStr = numberGroup[9 + paramCount];
            
            if (null != leftIdStr)
            {
                leftId = Integer.parseInt(leftIdStr);
            }
        }
        
        map.addAttribute("leftId", leftId);
        
        // 获取该类型所有父类型
        if (null != tdProductCategory)
        {
            if (null != tdProductCategory.getParentTree() && !"".equals(tdProductCategory.getParentTree()))
            {
                List<TdProductCategory> catList = new ArrayList<TdProductCategory>();
                
                for (String cid : tdProductCategory.getParentTree().split(","))
                {
                    if (!"".equals(cid))
                    {
                        // 去除方括号
                        cid = cid.replace("[", "");
                        cid = cid.replace("]", "");
                        
                        TdProductCategory tpc = tdProductCategoryService.findOne(Long.parseLong(cid));
                        
                        if (null != tpc)
                        {
                            catList.add(tpc);
                        }
                    }
                }
                
                map.addAttribute("category_tree_list", catList);
            }
        }
        
        // 分类热卖推荐
        map.addAttribute("hot_sale_list", tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(categoryId, 0, 10).getContent());   
        
        // 销量排行
        map.addAttribute("most_sold_list", tdGoodsService.findByCategoryIdAndIsOnSaleTrueOrderBySoldNumberDesc(categoryId, 0, 10).getContent());   
        
        // 新品推荐
        map.addAttribute("newest_list", tdGoodsService.findByCategoryIdAndIsOnSaleTrueOrderByOnSaleTimeDesc(categoryId, 0, 10).getContent());   
        
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
        
        // 仅显示有货
        if (leftId.intValue() > 0)
        {
            // 按价格区间
            if (null != priceLow && null != priceHigh)
            {
                // 全部品牌
                if (0 == brandIndex.intValue())
                {
                    // 有货、价格区间
                    goodsPage = tdGoodsService.findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, priceLow, priceHigh, paramValueList, pageRequest);
                }
                else
                {
                    goodsPage = tdGoodsService.findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, brandId, priceLow, priceHigh, paramValueList, pageRequest);
                    
                }
            }
            // 所有价格
            else
            {
                // 全部品牌
                if (0 == brandIndex.intValue())
                {
                    goodsPage = tdGoodsService.findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, paramValueList, pageRequest);
                }
                else
                {
                    goodsPage = tdGoodsService.findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, brandId, paramValueList, pageRequest);
                    
                }
            }
        }
        // 所有商品
        else
        {
            // 按价格区间
            if (null != priceLow && null != priceHigh)
            {
                // 全部品牌
                if (0 == brandIndex.intValue())
                {
                    goodsPage = tdGoodsService.findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, priceLow, priceHigh, paramValueList, pageRequest);
                    
                }
                else // 品牌、价格区间
                {
                    goodsPage = tdGoodsService.findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrue(
                                        categoryId, brandId, priceLow, priceHigh, paramValueList, pageRequest);
                }
            }
            // 所有价格
            else
            {
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
            }
        }

        
        map.addAttribute("goods_page", goodsPage);   
        
        
        // 查询对比商品
        String username = (String) req.getSession().getAttribute("username");
        if (null == username) {
            username = req.getSession().getId();
        }
        map.addAttribute("contrast_goods_list", tdContrastGoodsService.findByUsernameAndCategoryId(username, categoryId));
        
        // 促销公告
        map.addAttribute("promotion_notice", tdArticleService.findByMenuIdAndCategoryIdAndIsEnableOrderBySortIdAsc(10L, 17L, 0, ClientConstant.pageSize));
        
        if (null != showtype) {
			if (showtype.equals("horizontal")) {
				return "/client/goods_list_horizontal";
			}
		}
        return "/client/goods_list";
    }
}
