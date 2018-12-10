package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.StoreVO;

@Service
public class AdminSearchService {

	@Autowired
	private SqlSessionTemplate sqlSession;	
	private AdminDaoInterface adminDao;
	
	public List<StoreVO> adminSearchId() {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.getStoreList();
	}
	
	
}
