package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * @author lc
 * @注释：积分商品
 */
@Entity
public class TdPointGoods {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	//兑换积分
	@Column
	private Long pointUse;
	
	// 商品标题
	@Column
	private String title;
		
	// 副标题
	@Column
	private String subTitle;
	
	// 封面图片
    @Column
    private String coverImageUri;
    
    // 封面图片宽度
    @Column
    private Double coverImageWidth;
    
    // 封面图片高度
    @Column
    private Double coverImageHeight;
    
    // 轮播展示图片，多张图片以,隔开
    @Column
    private String showPictures;
    
    // 商品配置
    @Column
    private String configuration;
    
    // 商品服务
    @Column
    private String service;
    
    // 配送区域
    @Column
    private String deliveryArea;
    
    // 详细参数
    @Column
    private String paramDetail;
    
    // 商品详情
    @Column
    private String detail;
    
    // 商品售后服务
    @Column
    private String afterMarketService;
    
    // 是否上架
    @Column
    private Boolean isOnSale;
    
    // 库存数量
    @Column
    private Long leftNumber;
    
    // 库存信息
    @Column
    private Long storehouseId;
 
    // 该版本的已售数量
    @Column
    private Long soldNumber;
    
    // 上架时间
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date onSaleTime;
    
    // 创建日期
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;
    
    // 排序号
    @Column
    private Long sortId;
    
    // SEO标题
    @Column
    private String seoTitle;
    
    // SEO关键字
    @Column
    private String seoKeywords;
    
    // SEO描述
    @Column
    private String seoDescription;
    
    // 是否免邮
    @Column
    private Boolean isFeeNot;
    
    // 邮费
    @Column
    private Double postage;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getPointUse() {
		return pointUse;
	}

	public void setPointUse(Long pointUse) {
		this.pointUse = pointUse;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String getCoverImageUri() {
		return coverImageUri;
	}

	public void setCoverImageUri(String coverImageUri) {
		this.coverImageUri = coverImageUri;
	}

	public Double getCoverImageWidth() {
		return coverImageWidth;
	}

	public void setCoverImageWidth(Double coverImageWidth) {
		this.coverImageWidth = coverImageWidth;
	}

	public Double getCoverImageHeight() {
		return coverImageHeight;
	}

	public void setCoverImageHeight(Double coverImageHeight) {
		this.coverImageHeight = coverImageHeight;
	}

	public String getShowPictures() {
		return showPictures;
	}

	public void setShowPictures(String showPictures) {
		this.showPictures = showPictures;
	}

	public String getConfiguration() {
		return configuration;
	}

	public void setConfiguration(String configuration) {
		this.configuration = configuration;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getDeliveryArea() {
		return deliveryArea;
	}

	public void setDeliveryArea(String deliveryArea) {
		this.deliveryArea = deliveryArea;
	}

	public String getParamDetail() {
		return paramDetail;
	}

	public void setParamDetail(String paramDetail) {
		this.paramDetail = paramDetail;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getAfterMarketService() {
		return afterMarketService;
	}

	public void setAfterMarketService(String afterMarketService) {
		this.afterMarketService = afterMarketService;
	}

	public Boolean getIsOnSale() {
		return isOnSale;
	}

	public void setIsOnSale(Boolean isOnSale) {
		this.isOnSale = isOnSale;
	}

	public Long getLeftNumber() {
		return leftNumber;
	}

	public void setLeftNumber(Long leftNumber) {
		this.leftNumber = leftNumber;
	}

	public Long getStorehouseId() {
		return storehouseId;
	}

	public void setStorehouseId(Long storehouseId) {
		this.storehouseId = storehouseId;
	}

	public Long getSoldNumber() {
		return soldNumber;
	}

	public void setSoldNumber(Long soldNumber) {
		this.soldNumber = soldNumber;
	}

	public Date getOnSaleTime() {
		return onSaleTime;
	}

	public void setOnSaleTime(Date onSaleTime) {
		this.onSaleTime = onSaleTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getSortId() {
		return sortId;
	}

	public void setSortId(Long sortId) {
		this.sortId = sortId;
	}

	public String getSeoTitle() {
		return seoTitle;
	}

	public void setSeoTitle(String seoTitle) {
		this.seoTitle = seoTitle;
	}

	public String getSeoKeywords() {
		return seoKeywords;
	}

	public void setSeoKeywords(String seoKeywords) {
		this.seoKeywords = seoKeywords;
	}

	public String getSeoDescription() {
		return seoDescription;
	}

	public void setSeoDescription(String seoDescription) {
		this.seoDescription = seoDescription;
	}

	public Boolean getIsFeeNot() {
		return isFeeNot;
	}

	public void setIsFeeNot(Boolean isFeeNot) {
		this.isFeeNot = isFeeNot;
	}

	public Double getPostage() {
		return postage;
	}

	public void setPostage(Double postage) {
		this.postage = postage;
	}
        
}
