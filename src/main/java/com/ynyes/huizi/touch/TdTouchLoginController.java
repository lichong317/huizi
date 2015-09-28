package com.ynyes.huizi.touch;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserService;

@Controller
public class TdTouchLoginController {
	 	@Autowired
	    private TdUserService tdUserService;
	    
	    @Autowired
	    private TdSettingService tdSettingService;
	    
	    @Autowired
	    private TdCommonService tdCommonService;

	    @RequestMapping(value = "/touch/login", method = RequestMethod.GET)
	    public String login(HttpServletRequest req, ModelMap map) {
	        String username = (String) req.getSession().getAttribute("username");

	        String referer = req.getHeader("referer");
	        
	        // 基本信息
	        tdCommonService.setHeader(map, req);
	        
	        if (null == username) 
	        {
	            return "/touch/login";
	        }
	        
	        if (null == referer)
	        {
	            referer = "/touch/";
	        }
	        
	        return "redirect:/touch" + referer;
	    }
	    
	    @RequestMapping(value="/touch/login",method = RequestMethod.POST)
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
	        
	        if (null != user)
	        {
	        	if (!user.getPassword().equals(password))
	            {
	                res.put("msg", "密码错误");
	                return res;
	            }
	        	user.setLastLoginTime(new Date());
	             
	            tdUserService.save(user);
	             
	            request.getSession().setAttribute("username", username);
	            request.getSession().setAttribute("usermobile", user.getMobile());
	            res.put("code", 0);
	            return res;
	        }
	        
	        user = tdUserService.findByMobileAndIsEnabled(username);
	        if (null != user) {
	        	if (!user.getPassword().equals(password))
	            {
	                res.put("msg", "密码错误");
	                return res;
	            }
	        	user.setLastLoginTime(new Date());
	             
	            tdUserService.save(user);
	             
	            request.getSession().setAttribute("username", user.getUsername());
	            request.getSession().setAttribute("usermobile", user.getMobile());
	            res.put("code", 0);
	            return res;
			}else{
				res.put("msg", "不存在该用户");
				return res;
			}
	        
	    }
	    
	    /**
	     * @author mdj
	     * @param request
	     * @return 返回手机端主页
	     */
	    @RequestMapping("/touch/logout")
		public String logOut(HttpServletRequest request) {
			request.getSession().invalidate();
			return "redirect:/touch";
		}
}
