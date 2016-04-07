package com.ynyes.huizi.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdCoupon;

/**
 * TdCoupon 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdCouponRepo extends
		PagingAndSortingRepository<TdCoupon, Long>,
		JpaSpecificationExecutor<TdCoupon> 
{
	TdCoupon findByDiySiteIdAndTypeTitleAndIsDistributtedFalse(Long diySiteId,String typeTitle);  //zhangji
    List<TdCoupon> findByUsernameAndExpireTimeAfterAndIsDistributtedTrueAndIsUsedFalse(String username, Date current);
    
    List<TdCoupon> findByMobileAndExpireTimeAfterAndIsDistributtedTrueAndIsUsedFalse(String mobile, Date current);
    
    List<TdCoupon> findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(String mobile, Date current); //已过期 zhangji
    
    List<TdCoupon> findByMobileAndIsDistributtedTrueAndIsUsedTrue(String mobile);  //zhangji
    
    List<TdCoupon> findByUsernameAndIsDistributtedTrue(String username);
    
    List<TdCoupon> findByMobileAndIsDistributtedTrue(String mobile);
    
    List<TdCoupon> findByTypeIdAndIsDistributtedFalse(Long typeId);
    
    TdCoupon findTopByTypeIdAndDiySiteIdAndIsDistributtedFalse(Long typeId, Long diySiteId);
    
    List<TdCoupon> findByTypeIdAndIsDistributtedTrueOrderByIdDesc(Long typeId);
    
    TdCoupon findTopByTypeIdAndMobileAndIsDistributtedTrue(Long typeId, String mobile);
    
    TdCoupon findTopByTypeIdAndUsernameAndIsDistributtedTrueAndIsOwnTrue(Long typeId, String username);
    
    Page<TdCoupon> findByIsDistributtedFalseOrderBySortIdAsc(Pageable page);
    
    Page<TdCoupon> findByIsDistributtedTrueOrderBySortIdAsc(Pageable page);
    
    List<TdCoupon> findByIsDistributtedTrueOrderByIdDesc();
    
    List<TdCoupon> findTypeIdDistinctByIsDistributtedFalse();
    
    List<TdCoupon> findByDiySiteIdAndIsUsedTrue(Long diysiteId);
    
    TdCoupon findByMobileAndConsumerPassword(String mobile, String password);
    
    TdCoupon findByTypeId(Long typeId);
    TdCoupon findTopByTypeIdAndIsDistributtedFalse(Long typeId);
    
    /**领用记录**/
    Page<TdCoupon> findByIsDistributtedTrueOrderByIdDesc(Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueOrderByIdDesc(Long typeId,Pageable page);
    Page<TdCoupon> findByIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedTrueOrderByIdDesc(Long typeId,Pageable page);
    Page<TdCoupon> findByIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedFalseOrderByIdDesc(Long typeId,Pageable page);
    Page<TdCoupon> findByIsDistributtedTrueAndUsernameContainingOrIsDistributtedTrueAndMobileContainingOrIsDistributtedTrueAndCarCodeContainingOrderByIdDesc(String keywords,String keywords1,String keywords2, Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndMobileContainingOrTypeIdAndIsDistributtedTrueAndCarCodeContainingOrderByIdDesc(long typeId,String keywords,long typeId1,String keywords1,long typeId2,String keywords2, Pageable page);
    Page<TdCoupon> findByIsDistributtedTrueAndIsUsedTrueAndUsernameContainingOrIsDistributtedTrueAndIsUsedTrueAndMobileContainingOrIsDistributtedTrueAndIsUsedTrueAndCarCodeContainingOrderByIdDesc(String keywords,String keywords1,String keywords2, Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedTrueAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndIsUsedTrueAndMobileContainingOrTypeIdAndIsDistributtedTrueAndIsUsedTrueAndCarCodeContainingOrderByIdDesc(long typeId,String keywords,long typeId1,String keywords1,long typeId2,String keywords2,Pageable page);
    Page<TdCoupon> findByIsDistributtedTrueAndIsUsedFalseAndUsernameContainingOrIsDistributtedTrueAndIsUsedFalseAndMobileContainingOrIsDistributtedTrueAndIsUsedFalseAndCarCodeContainingOrderByIdDesc(String keywords,String keywords1,String keywords2, Pageable page);
    Page<TdCoupon> findByTypeIdAndIsDistributtedTrueAndIsUsedFalseAndUsernameContainingOrTypeIdAndIsDistributtedTrueAndIsUsedFalseAndMobileContainingOrTypeIdAndIsDistributtedTrueAndIsUsedFalseAndCarCodeContainingOrderByIdDesc(long typeId,String keywords,long typeId1,String keywords1,long typeId2,String keywords2,Pageable page);
    /**领用记录**/
}
