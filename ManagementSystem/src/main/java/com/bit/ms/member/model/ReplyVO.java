package com.bit.ms.member.model;

import org.apache.ibatis.type.Alias;

@Alias("replyVO")
public class ReplyVO {

	private int reply_id;
	private int notice_id;
	private String reply_con;
	private int store_id;
	private String admin_id;

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public int getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}

	public String getReply_con() {
		return reply_con;
	}

	public void setReply_con(String reply_con) {
		this.reply_con = reply_con;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	@Override
	public String toString() {
		return "ReplyVO [reply_id=" + reply_id + ", notice_id=" + notice_id + ", reply_con=" + reply_con + ", store_id="
				+ store_id + ", admin_id=" + admin_id + "]";
	}

}
