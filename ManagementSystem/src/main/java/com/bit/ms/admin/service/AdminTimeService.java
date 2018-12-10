package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.SeatVO;
import com.bit.ms.user.model.UserOrdersVO;
import com.bit.ms.user.model.UserVO;

@Service
public class AdminTimeService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private AdminDaoInterface adminDao;

	// 선택한 좌석의 유저 시간 업데이트(충전시간, 사용자 아이디, 매장 아이디)
	public int updateAddTime(long addTime, String userId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.updateAddTime(addTime, userId, storeId);
	}

	// 사용 종료 또는 강제 종료된 좌석 지우기
	public int deleteSeat(String userId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.deleteSeat(userId, storeId);
	}

	// 선택된 좌석의 사용자 정보 가져오기
	public UserVO getUserInfo(String userId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getUserInfo(userId, storeId);
	}

	// 선택된 좌석의 주문 정보 가져오기
	public List<UserOrdersVO> getOrdersInfo(String userId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getOrdersInfo(userId, storeId);
	}

	// 좌석 정보 모두 가져오기
	public List<SeatVO> getSeatListAll(int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getSeatListAll(storeId);
	}
}
