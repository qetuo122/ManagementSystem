package com.bit.ms.user.service;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.dao.UserDaoInterface;
import com.bit.ms.member.model.StoreVO;
import com.bit.ms.user.model.UserBoardListVO;
import com.bit.ms.user.model.UserBoardReplyVO;
import com.bit.ms.user.model.UserBoardVO;
import com.bit.ms.user.model.UserVO;

@Service
public class UserBoardService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;

	private UserDaoInterface userDaoInterface;

	// List
	// 페이지마다 보여줄 게시글의 수
	private static final int USERBOARD_COUNT_PER_PAGE = 10;

	public UserBoardListVO getUserBoardList(HttpSession session, HttpServletRequest request, String keyword) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		StoreVO storevo = (StoreVO) session.getAttribute("storeSelectSession");

		int store_id = storevo.getStore_id();

		System.out.println("서비스 store_id = " + store_id);

		String pageParam = request.getParameter("page");

		int currentPageNum = 1;

		if (pageParam != null) {
			currentPageNum = Integer.parseInt(pageParam);
		}

		int userBoardTotalCount = 0;

		List<UserBoardVO> userBoardList = null;

		int firstRow = 0;

		// HashMap<String, Object> map = new HashMap<String, Object>();

		try {

			// 전체 게시글 구하기
			userBoardTotalCount = userDaoInterface.UserBoardTotalCount(store_id, keyword);

			if (userBoardTotalCount > 0) {

				firstRow = (currentPageNum - 1) * USERBOARD_COUNT_PER_PAGE; // mysql은 0열부터 시작 -1을 해줌

				userBoardList = userDaoInterface.UserBoardSelectList(store_id, keyword, firstRow);

			} else { // 없는경우
				userBoardList = Collections.emptyList();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 페이지 수(나눌때 정확한 값을 얻기위해 double로 형변환)
		int userBoardPageTotalCount = (int) Math.ceil(userBoardTotalCount / (double) USERBOARD_COUNT_PER_PAGE);
		System.out.println("UserBoardService || 페이지 수 : " + userBoardPageTotalCount);

		return new UserBoardListVO(userBoardList, userBoardTotalCount, currentPageNum, userBoardPageTotalCount,
				USERBOARD_COUNT_PER_PAGE, firstRow);

	}

	public List<UserBoardVO> getUserBoardNoticeS(HttpSession session) { // 공지사항 받을것

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		StoreVO storevo = (StoreVO) session.getAttribute("storeSelectSession");

		int store_id = storevo.getStore_id();

		String admin_id = storevo.getAdmin_id();

		List<UserBoardVO> userboardnotice = null;

		try {
			userboardnotice = userDaoInterface.getUserBoardNoticeI(store_id, admin_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userboardnotice;
	}

	public UserBoardVO userBoardWrite(UserBoardVO userBoardVO, HttpSession httpsession) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		UserVO userVO = (UserVO) httpsession.getAttribute("userSession");
		AdminVO adminVO = (AdminVO) httpsession.getAttribute("adminSession");
		StoreVO storeVO = (StoreVO) httpsession.getAttribute("storeSelectSession");

		if (adminVO == null) {
			userBoardVO.setWriter_id(userVO.getUser_id());
		} else {
			userBoardVO.setWriter_id(adminVO.getAdmin_id());
		}
		userBoardVO.setStore_id(storeVO.getStore_id());

		System.out.println("UserBoardService Write > BEFORE || userBoardVO : " + userBoardVO);

		int resultCnt = 0;

		try {
			resultCnt = userDaoInterface.insertUserBoard(userBoardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("UserBoardService Write > AFTER || userBoardVO : " + userBoardVO);

		return userBoardVO;
	}

	public int UserBoardDeleteS(int uboard_id) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		int resultCnt = 0;

		try {
			resultCnt = userDaoInterface.UserBoardDeleteI(uboard_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;

	}

	public int UserBoardModifyS(UserBoardVO userBoardVO) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		int resultCnt = 0;

		try {
			resultCnt = userDaoInterface.UserBoardModifyI(userBoardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;

	}

	// ViewViewViewViewViewViewViewViewViewViewViewViewViewViewViewViewView

	public UserBoardVO getUserBoardViewS(int uboard_id) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		UserBoardVO userBoardVO = null;

		try {
			userBoardVO = userDaoInterface.getUserBoardViewI(uboard_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return userBoardVO;
	}

	public int getViewPreviousNUM(HttpSession session, int uboard_id, String keyword) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		StoreVO storevo = (StoreVO) session.getAttribute("storeSelectSession");

		int store_id = storevo.getStore_id();

		int num = 0;

		try {
			num = userDaoInterface.getPreviousNUM(uboard_id, store_id, keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return num;
	}

	public int getViewNextNUM(HttpSession session, int uboard_id, String keyword) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		StoreVO storevo = (StoreVO) session.getAttribute("storeSelectSession");

		int store_id = storevo.getStore_id();

		int num = 0;

		try {
			num = userDaoInterface.getNextNUM(uboard_id, store_id, keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return num;
	}

	// 댓글
	public List<UserBoardReplyVO> getUserBoardReplyListS(int uboard_id) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		List<UserBoardReplyVO> UserBoardList = null;

		try {
			UserBoardList = userDaoInterface.getUserBoardReplyListI(uboard_id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return UserBoardList;

	}

	public int UserBoardReplyInsertS(UserBoardReplyVO userBoardReplyVO) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		int resultCnt = 0;
		try {
			resultCnt = userDaoInterface.UserBoardReplyInsertI(userBoardReplyVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultCnt;
	}

	public int UserBoardReplyDeleteS(int uboard_reply_id) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		int resultCnt = 0;
		try {
			resultCnt = userDaoInterface.UserBoardReplyDeleteI(uboard_reply_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultCnt;
	}

	public int UserBoardReplyModifyS(UserBoardReplyVO userBoardReplyVO) {

		userDaoInterface = sessionTemplate.getMapper(UserDaoInterface.class);

		int resultCnt = 0;
		try {
			resultCnt = userDaoInterface.UserBoardReplyModifyI(userBoardReplyVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultCnt;
	}

}
