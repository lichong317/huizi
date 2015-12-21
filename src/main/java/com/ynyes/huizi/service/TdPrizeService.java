package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdPrize;
import com.ynyes.huizi.repository.TdPrizeRepo;

@Service
@Transactional
public class TdPrizeService {
	
	@Autowired
    TdPrizeRepo repository;
	
	public List<TdPrize> findAll(){
		return (List<TdPrize>) repository.findAll();
	}

	public TdPrize findOne(Long id) {
		// TODO Auto-generated method stub
		if (null == id) {
			return null;
		}
		return repository.findOne(id);
	}

	public TdPrize save(TdPrize e) {
		// TODO Auto-generated method stub
		return repository.save(e);
	}	
	
	public List<TdPrize> save(List<TdPrize> entities)
    {
        
        return (List<TdPrize>) repository.save(entities);
    }
	
	public void delete(Long id) {
		// TODO Auto-generated method stub
		if (null != id)
	    {
	       repository.delete(id);
	    }
	}

	public void delete(TdPrize e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
	
	
	public Page<TdPrize> findAllOrderBySortId(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
		return repository.findAll(pageRequest);
	}
	
	public Page<TdPrize> findAll(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "id"));
		return repository.findAll(pageRequest);
	}
}
