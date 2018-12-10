package com.bit.ms.admin.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.ms.admin.model.NoticeVO;
import com.bit.ms.dao.AdminDaoInterface;

@Service
public class AdminNoticeBoardService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;

	private AdminDaoInterface adminDaoInterface;

	//공지사항 글 삭제
	@Transactional
	public void noticeDelete(int id) {
		adminDaoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			adminDaoInterface.deleteNotice(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//공지사항 글 쓰기
	@Transactional
	public void noticeWrite(NoticeVO noticeVO) {
		adminDaoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			adminDaoInterface.insertNotice(noticeVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//공지사항 글 수정
	@Transactional
	public void noticeModify(NoticeVO noticeVO) {
		adminDaoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			adminDaoInterface.updateNotice(noticeVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
