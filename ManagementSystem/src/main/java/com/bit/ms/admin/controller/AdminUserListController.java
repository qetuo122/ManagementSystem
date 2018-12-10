package com.bit.ms.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.model.UserListVO;
import com.bit.ms.admin.service.AdminUserListService;
import com.bit.ms.user.model.UserVO;

@Controller
@RequestMapping("/admin/userList")
public class AdminUserListController {

	@Autowired
	AdminUserListService listService;

	//회원목록 페이지 이동
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String userList() {
		
		return "admin/adminUserList";
	}
	
	// 회원목록을 테이블로 뿌려줌
	@RequestMapping(value = "/all", method = RequestMethod.GET)
	@ResponseBody
	public List<UserVO> getUserList() {

		List<UserVO> result = listService.getUserList();

		return result;
	}
	
	// 회원목록에서 각 컬럼들을 클릭시 정렬
	@RequestMapping(value = "/sort", method = RequestMethod.GET)
	@ResponseBody
	public List<UserVO> sortingUserList(UserListVO userListVO) {
		
		List<UserVO> result = listService.sortingUserList(userListVO);
		
		return result;
	}
}
