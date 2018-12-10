package com.bit.ms.admin.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.admin.model.SalesVO;
import com.bit.ms.admin.service.AdminSalesCalenderService;

@Controller
public class AdminSalesCalenderController {

	@Autowired
	private AdminSalesCalenderService salesService;
	
	@RequestMapping("admin/salesCalender")
	public ModelAndView adminSales(HttpSession session, Model model) {
		
		ModelAndView modelAndView = new ModelAndView();
		
		/*AdminVO userData = (AdminVO) session.getAttribute("adminSession");
		
		int storeId = userData.getStore_id();
		
		try {
			model.addAttribute("admin",salesService.getStoreId(storeId));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		List<SalesVO> list = salesService.salesList();
		
		modelAndView.addObject("salesList", list);
		modelAndView.setViewName("admin/adminSalesCalender");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "admin/salesInfo/{indexId}", method = RequestMethod.GET)
	@ResponseBody
	public List<SalesVO> salesViewList(@PathVariable("indexId") int day, int storeId, int nowMonth) {
		
		List<SalesVO> viewList = salesService.salesViewList(day, storeId, nowMonth);
		
		System.out.println("확인용 : " + viewList);
		
		return viewList;
	}
	
	@RequestMapping(value="/admin/adminSalestoExcel/{nowMonth}", method = RequestMethod.GET)
	public ModelAndView excelConvert(@PathVariable("nowMonth") int nowMonth) {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<SalesVO> list = salesService.salesLists(nowMonth);
		
		modelAndView.addObject("salesList", list);
		modelAndView.setViewName("admin/adminSalestoExcel");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="/admin/adminSalesChart/{nowMonth}", method = RequestMethod.GET)
	@ResponseBody
	public List<SalesVO> viewChart(@PathVariable("nowMonth") int nowMonth, int storeId) {
		
		List<SalesVO> viewList = salesService.salesChart(nowMonth, storeId);
		
		System.out.println("확인용 : " + viewList);
		
		return viewList;
	}
	
	
}
