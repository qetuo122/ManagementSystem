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

.select_pick{
	display:inline;
    width: 35%;
    height: 40px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.0;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 15px;
}

</style>
</head>
<body>
	<div class="container">
		<div class="titleStyle">
			<h1>MS :p</h1>
		</div>
		<form method="POST">
			<!-- 세션에 저장한 소셜 아이디를 가져옴 -->
			<c:if test="${!empty whatid}">
				<input type="hidden" name="whatid" value="${whatid}" />
			</c:if>
			<!-- 세션에 저장한 소셜 구분을 가져옴 -->
			<c:if test="${!empty divide}">
				<input type="hidden" name="divide" value="${divide}" />
			</c:if>

			<!-- 아이디 -->
			<div class="form-group">
				<label for="user_id">아이디</label>
					<input type="text" class="form-control" id="user_id" name="user_id" placeholder="ID" required>
				<div class="check_font" id="id_check"></div>
			</div>
			<!-- 비밀번호 -->
			<div class="form-group">
				<label for="user_pw">비밀번호</label>
					<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="PASSWORD" required>
				<div class="check_font" id="pw_check"></div>
			</div>
			<!-- 비밀번호 재확인 -->
			<div class="form-group">
				<label for="user_pw2">비밀번호 확인</label>
					<input type="password" class="form-control" id="user_pw2" name="user_pw2" placeholder="Confirm Password" required>
				<div class="check_font" id="pw2_check"></div>
			</div>
			<!-- 이름 -->
			<div class="form-group">
				<label for="user_name">이름</label>
					<input type="text" class="form-control" id="user_name" name="user_name" placeholder="Name" value="${param.name}" required>
				<div class="check_font" id="name_check"></div>
			</div>
			<!-- 생년월일 -->
			<div class="form-group required">
				<label for="user_birth">생년월일</label>
					<input type="text" class="form-control" id="user_birth" name="user_birth" placeholder="ex) 19990415" required>
				<div class="check_font" id="birth_check"></div>
			</div>
			<!-- 본인확인 이메일 -->
			<div class="form-group">
				<label for="user_email">이메일</label>
					<input type="text" class="form-control" name="user_email" id="user_email" placeholder="E-mail" value="${param.email}" required>
					<div class="check_font" id="email_check"></div>
			</div>
			<!-- 휴대전화 -->
			<div class="form-group">
				<label for="user_phone">휴대전화 ('-' 없이 번호만 입력해주세요)</label>
				<input type="text" class="form-control" id="user_phone" name="user_phone" placeholder="Phone Number" required>
				<div class="check_font" id="phone_check"></div>
			</div>
			<div class="reg_button">
				<button class="btn btn-primary px-3" id="reg_submit">
					<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
				</button>
				<a class="btn btn-danger px-3" href="${pageContext.request.contextPath}">
					<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
				</a>
			</div>
		</form>
	</div>
