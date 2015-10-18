package com.ynyes.huizi.controller.management;

import java.util.List;

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

import com.ynyes.huizi.entity.TdPrize;
import com.ynyes.huizi.entity.TdPrizeCategory;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.service.TdPrizeCategoryService;
import com.ynyes.huizi.service.TdPrizeService;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
@RequestMapping(value="/Verwalter")
public class TdManagerLotteryController {
	
	@Autowired
	TdPrizeService tdPrizeService;
	
	@Autowired
	TdPrizeCategoryService tdPrizeCategoryService;
	
	@Autowired
	TdCouponTypeService tdCouponTypeService;
	
	@Autowired
    TdManagerLogService tdManagerLogService;
	
	@RequestMapping(value="/prizecategory/list")
	public String prizecategorylist(String __EVENTTARGET, 
									String __EVENTARGUMENT,
						            String __VIEWSTATE, String[] listChkTitle, Long[] listId,
						            Integer[] listChkId,
						            Long[] listSortId,
						            Integer page,
						            ModelMap map,
						            HttpServletRequest req){
		
		 String username = (String) req.getSession().getAttribute("manager");
	        
	     if (null == username) {
	            return "redirect:/Verwalter/login";
	     }
	        
	     if (null != __EVENTTARGET)
	     {
	            if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
	            {
	                btnTypeDelete(listId, listChkId);
	                tdManagerLogService.addLog("delete", "删除奖项类型", req);
	            }
	            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
	            {
	                btnTypeSave(listId, listSortId);
	                tdManagerLogService.addLog("edit", "修改奖项类型", req);
	            }
	     }
	     
	     if (null == page) {
			page = 0;
		 }
	     
	     Page<TdPrizeCategory> TdPrizeCategory_page = null;
	     
	     TdPrizeCategory_page = tdPrizeCategoryService.findAllOrderBySortId(page , SiteMagConstant.pageSize);
	     
	     map.addAttribute("prizeCategory_page", TdPrizeCategory_page);
	     
	     map.addAttribute("__EVENTTARGET", __EVENTTARGET);
	     map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
	     map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		
		 return "/site_mag/prize_category_list";
	}
	
	@RequestMapping(value="/prizecategory/edit")
    public String orderEdit(Long id,
                        String __VIEWSTATE,
                        ModelMap map,
                        HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
                                
        if (null != id)
        {
            map.addAttribute("prizeCategory", tdPrizeCategoryService.findOne(id));
        }
        
        //优惠券类型
        map.addAttribute("tdcouponType_list", tdCouponTypeService.findAllOrderBySortIdAsc());
        
        return "/site_mag/prize_category_edit";
    }
	
	@RequestMapping(value = "/prizecategory/save")
	public String typeSave(TdPrizeCategory tdPrizeCategory, String __VIEWSTATE, ModelMap map,
	            HttpServletRequest req) {
	    String username = (String) req.getSession().getAttribute("manager");
	        
	    if (null == username) {
	            return "redirect:/Verwalter/login";
	    }

	    map.addAttribute("__VIEWSTATE", __VIEWSTATE);

	    if (null == tdPrizeCategory.getId()) {
	            tdManagerLogService.addLog("add", "用户添加奖项类型", req);
	    } else {
	            tdManagerLogService.addLog("edit", "用户修改奖项类型", req);
	    }

	    tdPrizeCategoryService.save(tdPrizeCategory);

	    return "redirect:/Verwalter/prizecategory/list";
	}
	
	@RequestMapping(value="/prize/list")
	public String prizelist(String __EVENTTARGET, 
									String __EVENTARGUMENT,
						            String __VIEWSTATE, String[] listChkTitle, Long[] listId,
						            Integer[] listChkId,
						            Long[] listSortId,
						            Integer page,
						            ModelMap map,
						            HttpServletRequest req){
		
		 String username = (String) req.getSession().getAttribute("manager");
	        
	     if (null == username) {
	            return "redirect:/Verwalter/login";
	     }
	        
	     if (null != __EVENTTARGET)
	     {
	            if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
	            {
	                btnTypeDelete(listId, listChkId);
	                tdManagerLogService.addLog("delete", "删除中奖记录", req);
	            }
//	            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
//	            {
//	                btnTypeSave(listId, listSortId);
//	                tdManagerLogService.addLog("edit", "修改奖项类型", req);
//	            }
	     }
	     
	     if (null == page) {
			page = 0;
		 }
	     
	     Page<TdPrize> TdPrize_page = null;
	     
	     TdPrize_page = tdPrizeService.findAll(page , SiteMagConstant.pageSize);
	     
	     map.addAttribute("prize_page", TdPrize_page);
	     
	     map.addAttribute("__EVENTTARGET", __EVENTTARGET);
	     map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
	     map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		
		 return "/site_mag/prize_list";
	}
	
	@ModelAttribute
    public void getModel(@RequestParam(value = "prizeTypeId", required = false) Long prizeTypeId,
                        @RequestParam(value = "prizeId", required = false) Long prizeId,
                        Model model) {
        if (null != prizeTypeId) {
            model.addAttribute("tdPrizeCategory", tdPrizeCategoryService.findOne(prizeTypeId));
        }
        
        if (null != prizeId) {
            model.addAttribute("tdPrize", tdPrizeService.findOne(prizeId));
        }
    }
	
	 private void btnTypeSave(Long[] ids, Long[] sortIds)
	    {
	        if (null == ids || null == sortIds
	                || ids.length < 1 || sortIds.length < 1)
	        {
	            return;
	        }
	        
	        for (int i = 0; i < ids.length; i++)
	        {
	            Long id = ids[i];
	            
	            TdPrizeCategory e = tdPrizeCategoryService.findOne(id);
	            
	            if (null != e)
	            {
	                if (sortIds.length > i)
	                {
	                    e.setSortId(sortIds[i]);
	                    tdPrizeCategoryService.save(e);
	                }
	            }
	        }
	    }
	    
	    private void btnTypeDelete(Long[] ids, Integer[] chkIds)
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
	                
	                tdPrizeCategoryService.delete(id);
	            }
	        }
	    }
	    
	    private void btnSave(Long[] ids, Long[] sortIds)
	    {
	        if (null == ids || null == sortIds
	                || ids.length < 1 || sortIds.length < 1)
	        {
	            return;
	        }
	        
	        for (int i = 0; i < ids.length; i++)
	        {
	            Long id = ids[i];
	            
	            TdPrize e = tdPrizeService.findOne(id);
	            
	            if (null != e)
	            {
	                if (sortIds.length > i)
	                {
	                    //e.setSortId(sortIds[i]);
	                	tdPrizeService.save(e);
	                }
	            }
	        }
	    }
	    
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
	                
	                tdPrizeService.delete(id);
	            }
	        }
	    }
}
