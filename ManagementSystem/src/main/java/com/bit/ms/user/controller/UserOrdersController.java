package com.bit.ms.user.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.member.model.FoodVO;
import com.bit.ms.user.model.UserOrdersVO;
import com.bit.ms.user.service.UserOrdersService;

@Controller
public class UserOrdersController {

	@Autowired
	UserOrdersService service;

	@RequestMapping("/user/userOrders")
	public String userOrders() {
		return "user/userOrders";
	}

	@RequestMapping("/user/getMenuList")
	@ResponseBody
	public List<FoodVO> getMenuList(@RequestParam("foodType") String foodType,
									@RequestParam("storeId") int storeId) {
		return service.getFoodInfo(foodType, storeId);
	}

	@RequestMapping("/user/orders")
	@ResponseBody
	public void orders(@RequestBody List<Map<String, Object>> ordersList,
						@RequestParam("userId") String userId,
						@RequestParam("storeId") int storeId) {
		
		int resultCnt = 0;
		String sb1 = "";
		String sb2 = "";
		String sb3 = "";
		String sb4 = "";
		
		for (int i = 0; i < ordersList.size(); i++) {
			String foodType = (String)ordersList.get(i).get("foodType");
			String foodName = (String)ordersList.get(i).get("foodName");
			int foodId = (Integer)ordersList.get(i).get("foodId");
			int foodCnt = (Integer)ordersList.get(i).get("foodCnt");
			
			resultCnt += service.updateStock(foodCnt, foodId, storeId); // 재고 업데이트
			
			sb1 += foodType + ",";
			sb2 += foodName + ",";
			sb3 += foodId + ",";
			sb4 += foodCnt + ",";
		}
		
		UserOrdersVO ordersVO = new UserOrdersVO();
		ordersVO.setFood_type(sb1);
		ordersVO.setFood_name(sb2);
		ordersVO.setFood_id(sb3);
		ordersVO.setFood_cnt(sb4);
		ordersVO.setUser_id(userId);
		ordersVO.setStore_id(storeId);
		
		resultCnt += service.inserOrders(ordersVO); // 주문 목록에 추가
		
		if(resultCnt == ordersList.size() + 1) {
			System.out.println("주문 및 재고 업데이트 완료");
		}
	}
}
