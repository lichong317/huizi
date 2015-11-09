package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdContrastGoods;

public interface TdContrastGoodsRepo extends
		PagingAndSortingRepository<TdContrastGoods, Long>,
		JpaSpecificationExecutor<TdContrastGoods>{
	
	List<TdContrastGoods> findByUsernameAndCategoryId(String username, Long categoryId);
	
	TdContrastGoods findTopByGoodsId(Long goodsId);
	
	List<TdContrastGoods> findByGoodsIdAndUsernameAndCategoryId(Long goodsId, String username, Long categoryId);
	
	List<TdContrastGoods> findByIsLoggedInFalse();
	
	List<TdContrastGoods> findByUsername(String username);
	
	List<TdContrastGoods> findByGoodsIdAndPriceAndUsername(Long goodsId, Double price, String username);
}
