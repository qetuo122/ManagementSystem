package com.bit.ms.user.service;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.UserDaoInterface;
import com.bit.ms.user.model.UserVO;

@Service
public class UserMyPageService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private UserDaoInterface userDao;

	public UserVO getMyPage(String user_id) {
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.getMyPage(user_id);
	}
	// 사용자 삭제 메서드
	public int deleteUser(String user_id) {
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.deleteUser(user_id);
	}
	// 이름 수정 메서드
	public int editName(String user_name, String user_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_name", user_name);
		map.put("user_id", user_id);
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.editUserName(map);
	}
	// 비밀번호 수정 메서드
	public int editPw(String user_pw, String user_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_pw", user_pw);
		map.put("user_id", user_id);
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.editUserPw(map);
	}
	// 폰번호 수정 메서드
	public int editPhone(String user_phone, String user_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_phone", user_phone);
		map.put("user_id", user_id);
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.editUserPhone(map);
	}
	// 생년월일 수정 메서드
	public int editBirth(String user_birth, String user_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_birth", user_birth);
		map.put("user_id", user_id);
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.editUserBirth(map);
	}
	// 이메일 수정 메서드
	public int editEmail(String user_email, String user_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		map.put("user_id", user_id);
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.editUserEmail(map);
	}
}
