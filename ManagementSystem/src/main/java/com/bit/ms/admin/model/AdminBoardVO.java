package com.bit.ms.admin.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("AdminBoardVO")
public class AdminBoardVO {

	private int cboard_id;
	private String cboard_title;
	private String cboard_con;
	private Timestamp cboard_date;
	private String writer_cid;
	private int store_id;
	
	public AdminBoardVO() {
		super();
	}
	
	public AdminBoardVO(int cboard_id, String cboard_title, String cboard_con, Timestamp cboard_date, String writer_cid,
			int store_id) {
		this.cboard_id = cboard_id;
		this.cboard_title = cboard_title;
		this.cboard_con = cboard_con;
		this.cboard_date = cboard_date;
		this.writer_cid = writer_cid;
		this.store_id = store_id;
	}


	public int getCboard_id() {
		return cboard_id;
	}
	public void setCboard_id(int cboard_id) {
		this.cboard_id = cboard_id;
	}
	public String getCboard_title() {
		return cboard_title;
	}
	public void setCboard_title(String cboard_title) {
		this.cboard_title = cboard_title;
	}
	public String getCboard_con() {
		return cboard_con;
	}
	public void setCboard_con(String cboard_con) {
		this.cboard_con = cboard_con;
	}
	public Timestamp getCboard_date() {
		return cboard_date;
	}
	public void setCboard_date(Timestamp cboard_date) {
		this.cboard_date = cboard_date;
	}
	public String getWriter_cid() {
		return writer_cid;
	}
	public void setWriter_cid(String writer_cid) {
		this.writer_cid = writer_cid;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}
	@Override
	public String toString() {
		return "AdminBoardVO [cboard_id=" + cboard_id + ", cboard_title=" + cboard_title + ", cboard_con=" + cboard_con
				+ ", cboard_date=" + cboard_date + ", writer_cid=" + writer_cid + ", store_id=" + store_id + "]";
	}
	
	
	
}
