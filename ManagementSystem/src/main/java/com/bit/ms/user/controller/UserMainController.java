package com.bit.ms.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/user/main")
public class UserMainController {

	@RequestMapping(method = RequestMethod.GET)
	public String userMain() {

		return "user/userMain";
	}
}
