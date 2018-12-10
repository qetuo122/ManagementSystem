package com.bit.ms.user.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.dao.UserDaoInterface;
import com.bit.ms.member.model.StoreVO;

@Service
public class UserSearchService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	private UserDaoInterface userDao;
	private AdminDaoInterface adminDao;

	// 아이디 찾기
	public String get_searchId(String user_name, String user_phone) {

		userDao = sqlSession.getMapper(UserDaoInterface.class);
		
		System.out.println("서비스 확인" + userDao.searchId(user_name, user_phone));
		String result = "";

		try {
			result = userDao.searchId(user_name, user_phone);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("서비스 확인 :" + userDao);
		return result;
	}

	// 비밀번호 찾기
	
	
	// 매장번호 출력
	public List<StoreVO> getStoreOption(){
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.getStoreList();
	}
}
