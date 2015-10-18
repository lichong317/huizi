package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdPrize;


public interface TdPrizeRepo extends
		PagingAndSortingRepository<TdPrize, Long>,
		JpaSpecificationExecutor<TdPrize> {
		  
}
