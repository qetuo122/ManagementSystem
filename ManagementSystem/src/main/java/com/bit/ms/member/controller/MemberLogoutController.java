package com.bit.ms.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserTimeService;

@Controller
public class MemberLogoutController {
	
	@Autowired
	UserTimeService service;
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		UserVO userVO = (UserVO) session.getAttribute("userSession");
		String page = "redirect:/";

		if (userVO == null) { // admin이 로그아웃하면 adminLogin페이지로 보내줌
			page = "redirect:/admin";
		}

		session.invalidate();
		return page;
	}
}