package com.bit.ms.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bit.ms.admin.model.NoticeVO;
import com.bit.ms.admin.service.AdminNoticeBoardService;
import com.bit.ms.member.service.MemberNoticeBoardService;

@Controller
@RequestMapping("/admin")
public class AdminNoticeBoardController {

	@Autowired
	MemberNoticeBoardService viewService;
	@Autowired
	AdminNoticeBoardService noticeBoardService;

	// 공지사항에서 글쓰기 클릭시 글쓰기폼으로 이동
	@RequestMapping(value = "/noticeWrite", method = RequestMethod.GET)
	public String getWriteForm() {

		return "admin/adminNoticeWriteForm";
	}

	// 글작성 완료시 다시 공지사항 게시판으로 이동
	@RequestMapping(value = "/noticeWrite", method = RequestMethod.POST)
	public String writeSuccess(NoticeVO noticeVO) {

		noticeBoardService.noticeWrite(noticeVO);

		return "redirect:/member/notice?page=1";
	}

	// 글 수정
	@RequestMapping(value = "/notice/modify/{id}", method = RequestMethod.GET)
	public ModelAndView noticeModify(@PathVariable("id") int id) {

		ModelAndView modelAndView = new ModelAndView();
		NoticeVO no = viewService.getView(id);

		modelAndView.setViewName("/admin/adminNoticeModifyForm");
		modelAndView.addObject("modifyView", no);

		return modelAndView;
	}

	// 글 수정
	@RequestMapping(value = "/notice/modify/{id}", method = RequestMethod.POST)
	public String noticeModifySuccess(@PathVariable("id") int id, NoticeVO noticeVO, Model model) {

		noticeVO.setNotice_id(id); // 받은 id값을 notice_id에 넣어줌

		noticeBoardService.noticeModify(noticeVO);

		return "redirect:/member/notice/" + id;
	}

	// 삭제 모달창에서 삭제를 누르면 해당 글이 삭제되고 목록으로 돌아감
	@RequestMapping(value = "/notice/delete/{id}", method = RequestMethod.GET)
	public String noticeDelete(@PathVariable("id") int id) {

		noticeBoardService.noticeDelete(id);

		return "redirect:/member/notice?page=1";
	}
}
