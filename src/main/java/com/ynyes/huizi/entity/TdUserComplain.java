package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;


/**
 * 用户咨询
 * 
 * 储存所有用户信息
 * 
 * @author Sharon
 *
 */

@Entity
public class TdUserComplain {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    // 投诉内容
    @Column
    private String content;
    
    // 投诉分类
    @Column
    private String type;
    
    // 投诉时间
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date complainTime;
    
    // 投诉用户
    @Column
    private String username;
    
    // 投诉用户
    @Column
    private String userHeadImageUri;
    
    // 是否已回复
    @Column
    private Boolean isReplied;
    
    // 投诉回复
    @Column
    private String reply;
    
    // 回复时间
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date replyTime;
    
    // 投诉的商品ID
    @Column
    private Long goodsId;
    
    // 投诉的商品名称
    @Column
    private String goodsTitle;
    
    // 投诉的商品封面
    @Column
    private String goodsCoverImageUri;
    
    // 显示状态
    @Column
    private Long statusId;
    
    // 排序号
    @Column
    private Long sortId;

    // 订单Id
    @Column
    private Long orderId;
    
    // 订单号
    @Column
    private String orderNumber;
    
    
    public Date getComplainTime() {
		return complainTime;
	}

	public void setComplainTime(Date complainTime) {
		this.complainTime = complainTime;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getConsultTime() {
        return complainTime;
    }

    public void setConsultTime(Date consultTime) {
        this.complainTime = consultTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public Date getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsTitle() {
        return goodsTitle;
    }

    public void setGoodsTitle(String goodsTitle) {
        this.goodsTitle = goodsTitle;
    }

    public Long getStatusId() {
        return statusId;
    }

    public void setStatusId(Long statusId) {
        this.statusId = statusId;
    }

    public Long getSortId() {
        return sortId;
    }

    public void setSortId(Long sortId) {
        this.sortId = sortId;
    }

    public Boolean getIsReplied() {
        return isReplied;
    }

    public void setIsReplied(Boolean isReplied) {
        this.isReplied = isReplied;
    }

    public String getGoodsCoverImageUri() {
        return goodsCoverImageUri;
    }

    public void setGoodsCoverImageUri(String goodsCoverImageUri) {
        this.goodsCoverImageUri = goodsCoverImageUri;
    }

    public String getUserHeadImageUri() {
        return userHeadImageUri;
    }

    public void setUserHeadImageUri(String userHeadImageUri) {
        this.userHeadImageUri = userHeadImageUri;
    }
    
}
