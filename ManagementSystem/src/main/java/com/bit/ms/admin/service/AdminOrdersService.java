package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.FoodVO;

@Service
public class AdminOrdersService {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	AdminDaoInterface adminDao;
	
	public int insertFood(FoodVO foodVO) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.insertFood(foodVO);
	}

	public int updateFood(FoodVO foodVO) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.updateFood(foodVO);
	}
	
	public int deleteFood(int foodId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.deleteFood(foodId, storeId);
	}
	
	public List<FoodVO> getFoodInfoAll(int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.getFoodInfoAll(storeId);	
	}
	
	public int processOrders(int ordersId, int storeId) {
		adminDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		return adminDao.processOrders(ordersId, storeId);
	}
}
