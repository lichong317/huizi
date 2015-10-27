package com.ynyes.huizi.controller.front;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.junit.runners.Parameterized;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdPrize;
import com.ynyes.huizi.entity.TdPrizeCategory;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserLevel;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdPrizeCategoryService;
import com.ynyes.huizi.service.TdPrizeService;
import com.ynyes.huizi.service.TdUserLevelService;
import com.ynyes.huizi.service.TdUserService;

@Controller
public class TdLotteryController {

	@Autowired
	private TdCommonService tdCommonService;
	
	@Autowired
	private TdUserService tdUserService;
	
	@Autowired
	private TdUserLevelService tdUserLevelService;
	
	@Autowired
	private TdPrizeService tdPrizeService;
	
	@Autowired
	private TdPrizeCategoryService tdPrizeCategoryService;
	
	@Autowired
	private TdCouponTypeService tdCouponTypeService;
	
	@Autowired
	private TdGoodsService tdGoodsService;
	
	@RequestMapping("/lottery")
	public String lottery(ModelMap map, HttpServletRequest req){
		
		String username = (String) req.getSession().getAttribute("username");
		
		if (null == username)
        {
            return "redirect:/login";
        }
		
		tdCommonService.setHeader(map, req);
		
		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
		
		if (null != tdUser) {
			map.addAttribute("user", tdUser);
			
			//等级信息
			TdUserLevel tdUserLevelnow = tdUserLevelService.findByLevelId(tdUser.getUserLevelId());
			
			TdUserLevel tdUserLevelnext = tdUserLevelService.findByLevelId(tdUser.getUserLevelId()+1);
			
			map.addAttribute("tdUserLevelnow", tdUserLevelnow);
			map.addAttribute("tdUserLevelnext", tdUserLevelnext);
		}
		
		//幸运用户
		map.addAttribute("luckydog_list", tdPrizeService.findAll());
		
		//本期大奖
		
		//本期奖项
		map.addAttribute("prizeCategory", tdPrizeCategoryService.findAllOrderBySortId());
		
		return "/client/lottery";
		
	}
	
	@RequestMapping(value="/lottery/signin",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> signin(String username,
	                HttpServletRequest request) {
	     Map<String, Object> res = new HashMap<String, Object>();
	        
	     res.put("code", 1);
	     
	     if (null == username) {
			res.put("msg", "用户名不存在！");
			return res;
		 }
	     
	     TdUser tdUser = tdUserService.findByUsername(username);
	     tdUser.setIsSignin(true);
	     tdUserService.save(tdUser);	     	     
	     
	     res.put("code", 0);
	     
	     return res;
	}
	
	@RequestMapping(value="/lottery/getPrizeType",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPrizeType(
	                HttpServletRequest request) {
	     Map<String, Object> res = new HashMap<String, Object>();
	        
	     res.put("code", 1);
	     
	     res.put("prizeCategory", tdPrizeCategoryService.findAllOrderBySortId());
	     
	     res.put("code", 0);
	     
	     return res;
	}
	
	@RequestMapping(value="/lottery/getPrize",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPrize(String username, Long id,
	                HttpServletRequest request) {
	     Map<String, Object> res = new HashMap<String, Object>();
	        
	     res.put("code", 1);
	     
	     if (null == username) {
	    	 res.put("msg", "登录超时");
	    	 return res;
		 }
	     
	     if (null == id) {
	    	 res.put("msg", "出错了");
	    	 return res;
		 }
	     
	     TdPrizeCategory tdPrizeCategory = tdPrizeCategoryService.findOne(id);
	     
	     TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
	     
	     if (null != tdPrizeCategory && null != tdUser) {
			if (tdPrizeCategory.getLeftNumber().equals(0L)) {
				 res.put("msg", "奖品已抽完！");
		    	 return res;
			}
			
			TdPrize tdPrize = new TdPrize();
			
			tdPrize.setGetTime(new Date());
			tdPrize.setUsername(username);
			tdPrize.setTypeId(tdPrizeCategory.getId());
			if (null != tdPrizeCategory.getTitle()) {
				tdPrize.setTypeTitle(tdPrizeCategory.getTitle());
			}			
			
			if (null != tdPrizeCategory.getPrizeType()) {
				tdPrize.setPrizeType(tdPrizeCategory.getPrizeType());
				if (tdPrizeCategory.getPrizeType().equals(0L) && null != tdPrizeCategory.getPrizePoints()) {					
					tdPrize.setPrizePoints(tdPrizeCategory.getPrizePoints());
				}
				else if (tdPrizeCategory.getPrizeType().equals(1L) && null != tdPrizeCategory.getCouponTypeId()) {
					tdPrize.setCouponTypeId(tdPrizeCategory.getCouponTypeId());
					TdCouponType tdCouponType = tdCouponTypeService.findOne(tdPrizeCategory.getCouponTypeId());
					tdPrize.setCouponTitle(tdCouponType.getTitle());
				}
				else if (tdPrizeCategory.getPrizeType().equals(2L) && null != tdPrizeCategory.getPrizeGoodsId()) {
					tdPrize.setGoodsId(tdPrizeCategory.getPrizeGoodsId());
					TdGoods tdGoods = tdGoodsService.findOne(tdPrizeCategory.getPrizeGoodsId());
					tdPrize.setGoodsTitle(tdGoods.getTitle());
				}
			}
			
			tdPrizeService.save(tdPrize);
			tdPrizeCategory.setLeftNumber(tdPrizeCategory.getLeftNumber()-1);
			tdPrizeCategoryService.save(tdPrizeCategory);
			res.put("code", 0);
		 }
	    	     	     
	     return res;
	}
}
