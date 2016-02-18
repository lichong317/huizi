package com.ynyes.huizi.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdPointGoods;

public interface TdPointGoodsRepo extends
PagingAndSortingRepository<TdPointGoods, Long>,
JpaSpecificationExecutor<TdPointGoods>{
	TdPointGoods findByIdAndIsOnSaleTrue(Long id);
}
