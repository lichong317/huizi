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
import org.springframework.web.bind.annotation.RequestParam;

import com.ynyes.huizi.entity.TdAd;
import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 后台广告位管理控制器
 * 
 * @author Sharon
 */

@Controller
@RequestMapping(value="/Verwalter/ad/type")
public class TdManagerAdTypeController {
    
    @Autowired
    TdAdTypeService tdAdTypeService;
    
    @Autowired
    TdManagerLogService tdManagerLogService;
    
    @Autowired
    TdAdService tdAdService;
    
    @RequestMapping(value="/list")
    public String setting(Integer page,
                          Integer size,
                          String __EVENTTARGET,
                          String __EVENTARGUMENT,
                          String __VIEWSTATE,
                          Long[] listId,
                          Integer[] listChkId,
                          Long[] listSortId,
                          ModelMap map,
                          HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        if (null != __EVENTTARGET)
        {
            if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
            {
                btnDelete(listId, listChkId);
                tdManagerLogService.addLog("delete", "用户删除广告位", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
            {
                btnSave(listId, listSortId);
                tdManagerLogService.addLog("edit", "用户修改广告位", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnPage"))
            {
                if (null != __EVENTARGUMENT)
                {
                    page = Integer.parseInt(__EVENTARGUMENT);
                } 
            }
        }
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null == size || size <= 0)
        {
            size = SiteMagConstant.pageSize;;
        }
        
        map.addAttribute("page", page);
        map.addAttribute("size", size);
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        
        Page<TdAdType> tdAdTypePage = tdAdTypeService.findAllOrderBySortIdAsc(page, size);
        
        map.addAttribute("ad_type_page", tdAdTypePage);
        
        if (null != tdAdTypePage) {
			for(int i=0; i < tdAdTypePage.getContent().size(); i++){
				List<TdAd> tdAdsList = tdAdService.findByTypeIdOrderBySortIdAsc(tdAdTypePage.getContent().get(i).getId());
				
				map.addAttribute("ad"+ i +"list", tdAdsList);
			}
		}
        
        return "/site_mag/ad_type_list";
    }
    
    @RequestMapping(value="/edit")
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
            map.addAttribute("ad_type", tdAdTypeService.findOne(id));
        }
        return "/site_mag/ad_type_edit";
    }
    
    @RequestMapping(value="/save")
    public String orderEdit(TdAdType tdAdType,
                        String __VIEWSTATE,
                        ModelMap map,
                        HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        
        String type = null;
        
        if (null == tdAdType.getId())
        {
            type = "add";
        }
        else
        {
            type = "edit";
        }
        
        tdAdTypeService.save(tdAdType);
        
        tdManagerLogService.addLog(type, "用户修改广告位", req);
        
        return "redirect:/Verwalter/ad/type/list";
    }

    @ModelAttribute
    public void getModel(@RequestParam(value = "id", required = false) Long id,
                        Model model) {
        if (null != id) {
            model.addAttribute("tdAdType", tdAdTypeService.findOne(id));
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
            
            TdAdType e = tdAdTypeService.findOne(id);
            
            if (null != e)
            {
                if (sortIds.length > i)
                {
                    e.setSortId(sortIds[i]);
                    tdAdTypeService.save(e);
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
                
                tdAdTypeService.delete(id);
            }
        }
    }
}
