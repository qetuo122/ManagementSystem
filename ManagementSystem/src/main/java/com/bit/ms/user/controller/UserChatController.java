package com.bit.ms.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserChatController {
	@RequestMapping("/user/chat")
	public String chat() {

		return "user/userChat";
	}
}
