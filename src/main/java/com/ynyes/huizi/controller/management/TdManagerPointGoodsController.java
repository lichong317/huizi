package com.ynyes.huizi.controller.management;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdPointGoods;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.service.TdPointGoodsService;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
@RequestMapping(value="/Verwalter/pointGoods")
public class TdManagerPointGoodsController {
	
    @Autowired
    TdManagerLogService tdManagerLogService;
	
    @Autowired
    TdPointGoodsService tdPointGoodsService;
    
    @RequestMapping(value="/list")
    public String goodsList(Integer page, 
                              Integer size,
                              Long categoryId,
                              String property,
                              String __EVENTTARGET,
                              String __EVENTARGUMENT,
                              String __VIEWSTATE,
                              String keywords,
                              Long[] listId,
                              Integer[] listChkId,
                              Long[] listSortId,
                              ModelMap map,
                              HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username) {
            return "redirect:/Verwalter/login";
        }
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null == size || size <= 0)
        {
            size = SiteMagConstant.pageSize;;
        }
        
        if (null != keywords)
        {
            keywords = keywords.trim();
        }
        
        if (null != __EVENTTARGET)
        {
            switch (__EVENTTARGET)
            {
            case "lbtnViewTxt":
            case "lbtnViewImg":
                __VIEWSTATE = __EVENTTARGET;
                break;
            
            case "btnSave":
                btnSave(listId, listSortId, username);
                tdManagerLogService.addLog("edit", "用户修改商品", req);
                break;
                
            case "btnDelete":
                btnDelete(listId, listChkId);
                tdManagerLogService.addLog("delete", "用户删除商品", req);
                break;
                
            case "btnPage":
                if (null != __EVENTARGUMENT)
                {
                    page = Integer.parseInt(__EVENTARGUMENT);
                } 
                break;
            
            case "btnOnSale":
                if (null != __EVENTARGUMENT)
                {
                    Long goodsId = Long.parseLong(__EVENTARGUMENT);
                    
                    if (null != goodsId)
                    {
                        TdPointGoods goods = tdPointGoodsService.findOne(goodsId);
                        
                        if (null != goods)
                        {
                            if (null == goods.getIsOnSale() || !goods.getIsOnSale())
                            {
                                goods.setIsOnSale(true);
                                tdManagerLogService.addLog("delete", "用户上架积分商品:" + goods.getTitle(), req);
                            }
                            else
                            {
                                goods.setIsOnSale(false);
                                tdManagerLogService.addLog("delete", "用户下架积分商品:" + goods.getTitle(), req);
                            }
                            tdPointGoodsService.save(goods, username);
                        }
                    }
                } 
                break;
            }
        }
        
        if (null != __EVENTTARGET && __EVENTTARGET.equalsIgnoreCase("lbtnViewTxt")
                || null != __EVENTTARGET && __EVENTTARGET.equalsIgnoreCase("lbtnViewImg"))
        {
            __VIEWSTATE = __EVENTTARGET;
        }
                    
        Page<TdPointGoods> goodsPage = null;
        
        if (null == categoryId)
        {
            if (null == keywords || "".equalsIgnoreCase(keywords))
            {
            	if ("isOnSale".equalsIgnoreCase(property)) {
					goodsPage = tdPointGoodsService.findByIsOnsaleTrueOrderBySortIdAsc(page, size);
				}else if ("isNotOnSale".equalsIgnoreCase(property)) {
					goodsPage = tdPointGoodsService.findByIsOnsaleFalseOrderBySortIdAsc(page, size);
				}else {
					goodsPage = tdPointGoodsService.findAllOrderBySortIdAsc(page, size);
				}
                
            }
            else
            {
            	if ("isOnSale".equalsIgnoreCase(property)) {
					goodsPage = tdPointGoodsService.searchIsOnsaleTrueAndOrderBySortIdAsc(keywords, page, size);
				}else if ("isNotOnSale".equalsIgnoreCase(property)) {
					goodsPage = tdPointGoodsService.searchIsOnsaleFalseAndOrderBySortIdAsc(keywords, page, size);
				}else {
					goodsPage = tdPointGoodsService.searchAndOrderBySortIdAsc(keywords, page, size);
				}
            }
        }
