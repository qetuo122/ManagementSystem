package com.bit.ms.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.member.model.MessageVO;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.member.service.MemberMessageService;
import com.bit.ms.user.model.UserVO;

@Controller
public class MemberMessageController {

	@Autowired
	private MemberMessageService service;
	
	//관리자가 갖고있는 매장목록 가져옴
	@RequestMapping(value = "/admin/storeList", method = RequestMethod.GET)
	public @ResponseBody List<StoreVO> getAdminStoreList(HttpSession session){
		AdminVO adminVo = (AdminVO) session.getAttribute("adminSession");
		String admin_id = adminVo.getAdmin_id();
		
		return service.adminStoreListGet(admin_id);
	}
	//관리자와 매장아이디를 조건으로 메시지 리스트를 뽑음
	@RequestMapping(value = "admin/message", method = RequestMethod.POST)
	public @ResponseBody List<MessageVO> getAdminMessageList(String store_name, String receive_id){
		//System.out.println(store_name + ":" + receive_id); 
		return service.getMessageList(store_name, receive_id);
	}
	//사용자아이디를 조건으로 메시지 리스트를 뽑음
	@RequestMapping(value = "user/message", method = RequestMethod.GET)
	public @ResponseBody List<MessageVO> getUserMessageList(HttpSession session) {
		
		//세션에서 받는사람 아이디와 매장아이디를 불러옴
		UserVO userVo = (UserVO) session.getAttribute("userSession");
		String receive_id = userVo.getUser_id(); //받는사람 아이디
				
		return service.getUserMessageList(receive_id);
				
	}
	// 메시지 쓰기
	@RequestMapping(value = "member/writeMessage")
	public @ResponseBody int writeMessage(MessageVO messageVo) {
		System.out.println("메시지 작성 성공 : " + messageVo);

		return service.messageWrite(messageVo);
		
	}
	//메시지 삭제
	@RequestMapping(value = "member/deleteMessage/{id}")
	public @ResponseBody int deleteMessage(@PathVariable("id") int message_id) {
	
		return service.messageDelete(message_id);
		
	}
	//메시지를 읽었을경우
	@RequestMapping(value = "member/readMessage", method = RequestMethod.POST)
	public @ResponseBody int readMessage(String message_read,  int message_id) {
		System.out.println(message_read);
		return service.messageRead(message_id,message_read);
		
	}
	//관리자 안읽은 메시지 카운트
	@RequestMapping(value = "admin/messageCnt")
	public @ResponseBody int cntAdminMessage(HttpSession session) {
		
		StoreVO storeVo = (StoreVO) session.getAttribute("storeSelectSession");
		String receive_id = storeVo.getStore_name();
		String store_id = Integer.toString(storeVo.getStore_id()); 
		//System.out.println(store_id + " : " + receive_id);
		
		return service.messageCnt(receive_id, store_id);
	}
	//사용자 안읽은 메시지 카운트
	@RequestMapping(value = "user/messageCnt")
	public @ResponseBody int cntUserMessage(HttpSession session) {		
		
		UserVO userVo = (UserVO) session.getAttribute("userSession");
		String receive_id = userVo.getUser_id();
			
		return service.userMessageCnt(receive_id);
	}
	//사용자 리스트를 받아오기
	@RequestMapping(value = "member/sendList", method = RequestMethod.GET)
	public @ResponseBody List<UserVO> getReceiveList() {
		return service.getUserListDinstinct();
	}
	//받는 사람 아이디에 해당하는 매장이름 받아오기(관리자용)
	/*@RequestMapping(value = "member/sendStore/{id}")
	public @ResponseBody List<StoreVO> getReceiveStoreId(@PathVariable("id") String send_id){
		
		return service.getStoreName(send_id);
	}*/
	//메시지 세부목록 불러오기
	@RequestMapping(value = "member/messageDetail/{message_id}", method = RequestMethod.GET)
	public @ResponseBody MessageVO getMessageDetail(@PathVariable("message_id") int message_id){
		return service.messageDetail(message_id);
	}
}
