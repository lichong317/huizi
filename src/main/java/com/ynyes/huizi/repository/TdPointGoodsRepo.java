package com.ynyes.huizi.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdPointGoods;

public interface TdPointGoodsRepo extends
PagingAndSortingRepository<TdPointGoods, Long>,
JpaSpecificationExecutor<TdPointGoods>{
	TdPointGoods findByIdAndIsOnSaleTrue(Long id);
	
	Page<TdPointGoods> findByIsOnSaleTrue(Pageable page);
	
	Page<TdPointGoods> findByIsOnSaleFalse(Pageable page);
	
	Page<TdPointGoods> findByTitleContainingOrSubTitleContainingOrDetailContainingOrderBySortIdAsc(String keywords1, String keywords2, String keywords3, Pageable page);
	
	Page<TdPointGoods> findByTitleContainingAndIsOnSaleTrueOrSubTitleContainingAndIsOnSaleTrueOrDetailContainingAndIsOnSaleTrueOrderBySortIdAsc(String keywords1, String keywords2, String keywords3, Pageable page);
	
	Page<TdPointGoods> findByTitleContainingAndIsOnSaleFalseOrSubTitleContainingAndIsOnSaleFalseOrDetailContainingAndIsOnSaleFalseOrderBySortIdAsc(String keywords1, String keywords2, String keywords3, Pageable page);
}
