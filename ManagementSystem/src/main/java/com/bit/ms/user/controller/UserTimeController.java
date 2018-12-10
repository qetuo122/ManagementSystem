package com.bit.ms.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.member.model.SeatVO;
import com.bit.ms.user.service.UserTimeService;

@Controller
public class UserTimeController {
	
	@Autowired
	UserTimeService service;
	
	@RequestMapping(value="/user/updateAddTime", method=RequestMethod.GET)
	@ResponseBody
	public void updateAddTime(@RequestParam("addTime") long addTime,
								@RequestParam("seatId") int seatId,
								@RequestParam("userId") String userId,
								@RequestParam("storeId") int storeId) {
		
		int pay = (int)(addTime / 3600)*1000; // 충전 시간(초)를 시간으로 변환한 후 가격 계산
		
		// 좌석에 따라 추가 금액 처리
		/////////////////////////////
		
		int resultCnt = service.updateAddTime(addTime, pay, userId, storeId);
		resultCnt += service.updateSeat(userId, seatId, storeId);
		
		if(resultCnt == 2) {
			System.out.println("시간 업데이트 성공");
			System.out.println("사용 중인 사용자 좌석 업데이트 성공");
		}
	}
	
	@RequestMapping(value="/user/updateSaveTime", method=RequestMethod.GET)
	@ResponseBody
	public void updateSaveTime(@RequestParam("useTime") long useTime,
								@RequestParam("userId") String userId,
								@RequestParam("storeId") int storeId) {
		
		int resultCnt = service.updateSaveTime(useTime, userId, storeId);
		
		if(resultCnt == 1) {
			System.out.println("사용 시간: " + useTime + " 차감");
		}
	}
	
	@RequestMapping("/user/updateSeatChange")
	@ResponseBody
	public void updateSeatChange(@RequestParam("seatId") int seatId,
								@RequestParam("userId") String userId,
								@RequestParam("storeId") int storeId) {
		
		int resultCnt = service.deleteUsingInfo(userId, storeId); // 이전 좌석 정보 지우기
		resultCnt += service.updateSeat(userId, seatId, storeId); // 새로 저장
		
		if(resultCnt == 2) {
			System.out.println("좌석 이동 완료");
		}
	}
	
	@RequestMapping("/user/getSeatListAll")
	@ResponseBody
	public List<SeatVO> getSeatListAll(@RequestParam("storeId") int storeId) {
		return service.getSeatListAll(storeId);
	}
	
	@RequestMapping("user/deleteUsingInfo")
	@ResponseBody
	public void deleteUsingInfo(@RequestParam("userId") String userId,
								@RequestParam("storeId") int storeId) {
		int resultCnt = service.deleteUsingInfo(userId, storeId);
		
		if(resultCnt == 1) {
			System.out.println("사용 중인 좌석 종료");
		}
	}
}
