package com.bit.ms.user.model;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.util.UriComponentsBuilder;

@Alias("UserBoardListVO")
public class UserBoardListVO {
	private int UserBoardTotalCount; // 글 총 갯수
	private int currentPageNum; // 현재 페이지
	private List<UserBoardVO> userBoardList; // 리스트 방식으로 담음 10개씩
	private int pageTotalCount; // 페이지 수
	private int userBoardCountPerPage; // 페이지당 보여지는 글 수 10개
	private int firstRow; // 페이지당 첫 줄

	@Override
	public String toString() {
		return "UserBoardListVO [UserBoardTotalCount=" + UserBoardTotalCount + ", currentPageNum=" + currentPageNum
				+ ", userBoardList=" + userBoardList + ", pageTotalCount=" + pageTotalCount + ", userBoardCountPerPage="
				+ userBoardCountPerPage + ", firstRow=" + firstRow + "]";
	}

	public UserBoardListVO(List<UserBoardVO> userBoardList, int userBoardTotalCount, int currentPageNum,
			int pageTotalCount, int userBoardCountPerPage, int firstRow) {
		super();
		UserBoardTotalCount = userBoardTotalCount;
		this.currentPageNum = currentPageNum;
		this.userBoardList = userBoardList;
		this.pageTotalCount = pageTotalCount;
		this.userBoardCountPerPage = userBoardCountPerPage;
		this.firstRow = firstRow;
	}

	public int getUserBoardTotalCount() {
		return UserBoardTotalCount;
	}

	public void setUserBoardTotalCount(int userBoardTotalCount) {
		UserBoardTotalCount = userBoardTotalCount;

	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public void setCurrentPageNum(int currentPageNum) {
		this.currentPageNum = currentPageNum;
	}

	public List<UserBoardVO> getUserBoardList() {
		return userBoardList;
	}

	public void setUserBoardList(List<UserBoardVO> userBoardList) {
		this.userBoardList = userBoardList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}

	public int getUserBoardCountPerPage() {
		return userBoardCountPerPage;
	}

	public void setUserBoardCountPerPage(int userBoardCountPerPage) {
		this.userBoardCountPerPage = userBoardCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public UserBoardListVO() {
		super();
		// TODO Auto-generated constructor stub
	}

}