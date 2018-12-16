<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="https://fonts.googleapis.com/css?family=Righteous&amp;subset=latin-ext" rel="stylesheet">
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
	height: 100%;
}

body {
	margin: 0;
}

.container {
	min-height: 100%;
	width: 350px;
}

.titleStyle {
	padding: 30px;
	margin-top: 10px;
	margin-bottom: 10px;
	color: black;
}

.container h1 {
	font-family: "Righteous";
	font-size: 80px;
	text-align: center;
}

.reg_button {
	padding: 20px;
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<div class="titleStyle">
			<h1>MS :p</h1>
		</div>
		<form method="POST">
			<!-- 아이디 -->
			<div class="form-group">
				<label for="admin_id">아이디</label> <input type="text"
					class="form-control" id="admin_id" name="admin_id" placeholder="ID">
				<div class="check_font" id="id_check"></div>
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label for="admin_pw">비밀번호</label> <input type="password"
					class="form-control" id="admin_pw" name="admin_pw"
					placeholder="PASSWORD">
			</div>
			<!-- 비밀번호 재확인 -->
			<div class="form-group">
				<label for="admin_pw2">비밀번호 재확인</label> <input type="password"
					class="form-control" id="admin_pw2" name="admin_pw2"
					placeholder="Confirm Password">
				<div class="check_font" id="pw_check"></div>
			</div>
			<!-- 이름 -->
			<div class="form-group">
				<label for="admin_name">이름</label> <input type="text"
					class="form-control" id="admin_name" name="admin_name"
					placeholder="Name">
				<div class="check_font" id="name_check"></div>
			</div>
			<!-- 휴대전화 -->
			<div class="form-group">
				<label for="admin_phone">휴대전화 (ex.01033334444)</label> <input type="text"
					class="form-control" id="admin_phone" name="admin_phone"
					placeholder="Phone Number">
				<div class="check_font" id="phone_check"></div>
			</div>
			<div class="reg_button">
				<button type="submit" class="btn btn-primary px-3" id="reg_submit">
					<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
				</button>
				<a class="btn btn-danger px-3" href="${pageContext.request.contextPath}/admin">
					<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
				</a>
			</div>
		</form>
	</div>
</body>
<script>

	//아이디 정규식
	var idJ = /^[a-z0-9]{4,12}$/;
	// 비밀번호 정규식
	var pwJ = /^[A-Za-z0-9]{4,12}$/;
	// 이름 정규식
	var nameJ = /^[가-힣]{2,6}$/;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	// <회원가입> 중복 유효성 검사(1 = 중복 / 0 != 중복)
	$("#admin_id").blur(function() {
		// id = "id_reg" / name = "admin_id"
		var amdin_id = $('#admin_id').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/idCheck?adminId='+amdin_id,
			type : 'get',
			success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {	

						if(idJ.test(amdin_id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("");
							$("#reg_submit").attr("disabled", false);
	
					} else if(amdin_id == ""){
					
						$('#id_check').text('아이디를 입력해주세요 :)');
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", true);				
				
					} else {
				
						$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", true);
					}
				}
			},error : function() {
					console.log("실패");
			}
		});
	});
	
	// <비밀번호> 일치 검사
	$('#admin_pw2').blur(function(){
		// pw1 & pw2 일치하지 않는다면,
		if($("#admin_pw").val() != $(this).val()){
			$("#pw_check").text("비밀번호가 일치하지 않습니다 :(");
			$("#pw_check").css("color", "red");
			
		} else {
			$("#pw_check").text("");
			$("#reg_submit").attr("disabled", false);
		}
	});
			
	// 1-1 정규식 체크
	$('#admin_pw').blur(function() {
		if (pwJ.test($(this).val())) {
			console.log(pwJ.test($(this).val()));
			$('#pw_check').text('');
		} else {
			console.log('false');
			$('#pw_check').text('숫자 or 문자로만 4~12자리 입력');
			$('#pw_check').css('color', 'red');
		}
	});
	
	// 이름에 특수문자 들어가지 않도록 설정
	$("#admin_name").blur(function() {
		if (nameJ.test($(this).val())) {
				console.log(nameJ.test($(this).val()));
				$("#name_check").text('');
		} else {
			$('#name_check').text('이름을 확인해주세요');
			$('#name_check').css('color', 'red');
		}
	});
	
	// 휴대전화
	$('#admin_phone').blur(function(){
		if(phoneJ.test($(this).val())){
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text('');
		} else {
			$('#phone_check').text('번호를 확인해주세요 :p');
			$('#phone_check').css('color', 'red');
		}
	});
	
	// 가입하기 버튼 눌렀을 때 이벤트!
	$('#reg_submit').click(function(){
		// 각 조건식 값
		var total_pass = new Array().fill(false);
		
		// 비밀번호 일치
		if($("#admin_pw").val() != $("#admin_pw2").val()){
			$("#admin_pw2").focus();
			total_pass[0] = false;
		} else{
			total_pass[0] = true;
		}
		// 비밀번호 정규식
		if (pwJ.test($('#admin_pw').val())) {
			total_pass[1] = true;
		} else {
			$("#admin_pw").focus();
			total_pass[1] = false;
		}
		// 이름 정규식
		if (nameJ.test($('#admin_name').val())) {
			total_pass[2] = true;
		} else {
			$("#admin_name").focus();
			total_pass[2] = false;
		}
		// 폰번호 정규식
		if(phoneJ.test($('#admin_phone').val())){
			total_pass[3] = true;
		} else {
			$('#admin_phone').focus();
			total_pass[3] = false;
		}
		
		
		var pass = true;
		// 조건식 에 true false 대입
		for(var i=0; i<total_pass.length; i++){
			if(total_pass[i] == false){
				
				return pass = false;
			}
		}
		// pass(모든 값)가 true라면 submit 버튼 활성화
		if(pass){
			alert('MS와 함께라면 성공합니다 :p');
			return true;
		}else{
			return false;
		}
		
	});
	
</script>

</html>