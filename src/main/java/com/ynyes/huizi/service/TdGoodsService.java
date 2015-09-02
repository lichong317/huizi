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

import com.ynyes.huizi.entity.TdBrand;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdGoodsCombination;
import com.ynyes.huizi.entity.TdGoodsGift;
import com.ynyes.huizi.entity.TdGoodsParameter;
import com.ynyes.huizi.entity.TdPriceChangeLog;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdWarehouse;
import com.ynyes.huizi.repository.TdGoodsRepo;

/**
 * TdGoods 服务类
 * 
 * @author Sharon
 *
 */

@Service
@Transactional
public class TdGoodsService {
    @Autowired
    TdGoodsRepo repository;

    @Autowired
    TdProductCategoryService tdProductCategoryService;

    @Autowired
    TdBrandService tdBrandService;

    @Autowired
    TdArticleService tdArticleService;

    @Autowired
    TdParameterService tdParameterService;

    @Autowired
    TdGoodsParameterService tdGoodsParameterService;

    @Autowired
    TdWarehouseService tdWarehouseService;

    @Autowired
    TdGoodsGiftService tdGoodsGiftService;

    @Autowired
    TdGoodsCombinationService tdGoodsCombinationService;

    @Autowired
    TdPriceChangeLogService tdPriceChangeLogService;

    /**
     * 查找所有商品
     * 
     * @param page
     * @param size
     * @return
     */
    public Page<TdGoods> findAll(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository.findAll(pageRequest);
    }

