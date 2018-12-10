package com.bit.ms.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.ms.dao.AdminDaoInterface;
import com.bit.ms.member.model.ReplyVO;

@Service
public class AdminNoticeReplyService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;

	private AdminDaoInterface daoInterface;

	@Transactional
	public List<ReplyVO> listReply(int id) {
		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);
		List<ReplyVO> reVO = null;
		try {
			reVO = daoInterface.replyList(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reVO;
	}

	@Transactional
	public void insertReply(ReplyVO vo) {
		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			daoInterface.insertReply(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void deleteReply(int id) {
		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			daoInterface.deleteReply(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateReply(ReplyVO vo) {
		daoInterface = sessionTemplate.getMapper(AdminDaoInterface.class);

		try {
			daoInterface.updateReply(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
