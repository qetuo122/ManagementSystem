package com.bit.ms.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.service.UserStoreListService;

@Controller
public class UserStoreChoiceController {

	@Autowired
	UserStoreListService userStoreListService;

	@RequestMapping(value = "/user/storeChoice", method = RequestMethod.GET)
	public String storeChoiceForm(Model model, HttpSession session) {

		List<StoreVO> result = userStoreListService.get_storeList(session);

		model.addAttribute("store", result);

		return "user/userStoreChoice";
	}

	@RequestMapping(value = "/user/storeChoice2", method = RequestMethod.GET)
	public String storeChoiceForm2(@RequestParam int store, HttpSession session) {

		@SuppressWarnings("unchecked")
		List<StoreVO> list = (List<StoreVO>) session.getAttribute("storeSession");

		session.setAttribute("storeSelectSession", list.get(store));

		System.out.println("선택한 스토어세션 storeSelectSession : " + session.getAttribute("storeSelectSession"));

		return "redirect:/user/main";
	}
}
