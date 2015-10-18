package com.ynyes.huizi.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdRedEnvelopeType;

public interface TdRedEnvelopeTypeRepo extends
PagingAndSortingRepository<TdRedEnvelopeType, Long>,
JpaSpecificationExecutor<TdRedEnvelopeType>{

}