    public Page<TdGoods> findAllOrderBySortIdAsc(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));

        return repository.findAll(pageRequest);
    }
    
    public Page<TdGoods> findByIsOnSaleTrueOrderBySortIdAsc(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "sortId"));

        return repository.findByIsOnSaleTrue(pageRequest);
    }

    public Page<TdGoods> findAllAndIsOnSaleTrue(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository.findByIsOnSaleTrue(pageRequest);
    }

    public List<TdGoods> findTop10ByIsOnSaleTrueOrderBySoldNumberDesc() {
        return repository.findTop10ByIsOnSaleTrueOrderBySoldNumberDesc();
    }

    public Page<TdGoods> searchAndOrderBySortIdAsc(String keywords, int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByTitleContainingOrSubTitleContainingOrDetailContainingOrderBySortIdAsc(
                        keywords, keywords, keywords, pageRequest);
    }
    
    public Page<TdGoods> searchAndIsOnSaleTrueOrderBySortIdAsc(String keywords, int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByTitleContainingOrSubTitleContainingOrDetailContainingAndIsOnSaleTrueOrderBySortIdAsc(
                        keywords, keywords, keywords, pageRequest);
    }

    public Page<TdGoods> searchAndFindByCategoryIdOrderBySortIdAsc(
            String keywords, Long categoryId, int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        String catIdStr = "[" + categoryId + "]";

        return repository
                .findByCategoryIdTreeContainingAndTitleContainingOrCategoryIdTreeContainingAndSubTitleContainingOrCategoryIdTreeContainingAndDetailContainingOrderBySortIdAsc(
                        catIdStr, keywords, catIdStr, keywords, catIdStr,
                        keywords, pageRequest);
    }
    
    public Page<TdGoods> searchAndFindByCategoryIdAndIsOnSaleTrueOrderBySortIdAsc(
            String keywords, Long categoryId, int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        String catIdStr = "[" + categoryId + "]";

        return repository
                .findByCategoryIdTreeContainingAndTitleContainingAndIsOnSaleTrueOrCategoryIdTreeContainingAndSubTitleContainingAndIsOnSaleTrueOrCategoryIdTreeContainingAndDetailContainingAndIsOnSaleTrueOrderBySortIdAsc(
                        catIdStr, keywords, catIdStr, keywords, catIdStr,
                        keywords, pageRequest);
    }

    public List<TdGoods> findByIdAndIsOnSaleTrue(Iterable<Long> ids) {
        return repository.findByIdAndIsOnSaleTrue(ids);
    }

    /**
     * 按类型查找所有商品
     * 
     * @param page
     * @param size
     * @return
     */
    public Page<TdGoods> findByReturnPriceNotZeroAndIsOnSaleTrue(int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository.findByReturnPriceNotAndIsOnSaleTrue(0.0, pageRequest);
    }

    public Page<TdGoods> findByReturnPriceNotZeroAndSearchAndIsOnSaleTrue(
            int page, int size, String keywords) {
        if (null == keywords) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByReturnPriceNotAndTitleContainingAndIsOnSaleTrue(0.0,
                        keywords, pageRequest);
    }

    public Page<TdGoods> findByIsGroupSaleTrueAndGroupSaleStopTimeAfterAndIsOnSaleTrue(
            int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsGroupSaleTrueAndGroupSaleStopTimeAfterAndIsOnSaleTrueOrderByGroupSaleStartTimeAsc(
                        new Date(), pageRequest);
    }

    public Page<TdGoods> findByIsGroupSaleTrueAndGroupSaleStartTimeBeforeAndGroupSaleStopTimeAfterAndIsOnSaleTrue(
            int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsGroupSaleTrueAndGroupSaleStopTimeAfterAndGroupSaleStartTimeBeforeAndIsOnSaleTrueOrderByGroupSaleStartTimeAsc(
                        new Date(), new Date(), pageRequest);
    }

    public Page<TdGoods> findByIsGroupSaleTrueAndGroupSaleStartTimeAfterAndGroupSaleStopTimeAfterAndIsOnSaleTrue(
            int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsGroupSaleTrueAndGroupSaleStopTimeAfterAndGroupSaleStartTimeAfterAndIsOnSaleTrueOrderByGroupSaleStartTimeAsc(
                        new Date(), new Date(), pageRequest);
    }

    public Page<TdGoods> findByIsGroupSaleTrueAndIsOnSaleTrue(int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsGroupSaleTrueAndIsOnSaleTrueOrderByGroupSaleStartTimeAsc(pageRequest);
    }

    public Page<TdGoods> findByCategoryIdTreeContainingOrderBySortIdAsc(
            Long catId, int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        String catIdStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingOrderBySortIdAsc(
                        catIdStr, pageRequest);
    }
    
    public Page<TdGoods> findByCategoryIdTreeContainingAndIsOnSaleTrueOrderBySortIdAsc(
            Long catId, int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        String catIdStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingAndIsOnSaleTrueOrderBySortIdAsc(
                        catIdStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndIsOnSaleTrue(Long catId, int page,
            int size) {
        if (null == catId) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        String catStr = "[" + catId + "]";

        return repository.findByCategoryIdTreeContainingAndIsOnSaleTrue(catStr,
                pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(
            Long catId, int page, int size) {
        if (null == catId) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        String catStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingAndIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(
                        catStr, pageRequest);
    }

    public Page<TdGoods> findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(
            int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndIsRecommendIndexTrueAndIsOnSaleTrueOrderByIdDesc(
            Long catId, int page, int size) {
        if (null == catId) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        String catStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingAndIsRecommendIndexTrueAndIsOnSaleTrueOrderByIdDesc(
                        catStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndIsOnSaleTrueOrderBySoldNumberDesc(
            Long catId, int page, int size) {
        if (null == catId) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        String catStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingAndIsOnSaleTrueOrderBySoldNumberDesc(
                        catStr, pageRequest);
    }
    
    public Page<TdGoods> findByCategoryIdAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            Long catId, int page, int size) {
        if (null == catId) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size);

        String catStr = "[" + catId + "]";

        return repository
                .findByCategoryIdTreeContainingAndIsOnSaleTrueOrderByOnSaleTimeDesc(
                        catStr, pageRequest);
    }

    public Page<TdGoods> findByIsOnSaleTrueOrderBySoldNumberDesc(int page,
            int size) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        return repository.findByIsOnSaleTrue(pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    // 无价格区间
    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndLeftNumberGreaterThanZeroAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndLeftNumberGreaterThanAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, 0L, paramStr, pageRequest);
    }

    // 显示有货和无货商品
    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> searchGoods(String keywords, int page, int size) {
        if (null == keywords) {
            return null;
        }

        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "id"));

        return repository
                .findByTitleContainingAndIsOnSaleTrueOrSubTitleContainingAndIsOnSaleTrueOrParamValueCollectContainingAndIsOnSaleTrueOrDetailContainingAndIsOnSaleTrue(
                        keywords, keywords, keywords, keywords, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, double priceLow, double priceHigh, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", priceLow, priceHigh, paramStr,
                        pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndSalePriceBetweenAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, long brandId, double priceLow, double priceHigh,
            int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndSalePriceBetweenAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, priceLow, priceHigh,
                        paramStr, pageRequest);
    }

    // 无价格区间
    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, int page, int size, List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderBySoldNumberDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "soldNumber"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderBySalePriceAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderBySalePriceDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "salePrice"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeAsc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.ASC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public Page<TdGoods> findByCategoryIdAndBrandIdAndParamsLikeAndIsOnSaleTrueOrderByOnSaleTimeDesc(
            long catId, long brandId, int page, int size,
            List<String> paramValueList) {
        PageRequest pageRequest = new PageRequest(page, size, new Sort(
                Direction.DESC, "onSaleTime"));

        String paramStr = "%";

        for (int i = 0; i < paramValueList.size(); i++) {
            String value = paramValueList.get(i);
            if (!"".equals(value)) {
                paramStr += value;
                paramStr += "%";
            }
        }

        return repository
                .findByCategoryIdTreeContainingAndBrandIdAndParamValueCollectLikeAndIsOnSaleTrue(
                        "[" + catId + "]", brandId, paramStr, pageRequest);
    }

    public List<TdGoods> findByProductIdAndIsOnSaleTrue(Long productId) {
        if (null == productId) {
            return null;
        }

        return repository.findByProductIdAndIsOnSaleTrue(productId);
    }
    /**
	 * @author lc
	 * @注释：所有秒杀商品
	 */
    public Page<TdGoods> findByFlashSaleAllOrderByFlashSaleStartTimeAsc(
            int page, int size) {
        PageRequest pageRequest = new PageRequest(page, size);

        return repository
                .findByIsFlashSaleTrueAndIsOnSaleTrueOrderByFlashSaleStartTimeAsc(pageRequest);
    }
    /**
     * 删除
     * 
     * @param id
     *            菜单项ID
     */
    public void delete(Long id) {
        if (null != id) {
            repository.delete(id);
        }
    }

    /**
     * 删除
     * 
     * @param e
     *            菜单项
     */
    public void delete(TdGoods e) {
        if (null != e) {
            repository.delete(e);
        }
    }

    /**
     * 查找
     * 
     * @param id
     *            ID
     * @return
     */
    public TdGoods findOne(Long id) {
        if (null == id) {
            return null;
        }

        return repository.findOne(id);
    }

    /**
     * 保存类型
     * 
     * @param e
     * @return
     */
    public TdGoods save(TdGoods e, String manager) {
        if (null == e) {
            return null;
        }

        // 参数类型ID
        Long paramCategoryId = null;

        // 保存分类名称
        if (null != e.getCategoryId()) {
            TdProductCategory cat = tdProductCategoryService.findOne(e
                    .getCategoryId());
            e.setCategoryTitle(cat.getTitle());
            e.setCategoryIdTree(cat.getParentTree());

            paramCategoryId = cat.getParamCategoryId();
        }

        // 保存品牌名称
        if (null != e.getCategoryId()) {
            TdBrand brand = tdBrandService.findOne(e.getBrandId());

            if (null != brand) {
                e.setBrandTitle(brand.getTitle());
            }
        }

        // 保存销售价
        if (null == e.getReturnPrice()) {
            e.setReturnPrice(0.0);
        }

        if (null == e.getOutFactoryPrice()) {
            e.setOutFactoryPrice(0.0);
        }

        e.setSalePrice(e.getReturnPrice() + e.getOutFactoryPrice());

        // 创建时间
        if (null == e.getCreateTime()) {
            e.setCreateTime(new Date());
        }

        // 上架时间
        if (null == e.getOnSaleTime() && e.getIsOnSale()) {
            e.setOnSaleTime(new Date());
        }

        // 仓库名
        if (null != e.getWarehouseId()) {
            TdWarehouse w = tdWarehouseService.findOne(e.getWarehouseId());

            if (null != w) {
                e.setWarehouseTitle(w.getTitle());
            }
        }

        // 当修改时，若切换过类型，参数数量由多变少，需要删除多余的参数
        if (null != e.getId() && null != paramCategoryId) {
            int count = tdParameterService
                    .countByCategoryTreeContaining(paramCategoryId);
            int size = e.getParamList().size();

            if (size > count) {
                List<TdGoodsParameter> subList = e.getParamList().subList(
                        count, size);
                tdGoodsParameterService.delete(subList);
                e.getParamList().removeAll(subList);
            }
        }

        // 当修改时，赠品数量减少时，需删除多余的赠品
        if (null != e.getId() && null != e.getGiftList()
                && null != e.getTotalGift()) {
            int count = e.getTotalGift();
            int size = e.getGiftList().size();

            if (size > count) {
                List<TdGoodsGift> subList = e.getGiftList()
                        .subList(count, size);
                tdGoodsGiftService.delete(subList);
                e.getGiftList().removeAll(subList);
            }
        }

        // 当修改时，组合商品数量减少时，需删除多余的组合商品
        if (null != e.getId() && null != e.getCombList()
                && null != e.getTotalComb()) {
            int count = e.getTotalComb();
            int size = e.getCombList().size();

            if (size > count) {
                List<TdGoodsCombination> subList = e.getCombList().subList(
                        count, size);
                tdGoodsCombinationService.delete(subList);
                e.getCombList().removeAll(subList);
            }
        }

        if (null != e.getParamList() && e.getParamList().size() > 0) {
            String valueCollect = "";
            for (TdGoodsParameter gp : e.getParamList()) {
                valueCollect += gp.getValue();
                valueCollect += ",";
            }
            e.setParamValueCollect(valueCollect);

            // 保存参数
            tdGoodsParameterService.save(e.getParamList());
        } else {
            e.setParamValueCollect("");
        }

        if (null == e.getId()) {
            if (null != e.getGiftList() && e.getGiftList().size() > 0) {
                e.setTotalGift(e.getGiftList().size());
            }

            if (null != e.getCombList() && e.getCombList().size() > 0) {
                e.setTotalComb(e.getCombList().size());
            }
        }

        // 保存赠品
        tdGoodsGiftService.save(e.getGiftList());

        // 保存组合
        tdGoodsCombinationService.save(e.getCombList());

        e = repository.save(e);
        

        // 添加改价记录
        TdPriceChangeLog priceLog = tdPriceChangeLogService
                .findTopByGoodsIdOrderByIdDesc(e.getId());

        // 没有改过价，或改价后的记录与当前销售价不相等
        if (null == priceLog || !priceLog.getPrice().equals(e.getSalePrice())) {
            TdPriceChangeLog newPriceLog = new TdPriceChangeLog();

            newPriceLog.setCreateTime(new Date());
            newPriceLog.setGoodsId(e.getId());
            newPriceLog.setGoodsTitle(e.getTitle() 
                    + (null == e.getSelectOneValue() ? "" : " " + e.getSelectOneValue())
                    + (null == e.getSelectTwoValue() ? "" : " " + e.getSelectTwoValue())
                    + (null == e.getSelectThreeValue() ? "" : " " + e.getSelectThreeValue()));
            newPriceLog.setOperator(manager);
            
            if (null != priceLog)
            {
                newPriceLog.setOriginPrice(priceLog.getPrice());
            }
            
            newPriceLog.setPrice(e.getSalePrice());
            newPriceLog.setSortId(99L);

            tdPriceChangeLogService.save(newPriceLog);
        }
        
        return e;
    }

}
