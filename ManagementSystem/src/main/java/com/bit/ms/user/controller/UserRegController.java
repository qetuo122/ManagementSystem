package com.bit.ms.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserMailSendService;
import com.bit.ms.user.service.UserRegService;
import com.bit.ms.user.service.UserSha256;

@Controller
public class UserRegController {

	@Autowired
	private UserRegService reg_service;
	@Autowired
	private UserMailSendService mailsender;

	// 회원가입 페이지에 보일 매장 리스트
	@RequestMapping(value = "/user/reg", method = RequestMethod.GET)
	public String userReg(Model model, HttpSession session) {

		return "user/userReg";
	}

	// 회원가입 컨트롤러
	@RequestMapping(value = "/user/reg", method = RequestMethod.POST)
	public String userRegPass(UserVO userVO, Model model, HttpServletRequest request, HttpSession session) {

		// 비밀번호 암호화
		String encryPassword = UserSha256.encrypt(userVO.getUser_pw());
		userVO.setUser_pw(encryPassword);
		
		// 회원가입 메서드
		reg_service.userReg_service(userVO);
		
		String store_id = request.getParameter("store_id");
		String seat_id = request.getParameter("seat_id");
		
		// 인증 메일 보내기 메서드
		mailsender.mailSendWithUserKey(userVO.getUser_email(), userVO.getUser_id(), request);

		if(store_id == null || store_id == "") { // 파라미터로 넘어오는 값이 없으면 일반로그인, 있으면 qr로그인
			return "redirect:/";
		} else {
			return "redirect:/user/qrLogin?store_id=" + store_id + "&seat_id=" + seat_id;
		}
	}

	// id 중복 체크 컨트롤러
	@RequestMapping(value = "/user/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("userId") String user_id) {

		return reg_service.userIdCheck(user_id);
	}

	// e-mail 중복 체크 컨트롤러
	@RequestMapping(value = "/user/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("userMail") String user_email) {
		System.out.println("메일 중복체크 컨트롤러");
		return reg_service.userMailCheck(user_email);
	}

	// e-mail 인증 컨트롤러
	@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {

		mailsender.alter_userKey_service(user_id, key);

		return "user/userRegSuccess";
	}
}
