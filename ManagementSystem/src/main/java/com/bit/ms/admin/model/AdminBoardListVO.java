package com.bit.ms.admin.model;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("AdminBoardListVO")
public class AdminBoardListVO {

	private int ceoBoardTotalCount; // 글 총 갯수
	private int currentPageNum; // 현재 페이지
	private List<AdminBoardVO> ceoBoardList; // 리스트 방식으로 게시글 10개씩 담음
	private int pageTotalCount; // 페이지 수
	private int ceoBoardCountPerPage; // 페이지당 보여지는 글 10개
	private int firstRow; // 페이지당 첫 줄
	
	public AdminBoardListVO(int ceoBoardTotalCount, int currentPageNum, List<AdminBoardVO> ceoBoardList,
			int pageTotalCount, int ceoBoardCountPerPage, int firstRow) {
		super();
		this.ceoBoardTotalCount = ceoBoardTotalCount;
		this.currentPageNum = currentPageNum;
		this.ceoBoardList = ceoBoardList;
		this.pageTotalCount = pageTotalCount;
		this.ceoBoardCountPerPage = ceoBoardCountPerPage;
		this.firstRow = firstRow;
	}

	public int getCeoBoardTotalCount() {
		return ceoBoardTotalCount;
	}

	public void setCeoBoardTotalCount(int ceoBoardTotalCount) {
		this.ceoBoardTotalCount = ceoBoardTotalCount;
	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public void setCurrentPageNum(int currentPageNum) {
		this.currentPageNum = currentPageNum;
	}

	public List<AdminBoardVO> getCeoBoardList() {
		return ceoBoardList;
	}

	public void setCeoBoardList(List<AdminBoardVO> ceoBoardList) {
		this.ceoBoardList = ceoBoardList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}

	public int getCeoBoardCountPerPage() {
		return ceoBoardCountPerPage;
	}

	public void setCeoBoardCountPerPage(int ceoBoardCountPerPage) {
		this.ceoBoardCountPerPage = ceoBoardCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	@Override
	public String toString() {
		return "AdminBoardListVO [ceoBoardTotalCount=" + ceoBoardTotalCount + ", currentPageNum=" + currentPageNum
				+ ", ceoBoardList=" + ceoBoardList + ", pageTotalCount=" + pageTotalCount + ", ceoBoardCountPerPage="
				+ ceoBoardCountPerPage + ", firstRow=" + firstRow + "]";
	}
	
	
	
}