</body>
<script>
		
	//모든 공백 체크 정규식
	var empJ = /\s/g;
	//아이디 정규식
	var idJ = /^[a-z0-9]{4,12}$/;
	// 비밀번호 정규식
	var pwJ = /^[A-Za-z0-9]{4,12}$/; 
	// 이름 정규식
	var nameJ = /^[가-힣]{2,6}$/;
	// 이메일 검사 정규식
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
	$("#user_id").blur(function() {
		// id = "id_reg" / name = "userId"
		var user_id = $('#user_id').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/user/idCheck?userId='+ user_id,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다 :p");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} else {
						
						if(idJ.test(user_id)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#id_check").text("");
							$("#reg_submit").attr("disabled", false);
				
						} else if(user_id == ""){
							
							$('#id_check').text('아이디를 입력해주세요 :)');
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else {
							
							$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
							$('#id_check').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
						}
						
					}
				}, error : function() {
						console.log("실패");
				}
			});
		});
	
	// 이메일 중복 검사(1 중복 || 0 사용가능)
	$('#user_email').blur(function(){
		// id = "id_reg" / name = "userId"
		var user_email = $(this).val();
		$.ajax({
			url :'${pageContext.request.contextPath}/user/mailCheck?userMail='+ user_email,
			type :'get',
			dataType : 'json',
			success : function(data){
				console.log(data);
				
				if(data == 1){
					// 1 : 아이디가 중복되는 문구
					$("#email_check").text("이미 가입된 이메일입니다 :p");
					$("#email_check").css("color", "red");
					$("#reg_submit").attr("disabled", true);
				} else{
					// 이메일
					if(mailJ.test($('#user_email').val())){
						console.log(mailJ.test($('#user_email').val()));
						$("#email_check").text('');
						$("#reg_submit").attr("disabled", false);
					} else {
						$('#email_check').text('이메일을 확인해주세요 :)');
						$('#email_check').css('color', 'red');
						$("#reg_submit").attr("disabled", true);
					}
				
				}
				
			}, error : function(error) {
				console.log("실패");
			}
		});
		
	});
		
	// 비밀번호 유효성 검사
	// 1-1 정규식 체크
	$('#user_pw').blur(function() {
		if (pwJ.test($('#user_pw').val())) {
			console.log('true');
			$('#pw_check').text('');
		} else {
			console.log('false');
			$('#pw_check').text('숫자 or 문자로만 4~12자리 입력');
			$('#pw_check').css('color', 'red');
		}
	});
	
	// 1-2 패스워드 일치 확인
	$('#user_pw2').blur(function() {
		if ($('#user_pw').val() != $(this).val()) {
			$('#pw2_check').text('비밀번호가 일치하지 않습니다 :(');
			$('#pw2_check').css('color', 'red');
		} else {
			$('#pw2_check').text('');
		}
	});

	// 이름에 특수문자 들어가지 않도록 설정
	$("#user_name").blur(function() {
		if (nameJ.test($(this).val())) {
				console.log(nameJ.test($(this).val()));
				$("#name_check").text('');
		} else {
			$('#name_check').text('이름을 확인해주세요');
			$('#name_check').css('color', 'red');
		}
	});
	
	
	// 휴대전화
	$('#user_phone').blur(function(){
		if(phoneJ.test($(this).val())){
			console.log(nameJ.test($(this).val()));
			$("#phone_check").text('');
		} else {
			$('#phone_check').text('휴대폰번호를 확인해주세요 :)');
			$('#phone_check').css('color', 'red');
		}
	});

	// 생일 유효성 검사
	var birthJ = false;
	
	// 생년월일	birthJ 유효성 검사
	$('#user_birth').blur(function(){
		var dateStr = $(this).val();		
	    var year = Number(dateStr.substr(0,4)); 
	    var month = Number(dateStr.substr(4,2));
	    var day = Number(dateStr.substr(6,2));
	    var today = new Date(); // 날짜 변수 선언
	    var yearNow = today.getFullYear();
		
	    if (dateStr.length <=8) {
			
		    if (year < 1900 || year > yearNow){
		    	
		    	$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red');
		    	
		    }else if (month < 1 || month > 12) {
		    		
		    	$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red'); 
		    
		    }else if (day < 1 || day > 31) {
		    	
		    	$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red'); 
		    	
		    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		    	 
		    	$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red'); 
		    	 
		    }else if (month == 2) {
		    	 
		       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		       	
		     	if (day>29 || (day==29 && !isleap)) {
		     		
		     		$('#birth_check').text('생년월일을 확인해주세요 :)');
					$('#birth_check').css('color', 'red'); 
		    	
				}else{
					$('#birth_check').text('');
					birthJ = true;
				}//end of if (day>29 || (day==29 && !isleap))
		     	
		    }else{
		    	
		    	$('#birth_check').text(''); 
				birthJ = true;
			}//end of if
			
			}else{
				//1.입력된 생년월일이 8자 초과할때 :  auth:false
				$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red');  
			}
		}); //End of method /*
	
	/* // 매장 선택 값이 0인 경우 경고창
	$("#reg_submit").click(function(){
		console.log($('#store_id').val());
		if($('#store_id option:selected').val() == 0){
			$('#store_id').focus();
			return false;
		} else{
			return true;
		}
	}); */
	
	/* function confirm_email(){
		console.log("인증 버튼");
		
		var email = $('#user_email').val();
		console.log("이메일" + email);
		
		$.ajax({
			url : '${pageContext.request.contextPath}/user/regMailConfirm',
			dataType : 'json',
			type : 'post',
			data : {
				"user_email" : email
			},
			success : function(data){
				console.log("dkjdl;kajf;klajfak;djfl;dakjfl;adjfl;akdfja;dklfja");
				console.log(data);
				alert('이메일이 전송되었습니다 :)');
				
			},error : function(error){
				alert(error);
			}
		});
		
	} */
	
	
	// 가입하기 실행 버튼 유효성 검사!
	var inval_Arr = new Array(5).fill(false);
	$('#reg_submit').click(function(){
		// 비밀번호가 같은 경우 && 비밀번호 정규식
		if (($('#user_pw').val() == ($('#user_pw2').val()))
				&& pwJ.test($('#user_pw').val())) {
			inval_Arr[0] = true;
		} else {
			inval_Arr[0] = false;
		}
		// 이름 정규식
		if (nameJ.test($('#user_name').val())) {
			inval_Arr[1] = true;	
		} else {
			inval_Arr[1] = false;
		}
		// 이메일 정규식
		if (mailJ.test($('#user_email').val())){
			console.log(phoneJ.test($('#user_email').val()));
			inval_Arr[2] = true;
		} else {
			inval_Arr[2] = false;
		}
		// 휴대폰번호 정규식
		if (phoneJ.test($('#user_phone').val())) {
			console.log(phoneJ.test($('#user_phone').val()));
			inval_Arr[3] = true;
		} else {
			inval_Arr[3] = false;
		}
		// 생년월일 정규식
		if (birthJ) {
			console.log(birthJ);
			inval_Arr[4] = true;
		} else {
			inval_Arr[4] = false;
		}
		
		var validAll = true;
		for(var i = 0; i < inval_Arr.length; i++){
			
			if(inval_Arr[i] == false){
				validAll = false;
			}
		}
		
		if(validAll){ // 유효성 모두 통과
			alert('이메일에서 인증 메일을 확인해주세요!');
			/* confirm_email(); */
			/* location.href("${pageContext.request.contextPath}"); */
			/* return false; */
		} else{
			alert('입력한 정보들을 다시 한번 확인해주세요 :)')
			/* return false; */
		}
	});
	 
	
	
</script>

</html>