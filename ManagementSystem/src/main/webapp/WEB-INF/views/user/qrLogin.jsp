<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
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
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<style>
*{
	font-size: 20px;
	font-family: 'BMHANNAPro';
}

input{
	font-family: sans-serif;
}

html, body {
	background-color: black;
	height: 100%;
}

body {
	margin: 0;
}

.container {
	min-height: 80%;
	position: relative;
}

.full {
<%-- 	background-image:
		url("<%=request.getContextPath()%>/images/login-back.jpg"); --%>
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	height: 70%;
}
.a_none{
	font-size: 16px;
	font-weight: bolder;
}

.interval_height{
	margin-bottom: 5px;
}

.area_inputs {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	margin: auto;
	width: 80%;
	height: 30%;
}

.select_pick{
	display:inline;
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
/* 시간충전 modal창 내용 */
.modal_contents {
	background-color: #fefefe;
	margin: auto;
	padding: 15px;
	border: 1px solid #888;
	border-radius: 20px;
	width: 50%;
	text-align: center;
}

/* modal창 감싸고 있는 배경 Div */
.add_time_modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* 시간충전 modal창 내용 */
.modal_contents {
	background-color: #fefefe;
	margin: auto;
	padding: 15px;
	border: 1px solid #888;
	border-radius: 20px;
	width: 50%;
	text-align: center;
}

/* 충전하기 버튼 */
.add_time_btn {
	width: 150px;
	background-color: #f8585b;
	border: none;
	border-radius: 10px;
	color: #fff;
	padding: 15px 0;
	margin-top: 10px;
	text-align: center;
	font-size: 18px;
	cursor: pointer;
}

/* close 버튼 */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	font-size: 28px;
	font-family: sans-serif;
}

