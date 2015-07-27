package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;


/**
 * 优惠券
 * 
 * @author Sharon
 *
 */

@Entity
public class TdCoupon {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
	// 优惠券类型
	@Column
	private Long typeId;
	
	// 优惠券名称
	@Column
    private String typeTitle;
	
	// 优惠券描述
    @Column
    private String typeDescription;
    
    // 优惠券图片
    @Column
    private String typePicUri;
    
    // 是否已领用
    @Column
    private Boolean isDistributted;
    
    // 剩余数量
    @Column
    private Long leftNumber;
    
    // 剩余数量
    @Column
    private Long getNumber;
    
    // 领用用户
    @Column
    private String username;
    
    // 领用日期
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date getTime;
    
    // 过期日期
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date expireTime;
    
    // 排序号
    @Column
    private Long sortId;

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

    public Boolean getIsDistributted() {
        return isDistributted;
    }

    public void setIsDistributted(Boolean isDistributted) {
        this.isDistributted = isDistributted;
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

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    public Long getSortId() {
        return sortId;
    }

    public void setSortId(Long sortId) {
        this.sortId = sortId;
    }

    public String getTypeDescription() {
        return typeDescription;
    }

    public void setTypeDescription(String typeDescription) {
        this.typeDescription = typeDescription;
    }

    public String getTypePicUri() {
        return typePicUri;
    }

    public void setTypePicUri(String typePicUri) {
        this.typePicUri = typePicUri;
    }

    public Long getLeftNumber() {
        return leftNumber;
    }

    public void setLeftNumber(Long leftNumber) {
        this.leftNumber = leftNumber;
    }

    public Long getGetNumber() {
        return getNumber;
    }

    public void setGetNumber(Long getNumber) {
        this.getNumber = getNumber;
    }
}
