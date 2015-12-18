package com.ynyes.huizi.controller.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdDiySite;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdDiySiteService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.SMSUtil;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
@RequestMapping("/shop")
public class TdShopController {
	@Autowired 
    private TdDiySiteService tdDiySiteService;
	
	@Autowired 
    private TdUserService tdUserService;
		
	@Autowired
    private TdCommonService tdCommonService;
	
	@Autowired
    private TdUserRecentVisitService tdUserRecentVisitService;
    
	@RequestMapping("/list")
    public String infoList(Integer page, 
                            ModelMap map,
                            Integer cid,
                            HttpServletRequest req){
	    
	    tdCommonService.setHeader(map, req);
        
        if (null == cid)
        {
            cid = 0;
        }
        
        if (null == page) {
			page = 0;
		}
        
        map.addAttribute("cid", cid);        
        
        map.addAttribute("shop_list", tdDiySiteService.findAllOrderBySortIdAsc(page, SiteMagConstant.pageSize));
       
        
        
        return "/client/shop_list";
    }
	
	@RequestMapping("/{id}")
    public String shop(@PathVariable Long id, ModelMap map, HttpServletRequest req){
	    tdCommonService.setHeader(map, req);
	    
	    map.addAttribute("shop", tdDiySiteService.findOne(id));
	    
        return "/client/shop_detail";
    }
	
	/**
	 * @author lc
	 * @注释：发送地址到用户手机
	 */
    @RequestMapping(value="/sendAddress", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> sendaddress(Long id, HttpServletRequest req){
    	 Map<String, Object> res = new HashMap<String, Object>();         
        res.put("code", 1);
        String username = (String) req.getSession().getAttribute("username");
        if (null == username) {
			res.put("msg", "请登录");
			return res;
		}
         
        if (null == id) {
        	res.put("msg", "发送失败！");
			return res;
		}
        
        TdUser tdUser = tdUserService.findByUsername(username);
        TdDiySite tdDiySite = tdDiySiteService.findOne(id);
        if (null == tdDiySite) {
        	res.put("msg", "发送失败！");
			return res;
		}
        if (null == tdDiySite.getTitle() || null == tdDiySite.getAddress() || null == tdDiySite.getServiceTele()) {
        	res.put("msg", "发送失败！");
			return res;
		}
        //发送地址到手机
        SMSUtil.send(tdUser.getMobile(), "33442" ,new String[]{tdDiySite.getTitle(), tdDiySite.getAddress(), tdDiySite.getServiceTele(),"http://www.huizhidian.com/touch/shop/list"});
        res.put("code", 0);
        return res;
    }
}
