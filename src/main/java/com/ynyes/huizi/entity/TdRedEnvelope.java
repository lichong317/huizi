package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class TdRedEnvelope {
	 @Id
	 @GeneratedValue(strategy = GenerationType.AUTO)
	 private Long id;
	 
	 // 红包类别id
	 @Column
	 private Long typeId;
	 
	 // 红包名称
	 @Column
	 private String typeTitle;
	 	 
	 //奖品类型  0: 积分  1:优惠券  
	 @Column
	 private Long redEnvelopeType;
	 
	 //优惠券类型id
	 @Column
	 private Long couponTypeId;
	 
	 // 优惠券名称
	 @Column
	 private String couponTitle;
	 
	 //奖励积分
	 @Column
	 private Long prizePoints;
	 	 
	 // 用户名
	 @Column
	 private String username;
	 
	 // 是否领取
	 @Column
	 private Boolean isGet;
	 
	 // 图片
	 @Column
	 private String picUri;
	 
	 // 发放日期
	 @Column
	 @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	 private Date sendTime;
	 
	// 领取日期
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

	public String getPicUri() {
		return picUri;
	}

	public void setPicUri(String picUri) {
		this.picUri = picUri;
	}

	public Long getRedEnvelopeType() {
		return redEnvelopeType;
	}

	public void setRedEnvelopeType(Long redEnvelopeType) {
		this.redEnvelopeType = redEnvelopeType;
	}

	public Long getCouponTypeId() {
		return couponTypeId;
	}

	public void setCouponTypeId(Long couponTypeId) {
		this.couponTypeId = couponTypeId;
	}

	public String getTypeTitle() {
		return typeTitle;
	}

	public void setTypeTitle(String typeTitle) {
		this.typeTitle = typeTitle;
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Boolean getIsGet() {
		return isGet;
	}

	public void setIsGet(Boolean isGet) {
		this.isGet = isGet;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Date getGetTime() {
		return getTime;
	}

	public void setGetTime(Date getTime) {
		this.getTime = getTime;
	}
	 
}
