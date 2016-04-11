package com.ynyes.huizi.controller.management;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 优惠券管理
 * 
 * @author Sharon
 */

@Controller
@RequestMapping(value="/Verwalter/coupon")
public class TdManagerCouponController {
    
    @Autowired
    TdCouponTypeService tdCouponTypeService;
    
    @Autowired
    TdCouponService tdCouponService;
    
    @Autowired
    TdManagerLogService tdManagerLogService;
    
    @Autowired
    private TdProductCategoryService tdProductCategoryService;
//    @RequestMapping(value="/check", method = RequestMethod.POST)
//    @ResponseBody
//    public Map<String, String> validateForm(String param, Long id) {
//        Map<String, String> res = new HashMap<String, String>();
//        
//        res.put("status", "n");
//        
//        if (null == param || param.isEmpty())
//        {
//            res.put("info", "该字段不能为空");
//            return res;
//        }
//        
//        if (null == id)
//        {
//            if (null != tdSiteService.findByTitle(param))
//            {
//                res.put("info", "已存在同名站点");
//                return res;
//            }
//        }
//        else
//        {
//            if (null != tdSiteService.findByTitleAndIdNot(param, id))
//            {
//                res.put("info", "已存在同名站点");
//                return res;
//            }
//        }
//        
//        res.put("status", "y");
//        
//        return res;
//    }
    
