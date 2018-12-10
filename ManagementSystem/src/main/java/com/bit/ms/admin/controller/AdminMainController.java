package com.bit.ms.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.ms.member.model.StoreVO;

@Controller
@RequestMapping(value="/admin/main")
public class AdminMainController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String adminMain(@RequestParam int store, HttpSession session) {
		
		@SuppressWarnings("unchecked")
		List<StoreVO> list = (List<StoreVO>) session.getAttribute("storeSession");
		
		session.setAttribute("storeSelectSession", list.get(store));
		
		System.out.println("선택한 스토어세션 storeSelectSession : " + session.getAttribute("storeSelectSession"));
		
		return "admin/adminMain";
	}
}
