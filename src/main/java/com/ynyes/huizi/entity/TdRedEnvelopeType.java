package com.ynyes.huizi.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class TdRedEnvelopeType {
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	 
	// 红包名称
	@Column
	private String title;
		
	//红包类型  0: 积分  1:优惠券  
	@Column
	private Long redEnvelopeType;
	
	// 奖品数量
    @Column
    private Long prizeNumber;
	
    // 奖品剩余数量
    @Column
    private Long leftNumber;
    
	// 图片
    @Column
    private String picUri;
	
	//优惠券类型ID
	@Column
	private Long couponTypeId;
	
	//奖励积分
	@Column
	private Long prizePoints;
			
	// 排序号
	@Column
	private Long sortId;

	// 描述
    @Column
    private String description;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}


	public Long getPrizeNumber() {
		return prizeNumber;
	}

	public void setPrizeNumber(Long prizeNumber) {
		this.prizeNumber = prizeNumber;
	}

	public Long getLeftNumber() {
		return leftNumber;
	}

	public void setLeftNumber(Long leftNumber) {
		this.leftNumber = leftNumber;
	}

	public String getPicUri() {
		return picUri;
	}

	public void setPicUri(String picUri) {
		this.picUri = picUri;
	}

	public Long getCouponTypeId() {
		return couponTypeId;
	}

	public void setCouponTypeId(Long couponTypeId) {
		this.couponTypeId = couponTypeId;
	}

	public Long getPrizePoints() {
		return prizePoints;
	}

	public void setPrizePoints(Long prizePoints) {
		this.prizePoints = prizePoints;
	}

	public Long getRedEnvelopeType() {
		return redEnvelopeType;
	}

	public void setRedEnvelopeType(Long redEnvelopeType) {
		this.redEnvelopeType = redEnvelopeType;
	}

	public Long getSortId() {
		return sortId;
	}

	public void setSortId(Long sortId) {
		this.sortId = sortId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
    
    
}
