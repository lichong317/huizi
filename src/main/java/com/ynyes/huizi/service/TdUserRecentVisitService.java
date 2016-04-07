package com.ynyes.huizi.service;

import java.text.SimpleDateFormat;
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
import com.ynyes.huizi.entity.TdUserRecentVisit;
import com.ynyes.huizi.repository.TdUserRecentVisitRepo;

/**
 * TdUserRecentVisit 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdUserRecentVisitService {
    
    @Autowired
    TdUserRecentVisitRepo repository;
    
    @Autowired
    TdGoodsService tdGoodsService;
    
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
    public void delete(TdUserRecentVisit e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdUserRecentVisit> entities)
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
    public TdUserRecentVisit findOne(Long id)
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
    public List<TdUserRecentVisit> findAll(Iterable<Long> ids)
    {
        return (List<TdUserRecentVisit>) repository.findAll(ids);
    }
    
    public List<TdUserRecentVisit> findByUsername(String username)
    {
        return repository.findByUsername(username);
    }
    //zhangji
    public List<TdUserRecentVisit> findByUsernameOrderByVisitCountDesc(String username)
    {
    	return repository.findByUsernameOrderByVisitCountDesc(username);
    }
    
    public Page<TdUserRecentVisit> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    //zhangji
    public List<TdUserRecentVisit> findByUsernameAndVisitDate(String username,String visitDate)
    {
        return repository.findByUsernameAndVisitDate(username,visitDate);
    }
    
    public Page<TdUserRecentVisit> findByUsernameOrderByVisitTimeDesc(String username, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameOrderByVisitTimeDesc(username, pageRequest);
    }
    
    public Page<TdUserRecentVisit> findByUsernameAndSearchOrderByVisitTimeDesc(String username, String keywords, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        return repository.findByUsernameAndGoodsTitleContainingOrderByVisitTimeDesc(username, keywords, pageRequest);
    }
    //zhangji
    public TdUserRecentVisit findByUsernameAndGoodsId(String username,Long goodsId)
    {
        if (null == username || null == goodsId)
        {
            return null;
        }
    	return repository.findByUsernameAndGoodsId(username,goodsId);
    }
    public Page<TdUserRecentVisit> findByUsernameAndCategoryIdOrderByVisitTimeDesc(String username, Long categoryId, int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size);
        
        String catIdStr = "[" + categoryId + "]";
        
        return repository.findByUsernameAndCategoryIdTreeContainingOrderByVisitTimeDesc(username, catIdStr, pageRequest);
    }
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdUserRecentVisit save(TdUserRecentVisit e)
    {
        
        return repository.save(e);
    }
    
    public TdUserRecentVisit addNew(String username, Long goodsId)
    {
        if (null == username || null == goodsId)
        {
            return null;
        }
        
        TdUserRecentVisit recent = repository.findByUsernameAndGoodsId(username, goodsId);
//        
//        if (null == recent)
//        {
            TdGoods goods = tdGoodsService.findOne(goodsId);
            
            if (null == goods)
            {
                return null;
            }
            Date date = new Date();
            recent = new TdUserRecentVisit();
            recent.setUsername(username);
            recent.setGoodsId(goodsId);
            recent.setGoodsCoverImageUri(goods.getCoverImageUri());
            recent.setGoodsSalePrice(goods.getSalePrice());
            recent.setGoodsTitle(goods.getTitle());
            recent.setVisitTime(date);
            recent.setVisitCount(1L);
            recent.setSoldNumber(goods.getSoldNumber());
            recent.setCategoryId(goods.getCategoryId());
            recent.setCategoryIdTree(goods.getCategoryIdTree());
            //Date转换为String格式 zhangji
            SimpleDateFormat sdf =  new 	SimpleDateFormat("yyyy-MM-dd");
            String visitDate = sdf.format(date);
            recent.setVisitDate(visitDate);
//        }
//        else
//        {
//            recent.setVisitTime(new Date());
//        }
//        
        return repository.save(recent);
    }
    
    public List<TdUserRecentVisit> save(List<TdUserRecentVisit> entities)
    {
        
        return (List<TdUserRecentVisit>) repository.save(entities);
    }
}
