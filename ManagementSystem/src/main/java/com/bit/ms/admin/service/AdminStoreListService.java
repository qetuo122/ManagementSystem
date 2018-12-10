package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.StoreVO;

@Service
public class AdminStoreListService {

	@Autowired
	private SqlSessionTemplate adminSqlSession;
	private AdminDaoInterface adminDao;
	
	public List<StoreVO> get_storeList(){
		
		System.out.println("서비스 접속 확인");
		adminDao = adminSqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.getStoreList();
	}
	
}
