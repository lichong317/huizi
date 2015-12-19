package com.ynyes.huizi.controller.front;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.neo4j.cypher.internal.compiler.v2_1.planner.logical.steps.applyOptional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.util.SMSUtil;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.VerifServlet;

/**
 * 注册处理
 * 
 */
@Controller
public class TdRegisgerController {
    @Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdUserPointService tdUserPointService;
    
    @Autowired
    private TdSettingService tdSettingService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
    //APP 手机号验证
    @RequestMapping(value = "/app/reg/check/{type}", method = RequestMethod.GET)
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
    
    @RequestMapping(value = "/reg/check/{type}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> validateForm(@PathVariable String type, String param) {
        Map<String, String> res = new HashMap<String, String>();

        res.put("status", "n");
        
        
        if (null == type)
        {
        	res.put("info", "参数错误");
            return res;
        }
        
        if (type.equalsIgnoreCase("username"))
        {
        	if (null == param || param.isEmpty()) {
                res.put("info", "用户名不能为空");
                return res;
            }
        	
        	TdUser user = tdUserService.findByUsername(param);
        	
        	if (null != user)
        	{
        		res.put("info", "用户名已存在");
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
                res.put("info", "手机号不能为空");
                return res;
            }
        	
        	TdUser user = tdUserService.findByMobileAndIsEnabled(param);		
        	
        	if (null != user)	
         	{
        		res.put("info", "该手机已经注册");
                return res;
        	}
        }

        res.put("status", "y");

        return res;
    }
    
    @RequestMapping("/reg")
    public String reg(Integer errCode, Integer shareId, HttpServletRequest request, ModelMap map) {
        String username = (String) request.getSession().getAttribute("username");
        
        if (null != shareId)
        {
            map.addAttribute("share_id", shareId);
        }
        
        // 网站基本信息
        map.addAttribute("site", tdSettingService.findTopBy());
        tdCommonService.setHeader(map, request);
        
        if (null == username) {
            if (null != errCode)
            {
                if (errCode.equals(1))
                {
                    map.addAttribute("error", "短信验证码错误");
                }
                else if (errCode.equals(2))
                {
                    map.addAttribute("error", "用户名已存在");
                }
                else if (errCode.equals(3))
                {
                    map.addAttribute("error", "用户名已存在");
                }
                else if (errCode.equals(4))
                {
                    map.addAttribute("error", "验证码错误");
                }
                map.addAttribute("errCode", errCode);
            }
            return "/client/reg";
        }
        return "redirect:/";
    }
    
