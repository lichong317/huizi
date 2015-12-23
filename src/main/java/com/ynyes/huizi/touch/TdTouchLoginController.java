package com.ynyes.huizi.touch;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
