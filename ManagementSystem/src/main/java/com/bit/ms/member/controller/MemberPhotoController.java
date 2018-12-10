package com.bit.ms.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.member.model.PhotoBoardListVO;
import com.bit.ms.member.model.PhotoBoardReplyVO;
import com.bit.ms.member.model.PhotoBoardVO;
import com.bit.ms.member.service.MemberPhotoService;

@Controller
public class MemberPhotoController {

	@Autowired
	MemberPhotoService service;
	//포토게시판으로 이동
	@RequestMapping(value = "/member/photoBoard", method = RequestMethod.GET)
	public ModelAndView getPhotoList(HttpServletRequest request, HttpSession session) {
		
		String pageNumberStr = request.getParameter("page");
		int pageNumber = 1;
		
		if (pageNumberStr != null) {
			pageNumber = Integer.parseInt(pageNumberStr);
		}
		
		PhotoBoardListVO viewData = service.getPhotoListS(pageNumber, session);
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("member/photoBoard");
		modelAndView.addObject("photoData",viewData);
		modelAndView.addObject("pageNum", viewData.getCurrentPageNum());
		return modelAndView;
	}
	//글쓰기로 이동
	@RequestMapping(value = "/member/photoBoard/write", method = RequestMethod.GET)
	public String writePhotoForm() {
		System.out.println("글쓰기 이동");
		return "member/photoBoardWriteForm";
	}
	//글쓰기 폼에서 글 등록
	@RequestMapping(value = "/member/photoBoard/write", method = RequestMethod.POST)
	public String insertPhoto(PhotoBoardVO photoVo, HttpServletRequest request) {
		service.writePhotoS(photoVo, request);
		return "redirect:/member/photoBoard?page=1";
	}
	@RequestMapping(value = "/member/updateCnt/", method = RequestMethod.POST)
	@ResponseBody
	public int photoView(int photo_id, int photo_cnt, String photo_date) {

		return service.updateCntS(photo_id, photo_cnt, photo_date);
	}
	@RequestMapping(value = "/member/photoView/{id}", method = RequestMethod.GET)
	public ModelAndView goPhotoView(@PathVariable("id") int photo_id) {
		ModelAndView modelAndView = new ModelAndView();
		
		PhotoBoardVO viewData = service.getPhotoViewS(photo_id);
		
		modelAndView.setViewName("member/photoView");
		modelAndView.addObject("viewData",viewData);
		
		return modelAndView;
	}
	//게시물 삭제
	@RequestMapping(value = "member/photoBoard/delete/{photo_id}")
	public String deletePhoto(@PathVariable("photo_id") int photo_id) {
		service.deletePhotoS(photo_id);
		
		return "redirect:/member/photoBoard?page=1";
	}
	//게시물 수정페이지 이동
	@RequestMapping(value = "member/photoBoard/modify/{photo_id}", method = RequestMethod.GET)
	public ModelAndView modiForm(@PathVariable("photo_id") int photo_id) {
		
		ModelAndView modelAndView = new ModelAndView();
		PhotoBoardVO viewData = service.getPhotoViewS(photo_id);
		
		modelAndView.setViewName("member/photoBoardModifyForm");
		modelAndView.addObject("viewData",viewData);
		
		return modelAndView;
	}
	//게시물 수정
	@RequestMapping(value = "member/photoBoard/modify/{photo_id}", method = RequestMethod.POST)
	public String modifyPhoto(@PathVariable("photo_id") int photo_id, PhotoBoardVO photoVo, HttpServletRequest request) {
		service.modifyPhotoS(photoVo, request);
		return "redirect:/member/photoView/" + photo_id;
		
	}
	@RequestMapping(value = "member/photoView/photoReplyList/{photo_id}")
	@ResponseBody
	public List<PhotoBoardReplyVO> getPhotoReplyList(@PathVariable("photo_id") int photo_id){
		System.out.println("댓글리스트 출력 완료");
		return service.getPhotoReplyListS(photo_id);
	}
	@RequestMapping(value = "member/photoView/photoReply", method = RequestMethod.POST)
	@ResponseBody
	public int writePhotoReply(PhotoBoardReplyVO replyVo) {
		System.out.println("댓글등록 완료");
		return service.writePhotoReplyS(replyVo);
	}
	@RequestMapping(value = "member/photoView/countReply/{photo_id}")
	@ResponseBody
	public int getCountReply(@PathVariable("photo_id") int photo_id) {
		return service.getCountReplyS(photo_id);
	}
	@RequestMapping(value = "member/photoView/modiReply/{photoreply_id}", method = RequestMethod.POST)
	@ResponseBody
	public int modiReply(@PathVariable("photoreply_id") int photoreply_id, String photoreply_con) {
		return service.modiReplyS(photoreply_id,photoreply_con);
	}
	@RequestMapping(value = "member/photoView/deleteReply/{photoreply_id}")
	@ResponseBody
	public int deleteReply(@PathVariable("photoreply_id") int photoreply_id) {
		return service.deleteReplyS(photoreply_id);
	}
}
