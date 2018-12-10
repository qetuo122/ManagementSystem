package com.bit.ms.admin.model;

import org.apache.ibatis.type.Alias;

@Alias("noticeVO")
public class NoticeVO {
	private int notice_id;
	private String notice_title;
	private String notice_con;
	private String notice_date;
	private String admin_id;
	private int store_id;

	public int getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_con() {
		return notice_con;
	}

	public void setNotice_con(String notice_con) {
		this.notice_con = notice_con;
	}

	public String getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	@Override
	public String toString() {
		return "NoticeVO [notice_id=" + notice_id + ", notice_title=" + notice_title + ", notice_con=" + notice_con
				+ ", notice_date=" + notice_date + ", admin_id=" + admin_id + ", store_id=" + store_id + "]";
	}

}
