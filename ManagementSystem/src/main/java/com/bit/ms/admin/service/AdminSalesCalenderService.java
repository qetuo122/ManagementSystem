package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.SalesVO;
import com.bit.ms.dao.AdminDaoInterface;

@Service
public class AdminSalesCalenderService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private AdminDaoInterface salesDao;
	
	public List<SalesVO> salesList() {
		
		salesDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		List<SalesVO> list = null;
		
		try {
			list = salesDao.listAll();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
		
	}

	
	public List<SalesVO> salesViewList(int day, int storeId, int nowMonth) {
		// TODO Auto-generated method stub

		salesDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		List<SalesVO> viewList = null;
		
		try {
			viewList = salesDao.listSales(day, storeId, nowMonth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return viewList;
	}
	

	public Object getStoreId(int storeId) throws Exception {
		// TODO Auto-generated method stub
		
		salesDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		
		return salesDao.getStoreId(storeId).get(0);
	};
	
	public List<SalesVO> salesLists(int nowMonth) {
		
		salesDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		List<SalesVO> list = null;
		
		try {
			list = salesDao.listAlls(nowMonth);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
		
	}
	
	public List<SalesVO> salesChart(int nowMonth, int storeId) {
		
		salesDao = sqlSessionTemplate.getMapper(AdminDaoInterface.class);
		List<SalesVO> list = null;
		
		try {
			list = salesDao.chartList(nowMonth, storeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
		
	}
	
}
