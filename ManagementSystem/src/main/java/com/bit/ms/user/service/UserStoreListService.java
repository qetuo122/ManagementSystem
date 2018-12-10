package com.bit.ms.user.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.UserDaoInterface;
import com.bit.ms.member.model.StoreVO;

@Service
public class UserStoreListService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private UserDaoInterface userDao;

	public List<StoreVO> get_storeList(HttpSession session) {

		System.out.println("서비스 접속 확인");

		userDao = sqlSession.getMapper(UserDaoInterface.class);

		List<StoreVO> result = null;

		try {
			result = userDao.getStoreAllList();
		} catch (Exception e) {
			e.printStackTrace();
		}

		session.setAttribute("storeSession", result);
		System.out.println("전체 스토어세션 storeSession : " + session.getAttribute("storeSession"));

		return result;
	}

}
