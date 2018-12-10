package com.bit.ms.member.model;

import org.apache.ibatis.type.Alias;

@Alias("photoReplyVO")
public class PhotoBoardReplyVO {
	private int photoreply_id;
	private String photoreply_con;
	private String photoreply_writeid;
	private int store_id;
	private int photo_id;
	private String photoreply_date;
	
	public String getPhotoreply_date() {
		return photoreply_date;
	}
	public void setPhotoreply_date(String photoreply_date) {
		this.photoreply_date = photoreply_date;
	}
	public int getPhotoreply_id() {
		return photoreply_id;
	}
	public void setPhotoreply_id(int photoreply_id) {
		this.photoreply_id = photoreply_id;
	}
	public String getPhotoreply_con() {
		return photoreply_con;
	}
	public void setPhotoreply_con(String photoreply_con) {
		this.photoreply_con = photoreply_con;
	}
	public String getPhotoreply_writeid() {
		return photoreply_writeid;
	}
	public void setPhotoreply_writeid(String photoreply_writeid) {
		this.photoreply_writeid = photoreply_writeid;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}
	public int getPhoto_id() {
		return photo_id;
	}
	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}
	@Override
	public String toString() {
		return "PhotoBoardReplyVO [photoreply_id=" + photoreply_id + ", photoreply_con=" + photoreply_con
				+ ", photoreply_writeid=" + photoreply_writeid + ", store_id=" + store_id + ", photo_id=" + photo_id
				+ ", photoreply_date=" + photoreply_date + "]";
	}
	
	
}
