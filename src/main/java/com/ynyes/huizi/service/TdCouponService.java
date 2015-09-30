package com.ynyes.huizi.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.entity.TdDiySite;
import com.ynyes.huizi.repository.TdCouponRepo;

import scala.xml.dtd.PublicID;

/**
 * TdCoupon 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdCouponService {
    @Autowired
    TdCouponRepo repository;
    
    @Autowired
    TdCouponTypeService tdCouponTypeService;
    
    @Autowired
    TdDiySiteService tdDiySiteService;
    
    /**
     * 删除
     * 
     * @param id 菜单项ID
     */
    public void delete(Long id)
    {
        if (null != id)
        {
            repository.delete(id);
        }
    }
    
    /**
     * 删除
     * 
     * @param e 菜单项
     */
    public void delete(TdCoupon e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdCoupon> entities)
    {
        if (null != entities)
        {
            repository.delete(entities);
        }
    }
    
    /**
     * 查找
     * 
     * @param id ID
     * @return
     */
    public TdCoupon findOne(Long id)
    {
        if (null == id)
        {
            return null;
        }
        
        return repository.findOne(id);
    }
    
    /**
     * 免费打蜡券
     * @author Zhangji
     */
    public TdCoupon findByDiySiteIdAndTypeTitle(Long diySiteId,String typeTitle)
    {
    	return repository.findByDiySiteIdAndTypeTitleAndIsDistributtedFalse(diySiteId,typeTitle);
    }
    
    /**
     * 查找
     * 
     * @param ids
     * @return
     */
    public List<TdCoupon> findAll(Iterable<Long> ids)
    {
        return (List<TdCoupon>) repository.findAll(ids);
    }
    
    public List<TdCoupon> findByUsernameAndIsUseable(String username)
    {
        if (null == username)
        {
            return null;
        }
        return repository.findByUsernameAndExpireTimeAfterAndIsDistributtedTrueAndIsUsedFalse(username, new Date());
    }
    
    /***领用记录****/
    public Page<TdCoupon> findByIsDistributtedTrueOrderByIdDesc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByIsDistributtedTrueOrderByIdDesc(pageRequest);
    }
    public Page<TdCoupon> findByTypeIdAndIsDistributtedTrueOrderByIdDesc(Long typeId,int page,int size)
    {
    	PageRequest pageRequest = new PageRequest(page, size);
    	return repository.findByTypeIdAndIsDistributtedTrueOrderByIdDesc(typeId, pageRequest);
    }
    public Page<TdCoupon> findByIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	return repository.findByIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(pageRequest);
    }
    public Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(Long typeId,int page, int size){
    	if(null == typeId){
    		return null;
    	}
    	PageRequest pageRequest = new PageRequest(page, size);
    	return repository.findByTypeIdAndIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(typeId,pageRequest);
    }
    public Page<TdCoupon> findByIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	return repository.findByIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(pageRequest);
    }
    public Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(Long typeId, int page, int size){
    	if(null == typeId){
    		return null;
    	}
    	PageRequest pageRequest = new PageRequest(page, size);
    	return repository.findByTypeIdAndIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(typeId,pageRequest);
    }
    
    public Page<TdCoupon> findByIsDistributtedTrueAndContainingKeywords(String keywords, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByIsDistributtedTrueAndUsernameContainingOrIsDistributtedTrueAndMobileContainingOrIsDistributtedTrueAndCarCodeContainingOrderByIdDesc(keywords,keywords,keywords,pageRequest);
    }
    public Page<TdCoupon> findBytypeIdAndIsDistributtedTrueAndContainingKeywords(Long typeId,String keywords, int page, int size){
    	if(null == typeId){
    		return null;
    	}
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByTypeIdAndIsDistributtedTrueAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndMobileContainingOrTypeIdAndIsDistributtedTrueAndCarCodeContainingOrderByIdDesc(typeId,keywords,typeId,keywords,typeId,keywords,pageRequest);
    }
    public Page<TdCoupon> findByIsDistributtedTrueAndIsUsedTrueAndContainingKeywords(String keywords, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByIsDistributtedTrueAndIsUsedTrueAndUsernameContainingOrIsDistributtedTrueAndIsUsedTrueAndMobileContainingOrIsDistributtedTrueAndIsUsedTrueAndCarCodeContainingOrderByIdDesc(keywords,keywords,keywords,pageRequest);
    }
    public Page<TdCoupon> findBytypeIdAndIsDistributtedTrueAndIsUsedTrueAndContainingKeywords(Long typeId,String keywords, int page, int size){
    	if(null == typeId){
    		return null;
    	}
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByTypeIdAndIsDistributtedTrueAndIsUsedTrueAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndIsUsedTrueAndMobileContainingOrTypeIdAndIsDistributtedTrueAndIsUsedTrueAndCarCodeContainingOrderByIdDesc(typeId,keywords,typeId,keywords,typeId,keywords,pageRequest);
    }
    public Page<TdCoupon> findByIsDistributtedTrueAndIsUsedFalseAndContainingKeywords(String keywords, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByIsDistributtedTrueAndIsUsedFalseAndUsernameContainingOrIsDistributtedTrueAndIsUsedFalseAndMobileContainingOrIsDistributtedTrueAndIsUsedFalseAndCarCodeContainingOrderByIdDesc(keywords,keywords,keywords,pageRequest);
    }
    public Page<TdCoupon> findBytypeIdAndIsDistributtedTrueAndIsUsedFalseAndContainingKeywords(Long typeId,String keywords, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size);
    	
    	return repository.findByTypeIdAndIsDistributtedTrueAndIsUsedFalseAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndIsUsedFalseAndMobileContainingOrTypeIdAndIsDistributtedTrueAndIsUsedFalseAndCarCodeContainingOrderByIdDesc(typeId,keywords,typeId,keywords,typeId,keywords,pageRequest);
    }
    /***领用记录****/
    
    /**
	 * @author lc
	 * @注释：根据类型查找优惠券
	 */
    public TdCoupon findTopByTypeIdAndIsDistributtedFalse(Long typeId){
    	 if (null == typeId )
         {
             return null;
         }
    	 return repository.findTopByTypeIdAndIsDistributtedFalse(typeId);
    }
    
    //已使用 zhangji
    public List<TdCoupon> findByMobileAndIsUsedTrue(String mobile)
    {
        if (null == mobile)
        {
            return null;
        }
        return repository.findByMobileAndIsDistributtedTrueAndIsUsedTrue(mobile);
    }
    
    //已过期 zhangji
    public List<TdCoupon> findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(String mobile)
    {
        if (null == mobile)
        {
            return null;
        }
        return repository.findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(mobile, new Date());
    }
    
    public List<TdCoupon> findByMobileAndIsUseable(String mobile){
    	if (null == mobile)
        {
            return null;
        }
    	return repository.findByMobileAndExpireTimeAfterAndIsDistributtedTrueAndIsUsedFalse(mobile, new Date());
    }
    
    public List<TdCoupon> findByUsername(String username)
    {
        if (null == username)
        {
            return null;
        }
        return repository.findByUsernameAndIsDistributtedTrue(username);
    }
    
    public List<TdCoupon> findByMoblie(String mobile)
    {
        if (null == mobile)
        {
            return null;
        }
        return repository.findByMobileAndIsDistributtedTrue(mobile);
    } 
    
    public Page<TdCoupon> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    public List<TdCoupon> findAllOrderBySortIdAsc()
    {
        return (List<TdCoupon>) repository.findAll();
    }
    
    public List<TdCoupon> findDistinctTypeIdByIsDistributtedFalse()
    {
        return repository.findTypeIdDistinctByIsDistributtedFalse();
    }
    
    public List<TdCoupon> findByTypeIdAndIsDistributtedFalse(Long typeId)
    {
        return repository.findByTypeIdAndIsDistributtedFalse(typeId);
    }
    
    public List<TdCoupon> findByTypeIdAndIsDistributtedTrueOrderByIdDesc(Long typeId)
    {
        return repository.findByTypeIdAndIsDistributtedTrueOrderByIdDesc(typeId);
    }
    
    public TdCoupon findTopByTypeIdAndDiySiteIdAndIsDistributtedFalse(Long typeId, Long diySiteId)
    {
        if (null == typeId || null == diySiteId)
        {
            return null;
        }
        
        return repository.findTopByTypeIdAndDiySiteIdAndIsDistributtedFalse(typeId, diySiteId);
    }
    
    public Page<TdCoupon> findByIsDistributtedFalseOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByIsDistributtedFalseOrderBySortIdAsc(pageRequest);
    }
    
    public Page<TdCoupon> findByIsDistributtedTrueOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByIsDistributtedTrueOrderBySortIdAsc(pageRequest);
    }
    
    public TdCoupon findByTypeIdAndMobileAndIsDistributtedTrue(Long typeId, String mobile)
    {
        if (null == typeId || null == mobile)
        {
            return null;
        }
        
        return repository.findTopByTypeIdAndMobileAndIsDistributtedTrue(typeId, mobile);
    }
    
    public TdCoupon findByTypeIdAndUsernameAndIsDistributtedTrue(Long typeId, String username)
    {
        if (null == typeId || null == username)
        {
            return null;
        }
        
        return repository.findTopByTypeIdAndUsernameAndIsDistributtedTrue(typeId, username);
    }
    /**
	 * @author lc
	 * @注释：根据类型查找优惠券
	 */
    public TdCoupon findByTypeId(Long typeId){
    	 if (null == typeId )
         {
             return null;
         }
    	 return repository.findByTypeId(typeId);
    }
    
    public List<TdCoupon> findByIsDistributtedTrueOrderByIdDesc(){
    	return repository.findByIsDistributtedTrueOrderByIdDesc();
    }
    
    /**
	 * @author lc
	 * @注释：查询特定同盟店已使用的优惠券
	 */
    public List<TdCoupon> findByDiySiteIdAndIsUsedTrue(Long diySiteId){
    	if (null == diySiteId) {
			return null;
		}
    	return repository.findByDiySiteIdAndIsUsedTrue(diySiteId);
    }
    
    /**
	 * @author lc
     * @return 
	 * @注释：根据手机号和消费密码查询优惠券
	 */
    public TdCoupon findByMoblieAndConsumerPassword(String mobile, String password){
    	if (null == mobile || null == password) {
			return null;
		}
    	return repository.findByMobileAndConsumerPassword(mobile, password);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdCoupon save(TdCoupon e)
    {
        if (null == e.getIsDistributted())
        {
            e.setIsDistributted(false);
        }
        
        if (null == e.getGetNumber())
        {
            e.setGetNumber(0L);
        }
        
        if (null != e.getTypeId())
        {
            TdCouponType cType = tdCouponTypeService.findOne(e.getTypeId());
            
            if (null != cType)
            {
                e.setTypeTitle(cType.getTitle());
                e.setTypePicUri(cType.getPicUri());
                e.setTypeDescription(cType.getDescription());
                e.setTypeCategoryId(cType.getCategoryId());
            }
        }
        
        if (null != e.getDiySiteId())
        {
            TdDiySite diySite = tdDiySiteService.findOne(e.getDiySiteId());
            
            if (null != diySite)
            {
                e.setDiySiteTitle(diySite.getTitle());
            }
        }
        return repository.save(e);
    }
    
    public List<TdCoupon> save(List<TdCoupon> entities)
    {
        
        return (List<TdCoupon>) repository.save(entities);
    }
}
