package com.ynyes.huizi.controller.app;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.MD5;

/**
 * 登录及注册
 *
 */
@Controller
public class TdAppLoginController {
    @Autowired
    private TdUserService tdUserService;
    
        
    /**
	 * @author lc
	 * @注释：app 登录接口
	 */
    @RequestMapping(value="/app/login",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> applogin(String username, 
                String password, 
                String code, 
                Boolean isSave,
                HttpServletRequest request) {
        Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("status", 1);
        
        if (username.isEmpty() || password.isEmpty())
        {
            res.put("msg", "用户名及密码不能为空");
            return res;
        }
        
        if (code.isEmpty()) {
			res.put("msg", "验证码为空");
			return res;
		}
        
        String codeBack = (String) request.getSession().getAttribute("RANDOMVALIDATECODEKEY");
        if (null == codeBack) {
			codeBack = "123456";
		}
        if (!codeBack.equalsIgnoreCase(code)) {
        	res.put("msg", "验证码错误");
    		return res;
		}
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (!user.getPassword().equals(password))
        {
            res.put("msg", "密码错误");
            return res;
        }
        
        user.setLastLoginTime(new Date());
        
        tdUserService.save(user);
        
        res.put("username", username);
        
        res.put("password", MD5.md5(password, 32) );       
        
        res.put("status", 0);
        
        return res;
    }
    
}
