package com.bit.ms.member.model;


import org.apache.ibatis.type.Alias;

@Alias("messageVO")
public class MessageVO {

	private int message_id;
	private String message_title;
	private String message_con;
	private String message_date;
	private String send_id;
	private String receive_id;
	private String message_read;
	private int store_id;
	
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public String getMessage_title() {
		return message_title;
	}
	public void setMessage_title(String message_title) {
		this.message_title = message_title;
	}
	public String getMessage_con() {
		return message_con;
	}
	public void setMessage_con(String message_con) {
		this.message_con = message_con;
	}
	public String getMessage_date() {
		return message_date;
	}
	public void setMessage_date(String message_date) {
		this.message_date = message_date;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(String receive_id) {
		this.receive_id = receive_id;
	}
	public String getMessage_read() {
		return message_read;
	}
	public void setMessage_read(String message_read) {
		this.message_read = message_read;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}
	@Override
	public String toString() {
		return "MessageVO [message_id=" + message_id + ", message_title=" + message_title + ", message_con="
				+ message_con + ", message_date=" + message_date + ", send_id=" + send_id + ", receive_id=" + receive_id
				+ ", message_read=" + message_read + ", store_id=" + store_id + "]";
	}
}
