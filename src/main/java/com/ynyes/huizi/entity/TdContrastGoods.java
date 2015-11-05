package com.ynyes.huizi.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class TdContrastGoods {
	 @Id
	 @GeneratedValue(strategy = GenerationType.AUTO)
	 private Long id;
	    
	 // 用户
	 @Column
	 private String username;
	    
	 // 商品ID
	 @Column
	 private Long goodsId;
	    
	 // 商品标题
	 @Column
	 private String goodsTitle;
	    
	 // 商品封面
	 @Column
	 private String goodsCoverImageUri;
	 
	 @Column
	 private Double price;
	 
	 // 商品类型
	 @Column
	 private Long categoryId;
	    
	 // 商品类型名称
	 @Column
	 private String categoryTitle;
	  
	 // 商品所有类型
	 @Column
	 private String categoryIdTree;
	 
	 // 是否是登陆用户
	 @Column
	 private Boolean isLoggedIn;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Long getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Long goodsId) {
		this.goodsId = goodsId;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getCategoryIdTree() {
		return categoryIdTree;
	}

	public void setCategoryIdTree(String categoryIdTree) {
		this.categoryIdTree = categoryIdTree;
	}

	public String getGoodsTitle() {
		return goodsTitle;
	}

	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}

	public String getGoodsCoverImageUri() {
		return goodsCoverImageUri;
	}

	public void setGoodsCoverImageUri(String goodsCoverImageUri) {
		this.goodsCoverImageUri = goodsCoverImageUri;
	}

	public Boolean getIsLoggedIn() {
		return isLoggedIn;
	}

	public void setIsLoggedIn(Boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}
	 
	 
}
