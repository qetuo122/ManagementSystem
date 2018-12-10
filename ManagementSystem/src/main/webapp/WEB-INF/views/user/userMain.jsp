<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	height: 100%;
}

.userMain_container {
	text-align: center;
	padding: 30px;
	height: 100%;
}

.left_area, .center_area, .right_area {
	display: inline-block;
	width: 33%;
	height: 100%;
	padding-top: 10px;
	margin-bottom: 10px;
	border: 1px solid black;
	border-top-left-radius: 15px;
	border-bottom-left-radius: 15px;
	overflow-y: scroll;
}

.title_text {
	font-size: 40px;
	margin-bottom: 20px;
}

.content_text {
	font-size: 30px;
}

.time_table {
	margin: 0 auto;
	border-spacing: 20px;
	border-collapse: separate;
}

.time_table td {
	width: 250px;
	height: 100px;
	border-radius: 15px;
	font-size: 30px;
	color: gray;
	text-align: center;
	background-color: lightgray;
}

.time_table td:hover {
	opacity: 0.7;
	cursor: pointer;
}

.seat_list {
	width: 90%;
	margin: 0 auto;
	margin-left: 6%;
}

.seat_list > div {
	float: left;
	width: 22%;
	height: 90px;
	line-height: 90px;
	border-radius: 15px;
	font-size: 30px;
	color: gray;
	text-align: center;
	background-color: lightgray;
	margin-right: 3%;
	margin-top: 3%;
}

.seat_list > div:hover {
	opacity: 0.7;
	cursor: pointer;
}

.fading {
  -webkit-animation-name: fading;
  -webkit-animation-duration: 1.5s;
  animation-name: fading;
  animation-duration: 1.5s;
}

