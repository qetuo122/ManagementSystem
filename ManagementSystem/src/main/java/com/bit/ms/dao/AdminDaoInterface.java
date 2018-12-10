package com.bit.ms.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.ms.admin.model.AdminBoardReplyVO;
import com.bit.ms.admin.model.AdminBoardVO;
import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.admin.model.NoticeVO;
import com.bit.ms.admin.model.SalesVO;
import com.bit.ms.admin.model.UserListVO;
import com.bit.ms.member.model.FoodVO;
import com.bit.ms.member.model.ReplyVO;
import com.bit.ms.member.model.SeatVO;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserOrdersVO;
import com.bit.ms.user.model.UserVO;

public interface AdminDaoInterface {

	/*관리자정보관련*/
	int regAdmin(AdminVO adminVO);// admin 회원가입
	int checkOverId(String admin_id);// admin 아이디 중복 검사
	AdminVO loginAdmin(@Param("admin_id")String admin_id);// admin 로그인
	AdminVO getAdminMyage(String admin_id);// 관리자 마이페이지
	List<StoreVO> getStore(String admin_id);// 관리자의 해당 매장정보를 가져오는
	int editAdminName(HashMap<String, String> map); // 관리자 이름 변경
	int editAdminPw(HashMap<String, String> map); // 관리자 비밀번호 변경
	int editAdminPhone(HashMap<String, String> map); // 관리자 폰번호 변경
	int deleteAdmin(String admin_id);// 관리자 삭제
	StoreVO getStoreDetail(int store_id); //매장 상세정보
	int addStore(StoreVO storeVO); //매장 추가
	void deleteStore(int store_id); //소유한 매장삭제하기
	List<StoreVO> getStoreList();//매장 정보 가져오기
	String search_adminId(@Param("inputName_1") String admin_name, @Param("inputPhone_1") String admin_phone, @Param("search_store1") String admin_storeId); // 관리자 아이디 찾기
	int getSelectStoreName(String re_name);//매장중복검사
	
	/*공지사항 게시글*/
	void insertNotice(NoticeVO noticeVO) throws Exception;
	int pageCount() throws Exception;
	List<NoticeVO> selectList(int firstRow) throws Exception;
	NoticeVO selectView(int noticeId) throws Exception;
	void deleteNotice(int id) throws Exception;
	void updateNotice(NoticeVO noticeVO) throws Exception;
	
	/*공지사항 댓글*/
	List<ReplyVO> replyList(int id) throws Exception;
	void insertReply(ReplyVO vo) throws Exception;
	void updateReply(ReplyVO vo) throws Exception;
	void deleteReply(int id) throws Exception;
	
	/*CEO게시판*/
	List<AdminBoardVO> contentList(int firstRow, String keyword); // CEO 게시판 리스트
	int CEOWriteReg(AdminBoardVO ceoBoardVO); // CEO 게시판 게시글 등록
	AdminBoardVO contentView(int cboard_id); // CEO 게시글 읽기
	int contentDel(int cboard_id); // 게시글 삭제하기
	int contentModi(AdminBoardVO ceoVO); // 게시글 수정하기
		/*CEO게시판 페이징 처리*/
	int CEOBOardTotalCount(String keyword); // 총 페이지 갯수
	int getPreviousPage(@Param("cboard_id") int cboard_id, @Param("keyword") String keyword); // 이전 페이지
	int getNextPage(@Param("cboard_id") int cboard_id, @Param("keyword") String keyword); // 다음 페이지
		/*CEO게시판 댓글*/
	List<AdminBoardReplyVO> getReplyList(int cboard_id); // CEO게시판 댓글 불러오기
	int CEOBoardReplyInsert(AdminBoardReplyVO replyVO); // 댓글 작성	
	int CEOBoardReplyDelete(int cboard_reply_id); // 댓글 삭제
	int CEOBoardReplyModify(AdminBoardReplyVO replyVO); // 댓글 수정
	
	/*회원리스트 관련*/
	List<UserVO> getUserList();//회원리스트 전체 출력
	List<UserVO> sortingUserList(UserListVO userListVO); //클릭한 열로 정렬
	List<StoreVO> getStoreName(@Param("admin_id")String id); //관리자 아이디로 자신의 전체스토어 출력
	
	/* 매출기록 관련 */
	public List<SalesVO> listAll() throws Exception; // 매출기록 리스트 출력
	List<SalesVO> listSales(@Param("day")int day, @Param("storeId")int storeId, @Param("nowMonth")int nowMonth) throws Exception;
	List<SalesVO> getStoreId(int storeId) throws Exception;
	List<SalesVO> listAlls(int nowMonth) throws Exception;
	List<SalesVO> chartList(@Param("nowMonth")int nowMonth, @Param("storeId")int storeId) throws Exception;
	
	/* 좌석관리 */
	List<SeatVO> getSeatListI(@Param("store_id") int store_id,@Param("order_by") String order_by,@Param("sort") String sort);
	int addSeatI(SeatVO seatVO);
	int deleteSeatI(int seat_id);
	int modifySeatI(SeatVO seatVO);
	int addQrI(HashMap<String,String>map); // qr코드 추가
	String getQrI(int seat_id); // qr코드 불러오기
	
	/* 사용자 시간 관리 */
	int updateAddTime(long addTime, String userId, int storeId);
	int deleteSeat(String userId, int storeId);
	UserVO getUserInfo(String userId, int storeId);
	List<UserOrdersVO> getOrdersInfo(String userId, int storeId);
	List<SeatVO> getSeatListAll(int storeId);
	
	/* 상품관리 */
	int insertFood(FoodVO foodVO);
	int updateFood(FoodVO foodVO);
	int deleteFood(int foodId, int storeId);
	List<FoodVO> getFoodInfoAll(int storeId);
	int processOrders(int ordersId, int storeId);
}
