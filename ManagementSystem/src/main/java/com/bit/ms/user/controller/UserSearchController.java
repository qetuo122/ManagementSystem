package com.bit.ms.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.service.UserMailSendService;
import com.bit.ms.user.service.UserSearchService;

@Controller
public class UserSearchController {

	@Autowired
	private UserSearchService searchService;
	@Autowired
	private UserMailSendService mailsender;
	
	@RequestMapping(value = "/user/userSearch", method = RequestMethod.GET)
	public String userSearch(Model model) {

		//매장 출력
		List<StoreVO> storeVO = searchService.getStoreOption();
		model.addAttribute("search_store", storeVO);
		
		return "user/userSearch";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/user/userSearch", method = RequestMethod.POST)
	@ResponseBody
	public String userIdSearch(@RequestParam("inputName_1") String user_name, 
			@RequestParam("inputPhone_1") String user_phone) {
		
		String result = searchService.get_searchId(user_name, user_phone);
				
		System.out.println("컨트롤러 확인" + result);
		
		return result;
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "/user/searchPassword", method = RequestMethod.GET)
	@ResponseBody
	public String passwordSearch(@RequestParam("userId")String user_id,
			@RequestParam("userEmail")String user_email) {
		System.out.println("비밀번호 찾기 : Controller");
		mailsender.mailSendWithPassword(user_id, user_email);
		
		return "user/userSearchPassword";
	}
}
