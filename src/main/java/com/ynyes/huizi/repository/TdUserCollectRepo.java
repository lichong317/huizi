package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdUserCollect;

/**
 * TdUserCollect 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdUserCollectRepo extends
		PagingAndSortingRepository<TdUserCollect, Long>,
		JpaSpecificationExecutor<TdUserCollect> 
{
    Page<TdUserCollect> findByUsernameOrderByIdDesc(String username, Pageable page);
    
    Page<TdUserCollect> findByUsernameAndGoodsTitleContainingOrderByIdDesc(String username, String keywords, Pageable page);
    
    List<TdUserCollect> findByUsername(String username);
    
    TdUserCollect findByUsernameAndGoodsId(String username, Long goodsId);
    
    Long countByGoodsId(Long goodsId);
    
    // 商品关注
    List<TdUserCollect> findByGoodsId(Long goodsId);
}
