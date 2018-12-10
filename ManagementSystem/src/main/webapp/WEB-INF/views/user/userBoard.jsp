<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">

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
.userBoard_searchbar {
	position: absolute;
	bottom: 0px;
	width: 500px;
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
		<br> <a class="nav-link, hypertext_none"
			href="${pageContext.request.contextPath}/user/userBoard?page=1&keyword=">
			<b style="font-size: 30px;">[${storeSelectSession.store_name}] -
				유저게시판</b>
		</a><br> <br> <a id="write"
			class="btn btn-outline-elegant waves-effect"
			href="${pageContext.request.contextPath}/user/userBoard/write">글쓰기</a>

		<div class="userBoard_searchbar">
			<form method="get">
				<table>
					<tr>
						<td><input name="page" type="hidden" value="1" /> <input
							name="keyword" type="text" value="${param.keyword}" required
							style="width: 300px;"><label>검색(제목+내용) + ENTER!!</label></td>
						<td><input type="submit" value="검색"
							class="btn btn-outline-elegant waves-effect" /></td>
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
					<th style="width: 15%">등록시간</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="userBoardVO" items="${userboardnotice}">
					<tr style="background: #F2FCF6;">
						<td style="text-align: center;">[공지]</td>
						<td style="cursor: pointer;"
							onClick="location.href='${pageContext.request.contextPath}/user/userBoard/view/${userBoardVO.uboard_id}?page=${pageNum}&keyword=${param.keyword}'">${userBoardVO.uboard_title}</td>
						<td style="text-align: center;">${userBoardVO.writer_id}
							[관리자]</td>
						<td style="text-align: center;"><fmt:formatDate
								value="${userBoardVO.uboard_date}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</c:forEach>
				<c:choose>
					<c:when test="${userboardlist.userBoardList.isEmpty()}">
						<tr>
							<td colspan="4"><h3 style="text-align: center;">작성된
									게시글이 없습니다.</h3></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="userBoardVO"
							items="${userboardlist.userBoardList}">
							<tr>
								<td style="text-align: center;">${userBoardVO.uboard_id}</td>
								<td style="cursor: pointer;"
									onClick="location.href='${pageContext.request.contextPath}/user/userBoard/view/${userBoardVO.uboard_id}?page=${pageNum}&keyword=${param.keyword}'">
									${userBoardVO.uboard_title}</td>
								<td style="text-align: center;">${userBoardVO.writer_id}<c:if
										test='${storeSelectSession.admin_id == userBoardVO.writer_id}'>     [관리자]</c:if></td>
								<td style="text-align: center;"><fmt:formatDate
										value="${userBoardVO.uboard_date}" pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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
						<li class="page-item"><a class="page-link"
							href="userBoard?page=1&keyword=${param.keyword}">First</a></li>
					</c:otherwise>
				</c:choose>

				<!--페이지 한칸뒤로-->
				<c:choose>
					<c:when test="${param.page == 1}">
						<li class="page-item"><a class="page-link"
							aria-label="Previous"> <span aria-hidden="true">Previous</span>
								<span class="sr-only">Previous</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							aria-label="Previous"
							href="userBoard?page=${param.page-1}&keyword=${param.keyword}">
								<span aria-hidden="true">Previous</span> <span class="sr-only">Previous</span>
						</a></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이징처리 -->
				<c:choose>
					<c:when test="${userboardlist.pageTotalCount <= 7}">
						<c:forEach var="num" begin="1"
							end="${userboardlist.pageTotalCount}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:when test="${param.page <= 3}">
						<c:forEach var="num" begin="1" end="7">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:when test="${param.page  >= userboardlist.pageTotalCount - 3}">
						<c:forEach var="num" begin="${userboardlist.pageTotalCount-6}"
							end="${userboardlist.pageTotalCount}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="num" begin="${param.page - 3}"
							end="${param.page + 3}">
							<c:if test="${param.page == num}">
								<li class="page-item active"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
							<c:if test="${param.page != num}">
								<li class="page-item"><a class="page-link"
									href="userBoard?page=${num}&keyword=${param.keyword}">${num}</a></li>
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<!--페이지 한칸앞으로-->
				<c:choose>
					<c:when test="${userboardlist.pageTotalCount == param.page}">
						<li class="page-item"><a class="page-link" aria-label="Next">
								<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" aria-label="Next"
							href="userBoard?page=${param.page+1}&keyword=${param.keyword}">
								<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:otherwise>
				</c:choose>

				<!--가장맨앞으로-->
				<c:choose>
					<c:when test="${userboardlist.pageTotalCount == param.page}">
						<li class="page-item"><a class="page-link">Last</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="userBoard?page=${userboardlist.pageTotalCount}&keyword=${param.keyword}">Last</a></li>
					</c:otherwise>
				</c:choose>


			</ul>
		</nav>
	</div>

</body>
</html>