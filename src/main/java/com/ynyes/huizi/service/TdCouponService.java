package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.repository.TdCouponRepo;

/**
 * TdCoupon 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdCouponService {
    @Autowired
    TdCouponRepo repository;
    
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
    public void delete(TdCoupon e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdCoupon> entities)
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
    public TdCoupon findOne(Long id)
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
    public List<TdCoupon> findAll(Iterable<Long> ids)
    {
        return (List<TdCoupon>) repository.findAll(ids);
    }
    
    public Page<TdCoupon> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdCoupon save(TdCoupon e)
    {
        
        return repository.save(e);
    }
    
    public List<TdCoupon> save(List<TdCoupon> entities)
    {
        
        return (List<TdCoupon>) repository.save(entities);
    }
}
