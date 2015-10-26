package com.ynyes.huizi.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.repository.TdRedEnvelopeRepo;

@Service
@Transactional
public class TdRedEnvelopeService {
	@Autowired
    TdRedEnvelopeRepo repository;
	
	public List<TdRedEnvelope> findAll(){
		return (List<TdRedEnvelope>) repository.findAll();
	}

	public TdRedEnvelope findOne(Long id) {
		// TODO Auto-generated method stub
		if (null == id) {
			return null;
		}
		return repository.findOne(id);
	}

	public TdRedEnvelope save(TdRedEnvelope e) {
		// TODO Auto-generated method stub
		return repository.save(e);
	}	
	
	public List<TdRedEnvelope> save(List<TdRedEnvelope> entities)
    {
        
        return (List<TdRedEnvelope>) repository.save(entities);
    }
	
	public void delete(Long id) {
		// TODO Auto-generated method stub
		if (null != id)
	    {
	       repository.delete(id);
	    }
	}

	public void delete(TdRedEnvelope e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
	
	
	public Page<TdRedEnvelope> findAllOrderBySortId(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
		return repository.findAll(pageRequest);
	}
	
	public Page<TdRedEnvelope> findAll(int page, int size){
		
		PageRequest pageRequest = new PageRequest(page, size);
		return repository.findAll(pageRequest);
	}
	
	public Page<TdRedEnvelope> findByUsername(String username, int page, int size){
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "sendTime"));
		return repository.findByUsername(username, pageRequest);
	}
	
	public List<TdRedEnvelope> findByUsername(String username){
		return repository.findByUsernameOrderBySendTimeDesc(username);
	}
	
	public Page<TdRedEnvelope> findByUsernameAndIsGetFalse(String username, int page, int size){
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "sendTime"));
		return repository.findByUsernameAndIsGetFalse(username, pageRequest);
	}
	
	public List<TdRedEnvelope> findByUsernameAndIsGetFalse(String username){
		return repository.findByUsernameAndIsGetFalseOrderBySendTimeDesc(username);
	}
	
	public Page<TdRedEnvelope> findByUsernameAndIsGetTrue(String username, int page, int size){
		PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "sendTime"));
		return repository.findByUsernameAndIsGetTrue(username, pageRequest);
	}
	
	public List<TdRedEnvelope> findByUsernameAndIsGetTrue(String username){
		return repository.findByUsernameAndIsGetTrueOrderBySendTimeDesc(username);
	}
}