.selectedInfo {
	font-size: 24px;
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
	
	<div class="full">
		<div class="container">
			<div class="area_inputs wow fadeIn">
				<div class="form-group">
					<label class="font-weight-bold text-white" for="inputId">아이디</label>
					<div>
						<input type="text" class="form-control" id="inputId" name="user_id" value="${cookie.user_check.value}" placeholder="아이디">
					</div>
				</div>
				<div class="form-group">
					<label class="font-weight-bold text-white" for="inputPassword">비밀번호</label>
					<div>
						<input type="password" class="form-control" id="inputPassword" name="user_pw" placeholder="비밀번호">
					</div>
				</div>
				<div class="form-group">
					<span class="font-weight-bold text-white bg-dark"
						id="spanLoginCheck"></span>
				</div>
				<div class="form-group">
					<label class="font-weight-bold text-white"> 
						<input type="checkbox" id="remember_us" name="remember_userId" ${checked}> 아이디 기억하기
					</label>
					<div class="interval_height a_none">
						<a href="${pageContext.request.contextPath}/user/userSearch">&nbsp; 아이디 / 비밀번호 찾기</a>
					</div>
					<div>
						<button id="loginBtn" type="button"	class="btn btn-primary btn-block">로그인</button>
					</div>
				</div>
				<div class="form-group">
					<a class="btn btn-deep-orange btn-block" href="${pageContext.request.contextPath}/user/reg">회원가입</a>
				</div>
				<div class="form-group socialimage" id="kakaoBtn">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=85f4a0fdfed755ce3d9b2b081af17f44&redirect_uri=http://localhost:8080/MS/kakaologin&response_type=code">
						<img id="socialimage" src="${pageContext.request.contextPath}/images/logo-kakao.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="naverBtn">
					<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=BLxuRdNAKQL9y0hx6ugp&redirect_uri=http://localhost:8080/MS/naverlogin&state=<%= state %>">
						<img src="${pageContext.request.contextPath}/images/logo-naver.png" height="100%"/>
					</a>
				</div>
				<div class="form-group socialimage" id="githubBtn">
					<a href="https://github.com/login/oauth/authorize?client_id=ca3c1f71782ed1d5d649&redirect_uri=http://localhost:8080/MS/githublogin">
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
	</div>
	
<!-- 시간 추가 modal -->
<div id="add_time_modal" class="add_time_modal">
	<div class="modal_contents">
		<h3>
			<b>충전 후 바로 사용 가능합니다.</b><span class="close">&times;</span>
		</h3>
		
		<div id="selectedInfo" class="selectedInfo">
			<span style="font-weight: bold" id = "user_id"></span>님, <!-- 사용자 이름 -->
			<span style="color: red; font-weight: bold" id = "seat_id"></span>자리에 <!-- 좌석 번호  -->
			<select	name="addTime" id="selectAddTime">
			<option value="0">select Time</option></select>을 충전하시겠습니까? <!-- 충전 시간(가격) -->
		</div>
		
		<button id="add_time_btn" class="add_time_btn">충전하기</button>
	</div>
</div>	
</body>
<script>
	var store_id = "${param.store_id}"; //get으로 받아온 매장아이디
	var seat_id = "${param.seat_id}"; //get으로 받아온 자리아이디
	
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
		var remember_us = $('#remember_us').is(':checked');
			$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/',
			data : {
				user_id : id,
				user_pw : pw,
				store_id : store_id,
				remember_userId : remember_us
				},
				success : function(data) {
					if (data == 0) { //로그인 실패시
						console.log(data);
						$('#spanLoginCheck').text('로그인 정보를 정확히 입력해주세요.').attr("class","font-weight-bold text-white bg-dark");
					} else if (data == -2) { //인증하지 않았다면?
						console.log(data);
						$('#spanLoginCheck').text('이메일 인증을 해주셔야 합니다!').attr("class","font-weight-bold text-white bg-dark");						
					} else if (data == -3) { // 아이디가 사용중이라면?
						chkTime(id);
					} else { //로그인 성공시
						chkTime(id);
					}
				}
			});
		});
	function chkTime(id){
		$.ajax({
			url : '${pageContext.request.contextPath}/user/chkTime/' + id,
			success : function(data){
				if(data == null || data == ""){ //남은시간이 없는경우 모달창 띄움
					$('#add_time_modal').show();
					$('#user_id').text($('#inputId').val());
					$('#seat_id').text(seat_id);
				} else { //남은시간이 있는경우 
					$.ajax({ //기존에 로그인이 되어있는지 검사
						url : '${pageContext.request.contextPath}/user/chkSeat/' + store_id,
						success : function(data2){
							for(var i = 0; i < data2.length; i++){ //해당 매장에 접속중인 사용자들의 리스트와 내 아이디를 비교
								if(id == data2[i]){ //다른자리에 로그인된 상태라면
									if(confirm("기존에 로그인된 상태입니다. 로그아웃시키고 접속하시겠습니까?")){
										$.ajax({
											url: '${pageContext.request.contextPath}/user/deleteUsingInfo?userId=' + id + '&storeId=' + store_id, 
											type: 'get',
											success:function(){
												newAddTime(0);
											} // end success  
										}); // 기존 로그인된아이디 로그아웃 ajax끝 
									} else {
										location.reload();
									}
								} else { //다른자리에 로그인 안된 상태라면
									newAddTime(0);
								} 	
							} //로그인된상태 반복문 끝
						}
					});
				}
			}
		});
	}
	$('#add_time_btn').click(function(){
		var addTime = $('#selectAddTime option:selected').val()*60*60; // 충전할 시간(초 단위)
		if ($('#selectAddTime option:selected').val() == 0) {
			alert('충전하실 시간을 선택하세요.');
			return;
		} else {
			newAddTime(addTime);
		}
	});
	//////////// 시간을 충전하는 경우 로그인 /////////////
	function newAddTime(time){
		var userId = $('#inputId').val(); //사용자 아이디
		//선택한 자리에 다른 사용자가 있는지 검색
		$.ajax({
			url : '${pageContext.request.contextPath}/user/chkId/' + seat_id,
			success : function(data){
				console.log(data);
				if(data == null || data == ""){ // 선택한자리가 사용중이지 않다면 그냥 로그인
					$.ajax({ 
						url : '${pageContext.request.contextPath}/user/updateAddTime?addTime=' + time + '&seatId=' + seat_id + '&storeId=' + store_id + '&userId=' + userId,
						success : function(){
							$.ajax({
								url : '${pageContext.request.contextPath}/user/loginSuccess',
								data : {
									store_id : store_id,
									seat_id : seat_id,
									user_id : userId
								},
								success : function(){
									location.href = "${pageContext.request.contextPath}/user/main";
								}
							});
						}
					});	
				} else { //선택한자리가 사용중일떄 나이면 그냥 로그인 아니라면 거부
					if(data == userId){ //내가 사용중이라면
						$.ajax({ 
							url : '${pageContext.request.contextPath}/user/updateAddTime?addTime=' + time + '&seatId=' + seat_id + '&storeId=' + store_id + '&userId=' + userId,
							success : function(){
								$.ajax({
									url : '${pageContext.request.contextPath}/user/loginSuccess',
									data : {
										store_id : store_id,
										seat_id : seat_id,
										user_id : userId
									},
									success : function(){
										location.href = "${pageContext.request.contextPath}/user/main";
									}
								});
							}
						});
					} else { // 다른사람이 사용중이라면
						$('#spanLoginCheck').html("이미 사용중인 자리입니다.").attr("class","alreadUsing").css("color","red").css("font-weight","bold").css("background-color","#212121");
						//$('#spanLoginCheck').html("이미 사용중인 자리입니다.").attr("style","color : red !important; font-size : 30px;");
						//!important속성을 줄때 .css메서드로는 안먹히므로 attr속성으로 준다.
						//$('#spanLoginCheck').html("이미 사용중인 자리입니다.").css("color","red !important");
						$('#add_time_modal').hide();
					}
				} 
			}
		});
	}
	//모달창에 시간셀렉트문
	for (var i = 1; i <= 12; i++) {
		var option = '<option value='+ i + '>' + i + ' 시간 (' + i + ',000원)</option>';
		$('#selectAddTime').append(option);
	}
	
	var naver_id_login = new naver_id_login("OUHAR0pHNVfL5y2SBk3v", "http://localhost:8080/ms/user/main");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	naver_id_login.setDomain("http://localhost:8080/ms");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
	
	/* 설정정보를 초기화하고 연동을 준비 */
	/* naverLogin.init(); */
	$('.close').click(function(){
		$('#add_time_modal').hide();
	});

	
</script>
</html>