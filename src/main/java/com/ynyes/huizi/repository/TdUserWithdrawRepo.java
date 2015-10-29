package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdUserWithdraw;

public interface TdUserWithdrawRepo extends
PagingAndSortingRepository<TdUserWithdraw, Long>,
JpaSpecificationExecutor<TdUserWithdraw>{
	Page<TdUserWithdraw> findByUsernameOrderByIdDesc(String username, Pageable page);
    
    List<TdUserWithdraw> findByUsername(String username);
}
