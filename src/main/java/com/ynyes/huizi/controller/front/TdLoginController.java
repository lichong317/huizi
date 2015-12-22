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
import com.ynyes.huizi.entity.TdContrastGoods;
import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdAdService;
import com.ynyes.huizi.service.TdAdTypeService;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdContrastGoodsService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.MD5;
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
    private TdContrastGoodsService tdContrastGoodsService;
    
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
        
        // 检查是否有未领取红包
        List<TdRedEnvelope> tdRedEnvelopes = tdRedEnvelopeService.findByUsernameAndIsGetFalse(username);
        if (tdRedEnvelopes.isEmpty()) {
			res.put("hasRedenvelope", 0);
		}else {
			res.put("hasRedenvelope", 1);
		}
        
        request.getSession().setAttribute("username", username);
        
        res.put("code", 0);
        
        // 将对比商品转入该用户名下
        List<TdContrastGoods> contrastSessionGoodsList = tdContrastGoodsService
                .findByUsername(request.getSession().getId());
        
        // 合并商品
        List<TdContrastGoods> contrastUserGoodsList = tdContrastGoodsService
                .findByUsername(username);

        for (TdContrastGoods contrastGoods : contrastSessionGoodsList) {
        	contrastGoods.setUsername(username);
        	contrastUserGoodsList.add(contrastGoods);
        }

        tdContrastGoodsService.save(contrastUserGoodsList);

        for (TdContrastGoods cg1 : contrastUserGoodsList) {
            List<TdContrastGoods> findList = tdContrastGoodsService
                    .findByGoodsIdAndPriceAndUsername(cg1.getGoodsId(), cg1.getPrice(), username);

            if (findList.size() > 1) {
            	tdContrastGoodsService.delete(findList.subList(1,
                        findList.size()));
            }
        }
        
        return res;
    }

    @RequestMapping("/logout")
    public String logOut(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/";
    }

    /**
	 * @author lc
	 * @注释：密码找回
	 */
    @RequestMapping(value = "/login/password_retrieve", method = RequestMethod.GET)
	public String Retrieve(HttpServletRequest req, ModelMap map){
		tdCommonService.setHeader(map, req);
		return "/client/user_retrieve_step1";
	}
    
    @RequestMapping(value = "/login/password_retrieve", method = RequestMethod.POST)
	@ResponseBody
	public  Map<String, Object> Check(String username, String code, HttpServletRequest request){
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);
		
		if (username.isEmpty()) {
			res.put("msg", "用户名不能为空");
		}
		
		String codeBack = (String) request.getSession().getAttribute("RANDOMVALIDATECODEKEY");
		if (!codeBack.equalsIgnoreCase(code)){
			res.put("msg", "验证码错误");
			return res;
		 }
		 
		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
		if (null != user) {
			
			request.getSession().setAttribute("retrieve_username", user.getUsername());
            
			res.put("code", 0);
		}
		else {
			res.put("msg", "用户不存在");
		}
		
		return res;
	}
    
    @RequestMapping(value = "/login/retrieve_step2", method = RequestMethod.GET)
	public String Step2(Integer errCode, HttpServletRequest req, ModelMap map){
		tdCommonService.setHeader(map, req);
		String username = (String) req.getSession().getAttribute("retrieve_username");
		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
		
		 if (null != errCode)
         {
             if (errCode.equals(1))
             {
                 map.addAttribute("error", "验证码错误");
             }
             
             map.addAttribute("errCode", errCode);
         }
		 
		map.put("user", user);
		
		return "/client/user_retrieve_step2";
	}
    
    @RequestMapping(value = "/login/retrieve_step2", method = RequestMethod.POST)
	public String Step2(String smsCode,HttpServletRequest req, ModelMap map){
		if (null == smsCode) {
			return "redirect:/login/retrieve_step2?errCode=4";
		}
		String smsCodeSave = (String) req.getSession().getAttribute("SMSCODE");
		if (!smsCodeSave.equalsIgnoreCase(smsCode)) {
			return "redirect:/login/retrieve_step2?errCode=4";
		}
		String username = (String) req.getSession().getAttribute("retrieve_username");
		map.put("retrieve_username", username);
		tdCommonService.setHeader(map, req);
		
		return "/client/user_retrieve_step3";
	}
	
	@RequestMapping(value = "/login/retrieve_step3", method = RequestMethod.POST)
	public String Step3(String password, HttpServletRequest req, ModelMap map){
		String username = (String) req.getSession().getAttribute("retrieve_username");
		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
		if (null != password) {
			user.setPassword(password);
			tdUserService.save(user);
			tdCommonService.setHeader(map, req);
			req.getSession().setAttribute("username", user.getUsername());
			req.getSession().setAttribute("usermobile", user.getMobile());
			return "/client/user_retrieve_ok";
		}
		return "/client/error_404";
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
