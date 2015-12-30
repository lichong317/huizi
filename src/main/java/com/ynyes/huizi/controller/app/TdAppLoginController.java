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
import com.ynyes.huizi.util.VerifServlet;

/**
 * 登录及注册
 *
 */
@Controller
@RequestMapping(value="/app",method = RequestMethod.GET)
public class TdAppLoginController {
    @Autowired
    private TdUserService tdUserService;
    /**
	 * @author lc
	 * @注释：app 登录接口
	 */
    @RequestMapping(value="/login",method = RequestMethod.GET)
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
        
//        if (code.isEmpty()) {
//			res.put("msg", "验证码为空");
//			return res;
//		}
//        String codeBack = (String) request.getSession().getAttribute(VerifServlet.RANDOMCODEKEY);
//        System.out.println("App-login Session:" + request.getSession().getId());
//        System.out.println("code:"+codeBack);
//        if (null == codeBack) {
//			codeBack = "123456";
//		}
//        if (!codeBack.equalsIgnoreCase(code)) {
//        	res.put("msg", "验证码错误");
//    		return res;
//		}
        
        TdUser userMobile = tdUserService.findByMobileAndIsEnabled(username);
        TdUser userUsername=tdUserService.findByUsernameAndIsEnabled(username);
        TdUser user=null;
        if(userMobile==null && userUsername!=null){
        	user=userUsername;
        }else{
        	user=userMobile;
        }
        System.out.println("password:"+user.getPassword());
        if (!user.getPassword().equals(password))
        {
            res.put("msg", "密码错误");
            return res;
        }
        user.setLastLoginTime(new Date());
        Map<String, Object> data=new HashMap<String, Object>();
        data.put("username", user.getUsername());
        
        data.put("password", MD5.md5(password, 32) );       
        
        tdUserService.save(user);
        res.put("data", data);
      
        res.put("status", 0);
        
        res.put("msg", "登录成功!");
        
        return res;
    }
    
}
