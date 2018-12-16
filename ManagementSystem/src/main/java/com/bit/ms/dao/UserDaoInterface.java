package com.bit.ms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.ms.member.model.FoodVO;
import com.bit.ms.member.model.SeatVO;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserBoardReplyVO;
import com.bit.ms.user.model.UserBoardVO;
import com.bit.ms.user.model.UserOrdersVO;
import com.bit.ms.user.model.UserVO;

public interface UserDaoInterface {

	/* 유저정보관련 */
	int regUser(UserVO userVO) throws SQLException;// 유저 회원가입 메서드
	int GetKey(String user_id, String user_key); // 유저 인증키 생성 메서드
	int alter_userKey(String user_id, String key); // 유저 인증키 Y로 바꿔주는 메서드
	int searchPassword(String user_id, String user_email, String key); // 회원 임시 비밀번호 변경 메서드
	UserVO loginUser(@Param("user_id")String user_id);// 유저 로그인 메서드
	int update_store_id_S(String user_id, int store_id); // 유저 로그인시 store_id 저장
	String searchId(@Param("user_name")String user_name, @Param("user_phone")String user_phone);// 유저 ID 찾기
	UserVO userInfo(String user_id);
	UserVO searchPw(String userId);// 유저 PW 찾기
	UserVO getMyPage(String user_id);// 마이페이지 메서드
	int editUserName(HashMap<String,String> map);// 유저 이름 수정
	int editUserPhone(HashMap<String,String> map);// 유저 폰번호 수정
	int editUserBirth(HashMap<String,String> map);// 유저 생년월일 수정
	int editUserPw(HashMap<String,String> map);// 유저 비밀번호 수정
	int editUserEmail(HashMap<String,String> map);// 유저 이메일 수정
	int deleteUser(String user_id);// 유저 삭제
	int checkOverId(String user_id);// 아이디 중복 체크
	int checkOverEmail(String user_email);// 이메일 중복 체크
	String checkOverPhoneNum(String userPhone);// 유저 전화번호 중복 체크
	StoreVO getUserStoreVO(int store_id); // 유저로그인한 스토어id로 스토어VO가져옴
	int getSocialId(@Param("id")String id, @Param("divide")String divide); // 소셜로그인 아이디로 가입여부 확인
	UserVO getSocialIdToInfo(@Param("id")String id, @Param("divide")String divide); // 쇼셜아이디를 통해 유저정보를 가져옴
	List<StoreVO> getStoreAllList(); //모든 매장 정보
	
	/* 유저게시판 */	
	List<UserBoardVO> UserBoardSelectList(int store_id, String keyword, int firstRow);
	int UserBoardTotalCount(int store_id, String keyword);
	int insertUserBoard(UserBoardVO userBoardVO);
	UserBoardVO getUserBoardViewI(int uboard_id);
	int UserBoardDeleteI(int uboard_id);
	int UserBoardModifyI(UserBoardVO userBoardVO);
	int getPreviousNUM(@Param("uboard_id") int uboard_id, @Param("store_id") int store_id , @Param("keyword") String keyword);
	int getNextNUM(@Param("uboard_id") int uboard_id, @Param("store_id") int store_id, @Param("keyword") String keyword);
	List<UserBoardVO> getUserBoardNoticeI(int store_id, String admin_id);
	
	/* 유저게시판 댓글 */
	List<UserBoardReplyVO> getUserBoardReplyListI(int uboard_id);
	int UserBoardReplyInsertI(UserBoardReplyVO userBoardReplyVO);
	int UserBoardReplyDeleteI(int uboard_reply_id);
	int UserBoardReplyModifyI(UserBoardReplyVO userBoardReplyVO);
	
	/* 좌석 선택 및 시간 충전 */
	int updateAddTime(long addTime, int userPay, String userId, int storeId);
	int updateSaveTime(String userId, int storeId);
	int updateSeat(String userId, int seatId, int storeId);
	int deleteUsingInfo(String userId, int storeId);
	List<SeatVO> getSeatListAll(int storeId);
	
	/* 음식 주문 */
	List<FoodVO> getFoodInfo(String foodType, int storeId);
	int insertOrders(UserOrdersVO ordersVO);
	int updateStock(int foodCnt, int foodId, int storeId);
	
	// qr로그인시 남은시간있는지 확인
	Long getUserTimeI(String user_id);
	String getUserIdI(String user_id);
	List<SeatVO> getUserListI(int store_id);
}
