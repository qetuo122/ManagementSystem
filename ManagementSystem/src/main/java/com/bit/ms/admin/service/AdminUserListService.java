package com.bit.ms.admin.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.UserListVO;
import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserVO;

@Service
public class AdminUserListService {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	AdminDaoInterface adminDao;
	
	public List<UserVO> getUserList(){
		
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		return adminDao.getUserList();
	}

	public List<UserVO> sortingUserList(UserListVO userListVO) {
		
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		return adminDao.sortingUserList(userListVO);		
	}

	public List<StoreVO> getStoreName(String id, HttpSession session) {

		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		List<StoreVO> result = adminDao.getStoreName(id);
		
		session.setAttribute("storeSession", result);
		System.out.println("전체 스토어세션 storeSession : " + session.getAttribute("storeSession"));
		
		return result;
	}
	
}
