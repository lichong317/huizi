package com.ynyes.huizi.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdMessage;

public interface TdMessageRepo extends
		PagingAndSortingRepository<TdMessage, Long>,
		JpaSpecificationExecutor<TdMessage> {
	Page<TdMessage> findByTypeId(Long typeId, Pageable page);
	
	Long countByTypeId(Long typeId);
}
