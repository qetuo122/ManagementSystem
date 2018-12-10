package com.bit.ms.user.model;

import org.apache.ibatis.type.Alias;

@Alias("UserBoardReplyVO")
public class UserBoardReplyVO {

	// 게시판 답글
	private int uboard_reply_id;
	private String uboard_reply_con;
	private String reply_writer_id;

	// 게시판
	private int uboard_id;
	private int store_id;

	@Override
	public String toString() {
		return "UserBoardReplyVO [uboard_reply_id=" + uboard_reply_id + ", uboard_id=" + uboard_id
				+ ", reply_writer_id=" + reply_writer_id + ", uboard_reply_con=" + uboard_reply_con + ", store_id="
				+ store_id + "]";
	}

	public int getUboard_reply_id() {
		return uboard_reply_id;
	}

	public void setUboard_reply_id(int uboard_reply_id) {
		this.uboard_reply_id = uboard_reply_id;
	}

	public int getUboard_id() {
		return uboard_id;
	}

	public void setUboard_id(int uboard_id) {
		this.uboard_id = uboard_id;
	}

	public String getReply_writer_id() {
		return reply_writer_id;
	}

	public void setReply_writer_id(String reply_writer_id) {
		this.reply_writer_id = reply_writer_id;
	}

	public String getUboard_reply_con() {
		return uboard_reply_con;
	}

	public void setUboard_reply_con(String uboard_reply_con) {
		this.uboard_reply_con = uboard_reply_con;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public UserBoardReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserBoardReplyVO(int uboard_reply_id, int uboard_id, String reply_writer_id, String uboard_reply_con,
			int store_id) {
		super();
		this.uboard_reply_id = uboard_reply_id;
		this.uboard_id = uboard_id;
		this.reply_writer_id = reply_writer_id;
		this.uboard_reply_con = uboard_reply_con;
		this.store_id = store_id;
	}

}
