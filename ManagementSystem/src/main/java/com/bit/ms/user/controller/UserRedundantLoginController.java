package com.bit.ms.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserLoginService;
import com.bit.ms.user.service.UserRedundantLoginService;
import com.bit.ms.user.service.UserSha256;

@Controller
public class UserRedundantLoginController {

	@Autowired
	private UserRedundantLoginService loginManager;

	@Autowired
	private UserLoginService login_service;

	@RequestMapping("/user/redundant")
	public ModelAndView beforelogout(HttpSession httpSession, HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();

		String loginId = (String) httpSession.getAttribute("loginId");

		if (loginId != null) {
			// 기존의 접속(세션)을 끊는다.
			loginManager.removeSession(loginId);

			// 새로운 새션생성
			httpSession = request.getSession(true);
		}

		// 로그인시에 get방식으로 정보 받음
		String user_id = request.getParameter("user_Id");
		String user_pw = request.getParameter("user_Pw");
//		int store_id = Integer.parseInt(request.getParameter("store_Id"));
		String user_check = request.getParameter("remember_userId");

		System.out.println("UserRedundantLoginController // user_id : " + user_id);
		System.out.println("UserRedundantLoginController // user_pw : " + user_pw);
//		System.out.println("UserRedundantLoginController // store_id : " + store_id);
		System.out.println("UserRedundantLoginController // user_check : " + user_check);

		int result = 0;

		UserVO userVO = new UserVO();
		userVO.setUser_id(user_id);
		userVO.setUser_pw(UserSha256.encrypt(user_pw)); // 비밀번호 암호화

		result = login_service.userLogin_service(userVO, httpSession, user_check, response);

		if (result == 1) {
			System.out.println("[중복로그인] 먼저 로그인 해제하고 나중로그인 실행");
			mav.setViewName("redirect:/user/storeChoice");
		} else {
			System.out.println("[중복로그인] 실패");
			mav.setViewName("redirect:/");
		}
		loginManager.setSession(httpSession, loginId);

		return mav;
	}

	//1초 단위 ajax 세션확인 컨트롤러
	@RequestMapping(value = "/user/redundantout", method = RequestMethod.GET)
	@ResponseBody
	public int redundantlogout(HttpServletRequest request) {

		int result = 0;

		HttpSession session = request.getSession(false);

		if (session == null) {
			result = -1;
		}

//		System.out.println("[세션 실시간 확인2] " + result);

		return result;
	}

}
