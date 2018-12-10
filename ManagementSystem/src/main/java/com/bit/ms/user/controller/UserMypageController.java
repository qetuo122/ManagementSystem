package com.bit.ms.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.social.kakao.KakaoController;
import com.bit.ms.social.kakao.KakaoUnlink;
import com.bit.ms.user.model.UserVO;
import com.bit.ms.user.service.UserMyPageService;
import com.bit.ms.user.service.UserSha256;


@Controller
public class UserMypageController {
	
	@Autowired
	UserMyPageService service;
	
	@Autowired
	KakaoController kakaoController;
	
	@RequestMapping("/user/userMypage")
	public String userMypage(HttpSession session, Model model) {
		
		UserVO userData = (UserVO) session.getAttribute("userSession");
		
		String userId = userData.getUser_id();
		
		model.addAttribute("user",service.getMyPage(userId));
		
		return "user/userMypage";
	}
	//사용자 삭제
	@RequestMapping("/user/userDelete")
	public String delete(UserVO userVo) {
		//System.out.println(userVo);
		
		String user_id = userVo.getUser_id();
		service.deleteUser(user_id);
		
		//카카오 아이디 앱연동 해제(탈퇴)
		kakaoController.kakaounlink();
		
		return "user/userMypage";
	}
	//이름 수정
	@RequestMapping(value = "/user/userEditname", method = RequestMethod.POST)
	public @ResponseBody int editName(UserVO userVo) {
		String user_name = userVo.getUser_name();
		String user_id = userVo.getUser_id();
		return service.editName(user_name, user_id);
	}
	//비밀번호 수정
	@RequestMapping(value = "/user/userEditpw")
	public @ResponseBody int editPw(UserVO userVo) {
		String user_pw = userVo.getUser_pw();
		String encryPw = UserSha256.encrypt(user_pw); //비밀번호 암호화 처리
		userVo.setUser_pw(encryPw); // 객체에 암호화된 비밀번호 저장
		String user_id = userVo.getUser_id();
		return service.editPw(encryPw, user_id);
	}
	//폰번호 수정
	@RequestMapping(value = "/user/userEditphone")
	public @ResponseBody int editPhone(UserVO userVo) {
		String user_phone = userVo.getUser_phone();
		String user_id = userVo.getUser_id();
		return service.editPhone(user_phone, user_id);
	}
	//생년월일 수정
	@RequestMapping(value = "/user/userEditbirth")
	public @ResponseBody int editBirth(UserVO userVo) {
		String user_id = userVo.getUser_id();
		String user_birth = userVo.getUser_birth();
		return service.editBirth(user_birth, user_id);
	}
	//이메일 수정
	@RequestMapping(value = "/user/userEditemail")
	public @ResponseBody int editEmail(UserVO userVo) {
		String user_id = userVo.getUser_id();
		String user_email = userVo.getUser_email();
		return service.editEmail(user_email, user_id);
	}
}