@-webkit-keyframes fading {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fading {
  from {opacity: .4} 
  to {opacity: 1}
}

/* ///////////////////////////////////////////////////////////// */
/* 좌석 사용 중인 사용자에게 보여질 화면 스타일 지정 */
.userUsingMain_container {
	display: none;
	text-align: center;
	font-size: 50px;
	padding: 30px;
	height: 100%;
}

.using_wrap {
	margin: 0 auto;
	margin-top: 5%;
	border: 3px solid black;
	border-radius: 30px;
	padding: 20px;
	width: 35%;
}

.using_text {
	color: #3E4551;
}

.using_text > span:hover {
	color: red;
	cursor: pointer;
}

.end_btn {
	width: 150px;
	background-color: #f8585b;
	border: none;
	border-radius: 10px;
	color: #fff;
	padding: 15px 0;
	margin-top: 10px;
	text-align: center;
	font-size: 25px;
	cursor: pointer;
}

.end_btn:hover {
	opacity: 0.7;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/modal/userAddTimeModal.jsp"%>
	<%@ include file="/WEB-INF/views/user/userMessage.jsp"%>

	<div class="userMain_container">
		<div class="title_text">안녕하세요. ${userSession.user_name}님!</div>
		<div class="title_text">${storeSelectSession.store_name} 방문을 환영합니다:p</div>
		
		<div class="left_area">
			<div class="content_text">자리선택</div>
			<hr>
			<div class="content_text"><span id="useCnt">0</span> / <span id="totalCnt">0</span></div>
			<div class="seat_list"></div>
		</div>

		<div class="center_area">
			<div class="content_text">시간선택</div>
			<hr>
			<table id="timeTable" class="time_table">
			</table>
		</div>

		<div class="right_area">
			<div class="content_text">결제선택</div>
			<hr>
			<h1>준비 중...</h1>
		</div>
	</div>
	
	<!-- 좌석 사용 중인 유저가 보여질 화면 -->
	<div class="userUsingMain_container fading">
		<div>${userSession.user_name}님 즐거운 시간 되세요:p</div>
		<div>사용 중인 좌석은 <span id="usingSeatNum" style="color: red"></span>번 입니다.</div>
		<div class="using_wrap">
			<div>남은 시간 : <span id="min"></span> <span id="sec"></span></div>
			<div class="using_text"><span id="usingAddTime">시간 충전</span> / <span id="usingSeatChange">자리 변경</span></div>
			<button id="endBtn" class="end_btn">사용 종료</button>
		</div>
	</div>
</body>

<script>
	var selectedST = {}; // 좌석과 시간을 담을 객체 (동적 생성)
		
	$(document).ready(function() {
		createTable($('#timeTable'), 6, 2); // 시간 테이블 동적 생성
		
		$.ajax({ // 좌석 리스트 불러오기
			url : '${pageContext.request.contextPath}/user/getSeatListAll?storeId=${storeSelectSession.store_id}',
			type : 'get',

			success : function(data) {
				var str = '';
				var userId = null; // 사용자 아이디
				var userTime = 0; // 사용자의 남은 시간
				var seatId = null; // 좌석 번호
				var useCnt = 0; // 사용 중인 좌석 수
				
				$('#totalCnt').text(data.length); // 전체 좌석 수 변경
				
				for(var i=0; i<data.length; i++){
					if(data[i].user_id != null){
						if(data[i].user_id == '${userSession.user_id}'){
							userId = data[i].user_id; // 사용 중인 사용자 아이디 가져오기
							seatId = data[i].seat_id; // 사용 중인 좌석 번호 가져오기
							console.log(seatId);
							
							$.ajax({
								url : '${pageContext.request.contextPath}/admin/getUserInfo?storeId=${storeSelectSession.store_id}&userId='+userId,
								type : 'get',
								async: false,
								
								success : function(data) {
									userTime = data.user_time;
								}
							});
						}
						str += '<div class="using" style="font-size:50px; color:red">X</div>';
						useCnt++;
					}
					else{
						str += '<div onclick="seatChoise(this, '+ data[i].seat_id +')">'+ data[i].seat_id +'</div>';
					}
				}
				$('#useCnt').text(useCnt); // 현재 사용 중인 컴퓨터 수 변경
				$('.seat_list').html(str); // 자리 변경 modal창의 테이블과 같이 업데이트
				
				if(userId != null){
					var min = Math.floor(userTime/60); // 분 계산
					var sec = Math.floor(userTime%60); // 초 계산
					
					$('#usingSeatNum').text(seatId); // 좌석 번호 변경
					$('#min').text(min+'분');
					$('#sec').text(sec+'초');
					
					/* sock.onopen = function(){
						
					} */
					
					var timer = setInterval(function (){
						$('#min').text(min+'분');
						$('#sec').text(sec+'초');
						
						if(sec == 1 && min == 0){ // 사용 시간 종료
							clearInterval(timer);

						} else{
							sec--;
							
							if(sec < 1){
								min--;
								sec = 59;
							}
						}
						
						var seatUser = {
								seatId : seatId,
								min : min,
								sec : sec,
						};

						sock.send(JSON.stringify(seatUser)); // 서버로 메시지 전송
						
					}, 1000);
					
					/* modal 시간 select option 초기화  */
					for (var i = 1; i <= 12; i++) {
						var option = '<option value='+ i + '>' + i + ' 시간</option>';
						$('#selectAddTime').append(option);
					}
					
					$('.userMain_container').hide();
					$('.userUsingMain_container').show();
					
				}
			}
		}); // end ajax
		
		
		/* 사용 전 Modal창 충전하기 버튼 */
		$('#addTimeBtn').on('click', function() {
			var seatId = selectedST.seat;
			var addTime = selectedST.time*60*60; // 초 단위 저장
			
			$.ajax({
				// 로그인한 아이디와 충전시간, 선택한 좌석 번호, 매장 번호 넘겨 줌.
				url: '${pageContext.request.contextPath}/user/updateAddTime?userId=${userSession.user_id}&addTime=' + addTime + '&seatId=' + seatId + '&storeId=${storeSelectSession.store_id}', 
				type: 'get',
				
				success:function(){
					location.reload();
				} // end success  
			}); // end ajax
		});
		
		/* 사용 중 충전하기 */
		$('#usingAddTime').on('click', function () {
			$('#usingAddTimeModal').show();
		});
		
		/* 사용 중 자리변경 */
		$('#usingSeatChange').on('click', function () {
			$('#usingSeatChangeModal').show();
		});
		
		/* 사용 중 Modal창 충전하기 버튼 */
		$('#usingAddTimeBtn').on('click', function () {
			var addTime = $('#selectAddTime option:selected').val()*60*60;
			
			if(addTime == 0){
				alert('충전하실 시간을 선택하세요.');
				return;
			}
			
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/updateAddTime?storeId=${storeSelectSession.store_id}&userId=${userSession.user_id}&addTime='+addTime,
				type:'get',
				
				success:function(data){
					location.reload();
				}
			});
		});
		
		/* 사용 중 Modal창 자리이동 버튼 */
		$('#usingSeatChangeBtn').on('click', function () {
			if(selectedST.seat == null){
				alert('이동하실 좌석을 선택하세요.');
				return;
			}
			var changeConfirm = confirm('정말 이동하시겠습니까?');
			
			if(changeConfirm){
				$.ajax({
					url: '${pageContext.request.contextPath}/user/updateSeatChange?storeId=${storeSelectSession.store_id}&userId=${userSession.user_id}&seatId='+selectedST.seat,
					type:'get',
					
					success:function(data){
						location.reload();
					}
				});
			}
		});
		
		/* 사용 종료 */
		$('#endBtn').on('click', function () {
			var ordersConfirm = confirm('정말 종료하시겠습니까?');
			
			if(ordersConfirm){
				$.ajax({
					// 유저 아이디와 스토어 번호 넘겨 줌.
					url: '${pageContext.request.contextPath}/user/deleteUsingInfo?userId=${userSession.user_id}&storeId=${storeSelectSession.store_id}', 
					type: 'get',
					
					success:function(){
						location.reload();
					} // end success  
				});
			}
		});
		
		/* 시간 충전 modal 창 닫기 버튼 클릭 시 처리 */
		$('.close').on('click', function() {
			selectedReset();
			$('#addTimeModal').hide();
			$('#usingAddTimeModal').hide();
			$('#usingSeatChangeModal').hide();
		});

		/* modal 창 외 윈도우 클릭 시 처리 */
		$(window).on('click', function() {
			if (event.target == $('#addTimeModal').get(0)) {
				selectedReset();
				$('#addTimeModal').hide();
			}
			if(event.target == $('#usingAddTimeModal').get(0)){
				$('#usingAddTimeModal').hide();
			}
			if(event.target == $('#usingSeatChangeModal').get(0)){
				$('#usingSeatChangeModal').hide();
			}
		});
	}); // end document.ready
	
	/* 좌석 선택 처리 */
	function seatChoise(e, seatId) {
		$('.seat_list > div').each(function (index, item) {
			choiseProcess(seatId, item, e, 'seat');
		});
	}
	
	/* 시간 선택 처리 */
	function timeChoise(e) {
		$('#timeTable > tr > td').each(function (index, item) {
			choiseProcess(index, item, e, 'time');
		});
	}
	
	/* 선택 처리 과정 공통 */
	function choiseProcess(id, item, e, property) {
		if(item == e){ 

			if($(e).hasClass('selected')){
				$(e).css('background-color', '');
				$(e).css('color', '');
				$(e).removeClass('selected');
				
				if(property == 'seat'){ selectedST.seat = null;	}
				else { selectedST.time = null; }
			}
			else{
				$(e).css('background-color', '#3F729B');
				$(e).css('color', 'white');
				$(e).addClass('selected');
				
				if(property == 'seat'){ selectedST.seat = id; } // 실제 데이터베이스의 seat_id 저장
				else { selectedST.time = (id+1); } // index 저장
			}
		}
		
		else {
			if(!($(item).hasClass('using'))){ // 사용 중인 좌석이 아닌 경우에만
				$(item).css('background-color', '');
				$(item).css('color', '');
				$(item).removeClass('selected');
			}
		}
		
		if(selectedST.seat != null && selectedST.time != null){ // 시간과 좌석이 모두 선택되었으면
			$('#selectedInfo').children().eq(0).text('${userSession.user_name}');
			$('#selectedInfo').children().eq(1).text(selectedST.seat + '번');
			$('#selectedInfo').children().eq(2).text(selectedST.time + '시간(' + numberWithCommas(selectedST.time*1000) + '원)');
			$('#addTimeModal').show();
		}
	}
	
	/* 선택한 좌석과 시간 초기화 */
	function selectedReset() {
		$('.selected').css('background-color', '');
		$('.selected').css('color', '');
		$('.selected').removeClass();
		
		selectedST.seat =  null;
		selectedST.time =  null;
	}
	
	/* 시간 테이블 동적 생성(테이블 객체, 행, 열) */
	function createTable(obj, r, c) {
		var str = '';
		var id = 1;
		var price = 1000;

		for (var i = 0; i < r; i++) {
			str += '<tr>';

			for (var j = 0; j < c; j++) {
				str += '<td onclick="timeChoise(this)">';
				str += '<div>'+ numberWithCommas(price) +'원</div>';
				price += 1000;
				
				if(id < 10){ str += '<div>0' + id + ':00</div>'; }
				else { str += '<div>' + id + ':00</div>'; }
				str += '</td>';
				id++;
			}
			str += '</tr>';
		}
		$(obj).append(str);
	}
	
	/* 가격에 콤마 표시 */
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

</script>
</html>

