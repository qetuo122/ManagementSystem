<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/js/mdb.min.js"></script>
<style>
*{
	font-size: 20px;
	font-family: 'BMHANNAPro';
}

input{
	font-family: sans-serif;
}
html, body {
	/* background-color: black; */
	background-image: url(<%=request.getContextPath()%>/images/ms-background.jpg);
	background-size: cover;
	height: 100%;
}

body {
	margin: 0;
}

.full {
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	height: 70%;
}

.area_inputs {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	margin: auto;
	width: 350px;
	height: 40%;
}

#loginBtn, #singupBtn {
	width: 49%;
	margin: 0px;
}

#remember_label {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}


@media ( max-width : 767px ) {
	.area_inputs {
		width: 270px;
	}
	#loginBtn, #singupBtn {
		width: 100%;
	}
	#loginBtn {
		margin-bottom: 5px;
	}
	html, body {
		background-position: center;
	}
	#spanLoginCheck {
		font-size: 18px;
	}
}
</style>
</head>
<body>
	<!-- Cookie 객체 확인 및 checked 속성 바꾸기 -->
	<c:if test="${not empty cookie.admin_check}">
		<c:set value="checked" var="checked"/>
	</c:if>
	<div class="full">
		<div style="float: right; margin-top: 10px; margin-right: 10px;">
			<a href="${pageContext.request.contextPath}/"> 
				<img src="${pageContext.request.contextPath}/images/back-arrow.png" style="height: 40px; visibility: hidden;" />
			</a>
		</div>
		<div class="container">
			<div class="area_inputs wow fadeIn" data-wow-delay="0.3s">
				<div class="form-group">
					<div>
						<input type="text" class="form-control" id="inputId" name="admin_id" value="${cookie.admin_check.value}" placeholder="아이디">
					</div>
				</div>
				<div class="form-group">
					<div>
						<input type="password" class="form-control" id="inputPassword" name="admin_pw" placeholder="비밀번호">
					</div>
				</div>
				<div class="form-group">
					<span class="font-weight-bold text-white bg-dark" id="spanLoginCheck"></span>
				</div>
				<div class="form-group">
					<label id="remember_label" class="font-weight-bold text-white">
						<input type="checkbox" id="remember_ad" name="remember_adminId" ${checked}> 아이디 기억하기
					</label>
					<div>
						<button id="loginBtn" type="submit" class="btn btn-danger btn-inline-block">로그인</button>
						<a id="singupBtn" class="btn btn-deep-orange btn-inline-block" href="${pageContext.request.contextPath}/admin/reg">회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		//애니메이션 메서드
		new WOW().init();
	
		//아이디input에서 엔터입력시 비밀번호input으로 넘어감
		$('#inputId').keydown(function(event){
			if(event.keyCode == 13){
				$('#inputPassword').focus();
			}
		});
		
		//비밀번호input에서 엔터를 누르면 로그인 클릭됨
		$('#inputPassword').keydown(function(event) {
			if(event.keyCode == 13){
				$('#loginBtn').trigger('click');
			}
		});
	});
	
	$('#loginBtn').click(
		function() {
			var id = $('#inputId').val();
			var pw = $('#inputPassword').val();
			var remember_ad = $('#remember_ad').is(':checked');
				$.ajax({
					type : 'post',
					url : '${pageContext.request.contextPath}/admin',
					data : {
						admin_id : id,
						admin_pw : pw,
						remember_adminId : remember_ad
					},success : function(data) {
						if (data == 0) {
							$('#spanLoginCheck').text('로그인 정보를 정확히 입력해주세요.');
						}  else {
							location.href = '${pageContext.request.contextPath}/admin/storeChoice?id=' + id;
						}
					}
				});
			});
</script>
</html>