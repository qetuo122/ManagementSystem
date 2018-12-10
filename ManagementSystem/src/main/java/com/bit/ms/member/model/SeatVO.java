package com.bit.ms.member.model;

import org.apache.ibatis.type.Alias;

@Alias("seatVO")
public class SeatVO {

	private int seat_id; // 좌석 번호
	private String seat_name; // 좌석이름
	private int seat_pay; // 좌석 비용
	private int seat_update_time; // 좌석 수정시간
	private int seat_add_time; // 좌석 충전시간
	private String user_id; // 회원 아이디
	private int user_time; // 남은 시간
	private int user_pay; // 지불 금액
	private int store_id; // 매장 번호
	private String seat_qr; // 좌석 QR코드

	public int getSeat_id() {
		return seat_id;
	}

	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}

	public String getSeat_name() {
		return seat_name;
	}

	public void setSeat_name(String seat_name) {
		this.seat_name = seat_name;
	}

	public int getSeat_pay() {
		return seat_pay;
	}

	public void setSeat_pay(int seat_pay) {
		this.seat_pay = seat_pay;
	}

	public int getSeat_update_time() {
		return seat_update_time;
	}

	public void setSeat_update_time(int seat_update_time) {
		this.seat_update_time = seat_update_time;
	}

	public int getSeat_add_time() {
		return seat_add_time;
	}

	public void setSeat_add_time(int seat_add_time) {
		this.seat_add_time = seat_add_time;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	

	public int getUser_time() {
		return user_time;
	}

	public void setUser_time(int user_time) {
		this.user_time = user_time;
	}

	public int getUser_pay() {
		return user_pay;
	}

	public void setUser_pay(int user_pay) {
		this.user_pay = user_pay;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public String getSeat_qr() {
		return seat_qr;
	}

	public void setSeat_qr(String seat_qr) {
		this.seat_qr = seat_qr;
	}


	@Override
	public String toString() {
		return "SeatVO [seat_id=" + seat_id + ", seat_name=" + seat_name + ", seat_pay=" + seat_pay
				+ ", seat_update_time=" + seat_update_time + ", seat_add_time=" + seat_add_time + ", user_id=" + user_id
				+ ", user_time=" + user_time + ", user_pay=" + user_pay + ", store_id=" + store_id + ", seat_qr="
				+ seat_qr + "]";
	}

	public SeatVO(int seat_id, String seat_name, int seat_pay, int seat_update_time, int seat_add_time, String user_id,
			int store_id, String seat_qr) {
		super();
		this.seat_id = seat_id;
		this.seat_name = seat_name;
		this.seat_pay = seat_pay;
		this.seat_update_time = seat_update_time;
		this.seat_add_time = seat_add_time;
		this.user_id = user_id;
		this.store_id = store_id;
		this.seat_qr = seat_qr;
	}

	public SeatVO() {
		super();
		// TODO Auto-generated constructor stub
	}

}
