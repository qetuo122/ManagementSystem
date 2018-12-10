package com.bit.ms.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.admin.service.AdminSearchService;
import com.bit.ms.member.model.StoreVO;

@Controller
public class AdminSearchController {

	@Autowired
	AdminSearchService searchService;
	
	@RequestMapping(value = "/admin/adminSearch", method = RequestMethod.GET)
	public ModelAndView adminSearch() {
		
		// 매장 출력
		List<StoreVO> storeVO = searchService.adminSearchId();

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/adminSearch");
		mav.addObject("store_list2", storeVO);
		
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/adminSearch", method = RequestMethod.POST )
	public String adminSearchId(@RequestParam("inputName_1")String admin_name,
			@RequestParam("inputPhone_1")String admin_phone,
			@RequestParam("search_store1")String admin_storeId) {
		
		String result = "";
		
		
		
		return result;
	}
}
