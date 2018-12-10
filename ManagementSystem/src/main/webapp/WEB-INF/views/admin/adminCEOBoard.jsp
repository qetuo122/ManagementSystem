<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MS</title>
<style>
#write {
	float: right;
	margin: 20px;
}
/* 공지사항 게시판 제목 오버 */
.notice-title:hover {
	text-decoration: underline;
}

.table {
	table-layout: fixed;
}

.container * {
	font-size: 17px;
}

.hypertext_none {
	color: #181818;
	text-decoration: none;
}

/* 검색창 */
.CEOBoard_searchbar {
	position: absolute;
	bottom: 0px;
	width: 400px;
}

input { /* This styles the actual input box */
	font-size: 20px;
	padding: 10px;
	width: 100%;
}

label { /* This styles the label before interaction */
	font-size: 20px;
	font-weight: normal;
	position: absolute;
	left: 20px;
	top: 20px;
	pointer-events: none;
	transition: 0.2s ease all;
	-moz-transition: 0.2s ease all;
	-webkit-transition: 0.2s ease all;
}

input:focus ~ label, input:valid ~ label, form:focus ~ label {
	/* This styles the label after interaction */
	top: -20px;
	font-size: 14px;
}

/* 검색창 */
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container" style="overflow: hidden; position: relative;">
		<br> <a class="nav-link, hypertext_none" href="#">
			<b style="font-size: 30px;">CEO게시판</b>
		</a><br><br> <a id="write" class="btn btn-outline-elegant waves-effect" href="${pageContext.request.contextPath}/admin/CEOBoardWrite?page=1&keyword=${param.keyword}">글쓰기</a>
	
		<div class="CEOBoard_searchbar">
			<form method="get">
				<table>
					<tr>
						<td ><input type="hidden" name="page" value="1" />
						<input type="text" style="width: 300px;" name="keyword" value="${param.keyword }"><label>검색(제목+내용) + ENTER!!</label></td>
						<td><input type="submit" value="검색" class="btn btn-outline-elegant waves-effect" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="container">
		<table class="table">
			<thead>
				<tr class="text-center" style="background: #E6E6F2;">
					<th style="width: 10%">글번호</th>
					<th style="width: 55%">제목</th>
					<th style="width: 15%">작성자</th>
					<th style="width: 15%">작성시간</th>
				</tr>
			</thead>
			<tbody>
				<c:if test='${CEOBoard.ceoBoardList.isEmpty()}'>
					<tr>
						<td colspan="4"><h3 style="text-align: center;">작성된 게시글이 없습니다.</h3></td>
					</tr>
				</c:if>
				<c:if test='${!CEOBoard.ceoBoardList.isEmpty()}'>
					<c:forEach var="CEOBoardList" items="${CEOBoard.ceoBoardList}">
						<tr>
							<td style="text-align: center;">${CEOBoardList.cboard_id}</td>
							<td><a href="${pageContext.request.contextPath}/admin/CEOBoardView/view/${CEOBoardList.cboard_id}?page=${param.page}&keyword=${param.keyword}">${CEOBoardList.cboard_title}</a></td>
							<td style="text-align: center;">${CEOBoardList.writer_cid}</td>
							<td style="text-align: center;"><fmt:formatDate	value="${CEOBoardList.cboard_date}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	<!--Pagination 아래쪽 페이지 이동 -->
		<nav class="d-flex justify-content-center mt-3"
			style="padding-bottom: 20px">
			<ul class="pagination pagination-circle pg-teal mb-0">
				<!--가장맨앞으로-->
				<c:choose>
					<c:when test="${param.page == 1}">
						<li class="page-item"><a class="page-link">First</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="CEOBoard?page=1&keyword=${param.keyword}">First</a></li>
					</c:otherwise>
				</c:choose>

				<!--페이지 한칸뒤로-->
				<c:choose>
					<c:when test="${param.page == 1}">
						<li class="page-item"><a class="page-link" aria-label="Previous"> <span aria-hidden="true">Previous</span>
							<span class="sr-only">Previous</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" aria-label="Previous" href="CEOBoard?page=${param.page-1}&keyword=${param.keyword}">
							<span aria-hidden="true">Previous</span>
							<span class="sr-only">Previous</span>
						</a></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이징처리 -->
				<c:choose>
					<c:when test="${CEOBoard.pageTotalCount <= 7}">
						<c:forEach var="num" begin="1" end="${CEOBoard.pageTotalCount}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:when test="${param.page <= 3}">
						<c:forEach var="num" begin="1" end="7">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:when test="${param.page >= CEOBoard.pageTotalCount - 3}">
						<c:forEach var="num" begin="${CEOBoard.pageTotalCount-6}"
							end="${CEOBoard.pageTotalCount}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="num" begin="${param.page - 3}"
							end="${param.page + 3}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link" href="CEOBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<!--페이지 한칸앞으로-->
				<c:choose>
					<c:when test="${CEOBoard.pageTotalCount == param.page}">
						<li class="page-item"><a class="page-link" aria-label="Next">
							<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" aria-label="Next" href="CEOBoard?page=${param.page+1}&keyword=${param.keyword}">
							<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:otherwise>
				</c:choose>

				<!--가장맨앞으로-->
				<c:choose>
					<c:when test="${CEOBoard.pageTotalCount == param.page}">
						<li class="page-item"><a class="page-link">Last</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="CEOBoard?page=${CEOBoard.pageTotalCount}&keyword=${param.keyword}">Last</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
</body>
</html>