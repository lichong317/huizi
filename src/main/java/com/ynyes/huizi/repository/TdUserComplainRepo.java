package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdUserComplain;

/**
 * TdUserConsult 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdUserComplainRepo extends
		PagingAndSortingRepository<TdUserComplain, Long>,
		JpaSpecificationExecutor<TdUserComplain> 
{
	TdUserComplain findByUsernameAndOrderId(String username,Long orderId);  //zhagnji
	
    Page<TdUserComplain> findByStatusIdOrderBySortIdAsc(Long statusId, Pageable page);
    
    Page<TdUserComplain> findByStatusIdOrderByIdDesc(Long statusId, Pageable page);
    
    Page<TdUserComplain> findByUsernameContainingOrGoodsTitleContainingOrContentContainingOrderBySortIdAsc(String keywords1, String keywords2, String keywords3, Pageable page);
    
    Page<TdUserComplain> findByUsernameContainingOrGoodsTitleContainingOrContentContainingOrderByIdDesc(String keywords1, String keywords2, String keywords3, Pageable page);
    
    Page<TdUserComplain> findByUsernameContainingAndStatusIdOrGoodsTitleContainingAndStatusIdOrContentContainingAndStatusIdOrderBySortIdAsc(String keywords1, 
            Long statusId1,
            String keywords2,
            Long statusId2,
            String keyword3,
            Long statusId3,
            Pageable page);
    
    Page<TdUserComplain> findByUsernameContainingAndStatusIdOrGoodsTitleContainingAndStatusIdOrContentContainingAndStatusIdOrderByIdDesc(String keywords1, 
            Long statusId1,
            String keywords2,
            Long statusId2,
            String keyword3,
            Long statusId3,
            Pageable page);
    
    List<TdUserComplain> findByUsernameOrderByIdDesc(String username);
    
    Page<TdUserComplain> findByUsernameOrderByIdDesc(String username, Pageable page);
    
    Page<TdUserComplain> findByUsernameAndGoodsTitleContainingOrderByIdDesc(String username, String keywords, Pageable page);
    
    Page<TdUserComplain> findByGoodsIdAndStatusIdOrderByIdDesc(Long goodsId, Long statusId, Pageable page);
}
