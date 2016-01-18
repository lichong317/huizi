package com.ynyes.huizi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ynyes.huizi.entity.TdAppMenu;
import com.ynyes.huizi.entity.TdNaviBarItem;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.repository.TdAppMenuRepo;

@Service
@Transactional
public class TdAppMenuService {
	@Autowired
	TdAppMenuRepo repository;
	
	@Autowired
	TdSettingService tdSettingService;
	
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
    public void delete(TdAppMenu e)
    {
        if (null != e)
        {
            repository.delete(e);
        }
    }
    
    public void delete(List<TdAppMenu> entities)
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
    public TdAppMenu findOne(Long id)
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
    public List<TdAppMenu> findAll(Iterable<Long> ids)
    {
        return (List<TdAppMenu>) repository.findAll(ids);
    }
    
    public List<TdAppMenu> findAll()
    {
        return (List<TdAppMenu>) repository.findAll();
    }
    
    public Page<TdAppMenu> findAllOrderBySortIdAsc(int page, int size)
    {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(Direction.ASC, "sortId"));
        
        return repository.findAll(pageRequest);
    }
    
    public List<TdAppMenu> findAllOrderBySortIdAsc()
    {
        return (List<TdAppMenu>) repository.findAll(new Sort(Direction.ASC, "sortId"));
    }
    
    public List<TdAppMenu> findByIsEnableTrueOrderBySortIdAsc()
    {
        return repository.findByIsEnableTrueOrderBySortIdAsc();
    }
    
    /**
     * 保存
     * 
     * @param e
     * @return
     */
    public TdAppMenu save(TdAppMenu e)
    {
    	TdSetting tdSetting = tdSettingService.findTopBy();
    	
    	if (null != tdSetting ) {
			if (null != tdSetting.getUpdateNumber()) {
				tdSetting.setUpdateNumber(tdSetting.getUpdateNumber() + 1);
			}else {
				tdSetting.setUpdateNumber(0L);
			}
		}
    	
        return repository.save(e);
    }
    
    public List<TdAppMenu> save(List<TdAppMenu> entities)
    {
        
        return (List<TdAppMenu>) repository.save(entities);
    }
}
