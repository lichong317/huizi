package com.ynyes.huizi.controller.front;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserCollect;
import com.ynyes.huizi.entity.TdUserComment;
import com.ynyes.huizi.entity.TdUserComplain;
import com.ynyes.huizi.entity.TdUserConsult;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.entity.TdUserRecentVisit;
import com.ynyes.huizi.entity.TdUserReturn;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdOrderGoodsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdShippingAddressService;
import com.ynyes.huizi.service.TdUserCashRewardService;
import com.ynyes.huizi.service.TdUserCollectService;
import com.ynyes.huizi.service.TdUserCommentService;
import com.ynyes.huizi.service.TdUserComplainService;
import com.ynyes.huizi.service.TdUserConsultService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.service.TdUserReturnService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.ClientConstant;

/**
 * 用户中心
 * @author Sharon
 *
 */
@Controller
public class TdUserController {
    
    @Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdGoodsService tdGoodsService;
    
    @Autowired
    private TdUserReturnService tdUserReturnService;
    
    @Autowired
    private TdOrderService tdOrderService;
    
    @Autowired
    private TdUserPointService tdUserPointService;
    
    @Autowired
    private TdUserCollectService tdUserCollectService;
    
    @Autowired
    private TdUserConsultService tdUserConsultService;
    
    @Autowired
    private TdUserCommentService tdUserCommentService;
    
    @Autowired  
    private TdCouponService tdCouponService;
    
    @Autowired
    private TdUserRecentVisitService tdUserRecentVisitService;
    
    @Autowired
    private TdShippingAddressService tdShippingAddressService;
    
    @Autowired
    private TdOrderGoodsService tdOrderGoodsService;
    
    @Autowired
    private TdUserCashRewardService tdUserCashRewardService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
    @Autowired
    private TdProductCategoryService tdProductCategoryService;
    
    @Autowired
    private TdUserComplainService tdUserComplainService;
    
    @RequestMapping(value = "/user")
    public String user(HttpServletRequest req, ModelMap map) {
        String username = (String) req.getSession().getAttribute("username");
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        map.addAttribute("server_ip", req.getLocalName());
        map.addAttribute("server_port", req.getLocalPort());
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (null == tdUser)
        {
            return "/client/error_404";
        }
        
        map.addAttribute("user", tdUser);
        map.addAttribute("order_page", tdOrderService.findByUsername(username, 0, ClientConstant.pageSize));
        map.addAttribute("collect_page", tdUserCollectService.findByUsername(username, 0, ClientConstant.pageSize));
        map.addAttribute("recent_page", tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, 0, ClientConstant.pageSize));
        map.addAttribute("total_unpayed", tdOrderService.countByUsernameAndStatusId(username, 2));
        map.addAttribute("total_undelivered", tdOrderService.countByUsernameAndStatusId(username, 3));
        map.addAttribute("total_unreceived", tdOrderService.countByUsernameAndStatusId(username, 4));
        map.addAttribute("total_finished", tdOrderService.countByUsernameAndStatusId(username, 6));
        map.addAttribute("recommend_goods_page", tdGoodsService.findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(0, ClientConstant.pageSize));
        
