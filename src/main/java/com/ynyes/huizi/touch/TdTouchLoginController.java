package com.ynyes.huizi.touch;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;
import com.ynyes.huizi.entity.TdContrastGoods;
import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserService;

@Controller
public class TdTouchLoginController {
	 	@Autowired
	    private TdUserService tdUserService;
	    
	    @Autowired
	    private TdRedEnvelopeService tdRedEnvelopeService;
	    
	    @Autowired
	    private TdCommonService tdCommonService;

	    @RequestMapping(value = "/touch/login", method = RequestMethod.GET)
	    public String login(HttpServletRequest req, Long shareId,  ModelMap map) {
	        String username = (String) req.getSession().getAttribute("username");

	        String referer = req.getHeader("referer");
	        
	        if (null != shareId) {
	        	map.addAttribute("shareId", shareId);
			}
	        
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
	    
	    @RequestMapping(value = "/touch/loginMobile", method = RequestMethod.GET)
	    public String loginMobile(HttpServletRequest req, Long shareId,  ModelMap map) {
	        String username = (String) req.getSession().getAttribute("username");

	        String referer = req.getHeader("referer");
	        
	        if (null != shareId) {
	        	map.addAttribute("shareId", shareId);
			}
	        
	        // 基本信息
	        tdCommonService.setHeader(map, req);
	        
	        if (null == username) 
	        {
	            return "/touch/login_mobile";
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
	            
	            // 检查室友有未领取红包
	            List<TdRedEnvelope> tdRedEnvelopes = tdRedEnvelopeService.findByUsernameAndIsGetFalse(username);
	            if (tdRedEnvelopes.isEmpty()) {
	    			res.put("hasRedenvelope", 0);
	    		}else {
	    			res.put("hasRedenvelope", 1);
	    		}
	            
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
	    
	    @RequestMapping(value="/touch/loginmobile",method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> loginmobile(String mobile,  
	                String code, 
	                HttpServletRequest request) {
	        Map<String, Object> res = new HashMap<String, Object>();
	        
	        res.put("code", 1);
	        
	        if (mobile.isEmpty() || code.isEmpty())
	        {
	            res.put("msg", "用户名及密码不能为空");
	            return res;
	        }
	        
	        String smsCodeSave = (String) request.getSession().getAttribute("SMSCODE");
	        if (null == smsCodeSave ) {
	        	smsCodeSave = "123456";			
			}
	        if (!smsCodeSave.equalsIgnoreCase(code))
	        {
	        	 res.put("msg", "短信验证码错误");
	             return res;
	        }
	        
	        TdUser user = tdUserService.findByMobileAndIsEnabled(mobile);
	        
	        if (null == user) {
	        	res.put("msg", "用户名不存在");
	            return res;
			}
	                       
	        user.setLastLoginTime(new Date());
	        
	        tdUserService.save(user);
	        
	        // 检查是否有未领取红包
	        List<TdRedEnvelope> tdRedEnvelopes = tdRedEnvelopeService.findByUsernameAndIsGetFalse(user.getUsername());
	        if (tdRedEnvelopes.isEmpty()) {
				res.put("hasRedenvelope", 0);
			}else {
				res.put("hasRedenvelope", 1);
			}
	        
	        request.getSession().setAttribute("username", user.getUsername());
	        
	        res.put("code", 0);
	        
	        // 将对比商品转入该用户名下
//	        List<TdContrastGoods> contrastSessionGoodsList = tdContrastGoodsService
//	                .findByUsername(request.getSession().getId());
//	        
//	        // 合并商品
//	        List<TdContrastGoods> contrastUserGoodsList = tdContrastGoodsService
//	                .findByUsername(user.getUsername());
//
//	        for (TdContrastGoods contrastGoods : contrastSessionGoodsList) {
//	        	contrastGoods.setUsername(user.getUsername());
//	        	contrastUserGoodsList.add(contrastGoods);
//	        }
//
//	        tdContrastGoodsService.save(contrastUserGoodsList);
//
//	        for (TdContrastGoods cg1 : contrastUserGoodsList) {
//	            List<TdContrastGoods> findList = tdContrastGoodsService
//	                    .findByGoodsIdAndPriceAndUsername(cg1.getGoodsId(), cg1.getPrice(), user.getUsername());
//
//	            if (findList.size() > 1) {
//	            	tdContrastGoodsService.delete(findList.subList(1,
//	                        findList.size()));
//	            }
//	        }
	        
	        return res;
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
	    
	    /**
		 * @author lc
		 * @注释：qq登录
		 */
	    @RequestMapping(value = "/touch/login/qq_login_return", method = RequestMethod.GET)
		public String qqLoginReturn(String openID, HttpServletRequest request, ModelMap map) {

	    	if (null == openID) {
				return "/touch/";
			}
	    	
			tdCommonService.setHeader(map, request);	                
			//根据openID查找用户
			map.put("alipay_user_id", openID);
			map.put("qq", "qq");
			TdUser user = tdUserService.findByQqUserId(openID);
			
			if(null == user){
					//建立新用户
					String newUsername = randomUsername();
				 	user = tdUserService.addNewUser(null, newUsername, "huizhidian", null, null);
					if (null != user) {
						
						//QQ登录新建账号
						user.setQqUserId(openID);
						
						user.setLastLoginTime(new Date());
						tdUserService.save(user);
						request.getSession().setAttribute("username", user.getUsername());
						return "redirect:/touch/";
					}
					return "redirect:/touch/";
			}else{
					//用户存在，修改最后登录时间，跳转首页
					user.setLastLoginTime(new Date());
					//user.setLastLoginIp(CommonService.getIp(request));
					tdUserService.save(user);
					request.getSession().setAttribute("username", user.getUsername());
					//request.getSession().setAttribute("usermobile", user.getMobile());
					return "redirect:/touch/";
				}
				
		}
	    
	    /**
		 * @author lc
		 * @注释：支付宝触屏登录
		 */
	    @RequestMapping(value = "/touch/login/alipay_login_return", method = RequestMethod.GET)
		public String ailipayLoginReturn(String user_id, HttpServletRequest request, ModelMap map) {

	    	if (null == user_id) {
				return "/touch/login";
			}
	    	
			tdCommonService.setHeader(map, request);	                
			//根据openID查找用户
			map.put("alipay_user_id", user_id);
			
			TdUser user = tdUserService.findByAlipayUserId(user_id);
			
			if (null != user) {
				user.setLastLoginTime(new Date());
				//user.setLastLoginIp(CommonService.getIp(request));
				user = tdUserService.save(user);
				request.getSession().setAttribute("username", user.getUsername());
				//request.getSession().setAttribute("usermobile", user.getMobile());

				return "redirect:/touch/";
			} else { //新建用户 用户名随机
				String newUsername = randomUsername();
			    user = tdUserService.addNewUser(null, newUsername, "huizhidian", null, null);
				if (null != user) {
					
					//支付宝登录新建账号
					user.setAlipayUserId(user_id);
					
					user.setLastLoginTime(new Date());
					tdUserService.save(user);
					request.getSession().setAttribute("username", user.getUsername());
					return "redirect:/touch/";
				}
				
			}
			return "redirect:/touch/";	
		}
	    
	    
	    /**
		 * @author lc
		 * @注释：随机生成绑定用户名
		 */
		public String randomUsername() {
			Random random = new Random();
			String username = "";
			while (true) {
				int temp1 = random.nextInt(10000000);
				username = "user_" + temp1;
				if (null == tdUserService.findByUsername(username)) {
					return username;
				}
			}
		}
	    
	    /**
		 * @author lc
		 * @注释：密码找回
		 */
	    @RequestMapping(value = "/touch/login/password_retrieve", method = RequestMethod.GET)
		public String Retrieve(HttpServletRequest req, ModelMap map){
			tdCommonService.setHeader(map, req);
			return "/touch/user_retrieve_step1";
		}
	    
	    @RequestMapping(value = "/touch/login/password_retrieve", method = RequestMethod.POST)
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
	    
	    @RequestMapping(value = "/touch/login/retrieve_step2", method = RequestMethod.GET)
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
			
			return "/touch/user_retrieve_step2";
		}
	    
	    @RequestMapping(value = "/touch/login/retrieve_step2", method = RequestMethod.POST)
		public String Step2(String smsCode,HttpServletRequest req, ModelMap map){
			if (null == smsCode) {
				return "redirect:/touch//login/retrieve_step2?errCode=4";
			}
			String smsCodeSave = (String) req.getSession().getAttribute("SMSCODE");
			if (null == smsCodeSave) {
				smsCodeSave = "1234566";
			}
			if (!smsCodeSave.equalsIgnoreCase(smsCode)) {
				return "redirect:/touch//login/retrieve_step2?errCode=4";
			}
			String username = (String) req.getSession().getAttribute("retrieve_username");
			map.put("retrieve_username", username);
			tdCommonService.setHeader(map, req);
			
			return "/touch/user_retrieve_step3";
		}
		
		@RequestMapping(value = "/touch/login/retrieve_step3", method = RequestMethod.POST)
		public String Step3(String password, HttpServletRequest req, ModelMap map){
			String username = (String) req.getSession().getAttribute("retrieve_username");
			TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
			if (null != password) {
				user.setPassword(password);
				tdUserService.save(user);
				tdCommonService.setHeader(map, req);
				req.getSession().setAttribute("username", user.getUsername());
				//req.getSession().setAttribute("usermobile", user.getMobile());
				return "/touch/user_retrieve_ok";
			}
			return "/touch/error_404";
		}
}
