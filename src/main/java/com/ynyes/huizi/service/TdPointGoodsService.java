package com.ynyes.huizi.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdPointGoods;
import com.ynyes.huizi.repository.TdPointGoodsRepo;

@Service
@Transactional
public class TdPointGoodsService {
    @Autowired
    TdPointGoodsRepo repository;
    
    /**
	 * @author lc
	 * @注释：基本增删改查
	 */
    
    public TdPointGoods findOne(Long id){
    	return repository.findOne(id);
    }
    
    public List<TdPointGoods> findAll(){
    	return (List<TdPointGoods>) repository.findAll();
    }
    
    public void delete(Long id) {
        if (null != id) {
            repository.delete(id);
        }
    }

    public void delete(TdPointGoods e) {
        if (null != e) {
            repository.delete(e);
        }
    }
    
    public TdPointGoods save(TdPointGoods e, String manager){
    	if (null == e) {
			return null;
		}
    	
    	//兑换积分
    	if (null == e.getPointUse()) {
			e.setPointUse(0L);
		}
    	
        // 创建时间
        if (null == e.getCreateTime()) {
            e.setCreateTime(new Date());
        }

        // 上架时间
        if (null == e.getOnSaleTime() && e.getIsOnSale()) {
            e.setOnSaleTime(new Date());
        }
    	
    	e = repository.save(e);
    	
    	return e;
    }
    
    /**
	 * @author lc
	 * @注释：查找上架积分商品
	 */
    public TdPointGoods findOneAndIsOnsaleTrue(Long id){
    	return repository.findByIdAndIsOnSaleTrue(id);
    }
    
    
}