    @RequestMapping(value="/logutil")
    public String LogUtils(){
        return "/logutil";
    }
    /**
     * 
     * 注册用户保存到数据库<BR>
     * 方法名：saveUser<BR>
     * 时间：2015年2月2日-下午1:44:45 <BR>
     * @param user
     * @param name
     * @param mobile
     * @param password
     * @param newpassword
     * @return String<BR>
     * @param  [参数1]   [参数1说明]
     * @param  [参数2]   [参数2说明]
     * @exception <BR>
     * @since  1.0.0
     */
    @RequestMapping(value="/reg",method=RequestMethod.POST)
    public String reg(String username,
                String mobile,
                String password,
                String email,
                String yzmcode,
                String code,
                String smscode,
                Long shareId,
                HttpServletRequest request){
        String codeBack = (String) request.getSession().getAttribute("RANDOMVALIDATECODEKEY");
        String smsCodeSave = (String) request.getSession().getAttribute("SMSCODE");
        
        if (null == username) {
        	 if ( null == yzmcode)
             {
                 if (null == shareId)
                 {
                     return "redirect:/reg";
                 }
                 else
                 {
                     return "redirect:/reg?shareId=" + shareId;
                 }
             }
             
        	 if (!codeBack.equalsIgnoreCase(yzmcode))
             {
                 if (null == shareId)
                 {
                     return "redirect:/reg?errCode=4";
                 }
                 else
                 {
                     return "redirect:/reg?errCode=4&shareId=" + shareId;
                 }
             }
        	 
             if (!smsCodeSave.equalsIgnoreCase(smscode))
             {
                 if (null == shareId)
                 {
                     return "redirect:/reg?errCode=1";
                 }
                 else
                 {
                     return "redirect:/reg?errCode=1&shareId=" + shareId;
                 }
             }
             //将手机号作为用户名
             username = mobile;
             
		}else {
			if (null == code)
            {
                if (null == shareId)
                {
                    return "redirect:/reg";
                }
                else
                {
                    return "redirect:/reg?shareId=" + shareId;
                }
            }
            
            if (!codeBack.equalsIgnoreCase(code))
            {
                if (null == shareId)
                {
                    return "redirect:/reg?errCode=4";
                }
                else
                {
                    return "redirect:/reg?errCode=4&shareId=" + shareId;
                }
            }
		}
       
          
        TdUser user = tdUserService.findByUsername(username);
        
        if (null != user)
        {
            if (null == shareId)
            {
                return "redirect:/reg?errCode=2";
            }
            else
            {
                return "redirect:/reg?errCode=2&shareId=" + shareId;
            }
        }
        
        user = tdUserService.addNewUser(null, username, password, mobile, email);
        
        if (null == user)
        {
            if (null == shareId)
            {
                return "redirect:/reg?errCode=3";
            }
            else
            {
                return "redirect:/reg?errCode=3&shareId=" + shareId;
            }
        }
        
        user = tdUserService.save(user);
        
        // 奖励分享用户
        if (null != shareId)
        {
            TdUser sharedUser = tdUserService.findOne(shareId);
            
            if (null != sharedUser )
            {
                TdSetting setting = tdSettingService.findTopBy();
                TdUserPoint userPoint = new TdUserPoint();
                
                if (null != setting)
                {
                    userPoint.setPoint(setting.getRegisterSharePoints());
                }
                else
                {
                    userPoint.setPoint(0L);
                }
                
                if (null != sharedUser.getTotalPoints())
                {
                    userPoint.setTotalPoint(sharedUser.getTotalPoints() + userPoint.getPoint());
                }
                else
                {
                    userPoint.setTotalPoint(userPoint.getPoint());
                }
                
                userPoint.setUsername(sharedUser.getUsername());
                userPoint.setDetail("用户分享网站成功奖励");
                
                userPoint = tdUserPointService.save(userPoint);
                
                sharedUser.setTotalPoints(userPoint.getTotalPoint()); // 积分
                
                // 角色变换限制
                if (!sharedUser.getRoleId().equals(2L)) {
                	sharedUser.setRoleId(1L);
				}
                                
                if (null == sharedUser.getTotalLowerUsers()) {
					sharedUser.setTotalLowerUsers(1L);
				}else {
					sharedUser.setTotalLowerUsers(sharedUser.getTotalLowerUsers() + 1);
				}
                
                tdUserService.save(sharedUser);
                
                //用户层级关系
                user.setUpperUsername(sharedUser.getUsername());
                tdUserService.save(user);
            }
            
           
        }
        
        request.getSession().setAttribute("username", username);
        
        String referer = (String) request.getAttribute("referer");
        
        if (null != request.getAttribute("referer"))
        {
            return "redirect:" + referer;
        }
        
        if (null == shareId)
        {
            return "redirect:/user";
        }
        
        return "redirect:/user?shareId=" + shareId;
    }
    
    /**
	 * @author lc
	 * @注释：app注册接口
	 */
    @RequestMapping(value = "/app/register", method = RequestMethod.GET)
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
    	
    	String smsCodeSave = (String) request.getSession().getAttribute("SMSCODE");
    	if (!smsCodeSave.equalsIgnoreCase(smscode)) {
    		res.put("status", 2); 
    		res.put("msg", "验证码错误");
    		return res;
		}
    	
    	TdUser tdUser = tdUserService.findByUsername(mobile);
    	if (null != tdUser) {
    		res.put("status", 3); 
    		res.put("msg", "该手机号已被注册");
    		return res;
		}
    	
    	tdUser = tdUserService.addNewUser(null, mobile, password, mobile, null);
    	
    	if (null == tdUser) {
    		res.put("status", 3); 
    		res.put("msg", "该手机号已被注册");
    		return res;
		}
    	
    	res.put("code", 0);
    	return res;
    }
    
        
    @RequestMapping(value = "/code",method = RequestMethod.GET)
    public void verify(HttpServletResponse response, HttpServletRequest request) {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        VerifServlet randomValidateCode = new VerifServlet();
        randomValidateCode.getRandcode(request, response);
    }
    
    @RequestMapping(value = "/reg/checkYzmcode",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkyzmcode(String yzmcode, HttpServletResponse response, HttpServletRequest request) {
    	Map<String, Object> res = new HashMap<String, Object>();

        res.put("code", 1);    	
    	
    	if (null == yzmcode) {
    		res.put("msg", "验证码为空");
    		return res;
		}
    	
    	String codeBack = (String) request.getSession().getAttribute("RANDOMVALIDATECODEKEY");
    	if (!yzmcode.equalsIgnoreCase(codeBack)) {
    		res.put("msg", "验证码错误");
    		return res;
		}
    	
    	res.put("code", 0);
    	
    	return	res;
    			
    }
    
    @RequestMapping(value = "/reg/smscode",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> smsCode(String mobile, HttpServletResponse response, HttpServletRequest request) {
        Random random = new Random();
        
        String smscode = String.format("%04d", random.nextInt(9999));
        
        HttpSession session = request.getSession();
        
        session.setAttribute("SMSCODE", smscode);
       
        return SMSUtil.send(mobile, "15612" ,new String[]{smscode});
    }
    
}