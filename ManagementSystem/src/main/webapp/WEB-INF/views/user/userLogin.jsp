<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MS</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/css/mdb.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.13/js/mdb.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" type="text/css">
<style>
* {
	font-size: 20px;
	font-family: 'BMHANNAPro';
}

input {
	font-family: sans-serif;
}

html, body {
	/* background-color: black; */
	background-image: url(<%= request.getContextPath ()%>/images/ms-background.jpg);
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

.a_none {
	font-size: 16px;
	font-weight: bolder;
}

.interval_height {
	margin-bottom: 5px;
}

.area_inputs {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	margin: auto;
	width: 350px;
	height: 60%;
}

.select_pick {
	display: inline;
	width: 70%;
	height: 40px;
	padding: 6px 12px;
	font-size: 17px;
	line-height: 1.0;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 15px;
}

.socialimage {
	height: 65px;
	display: inline-block;
}

#loginBtn, #singupBtn {
	width: 49%;
	margin: 0px;
}

/* 아이디 기억하기 테두리 */
#remember_label {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}

/* 아이디비밀번호 찾기 */
#idANDpw {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}

/* 모바일 최적화 */
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
	.socialimage {
		height: 49px;
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
<%
	//난수 발생
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
%>
<body>
	<!-- Cookie가 비어있지 않을 때 checked 속성을 줌 -->
	<c:if test="${not empty cookie.user_check}">
		<c:set value="checked" var="checked"/>
	</c:if>
	<div style="float: right; margin-top: 10px; margin-right: 10px;">
		<a href="admin"> 
			<img src="${pageContext.request.contextPath}/images/adminLogin-move.png" style="height: 40px; visibility: hidden;" />
		</a>
	</div>
	<div class="full">
			<div class="area_inputs wow fadeIn">
				<div class="form-group">
					<div>
						<input type="text" class="form-control" id="inputId" name="user_id" value="${cookie.user_check.value}" placeholder="아이디">
					</div>
				</div>
				<div class="form-group">
					<div>
						<input type="password" class="form-control" id="inputPassword" name="user_pw" placeholder="비밀번호">
					</div>
				</div>
				<div class="form-group">
					<span class="font-weight-bold text-white bg-dark" id="spanLoginCheck"></span>
				</div>
				<div class="form-group">
					<label id="remember_label" class="font-weight-bold text-white"> 
						<input type="checkbox" id="remember_us" name="remember_userId" ${checked}> 아이디 기억하기
					</label>
					<div id="idANDpw" class="interval_height a_none">
						<a href="${pageContext.request.contextPath}/user/userSearch">&nbsp; 아이디 / 비밀번호 찾기</a>
					</div>
					<div class="signin">
						<button id="loginBtn" type="button"	class="btn btn-primary btn-inline-block">로그인</button>
						<a id="singupBtn" class="btn btn-deep-orange btn-inline-block" href="${pageContext.request.contextPath}/user/reg">회원가입</a>
					</div>
				</div>
				<div class="form-group socialimage" id="kakaoBtn">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=85f4a0fdfed755ce3d9b2b081af17f44&redirect_uri=http://ec2-54-180-123-73.ap-northeast-2.compute.amazonaws.com/MS/kakaologin&response_type=code">
						<img id="socialimage" src="${pageContext.request.contextPath}/images/logo-kakao.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="naverBtn">
					<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=BLxuRdNAKQL9y0hx6ugp&redirect_uri=http://ec2-54-180-123-73.ap-northeast-2.compute.amazonaws.com/MS/naverlogin&state=<%= state %>">
						<img src="${pageContext.request.contextPath}/images/logo-naver.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="githubBtn">
					<a href="https://github.com/login/oauth/authorize?client_id=ca3c1f71782ed1d5d649&redirect_uri=http://ec2-54-180-123-73.ap-northeast-2.compute.amazonaws.com/MS/githublogin">
						<img src="${pageContext.request.contextPath}/images/logo-github.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="githubBtn">
					<a href="">
						<img src="${pageContext.request.contextPath}/images/logo-facebook.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="githubBtn">
					<a href="">
						<img src="${pageContext.request.contextPath}/images/logo-google.png" height="100%"/>
					</a>
				</div>
			</div>
		</div>	
</body>
<script>
	$(document).ready(function(){
		//애니메이션 메서드
		new WOW().init();
		
		//매장select에서 클릭시 아이디input으로 포커스이동
		$('#store_id').change(function(){
			$('#inputId').focus();
		});
		
		//아이디input에서 엔터입력시 비밀번호input으로 포커스이동
		$('#inputId').keydown(function(event){
			if(event.keyCode == 13){
				$('#inputPassword').focus();
			}
		});

		//비밀번호input에서 엔터입력시 로그인버튼 클릭됨
		$('#inputPassword').keydown(function(event) {
			if(event.keyCode == 13){
				$('#loginBtn').trigger('click');
			}
		});
	});
	
	// 로그인 id / pw 유효성 검사
	$('#loginBtn').click(function() {
		var id = $('#inputId').val();
		var pw = $('#inputPassword').val();
		var store = $('#store_id').val();
		var remember_us = $('#remember_us').is(':checked');
			$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/',
			data : {
				user_id : id,
				user_pw : pw,
				store_id : store,
				remember_userId : remember_us
				},
				success : function(data) {
					if (data == 0) { //로그인 실패시
						console.log(data);
						$('#spanLoginCheck').text('로그인 정보를 정확히 입력해주세요.');
					} else if (data == -2) { //인증하지 않았다면?
						console.log(data);
						$('#spanLoginCheck').text('이메일 인증을 해주셔야 합니다!');						
					} else if (data == -3) { // 아이디가 사용중이라면?
						console.log(data);
						location.href = '${pageContext.request.contextPath}/user/redundant?user_Id=' + id + '&user_Pw=' + pw + '&remember_userId=' + remember_us;						
					} else { //로그인 성공시
						console.log(data);
						location.href = '${pageContext.request.contextPath}/user/storeChoice';
					}
				}
			});
		});
</script>
</html>