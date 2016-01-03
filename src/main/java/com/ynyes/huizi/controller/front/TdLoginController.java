package com.ynyes.huizi.controller.front;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;
import com.tencent.common.Configure;
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
import com.ynyes.huizi.util.CommonService;
import com.ynyes.huizi.util.VerifServlet;

import net.sf.json.JSONObject;

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
    
    
    @RequestMapping(value="/login",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(String username, 
                String password, 
                String code, 
                Boolean isSave, String alipayuser_id,String type,
                HttpServletRequest request) {
        Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        if (username.isEmpty() || password.isEmpty())
        {
            res.put("msg", "用户名及密码不能为空");
            return res;
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (null == user) {
        	res.put("msg", "用户名不存在");
            return res;
		}
        
        if (!user.getPassword().equals(password))
        {
            res.put("msg", "密码错误");
            return res;
        }
        
        user.setLastLoginTime(new Date());
        
        /**
		 * @author libiao
		 * 判断是首页直接登录还是绑定第三方账号
		 */
		if(null !=type){
			/**
			 * @author libiao
			 * 判断绑定类型为绑定QQ
			 */
			if("qq".equals(type)){
				user.setQqUserId(alipayuser_id);
			}
			/**
			 * @author lc
			 * @注释：添加支付宝第三方登陆用户名
			 */
			if("zfb".equals(type)){
				user.setAlipayUserId(alipayuser_id);
			}
			
			user = tdUserService.save(user);
		}
		
        
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

    @RequestMapping(value="/loginmobile",method = RequestMethod.POST)
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
        List<TdContrastGoods> contrastSessionGoodsList = tdContrastGoodsService
                .findByUsername(request.getSession().getId());
        
        // 合并商品
        List<TdContrastGoods> contrastUserGoodsList = tdContrastGoodsService
                .findByUsername(user.getUsername());

        for (TdContrastGoods contrastGoods : contrastSessionGoodsList) {
        	contrastGoods.setUsername(user.getUsername());
        	contrastUserGoodsList.add(contrastGoods);
        }

        tdContrastGoodsService.save(contrastUserGoodsList);

        for (TdContrastGoods cg1 : contrastUserGoodsList) {
            List<TdContrastGoods> findList = tdContrastGoodsService
                    .findByGoodsIdAndPriceAndUsername(cg1.getGoodsId(), cg1.getPrice(), user.getUsername());

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
  
	/**
	 * @author lc
	 * @注释：支付宝登陆信息提交
	 */
	@RequestMapping(value = "/login/alipay_login", method = RequestMethod.GET)
	public String alipay_login(HttpServletRequest req, ModelMap map) {
		// 目标服务地址
		String target_service = "user.auth.quick.login";
		// 必填

		// 防钓鱼时间戳
		String anti_phishing_key = "";
		// 若要使用请调用类文件submit中的query_timestamp函数

		// 客户端的IP地址
		String exter_invoke_ip = "";
		// 非局域网的外网IP地址，如：221.0.0.1
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "alipay.auth.authorize");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("target_service", target_service);
		sParaTemp.put("return_url", AlipayConfig.return_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");

		map.put("code", sHtmlText);

		return "/client/alipay_login";
	}
	
	/**
	 * @author lc
	 * @注释：支付宝登陆返回参数
	 */
	@RequestMapping(value= "/login/alipay_return_url"  , method = RequestMethod.GET)
	public String returnurl(HttpServletRequest request, ModelMap map, Device device){
		Map<String,String> params = new HashMap<String,String>();
		Map<String, String[]>  requestParams = request.getParameterMap();
		for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {

			String name = iter.next();
			String[] values =  requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			try {
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
				params.put(name, valueStr);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			params.put(name, valueStr);
		}

		tdCommonService.setHeader(map, request);

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		// 支付宝用户号
		String user_id = " ";
//		String token = " ";
		try {
			user_id = new String(request.getParameter("user_id").getBytes("ISO-8859-1"),"UTF-8");
			//授权令牌
//			token = new String(request.getParameter("token").getBytes("ISO-8859-1"),"UTF-8");

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

		// 计算得出通知验证结果
		boolean verify_result = AlipayNotify.verify(params);
//		// 假设验证成功
		verify_result = true;

		if (verify_result) {// 验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			// 请在这里加上商户的业务逻辑程序代码
			// ——请根据您的业务逻辑来编写程序（以下代码仅作参考）——

			// 判断是否在商户网站中已经做过了这次通知返回的处理
			// 如果没有做过处理，那么执行商户的业务程序
			// 如果有做过处理，那么不执行商户的业务程序

			// 该页面可做页面美工编辑
			// System.out.println("验证成功");
			
			// 触屏版重定向
			if (device.isMobile() || device.isTablet()) {
                return "redirect:/touch/login/alipay_login_return?user_id="+ user_id;
            }
			
			map.put("alipay_user_id", user_id);
			TdUser user = tdUserService.findByAlipayUserId(user_id);
			if (null != user) {
				user.setLastLoginTime(new Date());
				//user.setLastLoginIp(CommonService.getIp(request));
				user = tdUserService.save(user);
				request.getSession().setAttribute("username", user.getUsername());
				//request.getSession().setAttribute("usermobile", user.getMobile());
				return "redirect:/";
			} else {
				return "/client/accredit_login";
			}
			// request.getSession().setAttribute("alipay_user_id", user_id);
			// ——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

			//////////////////////////////////////////////////////////////////////////////////////////
		} else {
			// 该页面可做页面美工编辑
			// System.out.println("验证失败");

			return "/client/error_404";
			// 调试 假设验证成功
		}
	}
	
	/**
	 * @author lc
	 * @注释：支付宝绑定登陆
	 */
	@RequestMapping(value = "/login/alipay_accredit/{type}", method = RequestMethod.GET)
	public String alipaylogin(@PathVariable String type, String thirdparty_username, HttpServletRequest request, ModelMap map) {
		TdUser user = tdUserService.findByAlipayUserId(thirdparty_username);
		
		String newUsername = null;
		if ("qq".equals(type)) {// 如果需要区分用户名
			//user = tdUserService.findByQqUserId(useralipay_username);
			newUsername = randomUsername();
		}else {
			newUsername = randomUsername();
		}		        		
        
		if (null != user) {
			user.setLastLoginTime(new Date());
			//user.setLastLoginIp(CommonService.getIp(request));
			user = tdUserService.save(user);
			request.getSession().setAttribute("username", user.getUsername());
			//request.getSession().setAttribute("usermobile", user.getMobile());

			return "redirect:/";
		} else { //新建用户 用户名随机
		    user = tdUserService.addNewUser(null, newUsername, "huizhidian", null, null);
			if (null != user) {
				if("qq".equals(type)){
					//QQ登录新建账号
					user.setQqUserId(thirdparty_username);
				}else{
					//支付宝登录新建账号
					user.setAlipayUserId(thirdparty_username);
				}

				user.setLastLoginTime(new Date());
				tdUserService.save(user);
				request.getSession().setAttribute("username", user.getUsername());
				return "redirect:/";
			}
			
		}
		return "redirect:/";
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
	 * 跳转进入互联开放平台进行QQ登录验证
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 * @author libiao
	 */
	@RequestMapping(value = "/qq/login", method = RequestMethod.GET)
	public void infoQQLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		try {
			response.sendRedirect(new Oauth().getAuthorizeURL(request));
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
	}

	/**
	 * QQ登录返回结果处理
	 * @author libiao
	 * @param code
	 * @param state
	 * @param request
	 * @param map
	 * @return
	 * @throws IOException 
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/login/qq_login_return", method = RequestMethod.GET)
	public String qqLoginReturn(String code, String state, Device device, HttpServletRequest request, ModelMap map,  HttpServletResponse response) throws IOException {

		tdCommonService.setHeader(map, request);
		
		try {
			System.err.println("code-------"+code);
			System.err.println("state-------"+state);
			
			AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
			System.err.println("accessTokenObj--------"+accessTokenObj);
			String accessToken = null, openID = null;
			long tokenExpireIn = 0L;

			if (accessTokenObj.getAccessToken().equals("")) {
				// 我们的网站被CSRF攻击了或者用户取消了授权
				// 做一些数据统计工作
				System.err.print("没有获取到响应参数");
			} else {
				accessToken = accessTokenObj.getAccessToken();
				System.err.println("accessToken-------"+accessToken);
				
				tokenExpireIn = accessTokenObj.getExpireIn();

				request.getSession().setAttribute("demo_access_token", accessToken);
				request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

				// 利用获取到的accessToken 去获取当前用的openid -------- start
				OpenID openIDObj = new OpenID(accessToken);
				openID = openIDObj.getUserOpenID();
				System.err.println("openID-----------"+openID);

				//利用获取到的accessToken,openid 去获取用户在Qzone的昵称
				UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                if (userInfoBean.getRet() == 0) {
                   map.put("nickName",userInfoBean.getNickname());
                }
				
                //手机端跳转
                if (device.isMobile() || device.isTablet()) {
                    return "redirect:/touch/login/qq_login_return?openID="+ openID;
                }
                
				//根据openID查找用户
				map.put("alipay_user_id", openID);
				map.put("qq", "qq");
				TdUser user = tdUserService.findByQqUserId(openID);
				if(null == user){
					//用户不存在，跳转绑定页面
					return "/client/accredit_login";
				}else{
					//用户存在，修改最后登录时间，跳转首页
					user.setLastLoginTime(new Date());
					//user.setLastLoginIp(CommonService.getIp(request));
					tdUserService.save(user);
					request.getSession().setAttribute("username", user.getUsername());
					//request.getSession().setAttribute("usermobile", user.getMobile());
					return "redirect:/";
				}
			}
		} catch (QQConnectException e) {
			
		}
		return "/client/error_404";
	}
	
	/**
	 * @author lc
	 * @注释：微信登录
	 */
	@RequestMapping(value = "/weixin/login", method = RequestMethod.GET)
	public String infoWeixinLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		return "redirect:https://open.weixin.qq.com/connect/qrconnect?appid=wx518e7a154079ad7e&redirect_uri="
				+URLEncoder.encode("http://huizhidian.com/login/weixin_login_return", "utf-8") + "&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
	}
	
	@RequestMapping(value = "/login/weixin_login_return", method = RequestMethod.GET)
	public String weixnLoginReturn(String code, String state, HttpServletRequest request, ModelMap map) {
		
		if (null != code) {
			Map<String, String> res = getAccessToken(code);
			String accessToken = res.get("access_token");
			String openId = res.get("openid");
			System.out.println("lichong_________________accessToken__" + accessToken);
			System.out.println("lichong_________________openId__" + openId);
			TdUser tdUser = tdUserService.findByWeixinUserId(openId);
			
			if (null == tdUser) {
				if (true == getWxinfo(accessToken, openId)) {
					tdUser = tdUserService.findByWeixinUserId(openId);
					request.getSession().setAttribute("username", tdUser.getUsername());
					//request.getSession().setAttribute("usermobile", user.getMobile());
					return "redirect:/";
				}
			}else {
				request.getSession().setAttribute("username", tdUser.getUsername());
				//request.getSession().setAttribute("usermobile", user.getMobile());
				return "redirect:/";
			}
		}
		tdCommonService.setHeader(map, request);
		return "/client/error_404";
	}
	
	
	/**
	 * @author lc
	 * @注释：微信登录通过code 获取 access_token,用户openid, refresh_token,
	 */
	public Map<String, String> getAccessToken(String code){
		
		Map<String, String> res = new HashMap<String, String>();
		
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx518e7a154079ad7e&secret=a78740cbb33542e51623a4678432db76&code="
				+ code +"&grant_type=authorization_code";
		String accessToken = null;
		String expiresIn = null;
		String refresh_token = null;
		String openid = null;
		try {  
			  
            URL urlGet = new URL(url);  

            HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();  

            http.setRequestMethod("GET"); // 必须是get方式请求  

            http.setRequestProperty("Content-Type",  

                    "application/x-www-form-urlencoded");  

            http.setDoOutput(true);  

            http.setDoInput(true);  

            http.connect();  

            InputStream is = http.getInputStream();  

            int size = is.available();  

            byte[] jsonBytes = new byte[size];  

            is.read(jsonBytes);  

            String message = new String(jsonBytes, "UTF-8");  

            JSONObject demoJson = JSONObject.fromObject(message);  

            accessToken = demoJson.getString("access_token");  
            expiresIn = demoJson.getString("expires_in");  
            refresh_token = demoJson.getString("refresh_token");
            openid = demoJson.getString("openid");
            
            res.put("access_token", accessToken);
            res.put("expires_in", expiresIn);
            res.put("refresh_token", refresh_token);
            res.put("openid", openid);
            System.out.println("accessToken===="+accessToken);  
            System.out.println("expiresIn==="+expiresIn);  
  
           // System.out.println("====================获取token结束==============================");  

            is.close();  

        } catch (Exception e) {  

            e.printStackTrace(); 
        }  
		return res;
	}
	
	/**
	 * @author lc
	 * @注释：通过accessToken 和 openId 拉取用户信息并存储
	 */
	public Boolean getWxinfo(String accessToken, String openId){
		
		String url = "https://api.weixin.qq.com/sns/userinfo?access_token="
					+ accessToken + "&openid=" + openId + "&lang=zh_CN";
		String nickname = null;
		String headimgurl = null;
		String sex = null;
		String province = null;
		String city = null;
		try {  
			  
	        URL urlGet = new URL(url);  
	
	        HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();  
	
	        http.setRequestMethod("GET"); // 必须是get方式请求  
	
	        http.setRequestProperty("Content-Type",  
	
	                "application/x-www-form-urlencoded");  
	
	        http.setDoOutput(true);  
	
	        http.setDoInput(true);  
	
	        http.connect();  
	
	        InputStream is = http.getInputStream();  
	
	        int size = is.available();  
	
	        byte[] jsonBytes = new byte[size];  
	
	        is.read(jsonBytes);  
	
	        String message = new String(jsonBytes, "UTF-8");  
	
	        JSONObject demoJson = JSONObject.fromObject(message);  
	 
	        nickname = demoJson.getString("nickname");  
	        headimgurl = demoJson.getString("headimgurl");
	        sex = demoJson.getString("sex");
	        province = demoJson.getString("province");
	        city = demoJson.getString("city");
	
	        // 添加用户记录
	        String newUsername = randomUsername();
	        
	        TdUser user = tdUserService.addNewUser(null, newUsername, "huizhidian", null, null);
	        //user.setNickname(nickname);
	        user.setHeadImageUri(headimgurl);
	        user.setSex(sex);
	        user.setWeixinUserId(openId);
	        tdUserService.save(user);
	       // System.out.println("====================获取token结束==============================");  
	
	        is.close(); 
	        return true;
	
	    } catch (Exception e) {  
	
	        e.printStackTrace(); 
	    } 
		return false;
	}
	
    @RequestMapping(value = "/verify",method = RequestMethod.GET)
    public void verify(HttpServletResponse response, HttpServletRequest request) throws Exception{
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        VerifServlet randomValidateCode = new VerifServlet();
        randomValidateCode.getRandcode(request, response);
    }
}
