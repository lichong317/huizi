package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdUserComplain;
import com.ynyes.huizi.repository.TdUserComplainRepo;

/**
 * TdUserConsult 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdUserComplainService {
    
    @Autowired
    TdUserComplainRepo repository;
    
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
    public void delete(TdUserComplain e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdUserComplain> entities)
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
    public TdUserComplain findOne(Long id)
    {
        if (null == id)
        {
            return null;
        }
        
        return repository.findOne(id);
    }
    
    /**
     * zhangji
     */
    public TdUserComplain findByUsernameAndOrderId(String username,Long orderId)
    {
        if (null == username||null == orderId)
        {
            return null;
        }
        return repository.findByUsernameAndOrderId(username,orderId);
    }
    
    public List<TdUserComplain> findAll(){
    	return (List<TdUserComplain>) repository.findAll();
    }
    
    /**
     * 查找
     * 
     * @param ids
     * @return
     */
    public List<TdUserComplain> findAll(Iterable<Long> ids)
    {
        return (List<TdUserComplain>) repository.findAll(ids);
    }
    
    public List<TdUserComplain> findByUsername(String username)
    {
        return repository.findByUsernameOrderByIdDesc(username);
    }
    
    public Page<TdUserComplain> findByUsername(String username, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameOrderByIdDesc(username, pageRequest);
    }
    
    public Page<TdUserComplain> findByGoodsIdAndIsShowable(Long goodsId, int page, int size)
    {
        if (null == goodsId)
        {
            return null;
        }
        
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByGoodsIdAndStatusIdOrderByIdDesc(goodsId, 1L, pageRequest);
    }
    
    public Page<TdUserComplain> findByUsernameAndSearch(String username, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndGoodsTitleContainingOrderByIdDesc(username, keywords, pageRequest);
    }
    
    public Page<TdUserComplain> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    public Page<TdUserComplain> findAllOrderByIdDesc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.DESC, "id"));
        
        return repository.findAll(pageRequest);
    }
    
    public Page<TdUserComplain> findByStatusIdOrderBySortIdAsc(Long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByStatusIdOrderBySortIdAsc(statusId, pageRequest);
    }
    
    public Page<TdUserComplain> findByStatusIdOrderByIdDesc(Long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByStatusIdOrderByIdDesc(statusId, pageRequest);
    }
    
    public Page<TdUserComplain> searchAndFindByStatusIdOrderBySortIdAsc(String keywords, Long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameContainingAndStatusIdOrGoodsTitleContainingAndStatusIdOrContentContainingAndStatusIdOrderBySortIdAsc(keywords, statusId, keywords, statusId, keywords, statusId, pageRequest);
    }
    
    public Page<TdUserComplain> searchAndFindByStatusIdOrderByIdDesc(String keywords, Long statusId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameContainingAndStatusIdOrGoodsTitleContainingAndStatusIdOrContentContainingAndStatusIdOrderByIdDesc(keywords, statusId, keywords, statusId, keywords, statusId, pageRequest);
    }
    
    public Page<TdUserComplain> searchAndOrderBySortIdAsc(String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameContainingOrGoodsTitleContainingOrContentContainingOrderBySortIdAsc(keywords, keywords, keywords, pageRequest);
    }
    
    public Page<TdUserComplain> searchAndOrderByIdDesc(String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameContainingOrGoodsTitleContainingOrContentContainingOrderByIdDesc(keywords, keywords, keywords, pageRequest);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdUserComplain save(TdUserComplain e)
    {
        
        return repository.save(e);
    }
    
    public List<TdUserComplain> save(List<TdUserComplain> entities)
    {
        
        return (List<TdUserComplain>) repository.save(entities);
    }
}
