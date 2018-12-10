package com.bit.ms.member.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.MemberDaoInterface;
import com.bit.ms.member.model.MessageVO;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserVO;

@Service
public class MemberMessageService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private MemberDaoInterface memberDao;
	
	//관리자가 갖고있는 매장리스트 뽑는 메서드
	public List<StoreVO> adminStoreListGet(String admin_id){
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.adminStoreList(admin_id);
	}
	//메시지리스트를 가져오는 메서드
	public List<MessageVO> getMessageList(String store_name, String receive_id){
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("receive_id", receive_id);
		map.put("store_name", store_name);
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		List<MessageVO> list = memberDao.getMessageList(map); //받아온 메시지를 리스트에 담음
		
		return list;
	}
	//사용자의 메시지리스트 가져오는 메서드
	public List<MessageVO> getUserMessageList(String receive_id){
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		List<MessageVO> list = memberDao.userMessageList(receive_id); //받아온 메시지를 리스트에 담음
		
		return list;
	}
	//메시지를 쓰는 메서드
	public int messageWrite(MessageVO messageVo) {
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.writeMessage(messageVo);
		
	}
	//메시지 삭제하는 메서드
	public int messageDelete(int message_id) {
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.deleteMessage(message_id);
		
	}
	//메시지 읽은것을 확인하는 메서드
	public int messageRead(int message_id, String message_read) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("message_read", message_read);
		map.put("message_id", Integer.toString(message_id));
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.readMessage(map);
	}
	//안읽은 메시지 카운트(관리자)
	public int messageCnt(String receive_id, String store_id) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("receive_id", receive_id);
		map.put("store_id", store_id);
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.messageCnt(map);
	}
	//안읽은 메시지 카운트(사용자)
	public int userMessageCnt(String receive_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.userMessageCnt(receive_id);
	}
	/*//사용자의 매장이름을 가져옴
	public List<StoreVO> getStoreName(String send_id){
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.getStoreList(send_id);
	}*/
	//사용자 중복아이디를 제외한 리스트 받아오기
	public List<UserVO> getUserListDinstinct(){
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.userListDistinct();
		
	}
	public MessageVO messageDetail(int message_id){
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.getMessageDetail(message_id);
	}
	
}
