package com.bit.ms.member.model;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

@Alias("photoVO")
public class PhotoBoardVO {
	
	private int photo_id;
	private String photo_title;
	private String photo_con;
	private String photo_date;
	private int store_id;
	private String photo_upid;
	private String photo_file; // db에 저장될 파일이름
	private MultipartFile photoFile; 
	private int photo_cnt;
	
	public int getPhoto_cnt() {
		return photo_cnt;
	}
	public void setPhoto_cnt(int photo_cnt) {
		this.photo_cnt = photo_cnt;
	}
	public String getPhoto_file() {
		return photo_file;
	}
	public void setPhoto_file(String photo_file) {
		this.photo_file = photo_file;
	}
	public MultipartFile getPhotoFile() {
		return photoFile;
	}
	public void setPhotoFile(MultipartFile photoFile) {
		this.photoFile = photoFile;
	}
	public int getPhoto_id() {
		return photo_id;
	}
	public void setPhoto_id(int photo_id) {
		this.photo_id = photo_id;
	}
	public String getPhoto_title() {
		return photo_title;
	}
	public void setPhoto_title(String photo_title) {
		this.photo_title = photo_title;
	}
	public String getPhoto_con() {
		return photo_con;
	}
	public void setPhoto_con(String photo_con) {
		this.photo_con = photo_con;
	}
	public String getPhoto_date() {
		return photo_date;
	}
	public void setPhoto_date(String photo_date) {
		this.photo_date = photo_date;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}
	public String getPhoto_upid() {
		return photo_upid;
	}
	public void setPhoto_upid(String photo_upid) {
		this.photo_upid = photo_upid;
	}
	
	@Override
	public String toString() {
		return "PhotoBoardVO [photo_id=" + photo_id + ", photo_title=" + photo_title + ", photo_con=" + photo_con
				+ ", photo_date=" + photo_date + ", store_id=" + store_id + ", photo_upid=" + photo_upid
				+ ", photo_file=" + photo_file + ", photoFile=" + photoFile + ", photo_cnt=" + photo_cnt + "]";
	}
	
	
}
