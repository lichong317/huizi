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
import com.ynyes.huizi.entity.TdPrizeCategory;
import com.ynyes.huizi.repository.TdPrizeCategoryRepo;

@Service
@Transactional
public class TdPrizeCategoryService {
	
	@Autowired
	TdPrizeCategoryRepo repository;

	public TdPrizeCategory findOne(Long id) {
		// TODO Auto-generated method stub
		if (null == id) {
			return null;
		}
		return repository.findOne(id);
	}
	
	public TdPrizeCategory save(TdPrizeCategory e) {
		// TODO Auto-generated method stub
		return repository.save(e);
	}	
	
	public List<TdPrizeCategory> save(List<TdPrizeCategory> entities)
    {
        
        return (List<TdPrizeCategory>) repository.save(entities);
    }
	
	public void delete(Long id) {
		// TODO Auto-generated method stub
		if (null != id)
	    {
	       repository.delete(id);
	    }
	}

	public void delete(TdPrizeCategory e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
	
	public Page<TdPrizeCategory> findAllOrderBySortId(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
		return repository.findAll(pageRequest);
	}
	
	public List<TdPrizeCategory> findAllOrderBySortId(){
		return (List<TdPrizeCategory>) repository.findAll(new Sort(
                Direction.ASC, "sortId"));
	}
}
