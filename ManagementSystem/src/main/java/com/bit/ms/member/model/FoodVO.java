package com.bit.ms.member.model;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

@Alias("FoodVO")
public class FoodVO {
	private int food_id;
	private String food_type;
	private String food_name;
	private String food_photo;
	private MultipartFile report;
	private int food_stock;
	private int food_price;
	private int store_id;

	public int getFood_id() {
		return food_id;
	}

	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}

	public String getFood_type() {
		return food_type;
	}

	public void setFood_type(String food_type) {
		this.food_type = food_type;
	}

	public String getFood_name() {
		return food_name;
	}

	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}

	public String getFood_photo() {
		return food_photo;
	}

	public void setFood_photo(String food_photo) {
		this.food_photo = food_photo;
	}

	public int getFood_stock() {
		return food_stock;
	}

	public void setFood_stock(int food_stock) {
		this.food_stock = food_stock;
	}

	public int getFood_price() {
		return food_price;
	}

	public void setFood_price(int food_price) {
		this.food_price = food_price;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public MultipartFile getReport() {
		return report;
	}

	public void setReport(MultipartFile report) {
		this.report = report;
	}

	@Override
	public String toString() {
		return "FoodVO [food_id=" + food_id + ", food_type=" + food_type + ", food_name=" + food_name + ", food_photo="
				+ food_photo + ", report=" + report + ", food_stock=" + food_stock + ", food_price=" + food_price
				+ ", store_id=" + store_id + "]";
	}

}