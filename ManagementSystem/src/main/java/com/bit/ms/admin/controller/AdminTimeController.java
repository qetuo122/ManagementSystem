package com.bit.ms.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.service.AdminTimeService;
import com.bit.ms.member.model.SeatVO;
import com.bit.ms.user.model.UserOrdersVO;
import com.bit.ms.user.model.UserVO;

@Controller
public class AdminTimeController {

	@Autowired
	AdminTimeService service;

	// 사용자 시간 업데이트
	@RequestMapping("/admin/updateAddTime")
	@ResponseBody
	public void updateAddTime(@RequestParam("addTime") long addTime, @RequestParam("userId") String userId,
			@RequestParam("storeId") int storeId) {

		int resultCnt = service.updateAddTime(addTime, userId, storeId); // 유저 시간 업데이트

		if (resultCnt == 1) {
			System.out.println("유저 시간 업데이트 성공");
		}
	}

	// 사용 시간 종료 또는 강제 종료 시 좌석 삭제
	@RequestMapping("/admin/deleteSeat")
	@ResponseBody
	public void deleteSeat(@RequestParam("userId") String userId, @RequestParam("storeId") int storeId) {

		int resultCnt = service.deleteSeat(userId, storeId);

		if (resultCnt == 1) {
			System.out.println("좌석 삭제 완료");
		}
	}

	// 선택된 좌석의 사용자 정보 가져오기
	@RequestMapping("/admin/getUserInfo")
	@ResponseBody
	public UserVO getUserInfo(@RequestParam("userId") String userId, @RequestParam("storeId") int storeId) {
		return service.getUserInfo(userId, storeId);
	}
	
	// 선택된 좌석의 주문 정보 가져오기
	@RequestMapping("/admin/getOrdersInfo")
	@ResponseBody
	public List<UserOrdersVO> getOrdersInfo(@RequestParam("userId") String userId, 
										@RequestParam("storeId") int storeId) {
		
		return service.getOrdersInfo(userId, storeId);
	}
	
	// 좌석 정보 모두 가져오기
	@RequestMapping("/admin/getSeatListAll")
	@ResponseBody
	public List<SeatVO> getSeatListAll(@RequestParam("storeId") int storeId) {
		return service.getSeatListAll(storeId);
	}

}
