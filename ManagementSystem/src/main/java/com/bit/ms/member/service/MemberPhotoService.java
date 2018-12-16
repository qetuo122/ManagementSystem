package com.bit.ms.member.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.ms.dao.MemberDaoInterface;
import com.bit.ms.member.model.PhotoBoardListVO;
import com.bit.ms.member.model.PhotoBoardReplyVO;
import com.bit.ms.member.model.PhotoBoardVO;
import com.bit.ms.member.model.StoreVO;

@Service
public class MemberPhotoService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private MemberDaoInterface memberDao;
	
	private int NOTICE_COUNT_PER_PAGE = 6;//한 페이지에 보여줄 갯수
	//게시물 페이지 
	public PhotoBoardListVO getPhotoListS(int pageNumber, HttpSession session) {
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		
		int currentPageNum = pageNumber; // 현재 페이지 넘버
	
		StoreVO storeVo = (StoreVO) session.getAttribute("storeSelectSession");

		int store_id = storeVo.getStore_id();
		
		// 전체 게시글 구하기
		int photoTotalCount = memberDao.pageCount(store_id); //매장번호에 해당하는 게시글 가져오기
		List<PhotoBoardVO> photoList = null;
		int firstRow = 0;

		if (photoTotalCount > 0) {
			
			firstRow = (pageNumber - 1) * NOTICE_COUNT_PER_PAGE;
			photoList = memberDao.selectList(store_id, firstRow); // mysql은 0열부터 시작 -1을 해줌
		
		} else {
			currentPageNum = 0;
			photoList = Collections.emptyList();
		}
		
		return new PhotoBoardListVO(photoTotalCount, currentPageNum, photoList, NOTICE_COUNT_PER_PAGE, firstRow);
	}
	//게시물 등록
	public int writePhotoS(PhotoBoardVO photoVo, HttpServletRequest request) {
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.writePhotoI(photoVo);
	}
	public int updateCntS(int photo_id, int photo_cnt, String photo_date) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("photo_id", Integer.toString(photo_id));
		map.put("photo_cnt", Integer.toString(photo_cnt));
		map.put("photo_date", photo_date);
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		
		return memberDao.updateCnt(map);
	}
	public int deletePhotoS(int photo_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.deletePhotoI(photo_id);
	}
	public int modifyPhotoS(PhotoBoardVO photoVo, HttpServletRequest request) {
		
		String photo_title = photoVo.getPhoto_title();
		String photo_con = photoVo.getPhoto_title();
		String photo_id = Integer.toString(photoVo.getPhoto_id());
		String photo_file = photoVo.getPhoto_file();
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("photo_title", photo_title);
		map.put("photo_con", photo_con);
		map.put("photo_id", photo_id);
		map.put("photo_file", photo_file);
		
		return memberDao.modifyPhotoI(map);
	}
	public int writePhotoReplyS(PhotoBoardReplyVO replyVo) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.writePhotoReplyI(replyVo);
	}
	public List<PhotoBoardReplyVO> getPhotoReplyListS(int photo_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.getPhotoReplyListI(photo_id);
	}
	public int getCountReplyS(int photo_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.getCountReplyI(photo_id);
	}
	public int modiReplyS(int photoreply_id, String photoreply_con) {
		HashMap<String,String>map = new HashMap<String,String>();
		map.put("photoreply_id", Integer.toString(photoreply_id));
		map.put("photoreply_con", photoreply_con);
		
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.modiReplyI(map);
	}
	public int deleteReplyS(int photoreply_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.deleteReplyI(photoreply_id);
	}
	public PhotoBoardVO getPhotoViewS(int photo_id) {
		memberDao = sqlSessionTemplate.getMapper(MemberDaoInterface.class);
		return memberDao.getPhotoViewI(photo_id);
	}

}
