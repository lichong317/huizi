package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdUserWithdraw;
import com.ynyes.huizi.repository.TdUserWithdrawRepo;

@Service
@Transactional
public class TdUserWithdrawService {

	@Autowired
	TdUserWithdrawRepo repository;
	/**
     * 删除
     * 
     * @param id 菜单项ID
     */
    public void delete(Long id)
    {
        if (null != id)
        {
            repository.delete(id);
        }
    }
    
    /**
     * 删除
     * 
     * @param e 菜单项
     */
    public void delete(TdUserWithdraw e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdUserWithdraw> entities)
    {
        if (null != entities)
        {
            repository.delete(entities);
        }
    }
    
    /**
     * 查找
     * 
     * @param id ID
     * @return
     */
    public TdUserWithdraw findOne(Long id)
    {
        if (null == id)
        {
            return null;
        }
        
        return repository.findOne(id);
    }
    
    /**
     * 查找
     * 
     * @param ids
     * @return
     */
    public List<TdUserWithdraw> findAll(Iterable<Long> ids)
    {
        return (List<TdUserWithdraw>) repository.findAll(ids);
    }
    
    public List<TdUserWithdraw> findByUsername(String username)
    {
        return repository.findByUsername(username);
    }
    
    public Page<TdUserWithdraw> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    public Page<TdUserWithdraw> findByUsernameOrderByIdDesc(String username, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameOrderByIdDesc(username, pageRequest);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdUserWithdraw save(TdUserWithdraw e)
    {
        
        return repository.save(e);
    }
    
    public List<TdUserWithdraw> save(List<TdUserWithdraw> entities)
    {
        
        return (List<TdUserWithdraw>) repository.save(entities);
    }
}
