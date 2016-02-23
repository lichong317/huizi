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

import com.ynyes.huizi.entity.TdGoods;
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
    
    /**
	 * @author lc
	 * @注释：查询所有积分商品
	 */
    public Page<TdPointGoods> findAllOrderBySortIdAsc(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));

        return repository.findAll(pageRequest);
    }
    
    /**
	 * @author lc
	 * @注释：所有上架积分商品
	 */
    public Page<TdPointGoods> findByIsOnsaleTrueOrderBySortIdAsc(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));

        return repository.findByIsOnSaleTrue(pageRequest);
    }
    
    /**
	 * @author lc
	 * @注释：所有下架积分商品
	 */
    public Page<TdPointGoods> findByIsOnsaleFalseOrderBySortIdAsc(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));

        return repository.findByIsOnSaleFalse(pageRequest);
    }
    
    /**
	 * @author lc
	 * @注释：搜索所有积分商品
	 */
    public Page<TdPointGoods> searchIsOnsaleTrueAndOrderBySortIdAsc(String keywords, int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByTitleContainingOrSubTitleContainingOrDetailContainingOrderBySortIdAsc(
                        keywords, keywords, keywords, pageRequest);
    }
    
    /**
	 * @author lc
	 * @注释：搜索所有上架积分商品
	 */
    public Page<TdPointGoods> searchIsOnsaleFalseAndOrderBySortIdAsc(String keywords, int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByTitleContainingAndIsOnSaleTrueOrSubTitleContainingAndIsOnSaleTrueOrDetailContainingAndIsOnSaleTrueOrderBySortIdAsc(
                        keywords, keywords, keywords, pageRequest);
    }
    
    /**
	 * @author lc
	 * @注释：搜索所有下架积分商品
	 */
    public Page<TdPointGoods> searchAndOrderBySortIdAsc(String keywords, int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByTitleContainingAndIsOnSaleFalseOrSubTitleContainingAndIsOnSaleFalseOrDetailContainingAndIsOnSaleFalseOrderBySortIdAsc(
                        keywords, keywords, keywords, pageRequest);
    }
}
