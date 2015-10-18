package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdRedEnvelopeType;
import com.ynyes.huizi.repository.TdRedEnvelopeTypeRepo;

@Service
@Transactional
public class TdRedEnvelopeTypeService {
	@Autowired
	TdRedEnvelopeTypeRepo repository;

	public TdRedEnvelopeType findOne(Long id) {
		// TODO Auto-generated method stub
		if (null == id) {
			return null;
		}
		return repository.findOne(id);
	}
	
	public TdRedEnvelopeType save(TdRedEnvelopeType e) {
		// TODO Auto-generated method stub
		return repository.save(e);
	}	
	
	public List<TdRedEnvelopeType> save(List<TdRedEnvelopeType> entities)
    {
        
        return (List<TdRedEnvelopeType>) repository.save(entities);
    }
	
	public void delete(Long id) {
		// TODO Auto-generated method stub
		if (null != id)
	    {
	       repository.delete(id);
	    }
	}

	public void delete(TdRedEnvelopeType e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
	
	public Page<TdRedEnvelopeType> findAllOrderBySortId(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
		return repository.findAll(pageRequest);
	}
	
	public List<TdRedEnvelopeType> findAllOrderBySortId(){
		return (List<TdRedEnvelopeType>) repository.findAll(new Sort(
                Direction.ASC, "sortId"));
	}
}
