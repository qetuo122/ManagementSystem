package com.bit.ms.admin.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.SeatVO;

@Service
public class AdminSeatService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private AdminDaoInterface adminDaoInterface;

	public List<SeatVO> getSeatListS(int store_id, String order_by, String sort) {

		adminDaoInterface = sqlSessionTemplate.getMapper(AdminDaoInterface.class);

		System.out.println("store_id : " + store_id);
		System.out.println("order_by : " + order_by);
		System.out.println("sort : " + sort);

		List<SeatVO> list = null;

		try {
			list = adminDaoInterface.getSeatListI(store_id, order_by, sort);
			System.out.println("좌석 리스트 출력 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int addSeatS(SeatVO seatVO) {

		adminDaoInterface = sqlSessionTemplate.getMapper(AdminDaoInterface.class);

		int resultCnt = 0;

		try {
			resultCnt = adminDaoInterface.addSeatI(seatVO);
			System.out.println("좌석 리스트 추가 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}

	public int deleteSeatS(int seat_id) {

		adminDaoInterface = sqlSessionTemplate.getMapper(AdminDaoInterface.class);

		int resultCnt = 0;

		try {
			resultCnt = adminDaoInterface.deleteSeatI(seat_id);
			System.out.println("좌석 리스트 삭제 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}

	public int modifySeatS(SeatVO seatVO, int seat_id) {

		seatVO.setSeat_id(seat_id);
		System.out.println("AdminSeatService 수정객체 정보 확인 || seatVO : " + seatVO);
		int resultCnt = 0;

		try {
			resultCnt = adminDaoInterface.modifySeatI(seatVO);
			System.out.println("좌석 리스트 수정 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}

	public int addQrS(int seat_id, String seat_qr) {

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("seat_id", Integer.toString(seat_id));
		map.put("seat_qr", seat_qr);

		adminDaoInterface = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDaoInterface.addQrI(map);
	}

	public String getQrS(int seat_id) {
		adminDaoInterface = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDaoInterface.getQrI(seat_id);
	}
}
