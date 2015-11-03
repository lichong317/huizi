package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.repository.TdShippingAddressRepo;

import scala.xml.dtd.PublicID;

/**
 * TdShippingAddress 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdShippingAddressService {
    
    @Autowired
    TdShippingAddressRepo repository;
    
    // 查找所有货到付款地区
    public List<TdShippingAddress> findByIsCod(){
    	return repository.findByIsCodTrueOrderByIdDesc();
    }
    
    public Page<TdShippingAddress> findByIsCod(int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.DESC, "Id"));
    	return repository.findByIsCodTrue(pageRequest);
    }
    
    // 搜索地区
    public Page<TdShippingAddress> searchBykeywords(String keywords, int page, int size){
    	PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.DESC, "Id"));
    	
    	return repository.findByCountryContainingAndIsCodTrueOrProvinceContainingAndIsCodTrueOrCityContainingAndIsCodTrueOrDisctrictContainingAndIsCodTrue(keywords, keywords, keywords, keywords, pageRequest);
    }
    
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
    public void delete(TdShippingAddress e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdShippingAddress> entities)
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
    public TdShippingAddress findOne(Long id)
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
    public List<TdShippingAddress> findAll(Iterable<Long> ids)
    {
        return (List<TdShippingAddress>) repository.findAll(ids);
    }
    
    public List<TdShippingAddress> findAll()
    {
        return (List<TdShippingAddress>) repository.findAll();
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdShippingAddress save(TdShippingAddress e)
    {
        
        return repository.save(e);
    }
    
    public List<TdShippingAddress> save(List<TdShippingAddress> entities)
    {
        
        return (List<TdShippingAddress>) repository.save(entities);
    }
}
