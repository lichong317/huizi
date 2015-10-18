package com.ynyes.huizi.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdArticleCategory;
import com.ynyes.huizi.entity.TdPrizeCategory;

public interface TdPrizeCategoryRepo extends
			PagingAndSortingRepository<TdPrizeCategory, Long>,
			JpaSpecificationExecutor<TdPrizeCategory> {
	
	
}
