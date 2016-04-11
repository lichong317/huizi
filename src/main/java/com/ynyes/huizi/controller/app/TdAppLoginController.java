package com.ynyes.huizi.controller.app;

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
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.MD5;

/**
 * 登录及注册
 *
 */
@Controller
@RequestMapping(value="/app",method = RequestMethod.GET)
public class TdAppLoginController {
    @Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdOrderService tdOrderService;
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
        if( userUsername!=null){
        	user=userUsername;
        }
        else if (null != userMobile) {
        	user=userMobile;
		}else{
			 res.put("msg", "用户不存在");
	         return res;
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
        
        data.put("headImageUri", user.getHeadImageUri());
        
        tdUserService.save(user);
        res.put("data", data);
        
        //用户类型
        if (null != user.getRoleId()) {
            res.put("roleId", user.getRoleId());
		}else {
			res.put("roleId", 0);
		}
      
        //用户级别
        if (null != user.getUserLevelTitle()) {
        	res.put("userLevelTitle", user.getUserLevelTitle());
		}
        
        
        res.put("status", 0);
        
        res.put("msg", "登录成功!");
        
        return res;
    }
    
    /**
	 * @author lc
	 * @注释：app qq登录接口
	 */
    @RequestMapping(value="/qq/login",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> appQQlogin(ModelMap map, String openId, String gender, String screen_name, String headImageUri,
			  								HttpServletRequest req){
    	Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);       
        
        res.put("code", 0);
        
        return res;
    }
    
    /**
  	 * @author lc
  	 * @注释：app 个人中心计数接口
  	 */
     @RequestMapping(value="/user/count",method = RequestMethod.GET)
     @ResponseBody
     public Map<String, Object> appUserCount(ModelMap map, String username, 
  			  								HttpServletRequest req){
      	Map<String, Object> res = new HashMap<String, Object>();
          
        res.put("code", 1);       
        
        if (null != username) {
        	req.getSession().setAttribute("username", username);
		}
//        TdUser userUsername = tdUserService.findByUsernameAndIsEnabled(username);
        
        res.put("total_unpayed", tdOrderService.countByUsernameAndStatusId(username, 2));
        res.put("total_undelivered", tdOrderService.countByUsernameAndStatusId(username, 3));
        res.put("total_unreceived", tdOrderService.countByUsernameAndStatusId(username, 4));
        res.put("total_uncommented", tdOrderService.countByUsernameAndStatusId(username, 5));
        res.put("total_finished", tdOrderService.countByUsernameAndStatusId(username, 6));
        
        res.put("code", 0);
          
        return res;
     }
}
