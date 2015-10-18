package com.ynyes.huizi.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdRedEnvelope;

public interface TdRedEnvelopeRepo extends
PagingAndSortingRepository<TdRedEnvelope, Long>,
JpaSpecificationExecutor<TdRedEnvelope>{

}
