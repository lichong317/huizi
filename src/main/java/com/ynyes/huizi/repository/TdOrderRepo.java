package com.ynyes.huizi.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdOrder;

/**
 * TdOrder 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdOrderRepo extends
		PagingAndSortingRepository<TdOrder, Long>,
		JpaSpecificationExecutor<TdOrder> 
{
    Page<TdOrder> findByStatusIdOrderByIdDesc(Long statusId, Pageable page);
    
    Page<TdOrder> findByUsernameOrderByIdDesc(String username, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdNotOrderByIdDesc(String username, Long statusId, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdOrUsernameAndStatusIdOrUsernameAndStatusIdOrderByIdDesc(String username1,Long statusId1, String username2,Long statusId2, String username3,Long statusId3, Pageable page);
    
    Page<TdOrder> findByUsernameAndOrderTimeAfterOrderByIdDesc(String username, Date time, Pageable page);
    
    Page<TdOrder> findByUsernameAndOrderTimeAfterAndOrderNumberContainingOrderByIdDesc(String username, Date time, String keywords, Pageable page);
    
    Page<TdOrder> findByUsernameAndOrderNumberContainingOrderByIdDesc(String username, String keywords, Pageable page);
    Page<TdOrder> findByUsernameAndStatusIdNotAndOrderNumberContainingOrderByIdDesc(String username,  Long statusId, String keywords, Pageable page);
    
    Page<TdOrder> findByIdInAndOrderNumberContainingOrderByIdDesc(List<Long> orderids, String keywords, Pageable page);
    
    Page<TdOrder> findByIdInOrderByIdDesc(List<Long> orderids, Pageable page);
    
    Page<TdOrder> findByorderNumberContainingOrShippingAddressContainingOrShippingNameContainingOrUsernameContainingOrShippingPhoneContaining(String keywords, String keywords1, String keywords2, String keywords3, String keywords4, Pageable page);
    
    Page<TdOrder> findByorderNumberContainingAndStatusIdOrShippingAddressContainingAndStatusIdOrShippingNameContainingAndStatusIdOrUsernameContainingAndStatusIdOrShippingPhoneContainingAndStatusId(String keywords, Long statusId, String keywords1, Long statusId1, String keywords2, Long statusId2, String keywords3, Long statusId3, String keywords4, Long statusId4, Pageable page);
    
    /**
   	 * @author lc
   	 * @注释： 按时间、订单类型和订单状态查询
   	 */
       Page<TdOrder> findByOrderTimeAfterOrderByIdDesc(Date time, Pageable page);
       List<TdOrder> findByOrderTimeAfterOrderByIdDesc(Date time);
       Page<TdOrder> findByStatusIdAndTypeIdAndOrderTimeAfterOrderByIdDesc(long statusId, long typeId, Date time, Pageable page);
       List<TdOrder> findByStatusIdAndTypeIdAndOrderTimeAfterOrderByIdDesc(long statusId, long typeId, Date time);
       Page<TdOrder> findByStatusIdAndOrderTimeAfterOrderByIdDesc(long statusId, Date time, Pageable page);
       List<TdOrder> findByStatusIdAndOrderTimeAfterOrderByIdDesc(long statusId, Date time);
       Page<TdOrder> findBytypeIdAndOrderTimeAfterOrderByIdDesc(long typeId, Date time, Pageable page);
       List<TdOrder> findBytypeIdAndOrderTimeAfterOrderByIdDesc(long typeId, Date time);
    
    //zhangji
    Page<TdOrder> findByUsernameAndOrderNumberContainingAndStatusIdOrUsernameAndOrderNumberContainingAndStatusIdOrUsernameAndOrderNumberContainingAndStatusIdOrderByIdDesc(String username1, String keywords1, Long statusId1,String username2, String keywords2, Long statusId2,String username3, String keywords3, Long statusId3, Pageable page);
    Page<TdOrder> findByUsernameAndOrderNumberAndStatusIdOrUsernameAndOrderNumberAndStatusIdOrUsernameAndOrderNumberAndStatusIdOrderByIdDesc(String username1, String keywords1, Long statusId1,String username2, String keywords2, Long statusId2,String username3, String keywords3, Long statusId3, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdOrderByIdDesc(String username, Long statusId, Pageable page);
    Page<TdOrder> findByOrderNumberContainingIgnoreCaseAndOrderTimeAfterOrUsernameContainingIgnoreCaseAndOrderTimeAfterOrPayTypeTitleContainingIgnoreCaseAndOrderTimeAfter(String orderNumber,Date time, String orderNumber2,Date time2, String orderNumber3,Date time3, Pageable page);
    Page<TdOrder> findByUsernameAndIsCancelTrue(String username,Pageable page); //取消订单 zhangji
    Page<TdOrder> findByIsCancelTrue(Pageable page); //取消订单 zhangji
    Page<TdOrder> findByIsCancelTrueAndIsRefundFalse(Pageable page); //取消订单 zhangji
    Page<TdOrder> findByIsCancelTrueAndIsRefundTrue(Pageable page); //取消订单 zhangji
    Page<TdOrder> findByUsernameAndStatusIdAndOrderNumberContainingOrderByIdDesc(String username, Long statusId, String keywords, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdAndOrderTimeAfterOrderByIdDesc(String username, Long statusId, Date time, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdAndOrderTimeAfterAndOrderNumberContainingOrderByIdDesc(String username, Long statusId, Date time, String keywords, Pageable page);
    
    Page<TdOrder> findByUsernameAndStatusIdOrStatusIdOrStatusIdOrStatusId(String username, Long statusId1, Long statusId2,Long statusId3,Long statusId4, Pageable page); //zhangji
    
    Long countByUsernameAndStatusId(String username, Long statusId);
    
    List<TdOrder> findByStatusId(Long statusId);
    
    Long countByStatusId(Long statusId);
    
    TdOrder findByOrderNumber(String orderNumber);
    
    Page<TdOrder> findByOrderNumberContainingIgnoreCaseAndStatusIdAndOrderTimeAfterOrUsernameContainingIgnoreCaseAndStatusIdAndOrderTimeAfterOrPayTypeTitleContainingIgnoreCaseAndStatusIdAndOrderTimeAfter(String OrderNumber, Long statusId, Date time, String OrderNumber2, Long statusId2, Date time2, String OrderNumber3, Long statusId3, Date time3, Pageable page);
}
