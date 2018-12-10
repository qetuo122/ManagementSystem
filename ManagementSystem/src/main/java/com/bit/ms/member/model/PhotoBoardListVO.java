package com.bit.ms.member.model;

import java.util.List;

public class PhotoBoardListVO {

	private int photoBoardTotalCount; // 글 총 갯수
	private int currentPageNum; // 현재 페이지
	private List<PhotoBoardVO> photoBoardList; // 리스트 방식으로 담음 6개씩
	private int pageTotalCount; // 페이지 수
	private int photoBoardCountPerPage; // 페이지당 보여지는 글 수 6개
	private int firstRow; // 페이지당 첫 줄
	
	public PhotoBoardListVO(int photoBoardTotalCount, int currentPageNum, List<PhotoBoardVO> photoBoardList,
			 int photoBoardCountPerPage, int firstRow) {
		this.photoBoardTotalCount = photoBoardTotalCount;
		this.currentPageNum = currentPageNum;
		this.photoBoardList = photoBoardList;
		this.photoBoardCountPerPage = photoBoardCountPerPage;
		this.firstRow = firstRow;
		calculatePageTotalCount();
	}
	
	private void calculatePageTotalCount() {
		if (photoBoardTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = photoBoardTotalCount / photoBoardCountPerPage;
			if (photoBoardTotalCount % photoBoardCountPerPage > 0) {
				pageTotalCount++;
			}
		}

	}

	public int getPhotoBoardTotalCount() {
		return photoBoardTotalCount;
	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public List<PhotoBoardVO> getPhotoBoardList() {
		return photoBoardList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getPhotoBoardCountPerPage() {
		return photoBoardCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}
	@Override
	public String toString() {
		return "PhotoBoardListVO [photoBoardTotalCount=" + photoBoardTotalCount + ", currentPageNum=" + currentPageNum
				+ ", photoBoardList=" + photoBoardList + ", pageTotalCount=" + pageTotalCount
				+ ", photoBoardCountPerPage=" + photoBoardCountPerPage + ", firstRow=" + firstRow + "]";
	}
	
}
