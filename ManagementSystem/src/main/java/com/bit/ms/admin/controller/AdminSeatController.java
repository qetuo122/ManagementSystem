package com.bit.ms.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.admin.service.AdminSeatService;
import com.bit.ms.member.model.SeatVO;

@Controller
public class AdminSeatController {

	@Autowired
	AdminSeatService adminSeatService;

	@RequestMapping(value = "/admin/seat", method = RequestMethod.GET)
	public ModelAndView getAdminSeat() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("admin/adminSeatList");

		return mav;
	}

	@RequestMapping(value = "/admin/seat/list", method = RequestMethod.GET)
	@ResponseBody
	public List<SeatVO> getAdminSeatList(int store_id, String order_by, String sort) {// 좌석관리 리스트
		List<SeatVO> seatlist = adminSeatService.getSeatListS(store_id, order_by, sort);

		return seatlist;
	}

	@RequestMapping(value = "/admin/seat", method = RequestMethod.POST)
	@ResponseBody
	public void addSeat(SeatVO seatVO) {// 좌석 추가
		adminSeatService.addSeatS(seatVO);
	}

	@RequestMapping(value = "/admin/seat/{seat_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteSeat(@PathVariable("seat_id") int seat_id) { // 좌석 삭제
		adminSeatService.deleteSeatS(seat_id);
	}

	@RequestMapping(value = "/admin/seat/{seat_id}", method = RequestMethod.PUT)
	@ResponseBody
	public void modifySeat(@PathVariable("seat_id") int seat_id, @RequestBody SeatVO seatVO) { // 좌석 수정

		adminSeatService.modifySeatS(seatVO, seat_id);

	}
	// qr코드 추가 컨트롤러
	@RequestMapping(value = "/admin/addQr", method = RequestMethod.POST)
	@ResponseBody
	public int addQr(SeatVO seatVo) {
		
		int seat_id = seatVo.getSeat_id();
		String seat_qr = seatVo.getSeat_qr();
		
		return adminSeatService.addQrS(seat_id, seat_qr);
	}
	// qr 코드 불러오는 컨트롤러
	@RequestMapping(value = "/admin/addQr/{seat_id}", method = RequestMethod.GET)
	@ResponseBody
	public String getQr(@PathVariable("seat_id") int seat_id) {

		return adminSeatService.getQrS(seat_id);
	}
	

}
