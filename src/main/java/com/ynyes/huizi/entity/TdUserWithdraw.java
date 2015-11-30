package com.ynyes.huizi.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class TdUserWithdraw {

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
	
	// 分销商用户名
    @Column
    private String username;
    
    // 真实姓名
 	@Column
 	private String realName;
    
	// 提现时间
    @Column
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date withdrawTime;
    
    // 提现额度
    @Column
    private Double totalWithdraw;
    
    // 银行名
    @Column
    private String bankName;
    
    // 银行卡号
    @Column
    private String bankCardNumber;
    
    // 备注
    @Column
    private String detail;
    
    // 手机号码
  	@Column
  	private String mobile;
  	
  	// 排序号
    @Column
    private Long sortId;
    
    // 用户类型Id: 0-普通用户 1-分销商
    @Column
    private Long roleId;
    
    // 是否已回复
    @Column
    private Boolean isReplied;

    // 显示状态 0: 待审核 1: 正常
    @Column
    private Long statusId;
    
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
	
	 public Long getStatusId() {
		return statusId;
	}

	public void setStatusId(Long statusId) {
		this.statusId = statusId;
	}

	public String getRealName() {
			return realName;
		}

		public void setRealName(String realName) {
			this.realName = realName;
		}
		
	public Date getWithdrawTime() {
		return withdrawTime;
	}

	public void setWithdrawTime(Date withdrawTime) {
		this.withdrawTime = withdrawTime;
	}

	public Double getTotalWithdraw() {
		return totalWithdraw;
	}

	public void setTotalWithdraw(Double totalWithdraw) {
		this.totalWithdraw = totalWithdraw;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankCardNumber() {
		return bankCardNumber;
	}

	public void setBankCardNumber(String bankCardNumber) {
		this.bankCardNumber = bankCardNumber;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
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

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
    
    
}
