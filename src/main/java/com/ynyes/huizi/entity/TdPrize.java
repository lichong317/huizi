package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class TdPrize {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.AUTO)
	 private Long id;
	 
	 // 奖项类别id
	 @Column
	 private Long typeId;
	 
	 // 奖项名称
	 @Column
	 private String typeTitle;
	 
	 //奖品类型  0: 积分  1:优惠券  2:商品
	 @Column
	 private Long prizeType;
	 
	 //优惠券类型id
	 @Column
	 private Long couponTypeId;
	 
	 // 优惠券名称
	 @Column
	 private String couponTitle;
	 
	 //奖励积分
	 @Column
	 private Long prizePoints;
	 
	 //优惠券类型id
	 @Column
	 private Long goodsId;
	 
	 // 奖励商品名称
	 @Column
	 private String goodsTitle;
	 
	 // 用户名
	 @Column
	 private String username;
	 
	 // 抽取日期
	 @Column
	 @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	 private Date getTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public String getTypeTitle() {
		return typeTitle;
	}

	public void setTypeTitle(String typeTitle) {
		this.typeTitle = typeTitle;
	}

	public Long getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Long goodsId) {
		this.goodsId = goodsId;
	}

	public Long getPrizeType() {
		return prizeType;
	}

	public void setPrizeType(Long prizeType) {
		this.prizeType = prizeType;
	}

	public Long getCouponTypeId() {
		return couponTypeId;
	}

	public void setCouponTypeId(Long couponTypeId) {
		this.couponTypeId = couponTypeId;
	}

	public String getCouponTitle() {
		return couponTitle;
	}

	public void setCouponTitle(String couponTitle) {
		this.couponTitle = couponTitle;
	}

	public Long getPrizePoints() {
		return prizePoints;
	}

	public void setPrizePoints(Long prizePoints) {
		this.prizePoints = prizePoints;
	}

	public String getGoodsTitle() {
		return goodsTitle;
	}

	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getGetTime() {
		return getTime;
	}

	public void setGetTime(Date getTime) {
		this.getTime = getTime;
	}
	 
	 
}
