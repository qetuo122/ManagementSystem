package com.bit.ms.admin.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("salesVO")
public class SalesVO {
	
	private String sales_day;
	private int sales_total;
	private int sales_food;
	private int sales_seat;
	private int sales_id;
	private int store_id;
	private int salesDate;
	private int salesMonth;
	private String salesTime;
	
	@Override
	public String toString() {
		return "SalesVO [sales_day=" + sales_day + ", sales_total=" + sales_total + ", sales_food=" + sales_food
				+ ", sales_seat=" + sales_seat + ", sales_id=" + sales_id + ", store_id=" + store_id + ", salesDate="
				+ salesDate + ", salesMonth=" + salesMonth + ", salesTime=" + salesTime + "]";
	}

	public String getSales_day() {
		return sales_day;
	}

	public void setSales_day(String sales_day) {
		this.sales_day = sales_day;
	}

	public int getSales_total() {
		return sales_total;
	}

	public void setSales_total(int sales_total) {
		this.sales_total = sales_total;
	}

	public int getSales_food() {
		return sales_food;
	}

	public void setSales_food(int sales_food) {
		this.sales_food = sales_food;
	}

	public int getSales_seat() {
		return sales_seat;
	}

	public void setSales_seat(int sales_seat) {
		this.sales_seat = sales_seat;
	}

	public int getSales_id() {
		return sales_id;
	}

	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public int getSalesDate() {
		return salesDate;
	}

	public void setSalesDate(int salesDate) {
		this.salesDate = salesDate;
	}

	public int getSalesMonth() {
		return salesMonth;
	}

	public void setSalesMonth(int salesMonth) {
		this.salesMonth = salesMonth;
	}

	public String getSalesTime() {
		return salesTime;
	}

	public void setSalesTime(String salesTime) {
		this.salesTime = salesTime;
	}
	
}
