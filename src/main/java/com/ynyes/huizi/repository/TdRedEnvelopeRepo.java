package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdRedEnvelope;

public interface TdRedEnvelopeRepo extends
PagingAndSortingRepository<TdRedEnvelope, Long>,
JpaSpecificationExecutor<TdRedEnvelope>{
	
	Page<TdRedEnvelope> findByUsername(String username, Pageable page);
	
	List<TdRedEnvelope> findByUsernameOrderBySendTimeDesc(String username);
	
	Page<TdRedEnvelope> findByUsernameAndIsGetFalse(String username, Pageable page);
	
	List<TdRedEnvelope> findByUsernameAndIsGetFalseOrderBySendTimeDesc(String username);
	
	Page<TdRedEnvelope> findByUsernameAndIsGetTrue(String username, Pageable page);
	
	List<TdRedEnvelope> findByUsernameAndIsGetTrueOrderBySendTimeDesc(String username);

}
