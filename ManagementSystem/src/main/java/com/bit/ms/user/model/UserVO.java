package com.bit.ms.user.model;

import org.apache.ibatis.type.Alias;

//회원 테이블 User

@Alias("userVO")
public class UserVO {

	private String user_id; // 회원아이디
	private String user_name; // 회원이름
	private String user_pw; // 비밀번호
	private String user_phone; // 폰번호
	private String user_birth; // 생년월일
	private String user_email; // 이메일
	private long user_time; // 남은 시간
	private int store_id; // 사용 중인 매장 번호
	private int user_pay; // 결제 금액
	private String user_key; // 인증 번호
	private String divide; // 소셜구분용
	private String whatid; // 소셜 각 고유아이디

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public long getUser_time() {
		return user_time;
	}

	public void setUser_time(long user_time) {
		this.user_time = user_time;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public int getUser_pay() {
		return user_pay;
	}

	public void setUser_pay(int user_pay) {
		this.user_pay = user_pay;
	}

	public String getUser_key() {
		return user_key;
	}

	public void setUser_key(String user_key) {
		this.user_key = user_key;
	}

	public String getDivide() {
		return divide;
	}

	public void setDivide(String divide) {
		this.divide = divide;
	}

	public String getWhatid() {
		return whatid;
	}

	public void setWhatid(String whatid) {
		this.whatid = whatid;
	}

	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_name=" + user_name + ", user_pw=" + user_pw + ", user_phone="
				+ user_phone + ", user_birth=" + user_birth + ", user_email=" + user_email + ", user_time=" + user_time
				+ ", store_id=" + store_id + ", user_pay=" + user_pay + ", user_key=" + user_key + ", divide=" + divide
				+ ", whatid=" + whatid + "]";
	}

}