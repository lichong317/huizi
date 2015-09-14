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

import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.repository.TdOrderRepo;

/**
 * TdOrder 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdOrderService {
    @Autowired
    TdOrderRepo repository;
    
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
    public void delete(TdOrder e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdOrder> entities)
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
    public TdOrder findOne(Long id)
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
    public List<TdOrder> findAll(Iterable<Long> ids)
    {
        return (List<TdOrder>) repository.findAll(ids);
    }
    
    public List<TdOrder> findAll()
    {
        return (List<TdOrder>) repository.findAll();
    }
    
    public Page<TdOrder> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    public Page<TdOrder> findAllOrderByIdDesc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.DESC, "id"));
        
        return repository.findAll(pageRequest);
    }
    
    public Page<TdOrder> findByStatusIdOrderByIdDesc(long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByStatusIdOrderByIdDesc(statusId, pageRequest);
    }
    
    public Page<TdOrder> findByUsername(String username, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameOrderByIdDesc(username, pageRequest);
    }
    //zhangji
    public Page<TdOrder> findByUsernameAndStatusIdOrStatusIdOrStatusIdOrStatusId(String username,Long statusId1,Long statusId2,Long statusId3,Long statusId4,Integer page, int size)
    {
    	 PageRequest pageRequest = new PageRequest(page, size);
    	 return repository.findByUsernameAndStatusIdOrStatusIdOrStatusIdOrStatusId(username,3L,4L,6L,7L,pageRequest);
    }
    
    public TdOrder findByOrderNumber(String orderNumber)
    {
        return repository.findByOrderNumber(orderNumber);
    }
    
    public Page<TdOrder> findByUsernameAndTimeAfter(String username, Date time, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndOrderTimeAfterOrderByIdDesc(username, time, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndTimeAfterAndSearch(String username, Date time, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndOrderTimeAfterAndOrderNumberContainingOrderByIdDesc(username, time, keywords, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndSearch(String username, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndOrderNumberContainingOrderByIdDesc(username, keywords, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndStatusId(String username, long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndStatusIdOrderByIdDesc(username, statusId, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndStatusIdAndSearch(String username, long statusId, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndStatusIdAndOrderNumberContainingOrderByIdDesc(username, statusId, keywords, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndStatusIdAndTimeAfter(String username, long statusId, Date time, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndStatusIdAndOrderTimeAfterOrderByIdDesc(username, statusId, time, pageRequest);
    }
    
    public Page<TdOrder> findByUsernameAndStatusIdAndTimeAfterAndSearch(String username, long statusId, Date time, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndStatusIdAndOrderTimeAfterAndOrderNumberContainingOrderByIdDesc(username, statusId, time, keywords, pageRequest);
    }
    
    public Long countByUsernameAndStatusId(String username, long statusId)
    {
        return repository.countByUsernameAndStatusId(username, statusId);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdOrder save(TdOrder e)
    {
        
        return repository.save(e);
    }
    
    public List<TdOrder> save(List<TdOrder> entities)
    {
        
        return (List<TdOrder>) repository.save(entities);
    }
}
