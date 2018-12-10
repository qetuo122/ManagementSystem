package com.bit.ms.admin.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.service.AdminOrdersService;
import com.bit.ms.member.model.FoodVO;

@Controller
public class AdminOrdersController {
	
	@Autowired
	AdminOrdersService service;
	
	@RequestMapping(value="/admin/adminOrders")
	public String adminOrders() {
		
		return "admin/adminOrders";
	}
	
	@RequestMapping("/admin/insertFood")
	public String insertFood(FoodVO foodVO) throws IllegalStateException, IOException {
		
		int resultCnt = service.insertFood(foodVO); // 이미지를 제외한 음식 정보 저장
		
		if(resultCnt == 1) {
			System.out.println("음식 추가 성공");
			
		}
		return "redirect:/admin/adminOrders"; // 뷰 페이지만이 아닌 URL까지 변경해줘야 함
	}
	
	@RequestMapping("/admin/updateFood")
	@ResponseBody
	public void updateFood(@RequestParam("foodId") int foodId,
							@RequestParam("storeId") int storeId,
							FoodVO foodVO) {
		
		foodVO.setFood_id(foodId);
		foodVO.setStore_id(storeId);
		int resultCnt = service.updateFood(foodVO);
		
		if(resultCnt == 1) {
			System.out.println("음식 정보 업데이트 성공");
		}
	}

	@RequestMapping("/admin/deleteFood")
	@ResponseBody
	public void deleteProduct(@RequestParam("foodId") int foodId,
								@RequestParam("storeId") int storeId) {
		
		int resultCnt = service.deleteFood(foodId, storeId);
		
		if(resultCnt == 1) {
			System.out.println("음식 삭제 성공");
		}
	}
	
	@RequestMapping("/admin/getFoodInfoAll")
	@ResponseBody
	public List<FoodVO> getFoodInfoAll(@RequestParam("storeId") int storeId){
		return service.getFoodInfoAll(storeId);
	}
	
	@RequestMapping("/admin/processOrders")
	@ResponseBody
	public void processOrders(@RequestParam("ordersId") int ordersId,
								@RequestParam("storeId") int storeId) {
		
		int resultCnt = service.processOrders(ordersId, storeId);
		
		if(resultCnt == 1) {
			System.out.println("주문 목록 삭제");
		}
	}
}
