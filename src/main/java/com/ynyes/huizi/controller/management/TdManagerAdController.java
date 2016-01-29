package com.ynyes.huizi.controller.management;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdAd;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 后台广告管理控制器
 * 
 * @author Sharon
 */

@Controller
@RequestMapping(value="/Verwalter/ad")
public class TdManagerAdController {
    
    @Autowired
    TdAdService tdAdService;
    
    @Autowired
    TdAdTypeService tdAdTypeService;
    
    @Autowired
    TdManagerLogService tdManagerLogService;
    
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
                tdManagerLogService.addLog("delete", "用户删除广告", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
            {
                btnSave(listId, listSortId);
                tdManagerLogService.addLog("edit", "用户修改广告", req);
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
        
        map.addAttribute("ad_page", tdAdService.findAllOrderBySortIdAsc(page, size));
        
        return "/site_mag/ad_list";
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

        map.addAttribute("ad_type_list", tdAdTypeService.findAllOrderBySortIdAsc());
        
        if (null != id)
        {
            map.addAttribute("ad", tdAdService.findOne(id));
        }
        return "/site_mag/ad_edit";
    }
    
    @RequestMapping(value="/save")
    public String orderEdit(TdAd tdAd,
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
        
        if (null == tdAd.getId())
        {
            type = "add";
        }
        else
        {
            type = "edit";
        }
        
        tdAdService.save(tdAd);
        
        tdManagerLogService.addLog(type, "用户修改广告", req);
        
        return "redirect:/Verwalter/ad/list";
    }
    
    @RequestMapping(value="/param/edit",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> adTop(Long id,HttpServletRequest req)
    {
    	String username = (String) req.getSession().getAttribute("manager");
    	
    	Map<String,Object> res= new HashMap<>();
    	res.put("code", 1);
    	
    	if(null == username)
    	{
    		res.put("message", "请重新登录");
    		return res;
    	}
    	
    	if(null != id)
    	{
    		TdAd ad = tdAdService.findOne(id);
    		if(null != ad)
    		{
    			ad.setSortId(1L);
    			ad.setCreateTime(new Date());
    			tdAdService.save(ad);
    			
    			res.put("code", 0);
    			res.put("message", "置顶成功");
    			return res;
    		}
    	}
    	
    	res.put("message", "参数错误");
    	return res;
    }

    @ModelAttribute
    public void getModel(@RequestParam(value = "id", required = false) Long id,
                        Model model) {
        if (null != id) {
            model.addAttribute("tdAd", tdAdService.findOne(id));
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
            
            TdAd e = tdAdService.findOne(id);
            
            if (null != e)
            {
                if (sortIds.length > i)
                {
                    e.setSortId(sortIds[i]);
                    tdAdService.save(e);
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
                
                tdAdService.delete(id);
            }
        }
    }
}
