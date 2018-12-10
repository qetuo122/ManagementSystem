package com.bit.ms.admin.service;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.admin.model.AdminBoardListVO;
import com.bit.ms.admin.model.AdminBoardReplyVO;
import com.bit.ms.admin.model.AdminBoardVO;
import com.bit.ms.dao.AdminDaoInterface;

@Service
public class AdminCEOBoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	private AdminDaoInterface adminDao;
	
	// 페이지 마다 보여줄 게시글의 갯수
	private static final int CEOBOARD_COUNT_PER_PAGE = 10;
	// 게시글 리스트 불러는 메서드
	public AdminBoardListVO cBoardContentList(HttpServletRequest request, String keyword) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		String pageParam = request.getParameter("page"); // keyword와 같이 param 이지만 다르게 받음
		int currentPageNum = 1;
		
		// int형으로 안 받아지기 때문에 String 값으로 받은 뒤 형변환을 해주었다.
		if(pageParam != null) {
			currentPageNum = Integer.parseInt(pageParam);
		}
		// 총 페이지 수
		int ceoBoardTotalCount = 0;
		List<AdminBoardVO> ceoBoardList = null;
		int firstRow = 0;
		
		System.out.println("서비스는 나오지?");
		
		try{
			// 전체 게시글 구하기
			ceoBoardTotalCount = adminDao.CEOBOardTotalCount(keyword);
			
			if(ceoBoardTotalCount > 0) {
				// mysql은 0열부터 시작 -1을 해줌
				firstRow = (currentPageNum - 1) * CEOBOARD_COUNT_PER_PAGE;
				ceoBoardList = adminDao.contentList(firstRow, keyword);
				
				System.out.println("1" + ceoBoardList);
				
			} else { // 없을 경우
				ceoBoardList = Collections.emptyList();
				System.out.println("2" + ceoBoardList);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		// 페이지 수(나눌때 정확한 값을 얻기 위해 double로 형변환)
		int ceoBoardPageTotalCount = (int) Math.ceil(ceoBoardTotalCount / (double) CEOBOARD_COUNT_PER_PAGE);
		System.out.println("CEOboardService 진입 - 페이지 수 :" + ceoBoardPageTotalCount);
		
		return new AdminBoardListVO(ceoBoardTotalCount, currentPageNum, ceoBoardList, ceoBoardPageTotalCount, CEOBOARD_COUNT_PER_PAGE, firstRow);
	}
	

	// 게시글 작성 메서드
	public int CEOBoardWrite(AdminBoardVO ceoBoardVO) {
		
		// 초기값 0, 게시글 추가 되면 1
		int result = 0;
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		result = adminDao.CEOWriteReg(ceoBoardVO);
		
		return result;
	}
	
	
	// 게시글 내용 보기 메서드
	public AdminBoardVO cBoardContent(int cboard_id) {
		
		System.out.println("서비스단 게시글 번호" + cboard_id);
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.contentView(cboard_id);
	}
	
	// view 페이지에서 페이지 이동
	public int previousPageMove(int cboard_id, String keyword) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		// 첫번째 게시글 0
		int num = 0;
		
		try {
			num = adminDao.getPreviousPage(cboard_id, keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return num;
	}

	public int nextPageMove(int cboard_id, String keyword) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		int num = 0;
		
		try {
			num = adminDao.getNextPage(cboard_id, keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return num;
	}
	
	// 게시글 지우기
	public int CEOBoardDeleteService(int cboard_id) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.contentDel(cboard_id);
	}
	
	
	// 게시글 수정하기
	public int modifyCEOBoardContent(AdminBoardVO ceoVO) {
		System.out.println("게시글 수정 서비스 : 진입");
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.contentModi(ceoVO);
	}
	
	// 댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글
	//댓글 리스트 불러오기
	public List<AdminBoardReplyVO> getAdminReplyList(int cboard_id){
	
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.getReplyList(cboard_id);
	}
	
	// 댓글 적기
	public int writeReply(AdminBoardReplyVO replyVO) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.CEOBoardReplyInsert(replyVO);
	}
	
	// 댓글 삭제
	public int deleteReply(int cboard_reply_id) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.CEOBoardReplyDelete(cboard_reply_id);
	}
	
	// 댓글 수정
	public int modifyReply(AdminBoardReplyVO replyVO) {
		
		adminDao = sqlSession.getMapper(AdminDaoInterface.class);
		
		return adminDao.CEOBoardReplyModify(replyVO);
	}
}