        return "/client/user_index";
    }
    
    @RequestMapping(value = "/user/order/list/{statusId}")
    public String orderList(@PathVariable Integer statusId, 
                        Integer page,
                        String keywords,
                        Integer timeId,
                        HttpServletRequest req, 
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        if (null == timeId)
        {
            timeId = 0;
        }
        
        if (null == statusId)
        {
            statusId = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        map.addAttribute("status_id", statusId);
        map.addAttribute("time_id", timeId);
        
        Page<TdOrder> orderPage = null;
        
        if (timeId.equals(0))
        {
            if (statusId.equals(0))
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsername(username, page, ClientConstant.pageSize);
                }
            }
            else
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndSearch(username, statusId, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndStatusId(username, statusId, page, ClientConstant.pageSize);
                }
            }
        }
        else if (timeId.equals(1))
        {
            Date cur = new Date();
            Calendar calendar = Calendar.getInstance();//日历对象
            calendar.setTime(cur);//设置当前日期
            calendar.add(Calendar.MONTH, -1);//月份减一
            Date time =calendar.getTime();
            
            if (statusId.equals(0))
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfterAndSearch(username, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfter(username, time, page, ClientConstant.pageSize);
                }
            }
            else
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfterAndSearch(username, statusId, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfter(username, statusId, time, page, ClientConstant.pageSize);
                }
            }
        }
        else if (timeId.equals(3))
        {
            Date cur = new Date();
            Calendar calendar = Calendar.getInstance();//日历对象
            calendar.setTime(cur);//设置当前日期
            calendar.add(Calendar.MONTH, -3);//月份减一
            Date time =calendar.getTime();
            
            if (statusId.equals(0))
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfterAndSearch(username, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfter(username, time, page, ClientConstant.pageSize);
                }
            }
            else
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfterAndSearch(username, statusId, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfter(username, statusId, time, page, ClientConstant.pageSize);
                }
            }
        }
        else if (timeId.equals(6))
        {
            Date cur = new Date();
            Calendar calendar = Calendar.getInstance();//日历对象
            calendar.setTime(cur);//设置当前日期
            calendar.add(Calendar.MONTH, -6);//月份减一
            Date time =calendar.getTime();
            
            if (statusId.equals(0))
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfterAndSearch(username, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfter(username, time, page, ClientConstant.pageSize);
                }
            }
            else
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfterAndSearch(username, statusId, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfter(username, statusId, time, page, ClientConstant.pageSize);
                }
            }
        }
        else if (timeId.equals(12))
        {
            Date cur = new Date();
            Calendar calendar = Calendar.getInstance();//日历对象
            calendar.setTime(cur);//设置当前日期
            calendar.add(Calendar.YEAR, -1);//减一
            Date time =calendar.getTime();
            
            if (statusId.equals(0))
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfterAndSearch(username, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndTimeAfter(username, time, page, ClientConstant.pageSize);
                }
            }
            else
            {
                if (null != keywords && !keywords.isEmpty())
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfterAndSearch(username, statusId, time, keywords, page, ClientConstant.pageSize);
                }
                else
                {
                    orderPage = tdOrderService.findByUsernameAndStatusIdAndTimeAfter(username, statusId, time, page, ClientConstant.pageSize);
                }
            }
        }
        
        map.addAttribute("order_page", orderPage);
        
        return "/client/user_order_list";
    }
    
    @RequestMapping(value = "/user/order")
    public String order(Long id,
                        HttpServletRequest req, 
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        if (null != id)
        {
            map.addAttribute("order", tdOrderService.findOne(id));
        }
        
        return "/client/user_order_detail";
    }
    
    @RequestMapping(value = "/user/collect/list")
    public String collectList(HttpServletRequest req, 
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserCollect> collectPage = null;
        
        if (null == keywords || keywords.isEmpty())
        {
            collectPage = tdUserCollectService.findByUsername(username, page, ClientConstant.pageSize);
        }
        else
        {
            collectPage = tdUserCollectService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
        }
        
        //猜你喜欢 zhangji
        List<TdUserRecentVisit> lastVisitList = tdUserRecentVisitService.findByUsernameOrderByVisitCountDesc(username);
        if (0 == lastVisitList.size())
        {
            List<TdProductCategory> topCategoryList = tdProductCategoryService
                    .findByParentIdIsNullOrderBySortIdAsc();
        	//没有浏览记录时，第一页
            if (topCategoryList.size() > 0)
            {
		        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(0).getId(), page, 4));
		        map.addAttribute("categoryId0",topCategoryList.get(0).getId());
		        map.addAttribute("categoryTitle0",topCategoryList.get(0).getTitle());
            }
	        //第二页
            if (topCategoryList.size() > 1)
            {
		        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(1).getId(), page, 4));
		        map.addAttribute("categoryId1",topCategoryList.get(1).getId());
		        map.addAttribute("categoryTitle1",topCategoryList.get(1).getTitle());
            }
	        //第三页
            if (topCategoryList.size() > 2)
            {
		        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(2).getId(), page, 4));
		        map.addAttribute("categoryId2",topCategoryList.get(2).getId());
		        map.addAttribute("categoryTitle2",topCategoryList.get(2).getTitle());
            }
        }
        if (lastVisitList.size() > 0)
	        	{
		        	//猜你喜欢，第一页
			        TdGoods good_0 =tdGoodsService.findOne(lastVisitList.get(0).getGoodsId());
			        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_0.getCategoryId(), page, 4));
			        map.addAttribute("categoryId0",good_0.getCategoryId());
			        map.addAttribute("categoryTitle0",good_0.getCategoryTitle());
	        	}
         if (lastVisitList.size() > 1)
	        	{
			        //猜你喜欢，第二页
			        TdGoods good_1 =tdGoodsService.findOne(lastVisitList.get(1).getGoodsId());
			        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_1.getCategoryId(), page, 4));
			        map.addAttribute("categoryId1",good_1.getCategoryId());
			        map.addAttribute("categoryTitle1",good_1.getCategoryTitle());
	        	}
		  if (lastVisitList.size() > 2)
	        	{
				    //猜你喜欢，第三页
			        TdGoods good_2 =tdGoodsService.findOne(lastVisitList.get(2).getGoodsId());
			        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_2.getCategoryId(), page, 4));
			        map.addAttribute("categoryId2",good_2.getCategoryId());
			        map.addAttribute("categoryTitle2",good_2.getCategoryTitle());
	        	}
        
        map.addAttribute("collect_page", collectPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_collect_list";
    }
    
    @RequestMapping(value = "/user/collect/del")
    public String collectDel(HttpServletRequest req, 
            Long id,
            ModelMap map){
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
            return "redirect:/login";
        }
        
        if (null != id)
        {
            TdUserCollect collect = tdUserCollectService
                    .findByUsernameAndGoodsId(username, id);

            // 删除收藏
            if (null != collect) {
                tdUserCollectService.delete(collect);
            }
        }
        
        return "redirect:/user/collect/list";
    }
    
    @RequestMapping(value = "/user/collect/add", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> collectAdd(HttpServletRequest req, 
                        Long goodsId,
                        ModelMap map){
        
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("code", 1);
        
        if (null == goodsId)
        {
            res.put("message", "参数错误");
            return res;
        }
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            res.put("message", "请先登录");
            return res;
        }
        
        res.put("code", 0);
        
        // 没有收藏
        if (null == tdUserCollectService.findByUsernameAndGoodsId(username, goodsId))
        {
            TdGoods goods = tdGoodsService.findOne(goodsId);
            
            if (null == goods)
            {
                res.put("message", "商品不存在");
                return res;
            }
            
            TdUserCollect collect = new TdUserCollect();
            
            collect.setUsername(username);
            collect.setGoodsId(goods.getId());
            collect.setGoodsCoverImageUri(goods.getCoverImageUri());
            collect.setGoodsTitle(goods.getTitle());
            collect.setGoodsSalePrice(goods.getSalePrice());
            collect.setCollectTime(new Date());
            collect.setLeftNumber(goods.getLeftNumber()); //库存zhangji
            
            tdUserCollectService.save(collect);
            
            res.put("message", "添加成功");
            
            return res;
        }
        
        res.put("message", "您已收藏了该商品");
        
        return res;
    }
    
    @RequestMapping(value = "/user/recent/list")
    public String recentList(HttpServletRequest req, 
    					Long categoryId,
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserRecentVisit> recentPage = null;
        
        if (null == categoryId)
        {
        	recentPage = tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, page, ClientConstant.pageSize);
        }
        else
        {
        	recentPage = tdUserRecentVisitService.findByUsernameAndCategoryIdOrderByVisitTimeDesc(username, categoryId,page, ClientConstant.pageSize);
        }
