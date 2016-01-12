package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdAppMenu;

public interface TdAppMenuRepo extends
PagingAndSortingRepository<TdAppMenu, Long>,
JpaSpecificationExecutor<TdAppMenu>{
	List<TdAppMenu> findByIsEnableTrueOrderBySortIdAsc();
}
