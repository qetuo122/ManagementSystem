package com.bit.ms.admin.model;

public class AdminBoardReplyVO {

	private int cboard_reply_id;
	private String cboard_reply_con;
	private String cboard_reply_writer;
	private int cboard_id;
	
	public AdminBoardReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AdminBoardReplyVO(int cboard_reply_id, String cboard_reply_con, String cboard_reply_writer, int cboard_id) {
		super();
		this.cboard_reply_id = cboard_reply_id;
		this.cboard_reply_con = cboard_reply_con;
		this.cboard_reply_writer = cboard_reply_writer;
		this.cboard_id = cboard_id;
	}

	public int getCboard_reply_id() {
		return cboard_reply_id;
	}

	public void setCboard_reply_id(int cboard_reply_id) {
		this.cboard_reply_id = cboard_reply_id;
	}

	public String getCboard_reply_con() {
		return cboard_reply_con;
	}

	public void setCboard_reply_con(String cboard_reply_con) {
		this.cboard_reply_con = cboard_reply_con;
	}

	public String getCboard_reply_writer() {
		return cboard_reply_writer;
	}

	public void setCboard_reply_writer(String cboard_reply_writer) {
		this.cboard_reply_writer = cboard_reply_writer;
	}

	public int getCboard_id() {
		return cboard_id;
	}

	public void setCboard_id(int cboard_id) {
		this.cboard_id = cboard_id;
	}

	@Override
	public String toString() {
		return "AdminBoardReplyVO [cboard_reply_id=" + cboard_reply_id + ", cboard_reply_con=" + cboard_reply_con
				+ ", cboard_reply_writer=" + cboard_reply_writer + ", cboard_id=" + cboard_id + "]";
	}
	
}