//        else
//        {
//            if (null == keywords || "".equalsIgnoreCase(keywords))
//            {
//                goodsPage = tdPointGoodsService.findByCategoryIdTreeContainingOrderBySortIdAsc(categoryId, page, size);
//            }
//            else
//            {
//                goodsPage = tdPointGoodsService.searchAndFindByCategoryIdOrderBySortIdAsc(keywords, categoryId, page, size);
//            }
//        }
        
        map.addAttribute("content_page", goodsPage);
        
        // 参数注回
        map.addAttribute("page", page);
        map.addAttribute("size", size);
        map.addAttribute("keywords", keywords);
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        map.addAttribute("categoryId", categoryId);
        
        // 文字列表模式
        if (null != __VIEWSTATE && __VIEWSTATE.equals("lbtnViewTxt"))
        {
            return "/site_mag/goods_txt_list";
        }
        
        // 图片列表模式
        return "/site_mag/point_goods_list";
    }
    
    @RequestMapping(value="/edit")
    public String goodsEdit(Long pid, Long id, 
            String __EVENTTARGET,
            String __EVENTARGUMENT,
            String __VIEWSTATE,
            ModelMap map,
            HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username) {
            return "redirect:/Verwalter/login";
        }
        
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        
        
//        map.addAttribute("category_list", tdProductCategoryService.findAll());
                
        if (null != id)
        {
            TdPointGoods tdPointGoods = tdPointGoodsService.findOne(id);
            
            if (null != tdPointGoods)
            {
//                // 参数列表
//                TdProductCategory tpc = tdProductCategoryService.findOne(tdGoods.getCategoryId());
//                
//                if (null != tpc && null != tpc.getParamCategoryId())
//                {
//                    map.addAttribute("param_list", tdParameterService.findByCategoryTreeContaining(tpc.getParamCategoryId()));
//                }
                
                // 查找产品列表
//                map.addAttribute("product_list", tdProductService.findByProductCategoryTreeContaining(tdGoods.getCategoryId()));
//            
//                // 查找品牌
//                map.addAttribute("brand_list", tdBrandService.findByProductCategoryTreeContaining(tdGoods.getCategoryId()));
//                
//                map.addAttribute("warehouse_list", tdWarehouseService.findAll());
                
                map.addAttribute("goods", tdPointGoods);
            }
        }
        
        return "/site_mag/point_goods_edit";
    }
    
    @RequestMapping(value="/save", method = RequestMethod.POST)
    public String save(TdPointGoods tdPointGoods, 
                        String[] hid_photo_name_show360,
                        String __EVENTTARGET,
                        String __EVENTARGUMENT,
                        String __VIEWSTATE,
                        String menuId,
                        String channelId,
                        ModelMap map,
                        HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        String uris = parsePicUris(hid_photo_name_show360);
        
        tdPointGoods.setShowPictures(uris);
        
        String type = null;
        
        if (null == tdPointGoods.getId())
        {
            type = "add";
        }
        else
        {
            type = "edit";
        }
               
        
        tdPointGoodsService.save(tdPointGoods, username);
        
        tdManagerLogService.addLog(type, "用户修改积分商品", req);
        
        return "redirect:/Verwalter/pointGoods/list?__EVENTTARGET=" + __EVENTTARGET
                + "&__EVENTARGUMENT=" + __EVENTARGUMENT
                + "&__VIEWSTATE=" + __VIEWSTATE;
    }
    
    @ModelAttribute
    public void getModel(@RequestParam(value = "id", required = false) Long id,
            Model model) {
        if (id != null) {
            TdPointGoods goods = tdPointGoodsService.findOne(id);
            model.addAttribute("tdPointGoods", goods);
        }
    }
    
    /**
     * 图片地址字符串整理，多张图片用,隔开
     * 
     * @param params
     * @return
     */
    private String parsePicUris(String[] uris)
    {
        if (null == uris || 0 == uris.length)
        {
            return null;
        }
        
        String res = "";
        
        for (String item : uris)
        {
            String uri = item.substring(item.indexOf("|")+1, item.indexOf("|", 2));
            
            if (null != uri)
            {
                res += uri;
                res += ",";
            }
        }
        
        return res;
    }
    
    /**
     * 修改商品
     * @param cid
     * @param ids
     * @param sortIds
     * @param username
     */
    private void btnSave(Long[] ids, Long[] sortIds, String username)
    {
        if (null == ids || null == sortIds
                || ids.length < 1 || sortIds.length < 1)
        {
            return;
        }
        
        for (int i = 0; i < ids.length; i++)
        {
            Long id = ids[i];
            
            TdPointGoods goods = tdPointGoodsService.findOne(id);
                
            if (sortIds.length > i)
            {
                goods.setSortId(sortIds[i]);
                tdPointGoodsService.save(goods, username);
            }
        }
    }
    
    /**
     * 删除商品
     * 
     * @param ids
     * @param chkIds
     */
    private void btnDelete(Long[] ids, Integer[] chkIds)
    {
        if (null == ids || null == chkIds
                || ids.length < 1 || chkIds.length < 1)
        {
            return;
        }
        
        for (int chkId : chkIds)
        {
            if (chkId >=0 && ids.length > chkId)
            {
                Long id = ids[chkId];
                
                tdPointGoodsService.delete(id);
            }
        }
    }
}
