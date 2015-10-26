package com.ynyes.huizi.controller.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
        		res.put("info", "该用户已经存在");
                return res;
        	}
        }
        
        /**
         * 	ajax实时验证
         * 	手机号查找用户
         * 	判断手机号是已否注册
         * @author libiao
         */
//        if (type.equalsIgnoreCase("mobile"))		
//        {
//        	if (null == param || param.isEmpty())
//        	{
//                res.put("info", "用户名不能为空");
//                return res;
//            }
//        	
//        	TdUser user = tdUserService.findByMobile(param);		
//        	
//        	if (null != user)	
//         	{
//        		res.put("info", "该手机已经注册");
//                return res;
//        	}
//        }

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
                    map.addAttribute("error", "验证码错误");
                }
                else if (errCode.equals(2))
                {
                    map.addAttribute("error", "用户名已存在");
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
                String code,
                Long shareId,
                HttpServletRequest request){
        String codeBack = (String) request.getSession().getAttribute("RANDOMVALIDATECODEKEY");
        
        if (null == codeBack)
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
                return "redirect:/reg?errCode=1";
            }
            else
            {
                return "redirect:/reg?errCode=1&shareId=" + shareId;
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
                sharedUser.setRoleId(1L);
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
    
    @RequestMapping(value = "/code",method = RequestMethod.GET)
    public void verify(HttpServletResponse response, HttpServletRequest request) {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        VerifServlet randomValidateCode = new VerifServlet();
        randomValidateCode.getRandcode(request, response);
    }
    
}