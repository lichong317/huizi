package com.ynyes.huizi.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdPrize;


public interface TdPrizeRepo extends
		PagingAndSortingRepository<TdPrize, Long>,
		JpaSpecificationExecutor<TdPrize> {
		
	Page<TdPrize> findByUsername(String username, Pageable pageable);
}
