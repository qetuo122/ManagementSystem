<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.photoUl{
		list-style: none;
	}
	.photoUl:hover{
		color : grey;
	}
	
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="container"><br>
		<div class = "photoHeader" style = "position : relative">
		<b style = "font-size : 30px; margin-top : 10px;">[${storeSelectSession.store_name}] - Photo게시판</b>
		<hr>
		 <a id="write" class="btn btn-outline-elegant waves-effect"
			href="${pageContext.request.contextPath}/member/photoBoard/write" style = "right : 0px; top : 0px;position : absolute;">글쓰기</a></div>
		<c:if test="${!empty photoData.photoBoardList}">
			<c:forEach items = "${photoData.photoBoardList}" var = "photoData">
			<div class = "photoCon"><a style = "color : black;" onclick = "goPhotoView(${photoData.photo_id}, ${photoData.photo_cnt},'${photoData.photo_date}')">
				<ul class = "photoUl" style = "float : left; margin : 0px 30px 10px 10px; padding : 0px">
					<li><img src = "http://52.79.242.155:8080/FileServer/resources/photoBoard/${photoData.photo_file}" style = "width : 280px; height : 280px; margin : 0px auto 5px;"></li>
					<li>Title : ${photoData.photo_title}</li>
					<li>작성시간 : <fmt:parseDate value="${photoData.photo_date}" pattern="yyyy-MM-dd HH:mm" var = "date" />
						  <fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" /></li>
					<li>작성자 : ${photoData.photo_upid}</li>
					<li>조회수 : ${photoData.photo_cnt}</li>
				</ul>
			</a></div>
			</c:forEach>
		</c:if>
		<c:if test="${empty photoData.photoBoardList}">
			<h1>등록된 사진이 없습니다.</h1>
		</c:if>
	</div>	<br>
	<div style = "text-align : center;">	
		<c:if test="${!empty photoData}">
			<nav class="d-flex justify-content-center mt-3"	style="padding-bottom: 20px; clear : both;">
				<ul class="pagination pagination-circle pg-teal mb-0">

					<!--가장맨앞으로-->
					<li class="page-item"><a class="page-link" href="photoBoard?page=1">First</a></li>
					
					<!-- 한칸 전으로 -->
				<c:choose>
					<c:when test="${param.page == 1}">
						<li class="page-item"><a class="page-link" aria-label="Previous"> <span aria-hidden="true">Previous</span>
						<span class="sr-only">Previous</span></a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" aria-label="Next" href="photoBoard?page=${param.page-1}">
						<span aria-hidden="true">Previous</span> <span class="sr-only">Previous</span>
						</a></li>
					</c:otherwise>
				</c:choose>
					<!-- 일반페이지 카운팅 -->
					<c:forEach var = "num" begin = "1" end = "${photoData.pageTotalCount}">
						<c:if test="${param.page == num}">
							<li class="page-item active"><a class="page-link" href="photoBoard?page=${num}">${num}</a></li>
						</c:if>
						<c:if test="${param.page != num}">
							<li class="page-item"><a class="page-link" href="photoBoard?page=${num}">${num}</a></li>
						</c:if>
					</c:forEach>
					
					<!-- 다음페이지로 -->
				<c:choose>	
					<c:when test="${photoData.pageTotalCount == param.page}">
						<li class="page-item"><a class="page-link" aria-label="Next">
						<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" aria-label="Next" href="photoBoard?page=${param.page+1}">
						<span aria-hidden="true">Next</span> <span class="sr-only">Next</span>
						</a></li>
					</c:otherwise>
				</c:choose>
				
					<!-- 가장 맨 뒤로 -->
					<li class="page-item"><a class="page-link" href="photoBoard?page=${photoData.pageTotalCount}">End</a></li>
					
				</ul>
			</nav>
		</c:if>	
	</div>
</body>
<script>
	$(document).ready(function(){
	
	});
	
	function goPhotoView(photo_id, photo_cnt, photo_date){
		photo_cnt = photo_cnt + 1;
		$.ajax({
			url : '${pageContext.request.contextPath}/member/updateCnt/',
			type : 'POST',
			data : {
				photo_date : photo_date,
				photo_id : photo_id,
				photo_cnt : photo_cnt
			},
			success : function(data){
				location.href = "${pageContext.request.contextPath}/member/photoView/" + photo_id;
			} 
		});
		
	}
</script>
</html>