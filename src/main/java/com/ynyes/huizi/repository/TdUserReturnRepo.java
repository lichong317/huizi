package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdUserReturn;

/**
 * TdUserReturn 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdUserReturnRepo extends
		PagingAndSortingRepository<TdUserReturn, Long>,
		JpaSpecificationExecutor<TdUserReturn> 
{
	TdUserReturn findByUsernameAndOrderNumberAndGoodsId(String username,String orderNumber, Long goodsId); //zhangji
    Page<TdUserReturn> findByStatusIdOrderByIdDesc(Long statusId, Pageable page);
    
    Page<TdUserReturn> findByUsernameContainingOrGoodsTitleContainingOrOrderNumberContainingOrderByIdDesc(String keywords1, String keywords2, String keywords3, Pageable page);
    
    Page<TdUserReturn> findByUsernameContainingAndStatusIdOrGoodsTitleContainingAndStatusIdOrOrderNumberContainingAndStatusIdOrderByIdDesc(String keywords1, 
            Long statusId1,
            String keywords2,
            Long statusId2,
            String keyword3,
            Long statusId3,
            Pageable page);
    
    List<TdUserReturn> findByUsernameOrderByIdDesc(String username);
    
    Page<TdUserReturn> findByUsernameOrderByIdDesc(String username, Pageable page);
    
    Page<TdUserReturn> findByUsernameAndGoodsTitleContainingOrderByIdDesc(String username, String keywords, Pageable page);
}
