package com.bit.ms.admin.model;

import org.apache.ibatis.type.Alias;

@Alias("userListVO")
public class UserListVO {

	private String sortName;
	private String orderBy;
	private int store_id;

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	@Override
	public String toString() {
		return "UserListVO [sortName=" + sortName + ", orderBy=" + orderBy + ", store_id=" + store_id + "]";
	}
}
