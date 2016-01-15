package com.ynyes.huizi.controller.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdDiySite;
import com.ynyes.huizi.service.TdDiySiteService;

/**
 * @author lc
 * @注释：门店接口
 */
@Controller
@RequestMapping("/")
public class TdAppShopController {
	@Autowired
	TdDiySiteService tdDiySiteService;
	
	 // shop列表
    @RequestMapping(value="shop/getShopList")
    @ResponseBody
    public Map<String, Object> getShopList(ModelMap map,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        List<TdDiySite> tdDiySites = tdDiySiteService.findByIsEnableTrue();

        if (null != tdDiySites && !tdDiySites.isEmpty()) {
        	res.put("data", tdDiySites);
		}
        
        res.put("code", 0);
        
        return res;
    }
    
    // 门店详情
    @RequestMapping(value="shop/getShopDetail")
    @ResponseBody
    public Map<String, Object> getShopDetail(ModelMap map, Long id,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        TdDiySite tdDiySite = tdDiySiteService.findOne(id);

        if (null != tdDiySite) {
        	res.put("data", tdDiySite);
		}
        
        res.put("code", 0);
        
        return res;
    }
	
}
