package com.ynyes.huizi.touch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserLevel;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdPrizeCategoryService;
import com.ynyes.huizi.service.TdPrizeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserLevelService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserService;

@Controller
public class TdTouchLotteryController {
	
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
	
	@Autowired  
    private TdCouponService tdCouponService;
	
	@Autowired
	private TdUserPointService tdUserPointService;
	
	
	@Autowired
	private TdSettingService tdSettingService;
	
	@RequestMapping("/touch/lottery")
	public String lottery(ModelMap map, HttpServletRequest req){
		
		String username = (String) req.getSession().getAttribute("username");
		
		if (null == username)
        {
            return "redirect:/touch/login";
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
		map.addAttribute("luckydog_page", tdPrizeService.findAll(0, 20));
		
		//本期大奖
		
		//本期奖项
		map.addAttribute("prizeCategory", tdPrizeCategoryService.findAllOrderBySortId());
		
		return "/touch/user_lottery";
		
	}
}
