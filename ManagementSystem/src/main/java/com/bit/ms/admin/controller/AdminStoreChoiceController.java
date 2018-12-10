package com.bit.ms.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bit.ms.admin.service.AdminMypageService;
import com.bit.ms.admin.service.AdminRegService;
import com.bit.ms.admin.service.AdminUserListService;
import com.bit.ms.member.model.StoreVO;

@Controller
public class AdminStoreChoiceController {

	@Autowired
	AdminUserListService adminUserListService;
	@Autowired
	AdminMypageService adminMypageService;
	@Autowired
	AdminRegService adminRegService;

	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/admin/storeChoice", method = RequestMethod.GET)
	public String storeChoiceForm(@Param("id") String id, Model model, HttpSession session) {

		List<StoreVO> result = adminUserListService.getStoreName(id, session);

		model.addAttribute("store", result);

		return "admin/adminStoreChoice";
	}

	@RequestMapping(value = "/admin/storeReg", method = RequestMethod.GET)
	public String storeRegForm() {

		return "admin/adminStoreReg";
	}

	@RequestMapping(value = "/admin/storeReg", method = RequestMethod.POST)
	public String storeChoiceSubmit(StoreVO storeVO) {

		// 기본주소와 상세주소를 하나의 주소로 합쳐줌
		storeVO.setStore_address(storeVO.getStore_address1() + " " + storeVO.getStore_address2());
		adminMypageService.storeAdd(storeVO);

		return "redirect:/admin";
	}

	@RequestMapping(value = "/admin/storeCheck/{re_name}", method = RequestMethod.GET)
	@ResponseBody
	public int storeCheck(@PathVariable("re_name") String re_name) {

		int result = adminRegService.getSelectStoreName(re_name);

		return result;
	}
}
