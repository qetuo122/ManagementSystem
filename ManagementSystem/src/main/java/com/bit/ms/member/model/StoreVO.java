package com.bit.ms.member.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("storeVO")
public class StoreVO {

	private int store_id;
	private String store_name;
	private int store_zip;
	private String store_address;
	private String store_address1;
	private String store_address2;
	private String store_num;
	private String store_regDate;
	private String admin_id;

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public int getStore_zip() {
		return store_zip;
	}

	public void setStore_zip(int store_zip) {
		this.store_zip = store_zip;
	}

	public String getStore_address() {
		return store_address;
	}

	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}

	public String getStore_address1() {
		return store_address1;
	}

	public void setStore_address1(String store_address1) {
		this.store_address1 = store_address1;
	}

	public String getStore_address2() {
		return store_address2;
	}

	public void setStore_address2(String store_address2) {
		this.store_address2 = store_address2;
	}

	public String getStore_num() {
		return store_num;
	}

	public void setStore_num(String store_num) {
		this.store_num = store_num;
	}

	public String getStore_regDate() {
		return store_regDate;
	}

	public void setStore_regDate(String store_regDate) {
		this.store_regDate = store_regDate;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	@Override
	public String toString() {
		return "StoreVO [store_id=" + store_id + ", store_name=" + store_name + ", store_zip=" + store_zip
				+ ", store_address=" + store_address + ", store_address1=" + store_address1 + ", store_address2="
				+ store_address2 + ", store_num=" + store_num + ", store_regDate=" + store_regDate + ", admin_id="
				+ admin_id + "]";
	}
}
