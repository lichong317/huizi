package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdShippingAddress;

/**
 * TdShippingAddress 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdShippingAddressRepo extends
		PagingAndSortingRepository<TdShippingAddress, Long>,
		JpaSpecificationExecutor<TdShippingAddress> 
{
	List<TdShippingAddress> findByIsCodTrueOrderByIdDesc();
	
	Page<TdShippingAddress> findByIsCodTrue(Pageable pageable);
	
	Page<TdShippingAddress> findByCountryContainingAndIsCodTrueOrProvinceContainingAndIsCodTrueOrCityContainingAndIsCodTrueOrDisctrictContainingAndIsCodTrue(String keywords,String keywords1,String keywords2,String keywords3,Pageable pageable);
}
