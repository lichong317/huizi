package com.ynyes.huizi.touch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;

@Controller
public class TdTouchRegController {
	@Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdUserPointService tdUserPointService;
    
    @Autowired
    private TdSettingService tdSettingService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @RequestMapping("/touch/reg")
    public String reg(Integer errCode, 
    				  Integer shareId,
    				  HttpServletRequest request,
    				  ModelMap map) {
        String username = (String) request.getSession().getAttribute("username");
        if (null != shareId)
        {
            map.addAttribute("share_id", shareId);
        }
        
        // 基本信息
        tdCommonService.setHeader(map, request);
        
        if (null == username) {
            if (null != errCode)
            {
                if(errCode.equals(1))
                {
                	map.addAttribute("error","验证码错误");
                }
                else if (errCode.equals(2))
                {
                    map.addAttribute("error", "用户名已存在");
                }
                else if (errCode.equals(3))
                {
                    map.addAttribute("error", "短信验证码错误");
                }
                map.addAttribute("errCode", errCode);
            }
            return "/touch/reg";
        }
        return "redirect:/touch";
    }
}