    @RequestMapping(value="/type/list")
    public String couponType(String __EVENTTARGET,
                          String __EVENTARGUMENT,
                          String __VIEWSTATE,
                          Long[] listId,
                          Integer[] listChkId,
                          Long[] listSortId,
                          ModelMap map,
                          HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        
        if (null == username) {
            return "redirect:/Verwalter/login";
        }
        
        if (null != __EVENTTARGET)
        {
            if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
            {
                btnTypeDelete(listId, listChkId);
                tdManagerLogService.addLog("delete", "删除优惠券类型", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
            {
                btnTypeSave(listId, listSortId);
                tdManagerLogService.addLog("edit", "修改优惠券类型", req);
            }
        }
        
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);

        List<TdCouponType> couponTypeList = null;
        
        couponTypeList = tdCouponTypeService.findAllOrderBySortIdAsc();
        
        map.addAttribute("coupon_type_list", couponTypeList);
        
        return "/site_mag/coupon_type_list";
    }
    
    @RequestMapping(value = "/type/edit")
    public String typeEdit(Long id, String __VIEWSTATE, ModelMap map,
            HttpServletRequest req) {
        
        String username = (String) req.getSession().getAttribute("manager");
        
        if (null == username) {
            return "redirect:/Verwalter/login";
        }

        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        map.addAttribute("category_list", tdProductCategoryService.findAll());
        
        if (null != id) {
            map.addAttribute("coupon_type", tdCouponTypeService.findOne(id));
        }
        return "/site_mag/coupon_type_edit";
    }
    
    @RequestMapping(value = "/type/save")
    public String typeSave(TdCouponType tdCouponType, String __VIEWSTATE, ModelMap map,
            HttpServletRequest req) {
        String username = (String) req.getSession().getAttribute("manager");
        
        if (null == username) {
            return "redirect:/Verwalter/login";
        }

        map.addAttribute("__VIEWSTATE", __VIEWSTATE);

        if (null == tdCouponType.getId()) {
            tdManagerLogService.addLog("add", "用户添加优惠券类型", req);
        } else {
            tdManagerLogService.addLog("edit", "用户修改优惠券类型", req);
        }

        tdCouponTypeService.save(tdCouponType);

        return "redirect:/Verwalter/coupon/type/list";
    }
    
    
    @RequestMapping(value="/list")
    public String setting(Integer page,
                          Integer size,
                          String __EVENTTARGET,
                          String __EVENTARGUMENT,
                          String __VIEWSTATE,
                          Long[] listId,
                          Integer[] listChkId,
                          Long[] listSortId,
                          ModelMap map,
                          HttpServletRequest req){
        
        String username = (String) req.getSession().getAttribute("manager");
        
        if (null == username) {
            return "redirect:/Verwalter/login";
        }
        
        if (null != __EVENTTARGET)
        {
            if (__EVENTTARGET.equalsIgnoreCase("btnPage"))
            {
                if (null != __EVENTARGUMENT)
                {
                    page = Integer.parseInt(__EVENTARGUMENT);
                } 
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
            {
                btnDelete(listId, listChkId);
                tdManagerLogService.addLog("delete", "删除优惠券", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
            {
                btnSave(listId, listSortId);
                tdManagerLogService.addLog("edit", "修改优惠券", req);
            }
        }
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null == size || size <= 0)
        {
            size = SiteMagConstant.pageSize;
        }
        
        map.addAttribute("page", page);
        map.addAttribute("size", size);
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);

        Page<TdCoupon> couponPage = null;
        
        couponPage = tdCouponService.findByIsDistributtedFalseOrderBySortIdAsc(page, size);
        
        map.addAttribute("coupon_page", couponPage);
        
        return "/site_mag/coupon_list";
    }
    
    @RequestMapping(value="/edit")
    public String orderEdit(Long id,
                        String __VIEWSTATE,
                        ModelMap map,
                        HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
        
        List<TdCouponType> couponTypeList = null;
        
        couponTypeList = tdCouponTypeService.findAllOrderBySortIdAsc();
        
        map.addAttribute("coupon_type_list", couponTypeList);

        if (null != id)
        {
            map.addAttribute("coupon", tdCouponService.findOne(id));
        }
        return "/site_mag/coupon_edit";
    }
    
    @RequestMapping(value="/save")
    public String orderEdit(TdCoupon tdCoupon,
                        String __VIEWSTATE,
                        ModelMap map,
                        Long typeId,
                        HttpServletRequest req){
        String username = (String) req.getSession().getAttribute("manager");
        if (null == username)
        {
            return "redirect:/Verwalter/login";
        }
        
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);
                        
        if (null == tdCoupon.getId())
        {
            tdManagerLogService.addLog("add", "用户添加优惠券", req);
            if (null == tdCoupon.getIsDistributted())
            {
                tdCoupon.setIsDistributted(false);
            }
            
            if (null == tdCoupon.getGetNumber())
            {
                tdCoupon.setGetNumber(0L);
            }
            
            if (null != tdCoupon.getTypeId())
            {
                TdCouponType cType = tdCouponTypeService.findOne(tdCoupon.getTypeId());
                
                TdCoupon coupon = tdCouponService.findTopByTypeIdAndIsDistributtedFalse(typeId);
                if (null != cType && null != coupon)
                {
                	if (null != tdCoupon.getLeftNumber()) {
                		coupon.setLeftNumber(tdCoupon.getLeftNumber()+coupon.getLeftNumber());
					}                	
                }
                if (null == coupon) {
                	 coupon = new TdCoupon();                        
                	 if (null != tdCoupon.getLeftNumber()) {
                 		coupon.setLeftNumber(tdCoupon.getLeftNumber());
 					 } 
                     coupon.setIsDistributted(false);
                     coupon.setTypePicUri(cType.getPicUri());
                     coupon.setTypeId(typeId);
                     coupon.setSortId(99L);
                     coupon.setPrice(cType.getPrice());
                     coupon.setTypeDescription(cType.getDescription());
				}
                tdCouponService.save(coupon);
            }
        }
        else
        {
            tdManagerLogService.addLog("edit", "用户修改优惠券", req);
            tdCouponService.save(tdCoupon);
        }
        
        
        
        return "redirect:/Verwalter/coupon/list";
    }

    @RequestMapping(value="/distributed/list")
    public String distributedList(Integer page,
                          Integer size,
                          String __EVENTTARGET,
                          String __EVENTARGUMENT,
                          String __VIEWSTATE,
                          Long[] listId,
                          Integer[] listChkId,
                          Long[] listSortId,
                          ModelMap map,
                          String keywords,
                          Long isUsed,
                          Long typeId,
                          HttpServletRequest req){
        
        String username = (String) req.getSession().getAttribute("manager");
        
        if (null == username) {
            return "redirect:/Verwalter/login";
        }
        
        if (null != __EVENTTARGET)
        {
            if (__EVENTTARGET.equalsIgnoreCase("btnPage"))
            {
                if (null != __EVENTARGUMENT)
                {
                    page = Integer.parseInt(__EVENTARGUMENT);
                } 
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnDelete"))
            {
                btnDelete(listId, listChkId);
                tdManagerLogService.addLog("delete", "删除优惠券", req);
            }
            else if (__EVENTTARGET.equalsIgnoreCase("btnSave"))
            {
                btnSave(listId, listSortId);
                tdManagerLogService.addLog("edit", "修改优惠券", req);
            }
            else if(__EVENTTARGET.equalsIgnoreCase("changeType")){
				
			}
        }
        
        if (null == page || page < 0)
        {
            page = 0;
        }
        
        if (null == size || size <= 0)
        {
            size = SiteMagConstant.pageSize;;
        }
        
        
        if (null == isUsed) 
        {
        	isUsed = 0L;
		}
        
        if(null == typeId)
        {
        	typeId =0L;
        }
        
        Page<TdCoupon> couponPage = null;
        
        if (null == keywords) {//无搜索			
        	if (isUsed.equals(0L)) {//两种核销状态
					if(typeId.equals(0L)){//类型
						couponPage = tdCouponService.findByIsDistributtedTrueOrderByIdDesc(page, size);	
					}
					else{
						couponPage = tdCouponService.findByTypeIdAndIsDistributtedTrueOrderByIdDesc(typeId,page,size);
					}
				}
				else{
					if (isUsed.equals(1L)) {//已核销
						if(typeId.equals(0L)){//类型
							couponPage = tdCouponService.findByIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(page, size);
						}
						else{
							couponPage = tdCouponService.findByTypeIdAndIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(typeId,page, size);
						}
					}
					if (isUsed.equals(2L)) {//未核销
						if(typeId.equals(0L)){//类型
							couponPage = tdCouponService.findByIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(page, size);
						}
						else{
							couponPage = tdCouponService.findByTypeIdAndIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(typeId,page, size);
						}
					}
				}
		}else{//有搜索
			if (isUsed.equals(0L)) {//两种核销状态
				if(typeId.equals(0L)){//类型
					couponPage = tdCouponService.findByIsDistributtedTrueAndContainingKeywords(keywords, page, size);
				}
				else{
					couponPage = tdCouponService.findBytypeIdAndIsDistributtedTrueAndContainingKeywords(typeId,keywords, page, size);
				}
			}
			else{
				if (isUsed.equals(1L)) {//已核销
					if(typeId.equals(0L)){//类型
						couponPage = tdCouponService.findByIsDistributtedTrueAndIsUsedTrueAndContainingKeywords(keywords, page, size);
					}
					else{
						couponPage = tdCouponService.findBytypeIdAndIsDistributtedTrueAndIsUsedTrueAndContainingKeywords(typeId,keywords, page, size);
					}
				}
				if (isUsed.equals(2L)) {//未核销
					if(typeId.equals(0L)){//类型
						couponPage = tdCouponService.findByIsDistributtedTrueAndIsUsedFalseAndContainingKeywords(keywords, page, size);
					}
					else{
						couponPage = tdCouponService.findBytypeIdAndIsDistributtedTrueAndIsUsedFalseAndContainingKeywords(typeId,keywords, page, size);
					}
				}
			}
		}
				       
        map.addAttribute("coupon_page", couponPage);
        map.addAttribute("page", page);
        map.addAttribute("size", size);
        map.addAttribute("isUsed", isUsed);
        map.addAttribute("keywords", keywords);
        map.addAttribute("__EVENTTARGET", __EVENTTARGET);
        map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
        map.addAttribute("__VIEWSTATE", __VIEWSTATE);       

        //查询优惠券类型
        map.addAttribute("couponType_list", tdCouponTypeService.findAllOrderBySortIdAsc());
        map.addAttribute("typeId", typeId);
        
        return "/site_mag/coupon_distributed_list";
    }
    
    
    @ModelAttribute
    public void getModel(@RequestParam(value = "couponTypeId", required = false) Long couponTypeId,
                        @RequestParam(value = "couponId", required = false) Long couponId,
                        Model model) {
        if (null != couponTypeId) {
            model.addAttribute("tdCouponType", tdCouponTypeService.findOne(couponTypeId));
        }
        
        if (null != couponId) {
            model.addAttribute("tdCoupon", tdCouponService.findOne(couponId));
        }
    }
    
    private void btnTypeSave(Long[] ids, Long[] sortIds)
    {
        if (null == ids || null == sortIds
                || ids.length < 1 || sortIds.length < 1)
        {
            return;
        }
        
        for (int i = 0; i < ids.length; i++)
        {
            Long id = ids[i];
            
            TdCouponType e = tdCouponTypeService.findOne(id);
            
            if (null != e)
            {
                if (sortIds.length > i)
                {
                    e.setSortId(sortIds[i]);
                    tdCouponTypeService.save(e);
                }
            }
        }
    }
    
    private void btnTypeDelete(Long[] ids, Integer[] chkIds)
    {
        if (null == ids || null == chkIds
                || ids.length < 1 || chkIds.length < 1)
        {
            return;
        }
        
        for (int chkId : chkIds)
        {
            if (chkId >=0 && ids.length > chkId)
            {
                Long id = ids[chkId];
                
                tdCouponTypeService.delete(id);
            }
        }
    }
    
    private void btnSave(Long[] ids, Long[] sortIds)
    {
        if (null == ids || null == sortIds
                || ids.length < 1 || sortIds.length < 1)
        {
            return;
        }
        
        for (int i = 0; i < ids.length; i++)
        {
            Long id = ids[i];
            
            TdCoupon e = tdCouponService.findOne(id);
            
            if (null != e)
            {
                if (sortIds.length > i)
                {
                    e.setSortId(sortIds[i]);
                    tdCouponService.save(e);
                }
            }
        }
    }
    
    private void btnDelete(Long[] ids, Integer[] chkIds)
    {
        if (null == ids || null == chkIds
                || ids.length < 1 || chkIds.length < 1)
        {
            return;
        }
        
        for (int chkId : chkIds)
        {
            if (chkId >=0 && ids.length > chkId)
            {
                Long id = ids[chkId];
                
                tdCouponService.delete(id);
            }
        }
    }
}
