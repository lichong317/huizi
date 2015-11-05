package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdContrastGoods;
import com.ynyes.huizi.repository.TdContrastGoodsRepo;

@Service
@Transactional
public class TdContrastGoodsService {
	@Autowired
    TdGoodsService tdGoodsService;
	
	@Autowired
	TdContrastGoodsRepo repository;
	
	/*******信息查找部分*********/
	public List<TdContrastGoods> findAll()
	{
		return (List<TdContrastGoods>) repository.findAll();
	}	
	
	public TdContrastGoods findByGoodsId(Long goodsId){
		return repository.findTopByGoodsId(goodsId);
	}
	
	public List<TdContrastGoods> findByUsernameAndCategoryId(String username, Long categoryId)
	{
		return repository.findByUsernameAndCategoryId(username, categoryId);
	}
	
	public List<TdContrastGoods> findByGoodsIdAndPriceAndUsername(long goodsId, double price, String username)
	{
	    return repository.findByGoodsIdAndPriceAndUsername(goodsId, price, username);
	}
	
	public List<TdContrastGoods> findByUsername(String username){
		return repository.findByUsername(username);
	}
	
	public List<TdContrastGoods> findByisLoggedInFalse(){
    	return repository.findByIsLoggedInFalse();
    }
	
	public TdContrastGoods save(TdContrastGoods e)
	{
		return repository.save(e);
	}
	
	public List<TdContrastGoods> save(List<TdContrastGoods> entities)
	{
		return (List<TdContrastGoods>) repository.save(entities);
	}
	
	public void delete(Long id)
    {
        if (null != id)
        {
            repository.delete(id);
        }
    }
    
    public void delete(Iterable<TdContrastGoods> entities)
    {
        repository.delete(entities);
    }
    
    public void delete(TdContrastGoods e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdContrastGoods> entities)
    {
        if (null != entities)
        {
            repository.delete(entities);
        }
    }
    
    public TdContrastGoods findOne(Long id)
    {
        if (null == id)
        {
            return null;
        }
        
        return repository.findOne(id);
    }
}
