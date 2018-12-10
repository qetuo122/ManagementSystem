package com.bit.ms.dao;

import java.util.HashMap;
import java.util.List;

import com.bit.ms.member.model.MessageVO;
import com.bit.ms.member.model.PhotoBoardReplyVO;
import com.bit.ms.member.model.PhotoBoardVO;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserVO;

public interface MemberDaoInterface {

		//관리자 메시지, 사용자 메시지
		List<StoreVO> adminStoreList(String admin_id); //관리자가 소유한 매장목록
		List<MessageVO> getMessageList(HashMap<String,String> map); //메시지 리스트 받아오기
		List<MessageVO> userMessageList(String receive_id); //사용자의 메시지리스트 받아오기
		int writeMessage(MessageVO messageVo); // 메시지 쓰기
		int deleteMessage(int message_id); //메시지 삭제하기
		int readMessage(HashMap<String,String> map); //메시지 읽은것 확인
		int messageCnt(HashMap<String,String> map); //안읽은 메시지 카운트(관리자)
		int userMessageCnt(String receive_id); //안읽은 메시지 카운트(사용자)
		/*List<StoreVO> getStoreList(String send_id); //받는사용자의 리스트*/		
		List<UserVO> userListDistinct(); // 쪽지를 받을 사용자 리스트 받아오기
		MessageVO getMessageDetail(int message_id);
		
		//포토게시판
		int pageCount(int store_id); // 총 페이지 카운트
		List<PhotoBoardVO> selectList(int store_id, int firstlow); // 사진 리스트 뽑아오기
		int writePhotoI(PhotoBoardVO photoVo); // 사진을 제외한 등록
		int writePhotoComplete(HashMap<String,String> map); // 사진등록 
		PhotoBoardVO getPhotoViewI(int photo_id); // 사진 상세보기
		int deletePhotoI(int photo_id); // 사진삭제
		int modifyPhotoI(HashMap<String, String> map); //사진 수정
		int writePhotoReplyI(PhotoBoardReplyVO replyVo); // 사진 답글등록
		List<PhotoBoardReplyVO> getPhotoReplyListI(int photo_id); //사진 답글 리스트 추출
		int getCountReplyI(int photo_id); // 해당 게시물에 달린 댓글의 총 수를 구함
		int modiReplyI(HashMap<String,String>map); // 해당 게시물에 달린 댓글 수정
		int deleteReplyI(int photoreply_id); //해당 게시물에 달린 댓글 삭제
		int updateCnt(HashMap<String, String> map); //조회수 업데이트
}
