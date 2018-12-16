package com.bit.ms.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.admin.service.AdminMypageService;
import com.bit.ms.member.model.StoreVO;

@Controller
public class AdminMypageController {
	
	@Autowired
	private AdminMypageService service;
	
	@RequestMapping("/admin/adminMypage")
	public String adminMypage(HttpSession session, Model model) {
		
		AdminVO adminVo = (AdminVO) session.getAttribute("adminSession");
		String admin_id = adminVo.getAdmin_id();

		model.addAttribute("admin",service.getAdmin(admin_id));
		model.addAttribute("store",service.getStore(admin_id));
		
		return "admin/adminMypage";
	}
	
	@RequestMapping(value = "/admin/adminMypage/{store_id}", method = RequestMethod.GET)
	public @ResponseBody StoreVO store(@PathVariable("store_id") int store_id) {
		
		StoreVO store = service.getStoreDetail(store_id);
		
		return store;
	}
	//관리자 삭제
	@RequestMapping("/admin/adminDelete")
	public String delete(AdminVO adminVo) {
		
		String admin_id = adminVo.getAdmin_id();
		service.deleteAdmin(admin_id);
		
		return "admin/adminMypage";
	}
	//관리자 이름
	@RequestMapping(value = "/admin/adminEditname", method = RequestMethod.POST)
	public @ResponseBody int adminEditName(AdminVO adminVo) {
		String admin_name = adminVo.getAdmin_name();
		String admin_id = adminVo.getAdmin_id();
		return service.editAdminName(admin_name, admin_id); 
	}
	//관리자 비밀번호
		@RequestMapping(value = "/admin/adminEditpw", method = RequestMethod.POST)
	public @ResponseBody int adminEditPw(AdminVO adminVo) {
		String admin_pw = adminVo.getAdmin_pw();
		String admin_id = adminVo.getAdmin_id();
		return service.editAdminPw(admin_pw, admin_id); 
	}
	//관리자 폰번호
	@RequestMapping(value = "/admin/adminEditphone", method = RequestMethod.POST)
	public @ResponseBody int adminEditPhone(AdminVO adminVo) {
		String admin_phone = adminVo.getAdmin_phone();
		String admin_id = adminVo.getAdmin_id();
		return service.editAdminPhone(admin_phone, admin_id); 
	}
	/*//관리자 매장 추가
	@RequestMapping(value = "/admin/adminStoreAdd", method = RequestMethod.GET)
	public @ResponseBody List<StoreVO> getStoreList(){
		
		// 스토어리스트를 받아옴
		return service.storeListGet();
	}*/
	//관리자 매장 추가
	@RequestMapping(value = "/admin/adminStoreAdd", method = RequestMethod.POST)
	public String addStore(StoreVO storeVO) {
		
		System.out.println("매장등록시 정보 : " + storeVO);
		//선택된 매장아이디를 포함해 새로 회원가입
		service.storeAdd(storeVO);
		
		return "admin/adminMypage";
	}
	//관리자 매장 삭제
	@RequestMapping(value = "/admin/adminStoreDelete", method = RequestMethod.POST)
	public String deleteStore(AdminVO adminVo, HttpSession session) {
		//System.out.println("삭제 : " + adminVo);
		int store_id = adminVo.getStore_id();
		StoreVO storeDetail = service.getStoreDetail(store_id); // 해당 매장의 정보를 가져옴
		
		@SuppressWarnings("unchecked")
		List<StoreVO> list = (List<StoreVO>) session.getAttribute("storeSession"); //모든 매장정보의 세션을 가져옴
		
		// 세션을 리스트로 받아온후 get으로 하나씩 뽑아와서 삭제대상 매장과 비교한 후 일치하면 세션에서 삭제 ㄱㄱ
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getStore_id() == storeDetail.getStore_id()) {
				list.remove(list.get(i));
			}
		}
		
		session.setAttribute("storeSession", list); // 지운 리스트를 세션에 저장
		service.storeDelete(store_id); // DB에서 지움
		
		return "admin/adminMypage";
	}
}
