package com.bit.ms.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.admin.model.AdminBoardListVO;
import com.bit.ms.admin.model.AdminBoardReplyVO;
import com.bit.ms.admin.model.AdminBoardVO;
import com.bit.ms.admin.model.AdminVO;
import com.bit.ms.admin.service.AdminCEOBoardService;

@Controller
public class AdminCEOBoardController {

	@Autowired
	private AdminCEOBoardService CEOBoardService;
	
	// CEO게시판 게시글 리스트
	@RequestMapping(value = "/admin/CEOBoard", method = RequestMethod.GET)
	public ModelAndView adminCEOBoard(HttpServletRequest request,
			@RequestParam("keyword")String keyword) {
		
		AdminBoardListVO CEOBoardList = CEOBoardService.cBoardContentList(request, keyword);
		System.out.println("컨트롤러 : " + CEOBoardList);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCEOBoard");
		mav.addObject("CEOBoard", CEOBoardList); // 유저게시물
		mav.addObject("ceoPageNum", CEOBoardList.getCurrentPageNum()); // 페이지 번호
		
		return mav;
	}
	
	// CEO게시판 글쓰기 버튼
	@RequestMapping(value = "/admin/CEOBoardWrite", method = RequestMethod.GET)
	public String CEOBoardWrite() {
		
		return "admin/adminCEOWriteForm";
	}
	
	// CEO게시판 글쓰기 작성하기 완료 버튼
	@RequestMapping(value = "/admin/CEOBoardWrite", method = RequestMethod.POST)
	public String CEOWriteSuccess(AdminBoardVO ceoBoardVO, HttpSession session) {
		
		// 로그인 한 세션 아이디 값을 CEOBoardVO 아이디 값에 저장시킴
		AdminVO adminVO = (AdminVO) session.getAttribute("adminSession");
		String ceoId = adminVO.getAdmin_id();
		ceoBoardVO.setWriter_cid(ceoId);
		
		ceoBoardVO.setCboard_con(ceoBoardVO.getCboard_con().replaceAll("\r\n", "<br>"));
		
		// 작성한 게시글이 있다면 1 / 없으면 0
		CEOBoardService.CEOBoardWrite(ceoBoardVO);
		
		return "redirect:/admin/CEOBoardView/view/" + ceoBoardVO.getCboard_id() +"?page=1&keyword=";
	}
	
	// 게시글 내용 보기
	@RequestMapping(value = "/admin/CEOBoardView/view/{cboard_id}", method = RequestMethod.GET)
	public ModelAndView CEOBoardView(@PathVariable("cboard_id") int cboard_id,
			@RequestParam("keyword")String keyword) {
		
		System.out.println("게시글 내용 : 컨트롤러 진입");
		
		// 게시글 VO 객체명 생성
		AdminBoardVO ceoBoardVO = CEOBoardService.cBoardContent(cboard_id);
		int preNum = CEOBoardService.previousPageMove(cboard_id, keyword);
		int nextNum = CEOBoardService.nextPageMove(cboard_id, keyword);
		
		// 게시글VO ModelAndView 객체에 담기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCEOViewBoard");
		mav.addObject("CEOBoard_view", ceoBoardVO);
		mav.addObject("preNum", preNum);
		mav.addObject("nextNum", nextNum);
		
		return mav;
	}
		
	
	// 게시글 지우기
	@RequestMapping(value = "/admin/CEOBoardView/delete/{cboard_id}", method = RequestMethod.GET)
	public String CEOBoardDelete(@PathVariable("cboard_id")int cboard_id) {
		// 번호 들어오는지 확인
		System.out.println(cboard_id);
		CEOBoardService.CEOBoardDeleteService(cboard_id);
		
		return "redirect:/admin/CEOBoard?page=1&keyword=";
	}
	
	// 게시글 수정 폼 연결 컨트롤러
	@RequestMapping(value = "/admin/CEOBoard/modify/{cboard_id}", method = RequestMethod.GET)
	public ModelAndView CEOBoardModify(@PathVariable("cboard_id")int cboard_id) {
		
		AdminBoardVO result = CEOBoardService.cBoardContent(cboard_id);
		result.setCboard_con(result.getCboard_con().replaceAll("<br>", "\r\n"));
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCEOModifyForm");
		mav.addObject("ceoBoardmodi", result);
		
		return mav;
	}
	
	// 게시글 수정 확인 컨트롤러
	@RequestMapping(value = "/admin/CEOBoard/modify/{cboard_id}", method = RequestMethod.POST)
	public String CEOBoardModiSuccess(@PathVariable("cboard_id")int cboard_id,
			@RequestParam("page")int page, AdminBoardVO ceoVO) {
		
		System.out.println("게시판 수정 확인 : 컨트롤러 진입");
		ceoVO.setCboard_con(ceoVO.getCboard_con().replaceAll("\r\n", "<br>"));
		CEOBoardService.modifyCEOBoardContent(ceoVO);
		
		
		return "redirect:/admin/CEOBoardView/view/"+ cboard_id +"?page="+ page +"&keyword=";
	}
	
	// 댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글댓글
	@RequestMapping(value = "/admin/CEOBoard/reply/all/{cboard_id}", method = RequestMethod.GET)
	@ResponseBody
	public List<AdminBoardReplyVO> adminBoardReplyList(@PathVariable("cboard_id")int cboard_id) {
		
		
		System.out.println("댓글 List 컨트롤러" + cboard_id);
		List<AdminBoardReplyVO> ceoboard_reply_list = CEOBoardService.getAdminReplyList(cboard_id);
		
		return ceoboard_reply_list                                                                     ;
	}
	
	@RequestMapping(value = "/admin/CEOBoard/reply", method = RequestMethod.POST)
	@ResponseBody
	public int adminBoardReplyWrite(AdminBoardReplyVO replyVO) {
		
		int result = CEOBoardService.writeReply(replyVO);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/CEOBoard/reply/{cboard_reply_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public int adminBoardReplyDelete(@PathVariable("cboard_reply_id")int cboard_reply_id) {
		
		int result = CEOBoardService.deleteReply(cboard_reply_id);
		
		return result;
	}
	
	@RequestMapping(value = "/admin/CEOBoard/reply/{cboard_reply_id}", method = RequestMethod.PUT)
	@ResponseBody
	public int adminBoardReplyModify(@PathVariable("cboard_reply_id")int cboard_reply_id,
			@RequestBody AdminBoardReplyVO replyVO) {
		
		// 댓글 번호를 받아 특정 댓글을 택한다
		replyVO.setCboard_reply_id(cboard_reply_id);
		int result = CEOBoardService.modifyReply(replyVO);
		System.out.println(result);
		
		return result;
	}
	
}
