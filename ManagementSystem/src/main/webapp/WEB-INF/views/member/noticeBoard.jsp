<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>MS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.container {
	margin-top: 20px;
}
#write {
	float: right;
	margin: 10px;
}
/* 공지사항 게시판 제목 오버 */
.notice-title:hover {
	text-decoration: underline;
}

.table {
	table-layout: fixed;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
	<div class="container">
		<h1>[${storeSelectSession.store_name}] - 공지사항</h1>
		<c:if test="${!empty adminSession}">
			<a id="write" class="btn btn-outline-elegant waves-effect"
				href="${pageContext.request.contextPath}/admin/noticeWrite">글쓰기</a>
		</c:if>
		<table class="table">
			<thead>
				<tr class="text-center">
					<th style="width: 85%">제목</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${viewData.isEmpty()}">
					<tr>
						<td>작성된 게시글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!viewData.isEmpty()}">
					<c:forEach var="list" items="${viewData.noticeList}">
						<tr>
							<td style="padding: 20px;"><a class="notice-title"
								href="notice/${list.notice_id}">${list.notice_title}</a></td>
							<td class="text-center">
								<fmt:parseDate value="${list.notice_date}" pattern="yyyy-MM-dd HH:mm" var="date" /> 
								<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>

		<c:if test="${!viewData.isEmpty()}">
			<nav class="d-flex justify-content-center mt-3"	style="padding-bottom: 20px">
				<ul class="pagination pagination-circle pg-teal mb-0">
					<!--가장맨앞으로-->
					<li class="page-item"><a class="page-link"
						href="notice?page=1">First</a></li>

					<!--페이지 한칸뒤로-->
					<c:choose>
						<c:when test="${param.page == 1}">
							<li class="page-item"><a class="page-link"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									<span class="sr-only">Previous</span>
							</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								aria-label="Previous" href="notice?page=${param.page-1}"> <span
									aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
							</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 페이징처리 -->
					<c:forEach var="num" begin="1" end="${viewData.pageTotalCount}">
						<c:if test="${param.page == num}">
							<li class="page-item active"><a class="page-link"
								href="notice?page=${num}">${num}</a></li>
						</c:if>
						<c:if test="${param.page != num}">
							<li class="page-item"><a class="page-link"
								href="notice?page=${num}">${num}</a></li>
						</c:if>
					</c:forEach>

					<!--페이지 한칸앞으로-->
					<c:choose>
						<c:when test="${viewData.pageTotalCount == param.page}">
							<li class="page-item"><a class="page-link" aria-label="Next">
									<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
							</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" aria-label="Next"
								href="notice?page=${param.page+1}"> <span aria-hidden="true">&raquo;</span>
									<span class="sr-only">Next</span>
							</a></li>
						</c:otherwise>
					</c:choose>

					<!--가장맨앞으로-->
					<li class="page-item"><a class="page-link"
						href="notice?page=${viewData.pageTotalCount}">Last</a></li>
				</ul>
			</nav>
		</c:if>
	</div>
</body>
</html>