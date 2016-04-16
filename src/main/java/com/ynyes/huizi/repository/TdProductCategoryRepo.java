package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdProductCategory;

/**
 * TdProductCategory 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdProductCategoryRepo
		extends PagingAndSortingRepository<TdProductCategory, Long>, JpaSpecificationExecutor<TdProductCategory> {
	List<TdProductCategory> findByParentIdIsNullAndIsEnableTrueOrderBySortIdAsc();

	List<TdProductCategory> findByParentIdAndIsEnableTrueOrderBySortIdAsc(Long parentId);

	List<TdProductCategory> findByParentIdIsNullOrderBySortIdAsc();

	List<TdProductCategory> findByParentIdOrderBySortIdAsc(Long parentId);

	TdProductCategory findByTitle(String title);

	TdProductCategory findTopByTitleContaining(String title);

	TdProductCategory findByTitleAndIdNot(String title, Long id);

	TdProductCategory findByparentTree(String parentTree);

	List<TdProductCategory> findByTitleContainingAndLayerCount(String keywords, Long layerCount);

	/**
	 * 根据父类id和本类标题查找分类
	 * 
	 * @author DengXiao
	 */
	TdProductCategory findByParentIdAndTitle(Long parentId, String title);
}
