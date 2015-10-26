package com.ynyes.huizi.controller.front;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.VerifServlet;

/**
 * 登录及注册
 *
 */
@Controller
public class TdLoginController {
    @Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdSettingService tdSettingService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @Autowired
    private TdAdTypeService tdAdTypeService;
    
    @Autowired
    private TdAdService tdAdService;
    
    @Autowired
    private TdRedEnvelopeService tdRedEnvelopeService;
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest req, Long shareId, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");

        String referer = req.getHeader("referer");
        
        if (null != shareId) {
        	map.addAttribute("shareId", shareId);
		}
        
        // 网站基本信息
        map.addAttribute("site", tdSettingService.findTopBy());
        tdCommonService.setHeader(map, req);
        
        /**
		 * @author lc
		 * @注释：
		 */
        TdAdType tdAdType = tdAdTypeService.findByTitle("登陆广告位");
        
        if (null != tdAdType) {
            map.addAttribute("login_ad_list",
                    tdAdService.findByTypeId(tdAdType.getId()));
        }
        
        if (null == username) 
        {
            return "/client/login";
        }
        
        if (null == referer)
        {
            referer = "/";
        }
        
        return "redirect:" + referer;
    }
       
    
    @RequestMapping(value="/login",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(String username, 
                String password, 
                String code, 
                Boolean isSave,
                HttpServletRequest request) {
        Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        if (username.isEmpty() || password.isEmpty())
        {
            res.put("msg", "用户名及密码不能为空");
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (!user.getPassword().equals(password))
        {
            res.put("msg", "密码错误");
            return res;
        }
        
        user.setLastLoginTime(new Date());
        
        tdUserService.save(user);
        
        // 检查室友有未领取红包
        List<TdRedEnvelope> tdRedEnvelopes = tdRedEnvelopeService.findByUsernameAndIsGetFalse(username);
        if (tdRedEnvelopes.isEmpty()) {
			res.put("hasRedenvelope", 0);
		}else {
			res.put("hasRedenvelope", 1);
		}
        
        request.getSession().setAttribute("username", username);
        
        res.put("code", 0);
        
        return res;
    }

    @RequestMapping("/logout")
    public String logOut(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/verify",method = RequestMethod.GET)
    public void verify(HttpServletResponse response, HttpServletRequest request) {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        VerifServlet randomValidateCode = new VerifServlet();
        randomValidateCode.getRandcode(request, response);
    }
}
