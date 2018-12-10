package com.bit.ms.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserLoginService;

@Controller
public class UserQrLoginController {

	@Autowired
	UserLoginService userLoginService;
	
	@RequestMapping(value = "/user/loginSuccess", method = RequestMethod.GET)
	public String storeChoiceForm(int store_id, int seat_id, String user_id, HttpSession session) {
		
		StoreVO storeVo = userLoginService.getStoreS(store_id);
		session.setAttribute("storeSelectSession", storeVo); //스토어 세션 생성
		System.out.println("선택한 스토어세션 storeSelectSession : " + session.getAttribute("storeSelectSession"));
		
		UserVO userVo = userLoginService.getUserInfoS(user_id);
		session.setAttribute("userSession", userVo); // 유저 세션 생성
		System.out.println("유저세션 userSession : " + session.getAttribute("userSession"));
		return "redirect:/user/main";
	}
}
