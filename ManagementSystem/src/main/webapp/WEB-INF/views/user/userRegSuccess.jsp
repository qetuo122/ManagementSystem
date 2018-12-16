<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>환영합니다!</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/font.css" type="text/css">

<style>
* {
	font-family: "BMHANNAPro";
}
</style>

</head>
<body>

	<div style="margin: 100px;">
		<a><img src="${pageContext.request.contextPath}/images/ms-logo.png"	style="height: 80px; margin-left: 10px;" /></a> <br>
		<br>
		<h3>안녕하세요, ${param.user_id} 님</h3>
		<br>
		<p>환영합니다!</p>
		<br>
		<p>회원가입이 정상적으로 이루어 졌습니다.</p>
		<br>
		<p>로그인 하시면 홈페이지 내의 모든 서비스를 이용하실 수 있습니다.</p>
		<br> 
		<c:if test="${empty param.store_id }">
			<a href="${pageContext.request.contextPath}/">로그인 페이지로 이동하기</a>
		</c:if>
		<c:if test="${!empty param.store_id }">
			<a href="${pageContext.request.contextPath}/user/qrLogin?store_id=${param.store_id}&seat_id=${param.seat_id}">로그인 페이지로 이동하기</a>
		</c:if>
	</div>

</body>
</html>