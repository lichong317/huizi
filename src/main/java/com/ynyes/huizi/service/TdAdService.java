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

import com.ynyes.huizi.entity.TdAd;
import com.ynyes.huizi.repository.TdAdRepo;

/**
 * TdAd 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdAdService {
    
    @Autowired
    TdAdRepo repository;
    
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
    public void delete(TdAd e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdAd> entities)
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
    public TdAd findOne(Long id)
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
    public List<TdAd> findAll(Iterable<Long> ids)
    {
        return (List<TdAd>) repository.findAll(ids);
    }
    
    public List<TdAd> findAll()
    {
        return (List<TdAd>) repository.findAll();
    }
    
    public List<TdAd> findByTypeIdAndEndtimeAfter(Long typeId)
    {
        return repository.findByTypeIdAndEndTimeAfterOrderBySortIdAsc(typeId, new Date());
    }
    
    public Page<TdAd> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId").and(new Sort(Direction.DESC,"createTime")));
        
        return repository.findAll(pageRequest);
    }
    
    public List<TdAd> findAllOrderBySortIdAsc()
    {
        return (List<TdAd>) repository.findAll(new Sort(Direction.ASC, "sortId"));
    }
    
    public Page<TdAd> findByTypeIdOrderBySortIdAsc(Long typeId, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId").and(new Sort(Direction.DESC,"createTime")));
    	
    	return repository.findByTypeId(typeId, pageRequest);
    }
    
    public List<TdAd> findByTypeIdOrderBySortIdAsc(Long typeId){   	
    	
    	return repository.findByTypeId(typeId);
    }
    
    /**
	 * @author lc
	 * @注释：搜索广告
	 */
    public Page<TdAd> searchAll(String keywords, int page ,int size){
    	
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId").and(new Sort(Direction.DESC,"createTime")));
        
        return repository.findByTitleContainingOrSubtitleContaining(keywords, keywords, pageRequest);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdAd save(TdAd e)
    {
        if (null == e.getCreateTime())
        {
            e.setCreateTime(new Date());
        }
        
        return repository.save(e);
    }
    
    public List<TdAd> save(List<TdAd> entities)
    {
        
        return (List<TdAd>) repository.save(entities);
    }
}
