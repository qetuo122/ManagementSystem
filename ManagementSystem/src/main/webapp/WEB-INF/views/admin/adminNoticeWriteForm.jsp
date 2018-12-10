<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>MS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<form class="text-center p-5" method="post" >
			<input type="hidden" name="admin_id" value="${adminSession.admin_id}"/>
			<input type="hidden" name="store_id" value="${storeSelectSession.store_id}"/>
			<input type="text" class="form-control" placeholder="제목" name="notice_title">
			<textarea class="form-control" rows="20" placeholder="내용" name="notice_con"></textarea>
			<button type="submit" class="btn btn-info btn-block">작성하기</button>
		</form>
	</div>
</body>
</html>