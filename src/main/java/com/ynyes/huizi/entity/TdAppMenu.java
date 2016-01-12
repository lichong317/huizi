package com.ynyes.huizi.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * @author lc
 * @注释：app菜单图标
 */

@Entity
public class TdAppMenu {
	 @Id
	 @GeneratedValue(strategy = GenerationType.AUTO)
	 private Long id;
		
	 // 名称
	 @Column
	 private String title;
	    
	 // 图片地址
	 @Column
	 private String iconUri;
	    
	 // 排序号
	 @Column
	 private Long sortId;

	 // 是否使能
	 @Column
	 private Boolean isEnable;

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

	public String getIconUri() {
		return iconUri;
	}

	public void setIconUri(String iconUri) {
		this.iconUri = iconUri;
	}

	public Long getSortId() {
		return sortId;
	}

	public void setSortId(Long sortId) {
		this.sortId = sortId;
	}

	public Boolean getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(Boolean isEnable) {
		this.isEnable = isEnable;
	}
	 
	 
}
