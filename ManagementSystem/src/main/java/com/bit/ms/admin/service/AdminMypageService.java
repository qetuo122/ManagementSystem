package com.bit.ms.admin.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.StoreVO;

@Service
public class AdminMypageService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private AdminDaoInterface adminDao;
	
	//관리자 정보 가져오는 메서드
	public AdminVO getAdmin(String admin_id) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getAdminMyage(admin_id);
	}
	//해당 관리자의 매장정보를 가져오는 메서드
	public List<StoreVO> getStore(String admin_id) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		List<StoreVO> list = adminDao.getStore(admin_id);
		return list;
	}
	//매장상세정보 불러오는 매서드
	public StoreVO getStoreDetail(int store_id) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getStoreDetail(store_id);
	}
	//관리자 삭제 메서드
	public int deleteAdmin(String admin_id) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.deleteAdmin(admin_id);
	}
	/*//매장리스트 메서드
	public List<StoreVO> storeListGet(){
		
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		return adminDao.getStoreList();
	}*/
	//매장 추가메서드
	public int storeAdd(StoreVO storeVO) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.addStore(storeVO);
	}
	//매장 삭제메서드
	public void storeDelete(int store_id) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		adminDao.deleteStore(store_id);
	}
	// 관리자 이름 변경
	public int editAdminName(String admin_name, String admin_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("admin_name", admin_name);
		map.put("admin_id", admin_id);
	
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.editAdminName(map);
	}
	// 관리자 비밀번호 변경
	public int editAdminPw(String admin_pw, String admin_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("admin_pw", admin_pw);
		map.put("admin_id", admin_id);
	
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.editAdminPw(map);
	}
	// 관리자 폰번호 변경
	public int editAdminPhone(String admin_phone, String admin_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("admin_phone", admin_phone);
		map.put("admin_id", admin_id);

		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.editAdminPhone(map);
	}
}
