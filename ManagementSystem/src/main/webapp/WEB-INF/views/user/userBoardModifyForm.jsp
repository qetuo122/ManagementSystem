<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- 시간형식  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
.hypertext_none {
	color: #181818;
	text-decoration: none;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container" style="overflow: hidden; position: relative;">
		<br> <a class="nav-link, hypertext_none"
			href="${pageContext.request.contextPath}/user/userBoard?page=1&keyword=">
			<b style="font-size: 30px;">[${storeSelectSession.store_name}] -
				유저게시판</b>
		</a><br> <a id="write" class="btn btn-outline-elegant waves-effect"
			href="${pageContext.request.contextPath}/user/userBoard/write">글쓰기</a>

		<%-- <div keyclass="userBoard_searchbar">
			<form method="get">
				<input name="keyword" type="text" value="${param.keyword}" required> <label>검색(제목+내용) + ENTER!!</label>
				<input name="page" type="hidden" value="${param.page}" />
			</form>
		</div> --%>
	</div>

	<div class="container">
		<form class="text-center p-5" method="post">
			<input type="text" class="form-control" placeholder="제목"
				name="uboard_title" value="${userboardvo.uboard_title}">
			<!-- name값과 메서드의 매개변수가 이름이 같으면 알아서 넣어줌 객체도!! -->
			<textarea class="form-control" rows="20" placeholder="내용"
				name="uboard_con">${userboardvo.uboard_con}</textarea>
			<button type="submit" class="btn btn-info btn-block">수정하기</button>
		</form>
	</div>
</body>
</html>