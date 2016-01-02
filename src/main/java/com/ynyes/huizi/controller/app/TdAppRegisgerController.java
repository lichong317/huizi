package com.ynyes.huizi.controller.app;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdUserService;

/**
 * 注册处理
 * 
 */
@Controller
@RequestMapping(value = "/app", method = RequestMethod.GET)
public class TdAppRegisgerController {
    @Autowired
    private TdUserService tdUserService;
    
    //APP 手机号验证
    @RequestMapping(value = "/reg/check/{type}", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> appregcheck(@PathVariable String type, String param) {
        Map<String, Object> res = new HashMap<String, Object>();

        res.put("status", 1);
        
        if (null == type)
        {
        	res.put("msg", "参数错误");
            return res;
        }
        
        if (type.equalsIgnoreCase("username"))
        {
        	if (null == param || param.isEmpty()) {
                res.put("msg", "用户名不能为空");
                return res;
            }
        	
        	TdUser user = tdUserService.findByUsername(param);
        	
        	if (null != user)
        	{
        		res.put("msg", "用户名已存在");
                return res;
        	}
        }
        
        /**
         * 	ajax实时验证
         * 	手机号查找用户
         * 	判断手机号是已否注册
         * @author libiao
         */
        if (type.equalsIgnoreCase("mobile"))		
        {
        	if (null == param || param.isEmpty())
        	{
                res.put("msg", "手机号不能为空");
                return res;
            }
        	
        	TdUser user = tdUserService.findByMobileAndIsEnabled(param);		
        	
        	if (null != user)	
         	{
        		res.put("msg", "该手机已经注册");
                return res;
        	}
        }

        res.put("status", 0);

        return res;
    }
    
    
    /**
	 * @author lc
	 * @注释：app注册接口
	 */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> appreg(String mobile, String password, String smscode,  HttpServletResponse response, HttpServletRequest request){
    	Map<String, Object> res = new HashMap<String, Object>();

        res.put("status", 1);    	
    	
    	if (null == mobile) {
    		res.put("msg", "电话号码为空");
    		return res;
		}
    	
    	if (null == password) {
    		res.put("msg", "密码为空");
    		return res;
		}
    	
    	if (null == smscode) {
    		res.put("msg", "验证码为空");
    		return res;
		}
    	
//    	String smsCodeSave = (String) request.getSession().getAttribute("SMSCODE");
//    	if (null == smsCodeSave) {
//			smsCodeSave = "123456";
//		} 
//    	if (!smsCodeSave.equalsIgnoreCase(smscode)) {
//    		res.put("status", 2); 
//    		res.put("msg", "验证码错误");
//    		return res;
//		}
//    	
    	TdUser tdUser = tdUserService.findByUsername(mobile);
    	if (null != tdUser) {
    		res.put("status", 3); 
    		res.put("msg", "该手机号已被注册");
    		return res;
		}
    	
    	tdUser = tdUserService.addNewUser(null, mobile, password, mobile, null);
    	
    	tdUserService.save(tdUser);
    	
    	if (null == tdUser) {
    		res.put("status", 3); 
    		res.put("msg", "该手机号已被注册");
    		return res;
		}
    	
    	res.put("status", 0);
    	res.put("msg", "注册成功");
    	return res;
    }
    
   
    
}