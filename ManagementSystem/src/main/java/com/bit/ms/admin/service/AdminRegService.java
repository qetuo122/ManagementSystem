package com.bit.ms.admin.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.dao.AdminDaoInterface;

@Service
public class AdminRegService {

	@Autowired
	private SqlSessionTemplate adminSqlSession;
	private AdminDaoInterface adminDao;
	
	public int adminReg_service(AdminVO adminVO) {
		
		int result = 0;
		
		adminDao = adminSqlSession.getMapper(AdminDaoInterface.class);
		result = adminDao.regAdmin(adminVO);
		
		return result;
	}

	// 아이디 중복 체크
	public int adminIdCheck(String admin_id) {

		int result = 0;
		adminDao = adminSqlSession.getMapper(AdminDaoInterface.class);
		result = adminDao.checkOverId(admin_id);
		
		return result;
	}

	public int getSelectStoreName(String re_name) {

		adminDao = adminSqlSession.getMapper(AdminDaoInterface.class);
		int result = adminDao.getSelectStoreName(re_name);
		
		return result;
	}
}
