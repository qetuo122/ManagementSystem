<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MS</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container" style="overflow: hidden; position: relative;">
		<br> <a class="nav-link, hypertext_none"
			href="${pageContext.request.contextPath}/member/photoBoard?page=1">
			<b style="font-size: 30px;">[${storeSelectSession.store_name}] -
				Photo게시판</b>
		</a>
	</div>
	<div class="container">
		<form class="text-center p-5" action = "write"id = "addForm" method="post" enctype = "multipart/form-data">
		<c:if test="${!empty adminSession}">
			<input type = "hidden" name = "photo_upid" value = "${storeSelectSession.store_name} [관리자]">
		</c:if>
		<c:if test="${!empty userSession}">
			<input type = "hidden" name = "photo_upid" value = "${userSession.user_id}">
		</c:if>
			<input type = "hidden" name = "store_id" value = "${storeSelectSession.store_id}">
			<input type="text" class="form-control" placeholder="제목"
				name="photo_title" id = "photoTitle" required>
			<!-- name값과 메서드의 매개변수가 이름이 같으면 알아서 넣어줌 -->
			<textarea class="form-control" rows="20" placeholder="내용"
				name="photo_con" id = "photoCon" required></textarea>
			<input type = "file" id = "photoFile" name = "photoFile" style = "float : left;" required>
			<input type= "hidden" name="photo_file" id = "photo_file">
			<button class="btn btn-info btn-block" onclick = "insertPhoto()">작성하기</button>
		</form>
	</div>
</body>
<script>
	function insertPhoto(){
		if($('#photoFile').val() == null || $('#photoFile').val() == ""){
			alert("사진을 등록해주세요");
		} else if($('#photoTitle').val() == null || $('#photoTitle').val() == ""){
			alert("제목을 입력하세요");
		} else if($('#photoCon').val() == null || $('#photoCon').val() == ""){
			alert("내용을 입력하세요");
		} else {
			var formData = new FormData($('#addForm')[0]);
			
			$.ajax({
	            async : false,
    	        type : 'POST',
        		url : 'http://52.79.242.155:8080/FileServer/uploadFile/photo',
            	data : formData,
	            processData : false,
    	        contentType : false,
        	     
            	success : function(data) {
	        	   	$('#photo_file').val(data); // hidden form에 파일 이름 저장
    	        	$('#addForm').submit();
        	    }
			});
		}
	}
</script>
</html>