//        if (null == keywords || keywords.isEmpty())
//        {
//            recentPage = tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, page, ClientConstant.pageSize);
//        }
//        else
//        {
//            recentPage = tdUserRecentVisitService.findByUsernameAndSearchOrderByVisitTimeDesc(username, keywords, page, ClientConstant.pageSize);
//        }
        Date today = new Date();
        Calendar calendar = Calendar.getInstance();// 日历对象
        calendar.setTime(today);// 设置当前日期
        calendar.add(Calendar.DATE, -1);
        Date yesterday = calendar.getTime();
        calendar.add(Calendar.DATE,-1);
        Date tdby = calendar.getTime();
        
        map.addAttribute("today",today);
        map.addAttribute("yesterday", yesterday);
        map.addAttribute("tdby", tdby);
        map.addAttribute("categoryId",categoryId); //商品分类id zhangji
        map.addAttribute("recent_page", recentPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_recent_list";
    }
    /*
     * 删除历史记录
     * @zhangji
     */
    @RequestMapping(value="/user/recent/delete/{id}")
    public String recentDelete(HttpServletRequest req, 
    																ModelMap map,
    																@PathVariable Long id, 
    																String date){
         String username = (String) req.getSession().getAttribute("username");

         if (null == username) {
        	 return "redirect:/login";
         }
         if (0 == id &&null != date)
         {
        	 List<TdUserRecentVisit> recentList = tdUserRecentVisitService.findByUsernameAndVisitDate(username,date);
        	 tdUserRecentVisitService.delete(recentList);

         }
         else if(-1 == id && null != date)
         {
        	 List<TdUserRecentVisit> recentList = tdUserRecentVisitService.findByUsername(username);
        	 tdUserRecentVisitService.delete(recentList);
         }
         else
         {
        	 TdUserRecentVisit recent = tdUserRecentVisitService.findOne(id);
        	 tdUserRecentVisitService.delete(id);
         }
    	 return "redirect:/user/recent/list";
    }
    
    //listId 0-全部，1-未使用，2-已使用，3-已过期 
    @RequestMapping(value = "/user/coupon/list/{listId}")
    public String couponList(HttpServletRequest req, Integer page,@PathVariable Integer listId,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
         TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        List<TdCoupon> coupanList = null;
        
        switch(listId)
        {
        case 0:
        	coupanList =tdCouponService.findByMoblie(tdUser.getMobile()); //全部优惠券
        	break;
        case 1:	
        	coupanList =tdCouponService.findByMobileAndIsUseable(tdUser.getMobile());  //未使用的优惠券
        	break;
        case 2:
        	coupanList =tdCouponService.findByMobileAndIsUsedTrue(tdUser.getMobile()); //已使用的优惠券
        	break;
        case 3:
        	coupanList =tdCouponService.findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(tdUser.getMobile()); //已过期的优惠券
        	break;
        default:
        		coupanList =tdCouponService.findByMoblie(tdUser.getMobile()); //全部优惠券
        }
        
        //取得剩余天数 zhangji
        Date today = new Date();
        Calendar calendar1 = Calendar.getInstance();
        calendar1.setTime(today);
        
        for (TdCoupon cl:coupanList)
        {
        	Date deadline = cl.getExpireTime();
            Calendar calendar2 = Calendar.getInstance();
            calendar2.setTime(deadline);
            Long num = calendar2.getTimeInMillis() - calendar1.getTimeInMillis();
            Double hourLeft = new Double(num/(1000*60*60)).doubleValue();
            Long dateLeft = new Long(num/(1000*24*60*60)).longValue();
            cl.setHourLeft(hourLeft);
        	cl.setDateLeft(dateLeft);       
        }
        
      //猜你喜欢 zhangji
        List<TdUserRecentVisit> lastVisitList = tdUserRecentVisitService.findByUsernameOrderByVisitCountDesc(username);
        if (0 == lastVisitList.size())
        {
            List<TdProductCategory> topCategoryList = tdProductCategoryService
                    .findByParentIdIsNullOrderBySortIdAsc();
        	//没有浏览记录时，第一页
            if (topCategoryList.size() > 0)
            {
		        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(0).getId(), page, 4));
		        map.addAttribute("categoryId0",topCategoryList.get(0).getId());
		        map.addAttribute("categoryTitle0",topCategoryList.get(0).getTitle());
            }
	        //第二页
            if (topCategoryList.size() > 1)
            {
		        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(1).getId(), page, 4));
		        map.addAttribute("categoryId1",topCategoryList.get(1).getId());
		        map.addAttribute("categoryTitle1",topCategoryList.get(1).getTitle());
            }
	        //第三页
            if (topCategoryList.size() > 2)
            {
		        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(2).getId(), page, 4));
		        map.addAttribute("categoryId2",topCategoryList.get(2).getId());
		        map.addAttribute("categoryTitle2",topCategoryList.get(2).getTitle());
            }
        }
        if (lastVisitList.size() > 0)
	        	{
		        	//猜你喜欢，第一页
			        TdGoods good_0 =tdGoodsService.findOne(lastVisitList.get(0).getGoodsId());
			        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_0.getCategoryId(), page, 4));
			        map.addAttribute("categoryId0",good_0.getCategoryId());
			        map.addAttribute("categoryTitle0",good_0.getCategoryTitle());
	        	}
         if (lastVisitList.size() > 1)
	        	{
			        //猜你喜欢，第二页
			        TdGoods good_1 =tdGoodsService.findOne(lastVisitList.get(1).getGoodsId());
			        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_1.getCategoryId(), page, 4));
			        map.addAttribute("categoryId1",good_1.getCategoryId());
			        map.addAttribute("categoryTitle1",good_1.getCategoryTitle());
	        	}
		  if (lastVisitList.size() > 2)
	        	{
				    //猜你喜欢，第三页
			        TdGoods good_2 =tdGoodsService.findOne(lastVisitList.get(2).getGoodsId());
			        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_2.getCategoryId(), page, 4));
			        map.addAttribute("categoryId2",good_2.getCategoryId());
			        map.addAttribute("categoryTitle2",good_2.getCategoryTitle());
	        	}
        
		map.addAttribute("listId", listId);  
        map.addAttribute("coupan_list", coupanList);
        
        return "/client/user_coupon_list";
    }
    
    /*
     * 删除优惠券记录
     * @zhangji
     */
    @RequestMapping(value = "/user/coupon/del")
    public String couponDel(HttpServletRequest req, Integer listId,Long id,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
         TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        tdCouponService.delete(id);
        
        List<TdCoupon> coupanList = null;
        
        switch(listId)
        {
        case 0:
        	coupanList =tdCouponService.findByMoblie(tdUser.getMobile()); //全部优惠券
        	break;
        case 1:	
        	coupanList =tdCouponService.findByMobileAndIsUseable(tdUser.getMobile());  //未使用的优惠券
        	break;
        case 2:
        	coupanList =tdCouponService.findByMobileAndIsUsedTrue(tdUser.getMobile()); //已使用的优惠券
        	break;
        case 3:
        	coupanList =tdCouponService.findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(tdUser.getMobile()); //已过期的优惠券
        	break;
        default:
        		coupanList =tdCouponService.findByMoblie(tdUser.getMobile()); //全部优惠券
        }
        
        //取得剩余天数 zhangji
        Date today = new Date();
        Calendar calendar1 = Calendar.getInstance();
        calendar1.setTime(today);
        
        for (TdCoupon cl:coupanList)
        {
        	Date deadline = cl.getExpireTime();
            Calendar calendar2 = Calendar.getInstance();
            calendar2.setTime(deadline);
            Long num = calendar2.getTimeInMillis() - calendar1.getTimeInMillis();
            Double hourLeft = new Double(num/(1000*60*60)).doubleValue();
            Long dateLeft = new Long(num/(1000*24*60*60)).longValue();
            cl.setHourLeft(hourLeft);
        	cl.setDateLeft(dateLeft);       
        }
        
        map.addAttribute("coupan_list", coupanList);
        
        return "/client/user_coupon_list_detail";
    }
        
    @RequestMapping(value = "/user/point/list")
    public String pointList(HttpServletRequest req, Integer page,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserPoint> pointPage = null;
        
        pointPage = tdUserPointService.findByUsername(username, page, ClientConstant.pageSize);
        
        //猜你喜欢 zhangji
        List<TdUserRecentVisit> lastVisitList = tdUserRecentVisitService.findByUsernameOrderByVisitCountDesc(username);
        if (0 == lastVisitList.size())
        {
            List<TdProductCategory> topCategoryList = tdProductCategoryService
                    .findByParentIdIsNullOrderBySortIdAsc();
        	//没有浏览记录时，第一页
            if (topCategoryList.size() > 0)
            {
		        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(0).getId(), page, 4));
		        map.addAttribute("categoryId0",topCategoryList.get(0).getId());
		        map.addAttribute("categoryTitle0",topCategoryList.get(0).getTitle());
            }
	        //第二页
            if (topCategoryList.size() > 1)
            {
		        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(1).getId(), page, 4));
		        map.addAttribute("categoryId1",topCategoryList.get(1).getId());
		        map.addAttribute("categoryTitle1",topCategoryList.get(1).getTitle());
            }
	        //第三页
            if (topCategoryList.size() > 2)
            {
		        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(2).getId(), page, 4));
		        map.addAttribute("categoryId2",topCategoryList.get(2).getId());
		        map.addAttribute("categoryTitle2",topCategoryList.get(2).getTitle());
            }
        }
        if (lastVisitList.size() > 0)
	        	{
		        	//猜你喜欢，第一页
			        TdGoods good_0 =tdGoodsService.findOne(lastVisitList.get(0).getGoodsId());
			        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_0.getCategoryId(), page, 4));
			        map.addAttribute("categoryId0",good_0.getCategoryId());
			        map.addAttribute("categoryTitle0",good_0.getCategoryTitle());
	        	}
         if (lastVisitList.size() > 1)
	        	{
			        //猜你喜欢，第二页
			        TdGoods good_1 =tdGoodsService.findOne(lastVisitList.get(1).getGoodsId());
			        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_1.getCategoryId(), page, 4));
			        map.addAttribute("categoryId1",good_1.getCategoryId());
			        map.addAttribute("categoryTitle1",good_1.getCategoryTitle());
	        	}
		  if (lastVisitList.size() > 2)
	        	{
				    //猜你喜欢，第三页
			        TdGoods good_2 =tdGoodsService.findOne(lastVisitList.get(2).getGoodsId());
			        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_2.getCategoryId(), page, 4));
			        map.addAttribute("categoryId2",good_2.getCategoryId());
			        map.addAttribute("categoryTitle2",good_2.getCategoryTitle());
	        	}
        
        map.addAttribute("point_page", pointPage);
        
        return "/client/user_point_list";
    }
    
    @RequestMapping(value = "/user/return/{orderId}")
    public String userReturn(HttpServletRequest req, 
                        @PathVariable Long orderId,
                        Long id, // 商品ID
                        String method,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        if (null != orderId)
        {
            TdOrder tdOrder = tdOrderService.findOne(orderId);
            map.addAttribute("order", tdOrder);
            
            if (null != tdOrder && null != id)
            {
                for (TdOrderGoods tog : tdOrder.getOrderGoodsList())
                {
                    if (tog.getId().equals(id))
                    {
                        // 已经退换货
                        if (null != tog.getIsReturnApplied() && tog.getIsReturnApplied())
                        {
                            map.addAttribute("has_returned", true);
                        }

                        map.addAttribute("order_goods", tog);
                        
                        return "/client/user_return_edit";
                    }
                }
            }
        }
        
        return "/client/user_return";
    }
    
    @RequestMapping(value = "/user/return/save", method=RequestMethod.POST)
    public String returnSave(HttpServletRequest req, 
                        Long goodsId,
                        Long id, // 订单ID
                        String reason,
                        String telephone,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);

        if (null != id && null != goodsId)
        {
            TdOrder order = tdOrderService.findOne(id);
            
            if (null != order)
            {
                for (TdOrderGoods tog : order.getOrderGoodsList())
                {
                    if (goodsId.equals(tog.getGoodsId()))
                    {
                        TdUserReturn tdReturn = new TdUserReturn();
                        
                        tdReturn.setIsReturn(false); 
                        
                        // 用户
                        tdReturn.setUsername(username);
                        tdReturn.setTelephone(telephone);;
                        
                        // 退货订单商品
                        tdReturn.setOrderNumber(order.getOrderNumber());
                        tdReturn.setGoodsId(goodsId);
                        tdReturn.setGoodsTitle(tog.getGoodsTitle());
                        tdReturn.setGoodsPrice(tog.getPrice());
                        tdReturn.setGoodsCoverImageUri(tog.getGoodsCoverImageUri());
                        
                        // 退货时间及原因
                        tdReturn.setReason(reason);
                        tdReturn.setReturnTime(new Date());
                        
                        tdReturn.setStatusId(0L);
                        tdReturn.setReturnNumber(1L);
                        
                        // 保存
                        tdUserReturnService.save(tdReturn);
                        
                        // 该商品已经退换货
                        tog.setIsReturnApplied(true);
                        tdOrderGoodsService.save(tog);
                        break;
                    }
                }
            }
        }
        
        return "redirect:/user/return/list";
    }
    
    @RequestMapping(value = "/user/return/list")
    public String returnList(HttpServletRequest req, 
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserReturn> returnPage = null;
        
        if (null == keywords || keywords.isEmpty())
        {
            returnPage = tdUserReturnService.findByUsername(username, page, ClientConstant.pageSize);
        }
        else
        {
            returnPage = tdUserReturnService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
        }
        //猜你喜欢 zhangji
        List<TdUserRecentVisit> lastVisitList = tdUserRecentVisitService.findByUsernameOrderByVisitCountDesc(username);
        if (0 == lastVisitList.size())
        {
            List<TdProductCategory> topCategoryList = tdProductCategoryService
                    .findByParentIdIsNullOrderBySortIdAsc();
        	//没有浏览记录时，第一页
            if (topCategoryList.size() > 0)
            {
		        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(0).getId(), page, 4));
		        map.addAttribute("categoryId0",topCategoryList.get(0).getId());
		        map.addAttribute("categoryTitle0",topCategoryList.get(0).getTitle());
            }
	        //第二页
            if (topCategoryList.size() > 1)
            {
		        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(1).getId(), page, 4));
		        map.addAttribute("categoryId1",topCategoryList.get(1).getId());
		        map.addAttribute("categoryTitle1",topCategoryList.get(1).getTitle());
            }
	        //第三页
            if (topCategoryList.size() > 2)
            {
		        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(2).getId(), page, 4));
		        map.addAttribute("categoryId2",topCategoryList.get(2).getId());
		        map.addAttribute("categoryTitle2",topCategoryList.get(2).getTitle());
            }
        }
        if (lastVisitList.size() > 0)
	        	{
		        	//猜你喜欢，第一页
			        TdGoods good_0 =tdGoodsService.findOne(lastVisitList.get(0).getGoodsId());
			        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_0.getCategoryId(), page, 4));
			        map.addAttribute("categoryId0",good_0.getCategoryId());
			        map.addAttribute("categoryTitle0",good_0.getCategoryTitle());
	        	}
         if (lastVisitList.size() > 1)
	        	{
			        //猜你喜欢，第二页
			        TdGoods good_1 =tdGoodsService.findOne(lastVisitList.get(1).getGoodsId());
			        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_1.getCategoryId(), page, 4));
			        map.addAttribute("categoryId1",good_1.getCategoryId());
			        map.addAttribute("categoryTitle1",good_1.getCategoryTitle());
	        	}
		  if (lastVisitList.size() > 2)
	        	{
				    //猜你喜欢，第三页
			        TdGoods good_2 =tdGoodsService.findOne(lastVisitList.get(2).getGoodsId());
			        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_2.getCategoryId(), page, 4));
			        map.addAttribute("categoryId2",good_2.getCategoryId());
			        map.addAttribute("categoryTitle2",good_2.getCategoryTitle());
	        	}
        
        map.addAttribute("return_page", returnPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_return_list";
    }
    
    @RequestMapping(value = "/user/comment/add", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> commentAdd(HttpServletRequest req, 
                        TdUserComment tdComment,
                        String code,
                        ModelMap map){
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("code", 1);
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            res.put("message", "请先登录！");
            return res;
        }
        
        if (null == tdComment.getGoodsId())
        {
            res.put("message", "商品ID不能为空！");
            return res;
        }
        
        TdGoods goods = tdGoodsService.findOne(tdComment.getGoodsId());
        
        if (null == goods)
        {
            res.put("message", "评论的商品不存在！");
            return res;
        }
        
//        String codeBack = (String) req.getSession().getAttribute("RANDOMVALIDATECODEKEY");
//        
//        if (!codeBack.equalsIgnoreCase(code))
//        {
//            res.put("message", "验证码不匹配！");
//            return res;
//        }
//        
        tdComment.setCommentTime(new Date());
        tdComment.setGoodsCoverImageUri(goods.getCoverImageUri());
        tdComment.setGoodsTitle(goods.getTitle());
        tdComment.setIsReplied(false);
        tdComment.setNegativeNumber(0L);
        tdComment.setPositiveNumber(0L);
        tdComment.setUsername(username);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (null != user)
        {
            tdComment.setUserHeadUri(user.getHeadImageUri());
        }
        
        tdComment.setStatusId(0L);
        
        tdUserCommentService.save(tdComment);
        

        if (null == goods.getTotalComments())
        {
            goods.setTotalComments(1L);
        }
        else
        {
            goods.setTotalComments(goods.getTotalComments() + 1L);
        }
        
        res.put("code", 0);
        
        return res;
    }
    
    @RequestMapping(value = "/user/comment/list")
    public String commentList(HttpServletRequest req, 
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserComment> commentPage = null;
        
        if (null == keywords || keywords.isEmpty())
        {
            commentPage = tdUserCommentService.findByUsername(username, page, ClientConstant.pageSize);
        }
        else
        {
            commentPage = tdUserCommentService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
        }
        
        map.addAttribute("comment_page", commentPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_comment_list";
    }
    
    @RequestMapping(value = "/user/consult/add", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> consultAdd(HttpServletRequest req, 
                        TdUserConsult tdConsult,
                        String code,
                        ModelMap map){
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("code", 1);
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            res.put("message", "请先登录！");
            return res;
        }
        
        if (null == tdConsult.getGoodsId())
        {
            res.put("message", "商品ID不能为空！");
            return res;
        }
        
        TdGoods goods = tdGoodsService.findOne(tdConsult.getGoodsId());
        
        if (null == goods)
        {
            res.put("message", "咨询的商品不存在！");
            return res;
        }
        
//        String codeBack = (String) req.getSession().getAttribute("RANDOMVALIDATECODEKEY");
//        
//        if (!codeBack.equalsIgnoreCase(code))
//        {
//            res.put("message", "验证码不匹配！");
//            return res;
//        }
        
        tdConsult.setConsultTime(new Date());
        tdConsult.setGoodsCoverImageUri(goods.getCoverImageUri());
        tdConsult.setGoodsTitle(goods.getTitle());
        tdConsult.setIsReplied(false);
        tdConsult.setStatusId(0L);
        tdConsult.setUsername(username);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        if (null != user)
        {
            tdConsult.setUserHeadImageUri(user.getHeadImageUri());
        }
        
        tdUserConsultService.save(tdConsult);
        
        res.put("code", 0);
        
        return res;
    }
    
    @RequestMapping(value = "/user/consult/list")
    public String consultList(HttpServletRequest req, 
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdUserConsult> consultPage = null;
        
        if (null == keywords || keywords.isEmpty())
        {
            consultPage = tdUserConsultService.findByUsername(username, page, ClientConstant.pageSize);
        }
        else
        {
            consultPage = tdUserConsultService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
        }
        
        map.addAttribute("consult_page", consultPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_consult_list";
    }
    
    /*
     * 投诉
     * @zhangji
     */
    @RequestMapping(value = "/user/complain/list")
    public String complainList(HttpServletRequest req, 
                        Integer page,
                        String keywords,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", tdUser);
        
        Page<TdOrder> complainPage = null;

        if (null != keywords && !keywords.isEmpty())
        {
        	complainPage = tdOrderService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
        }
        else
        {
        	complainPage = tdOrderService.findByUsername(username, page, ClientConstant.pageSize);
        }
       
        //猜你喜欢 zhangji
        List<TdUserRecentVisit> lastVisitList = tdUserRecentVisitService.findByUsernameOrderByVisitCountDesc(username);
        if (0 == lastVisitList.size())
        {
            List<TdProductCategory> topCategoryList = tdProductCategoryService
                    .findByParentIdIsNullOrderBySortIdAsc();
        	//没有浏览记录时，第一页
            if (topCategoryList.size() > 0)
            {
		        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(0).getId(), page, 4));
		        map.addAttribute("categoryId0",topCategoryList.get(0).getId());
		        map.addAttribute("categoryTitle0",topCategoryList.get(0).getTitle());
            }
	        //第二页
            if (topCategoryList.size() > 1)
            {
		        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(1).getId(), page, 4));
		        map.addAttribute("categoryId1",topCategoryList.get(1).getId());
		        map.addAttribute("categoryTitle1",topCategoryList.get(1).getTitle());
            }
	        //第三页
            if (topCategoryList.size() > 2)
            {
		        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(topCategoryList.get(2).getId(), page, 4));
		        map.addAttribute("categoryId2",topCategoryList.get(2).getId());
		        map.addAttribute("categoryTitle2",topCategoryList.get(2).getTitle());
            }
        }
        if (lastVisitList.size() > 0)
	        	{
		        	//猜你喜欢，第一页
			        TdGoods good_0 =tdGoodsService.findOne(lastVisitList.get(0).getGoodsId());
			        map.addAttribute("reco_page0",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_0.getCategoryId(), page, 4));
			        map.addAttribute("categoryId0",good_0.getCategoryId());
			        map.addAttribute("categoryTitle0",good_0.getCategoryTitle());
	        	}
         if (lastVisitList.size() > 1)
	        	{
			        //猜你喜欢，第二页
			        TdGoods good_1 =tdGoodsService.findOne(lastVisitList.get(1).getGoodsId());
			        map.addAttribute("reco_page1",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_1.getCategoryId(), page, 4));
			        map.addAttribute("categoryId1",good_1.getCategoryId());
			        map.addAttribute("categoryTitle1",good_1.getCategoryTitle());
	        	}
		  if (lastVisitList.size() > 2)
	        	{
				    //猜你喜欢，第三页
			        TdGoods good_2 =tdGoodsService.findOne(lastVisitList.get(2).getGoodsId());
			        map.addAttribute("reco_page2",tdGoodsService.findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderBySortIdAsc(good_2.getCategoryId(), page, 4));
			        map.addAttribute("categoryId2",good_2.getCategoryId());
			        map.addAttribute("categoryTitle2",good_2.getCategoryTitle());
	        	}
        
        map.addAttribute("complain_page", complainPage);
        map.addAttribute("keywords", keywords);
        
        return "/client/user_complain_list";
    }
    @RequestMapping(value = "/user/complain/add", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> complainAdd(HttpServletRequest req, 
                        TdUserComplain tdComplain,
                        String code,
                        ModelMap map){
        Map<String, Object> res = new HashMap<String, Object>();
        res.put("code", 1);
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            res.put("message", "请先登录！");
            return res;
        }

        if(null != tdUserComplainService.findByUsernameAndOrderId(username, tdComplain.getOrderId()))
        {
        	res.put("message", "该订单已提交投诉，请勿重复提交。");
        	return res;
        }
        if (null == tdComplain.getOrderId())
        {
            res.put("message", "订单ID不能为空！");
            return res;
        }
        
        TdOrder order = tdOrderService.findOne(tdComplain.getOrderId());
        
        if (null == order)
        {
            res.put("message", "投诉的订单不存在！");
            return res;
        }
        
        tdComplain.setConsultTime(new Date());
        tdComplain.setOrderId(order.getId());
        tdComplain.setOrderNumber(order.getOrderNumber());
        tdComplain.setIsReplied(false);
        tdComplain.setStatusId(0L);
        tdComplain.setUsername(username);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        if (null != user)
        {
        	tdComplain.setUserHeadImageUri(user.getHeadImageUri());
        }
        
        tdUserComplainService.save(tdComplain);
        
        res.put("code", 0);
        return res;
    }
    
    @RequestMapping(value = "/user/address/ajax/add")
    @ResponseBody
    public Map<String, Object> addAddress(String receiverName,
                                    String prov,
                                    String city,
                                    String dist,
                                    String detail,
                                    String postcode,
                                    String mobile,
                                    HttpServletRequest req) {
        Map<String, Object> res = new HashMap<String, Object>();
        
        res.put("code", 1);
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            res.put("message", "请先登录");
            return res;
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (null == user)
        {
            res.put("message", "该用户不存在");
            return res;
        }
        
        TdShippingAddress address = new TdShippingAddress();
        
        address.setReceiverName(receiverName);
        address.setProvince(prov);
        address.setCity(city);
        address.setDisctrict(dist);
        address.setDetailAddress(detail);
        address.setPostcode(postcode);
        address.setReceiverMobile(mobile);
        
        user.getShippingAddressList().add(address);
        
        tdShippingAddressService.save(address);
        
        tdUserService.save(user);
        
        res.put("code", 0);
        
        return res;
    }
    
    @RequestMapping(value = "/user/address/{method}")
    public String address(HttpServletRequest req, 
                        @PathVariable String method,
                        Long id,
                        TdShippingAddress tdShippingAddress,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        map.addAttribute("user", user);
        
        if (null != user)
        {
            List<TdShippingAddress> addressList = user.getShippingAddressList();
            
            if (null != method && !method.isEmpty())
            {
                if (method.equalsIgnoreCase("update"))
                {
                    if (null != id)
                    {
                        //map.addAttribute("address", s)
                        for (TdShippingAddress add : addressList)
                        {
                            if (add.getId().equals(id))
                            {
                                map.addAttribute("address", add);
                            }
                        }
                    }
                }
                else if (method.equalsIgnoreCase("delete"))
                {
                    if (null != id)
                    {
                        for (TdShippingAddress add : addressList)
                        {
                            if (add.getId().equals(id))
                            {
                                addressList.remove(id);
                                user.setShippingAddressList(addressList);
                                tdShippingAddressService.delete(add);
                                return "redirect:/user/address/list";
                            }
                        }
                    }
                }
                else if (method.equalsIgnoreCase("save"))
                {
                    // 修改
                    if (null != tdShippingAddress.getId())
                    {
                        tdShippingAddressService.save(tdShippingAddress);
                    }
                    // 新增
                    else
                    {
                        addressList.add(tdShippingAddressService.save(tdShippingAddress));
                        user.setShippingAddressList(addressList);
                        tdUserService.save(user);
                    }
                    
                    return "redirect:/user/address/list";
                }
            }
            
            map.addAttribute("address_list", user.getShippingAddressList());
        }
        
        return "/client/user_address_list";
    }
    
    @RequestMapping(value = "/user/distributor/return")
    public String distributorReturnList(HttpServletRequest req, 
                        Integer page,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        map.addAttribute("user", user);
        map.addAttribute("reward_page", tdUserCashRewardService.findByUsernameOrderByIdDesc(username, page, ClientConstant.pageSize));
        
        return "/client/user_distributor_return";
    }
    
    @RequestMapping(value = "/user/distributor/lower")
    public String distributorLowerList(HttpServletRequest req, 
                        Integer page,
                        ModelMap map){
        
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        map.addAttribute("user", user);
        map.addAttribute("lower_page", tdUserService.findByUpperUsernameAndIsEnabled(username, page, ClientConstant.pageSize));
        
        return "/client/user_distributor_lower";
    }
    
    @RequestMapping(value = "/user/distributor/bankcard")
    public String distributorLowerList(HttpServletRequest req,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        map.addAttribute("user", user);
        
        return "/client/user_distributor_bankcard";
    }
    
    /**
     * 返现商品列表
     * 
     * @param req
     * @param page
     * @param map
     * @return
     */
    @RequestMapping(value = "/user/distributor/goods")
    public String distributorGoodsList(HttpServletRequest req, 
                        String keywords,
                        Integer page,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        if (null == page)
        {
            page = 0;
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        map.addAttribute("user", user);
        
        if (null == keywords || keywords.isEmpty())
        {
            map.addAttribute("goods_page", tdGoodsService.findByReturnPriceNotZeroAndIsOnSaleTrue(page, ClientConstant.pageSize));
        }
        else
        {
            map.addAttribute("goods_page", tdGoodsService.findByReturnPriceNotZeroAndSearchAndIsOnSaleTrue(page, ClientConstant.pageSize, keywords));
        }
        
        return "/client/user_distributor_goods";
    }
    
    @RequestMapping(value = "/user/info", method=RequestMethod.GET)
    public String userInfo(HttpServletRequest req,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", user);
        
        map.addAttribute("recommend_goods_page", tdGoodsService.findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(0, ClientConstant.pageSize));
        
        return "/client/user_info";
    }
    
    @RequestMapping(value = "/user/info", method=RequestMethod.POST)
    public String userInfo(HttpServletRequest req,
                        String realName,
                        String sex,
                        String email,
                        String mobile,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        if (null != email && null != mobile)
        {
            user.setRealName(realName);
            user.setSex(sex);
            user.setEmail(email);
            user.setMobile(mobile);
            user = tdUserService.save(user);
        }
        
        return "redirect:/user/info";
    }
    
    @RequestMapping(value = "/user/password", method=RequestMethod.GET)
    public String userPassword(HttpServletRequest req,
                        ModelMap map){
        String username = (String) req.getSession().getAttribute("username");
        
        if (null == username)
        {
            return "redirect:/login";
        }
        
        tdCommonService.setHeader(map, req);
        
        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
        
        map.addAttribute("user", user);
        
        return "/client/user_change_password";
    }
    
    @RequestMapping(value = "/user/password", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> userPassword(HttpServletRequest req, String oldPassword,
            String newPassword, ModelMap map) {
    	Map<String, Object> res = new HashMap<String, Object>();
        res.put("code", 1);
        
        String username = (String) req.getSession().getAttribute("username");

        if (null == username) {
        	res.put("msg", "请先登录！");
            return res;
        }

        TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

        if (user.getPassword().equals(oldPassword)) {
            user.setPassword(newPassword);
        }

        map.addAttribute("user", tdUserService.save(user));

        res.put("code", 0);
        return res;
    }
    
    
    @ModelAttribute
    public void getModel(@RequestParam(value = "addressId", required = false) Long addressId,
            Model model) {
        if (addressId != null) {
            model.addAttribute("tdShippingAddress", tdShippingAddressService.findOne(addressId));
        }
    }
}