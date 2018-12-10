package com.bit.ms.user.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.UserDaoInterface;
import com.bit.ms.member.model.FoodVO;
import com.bit.ms.user.model.UserOrdersVO;

@Service
public class UserOrdersService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private UserDaoInterface userDao;
	   
	public List<FoodVO> getFoodInfo(String foodType, int storeId) {
		
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.getFoodInfo(foodType, storeId);
	}
	
	public int inserOrders(UserOrdersVO ordersVO) {
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.insertOrders(ordersVO);
	}
	
	public int updateStock(int foodCnt, int foodId, int storeId) {
		userDao = sqlSessionTemplate.getMapper(UserDaoInterface.class);
		return userDao.updateStock(foodCnt, foodId, storeId);
	}
}
