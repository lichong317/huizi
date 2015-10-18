package com.ynyes.huizi.controller.management;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdRedEnvelopeType;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdRedEnvelopeTypeService;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
@RequestMapping(value="/Verwalter")
public class TdManagerRedEnvelopeController {
	
	@Autowired
	TdRedEnvelopeService tdRedEnvelopeService;
	
	@Autowired
	TdRedEnvelopeTypeService tdRedEnvelopeTypeService;
	
	@Autowired
	TdCouponTypeService tdCouponTypeService;
	
	@Autowired
    TdManagerLogService tdManagerLogService;
	
	@RequestMapping(value="/redenvelopeType/list")
	public String redenvelopeTypelist(String __EVENTTARGET, 
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
	                tdManagerLogService.addLog("delete", "删除红包类型", req);
	            }
	            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
	            {
	                btnTypeSave(listId, listSortId);
	                tdManagerLogService.addLog("edit", "修改红包类型", req);
	            }
	     }
	     
	     if (null == page) {
			page = 0;
		 }
	     
	     Page<TdRedEnvelopeType> TdRedEnvelopeType_page = null;
	     
	     TdRedEnvelopeType_page = tdRedEnvelopeTypeService.findAllOrderBySortId(page , SiteMagConstant.pageSize);
	     
	     map.addAttribute("TdRedEnvelopeType_page", TdRedEnvelopeType_page);
	     
	     map.addAttribute("__EVENTTARGET", __EVENTTARGET);
	     map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
	     map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		
		 return "/site_mag/redenvelope_type_list";
	}
	
	@RequestMapping(value="/redenvelopeType/edit")
    public String redenvelopeTypeEdit(Long id,
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
            map.addAttribute("redenvelopeType", tdRedEnvelopeTypeService.findOne(id));
        }
        
        //优惠券类型
        map.addAttribute("tdcouponType_list", tdCouponTypeService.findAllOrderBySortIdAsc());
        
        return "/site_mag/redenvelope_type_edit";
    }
	
	@RequestMapping(value = "/redenvelopeType/save")
	public String typeSave(TdRedEnvelopeType tdRedEnvelopeType, String __VIEWSTATE, ModelMap map,
	            HttpServletRequest req) {
	    String username = (String) req.getSession().getAttribute("manager");
	        
	    if (null == username) {
	            return "redirect:/Verwalter/login";
	    }

	    map.addAttribute("__VIEWSTATE", __VIEWSTATE);

	    if (null == tdRedEnvelopeType.getId()) {
	            tdManagerLogService.addLog("add", "用户添加红包类型", req);
	    } else {
	            tdManagerLogService.addLog("edit", "用户修改红包类型", req);
	    }

	    tdRedEnvelopeTypeService.save(tdRedEnvelopeType);

	    return "redirect:/Verwalter/redenvelopeType/list";
	}
	
	@RequestMapping(value="/redenvelope/list")
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
	                tdManagerLogService.addLog("delete", "删除发放红包记录", req);
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
	     
	     Page<TdRedEnvelope> TdRedEnvelope_page = null;
	     
	     TdRedEnvelope_page = tdRedEnvelopeService.findAll(page , SiteMagConstant.pageSize);
	     
	     map.addAttribute("TdRedEnvelope_page", TdRedEnvelope_page);
	     
	     map.addAttribute("__EVENTTARGET", __EVENTTARGET);
	     map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
	     map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		
		 return "/site_mag/redenvelope_list";
	}
	
	@ModelAttribute
    public void getModel(@RequestParam(value = "redenvelopeTypeId", required = false) Long redenvelopeTypeId,
                        @RequestParam(value = "redenvelopeId", required = false) Long redenvelopeId,
                        Model model) {
        if (null != redenvelopeTypeId) {
            model.addAttribute("tdRedEnvelopeType", tdRedEnvelopeTypeService.findOne(redenvelopeTypeId));
        }
        
        if (null != redenvelopeId) {
            model.addAttribute("tdRedEnvelope", tdRedEnvelopeService.findOne(redenvelopeId));
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
	            
	            TdRedEnvelopeType e = tdRedEnvelopeTypeService.findOne(id);
	            
	            if (null != e)
	            {
	                if (sortIds.length > i)
	                {
	                    e.setSortId(sortIds[i]);
	                    tdRedEnvelopeTypeService.save(e);
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
	                
	                tdRedEnvelopeTypeService.delete(id);
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
	            
	            TdRedEnvelope e = tdRedEnvelopeService.findOne(id);
	            
	            if (null != e)
	            {
	                if (sortIds.length > i)
	                {
	                    //e.setSortId(sortIds[i]);
	                	tdRedEnvelopeService.save(e);
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
	                
	                tdRedEnvelopeService.delete(id);
	            }
	        }
	    }
}
