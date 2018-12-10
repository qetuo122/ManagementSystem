package com.bit.ms.member.service;

import java.util.Collections;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.ms.admin.model.NoticeVO;
import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.NoticeListVO;

@Service
public class MemberNoticeBoardService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;

	private AdminDaoInterface daoInterface;

	// 페이지마다 보여줄 게시글의 수
	private static final int NOTICE_COUNT_PER_PAGE = 10;

	@Transactional
	public NoticeListVO getNoticeList(int pageNum) throws Exception {
		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		int currentPageNum = pageNum;

		// 전체 게시글 구하기
		int noticeTotalCount = daoInterface.pageCount();
		List<NoticeVO> noticeList = null;
		int firstRow = 0;

		if (noticeTotalCount > 0) {
			firstRow = (pageNum - 1) * NOTICE_COUNT_PER_PAGE + 1;
			noticeList = daoInterface.selectList(firstRow - 1); // mysql은 0열부터 시작 -1을 해줌
		} else {
			currentPageNum = 0;
			noticeList = Collections.emptyList();
		}
		return new NoticeListVO(noticeList, noticeTotalCount, currentPageNum, NOTICE_COUNT_PER_PAGE, firstRow);
	}

	// 공지사항 글 상세보기 서비스
	@Transactional
	public NoticeVO getView(int id) {

		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		NoticeVO no = null;
		try {
			no = daoInterface.selectView(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return no;
	}
}
