<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
html, body {
	background-color: black;
	height: 100%;
}

body {
	margin: 0;
}

.container {
	min-height: 100%;
	position: relative;
}

.full {
<%-- 	background-image:
		url("<%=request.getContextPath()%>/images/login-back.jpg"); --%>
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	height: 100%;
}

.area_inputs {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	margin: auto;
	width: 30%;
	height: 30%;
}

#storeRegBtn {
	margin-top : 10px;
}
</style>
</head>
<body>
	<div class="full">
		<div class="container">
			<div class="area_inputs">
				<div class="input-group">
					<c:if test="${!empty store}">
						<select id="storeList" class="custom-select">
							<option value="-1" selected>매장을 선택해주세요.</option>
							<c:forEach items="${store}" var="store" varStatus="status">
								<option value="${status.index}">${store.store_name}</option>
							</c:forEach>
						</select>
						<div class="input-group-append">
							<button id="connectionBtn" type="button" class="btn btn-secondary">접속하기</button>
						</div>
					</c:if>
				</div>
				<span class="font-weight-bold text-white bg-dark" id="spanStoreError"></span>				
			</div>
		</div>
	</div>
</body>
<script>
	$('#connectionBtn').click(function() {
		var storeIndex = $('#storeList').val();
		
		if (storeIndex != "-1") { //매장을 선택해야만 메인페이지로 이동
			location.href = "${pageContext.request.contextPath}/user/storeChoice2?store=" + storeIndex;
		} else {
			$('#spanStoreError').text('매장 선택 후 접속바랍니다.');
		}
	});
	
	$('#storeList').click(function(){
		$('#spanStoreError').text('');
	});
</script>
</html>