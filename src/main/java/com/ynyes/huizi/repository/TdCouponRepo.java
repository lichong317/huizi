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
    
    List<TdCoupon> findByUsernameAndIsDistributtedTrue(String username);
    
    List<TdCoupon> findByMobileAndIsDistributtedTrue(String mobile);
    
    List<TdCoupon> findByTypeIdAndIsDistributtedFalse(Long typeId);
    
    TdCoupon findTopByTypeIdAndDiySiteIdAndIsDistributtedFalse(Long typeId, Long diySiteId);
    
    List<TdCoupon> findByTypeIdAndIsDistributtedTrueOrderByIdDesc(Long typeId);
    
    TdCoupon findTopByTypeIdAndMobileAndIsDistributtedTrue(Long typeId, String mobile);
    
    Page<TdCoupon> findByIsDistributtedFalseOrderBySortIdAsc(Pageable page);
    
    Page<TdCoupon> findByIsDistributtedTrueOrderBySortIdAsc(Pageable page);
    
    List<TdCoupon> findByIsDistributtedTrueOrderByIdDesc();
    
    List<TdCoupon> findTypeIdDistinctByIsDistributtedFalse();
    
    List<TdCoupon> findByDiySiteIdAndIsUsedTrue(Long diysiteId);
    
    TdCoupon findByMobileAndConsumerPassword(String mobile, String password);
    
    TdCoupon findByTypeId(Long typeId);
}
