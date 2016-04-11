package com.ynyes.huizi.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdMessage;
import com.ynyes.huizi.repository.TdMessageRepo;

@Service
@Transactional
public class TdMessageService {
    @Autowired
    TdMessageRepo repository;
    
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
    public void delete(TdMessage e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdMessage> entities)
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
    public TdMessage findOne(Long id)
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
    public List<TdMessage> findAll(Iterable<Long> ids)
    {
        return (List<TdMessage>) repository.findAll(ids);
    }
    
    public List<TdMessage> findAll()
    {
        return (List<TdMessage>) repository.findAll();
    }
    
    public Page<TdMessage> findAll(int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
    	
    	return repository.findAll(pageRequest);
    }
    
    public Page<TdMessage> findByTypeId(Long typeId, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));
    	return repository.findByTypeId(typeId, pageRequest);
    }
    
    
    // 计数
    public Long countBytypeId(Long typeId){
    	return repository.countByTypeId(typeId);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdMessage save(TdMessage e)
    {
    	if (null == e) {
			return null ;
		}
    	
        if (null == e.getCreateTime())
        {
            e.setCreateTime(new Date());
        }
        
        // 设置简介
        if (null == e.getBrief() && !"".equals(e.getBrief()))
        {
            if (null != e.getContent() && e.getContent().length() > 0)
            {
                String brief = e.getContent().substring(0, 
                        e.getContent().length() > 254 ? 254 : e.getContent().length());
                e.setBrief(brief);
            }
        }
        
        return repository.save(e);
    }
    
    public List<TdMessage> save(List<TdMessage> entities)
    {
        
        return (List<TdMessage>) repository.save(entities);
    }
}
