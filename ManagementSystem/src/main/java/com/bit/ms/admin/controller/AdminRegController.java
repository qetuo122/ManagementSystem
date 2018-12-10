package com.bit.ms.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.admin.service.AdminRegService;

@Controller
public class AdminRegController {

	@Autowired
	AdminRegService reg_service;
	
	@RequestMapping(value = "/admin/reg", method = RequestMethod.GET)
	public String adminReg() {

		return "admin/adminReg";
	}
	
	@RequestMapping(value = "/admin/reg", method = RequestMethod.POST)
	public String adminRegPass(AdminVO adminVO) {
		
		reg_service.adminReg_service(adminVO);
		
		return "redirect:/admin";
	}
	
	// 아이디 중복 체크
	@RequestMapping(value = "/admin/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("adminId") String admin_id) {
		
		int result = 0;
		result = reg_service.adminIdCheck(admin_id);
		
		return result;
	}
}
