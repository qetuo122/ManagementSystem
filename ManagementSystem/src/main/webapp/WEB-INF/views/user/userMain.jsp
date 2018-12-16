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
	display: none;
	text-align: center;
	padding: 30px;
	height: 100%;
}

.left_area, .center_area, .right_area {
	display: inline-block;
	width: 50%;
	height: 100%;
	padding-top: 10px;
	margin-bottom: 10px;
	border: 1px solid black;
	overflow-y: scroll;
}

.center_area, .right_area {
	display: none;
}

.title_text {
	font-size: 35px;
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
	font-size: 30px;
	border-radius: 15px;
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

.prev_btn {
	float: left;
	margin-left: 10px;
	margin-right: -20px;
}

.prev_btn:hover {
  	background-color: rgba(0,0,0,0.8);
}


@media ( max-width : 767px ) {
	.left_area, .center_area, .right_area {
		width: 300px;
	}
	.title_text {
		font-size: 25px;
		margin-bottom: 0px;
	}
	.using_wrap {
		width: 300px;
	}
	.userUsingMain_container {
		font-size: 27px;
	}
}


</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/modal/userAddTimeModal.jsp"%>
	<%@ include file="/WEB-INF/views/user/userMessage.jsp"%>

	<div class="userMain_container">
		<div class="title_text">안녕하세요. ${userSession.user_name}님!</div>
		<div class="title_text" style="margin-bottom: 20px">${storeSelectSession.store_name} 방문을 환영합니다:p</div>
		
		<div class="left_area">
			<div class="content_text">자리선택</div>
			<hr>
			<div class="content_text"><span id="useCnt">0</span> / <span id="totalCnt">0</span></div>
			<div class="seat_list"></div>
		</div>

		<div class="center_area">
			<div class="content_text">
				<a class="prev_btn">&#10094;</a> 
				<span>시간선택</span>
			</div>
			
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
	var selectedSeatId = null;
	var selectedTimeId = null;
	var isSockOpen = false;
	var timer = null;
	
	$(document).ready(function() {
		
		sock.onopen = function () {
			isSockOpen = true;
		}
		
		getSeatList(); // 좌석 불러오기
		createTime($('#timeTable'), 6, 2); // 시간 테이블 동적 생성
		
		/* 사용 전 Modal창 충전하기 버튼 */
		$('#addTimeBtn').on('click', function() {
			updateSeat(selectedSeatId, selectedTimeId);
		});
		
		/* 사용 전 사용 시간 존재할 때 Modal 충전하기 */
		$('#alreadyTimeBtn').on('click', function () {
			$('#alreadyTimeModal').hide();
			$('.left_area').attr('style', 'display:none');
			$('.center_area').attr('style', 'display:inline-block');
		});
		
		/* 사용 전 사용 시간 존재할 때 바로 시작 하기 */
		$('#startBtn').on('click', function () {
			updateSeat(selectedSeatId, 0);
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
					sendInfo($('#usingSeatNum').text(), 2);
					$('#usingAddTimeModal').hide();
					getSeatList();
				}
			});
		});
		
		/* 사용 중 Modal창 자리이동 버튼 */
		$('#usingSeatChangeBtn').on('click', function () {
			if(selectedSeatId == null){
				alert('이동하실 좌석을 선택하세요.');
				return;
			}
			var changeConfirm = confirm('정말 이동하시겠습니까?');
			
			if(changeConfirm){
				if(overlapped(selectedSeatId)){
					alert('이미 사용중인 좌석입니다.');
					location.reload();
				}
				
				else {
					$.ajax({
						url: '${pageContext.request.contextPath}/user/updateSeatChange',
						type:'get',
						data: {
							userId: '${userSession.user_id}',
							storeId: '${storeSelectSession.store_id}',
							seatId: selectedSeatId
						},
						
						success:function(data){
							sendInfo(selectedSeatId, 3);
							$('#alreadyTimeModal').hide();
							$('#usingSeatChangeModal').hide();
							getSeatList();
						}
					});
				}
			}
		});
		
		/* 사용 종료 */
		$('#endBtn').on('click', function () {
			var ordersConfirm = confirm('정말 종료하시겠습니까?');
			
			if(ordersConfirm){
				deleteSeat();
			}
		});
		
		/* 시간 선택 창 이전 버튼 */
		$('.prev_btn').on('click', function () {
			$('.center_area').attr('style', 'display:none');
			$('.left_area').attr('style', 'display:inline-block');
			selectedReset('.selected'); 
			selectedTimeId = null;
		});
		
		/* 시간 충전 modal 창 닫기 버튼 클릭 시 처리 */
		$('.close').each(function(num){
			$(this).on('click', function(){
				if(num == 1){
					$('#addTimeModal').hide();
					selectedReset('.selected');
					selectedTimeId = null;
					
				}
				else if(num == 2){
					$('#alreadyTimeModal').hide();
					selectedReset('.selected'); 
					selectedSeatId = null;
				}
				
				else if(num == 3){
					$('#usingAddTimeModal').hide();
				}
				
				else if(num == 4){
					$('#usingSeatChangeModal').hide();
				}
			});
		});
		
		/* modal 창 외 윈도우 클릭 시 처리 */
		$(window).on('click', function() {
			if (event.target == $('#addTimeModal').get(0)) {
				$('#addTimeModal').hide();
				selectedReset('.selected'); 
				selectedTimeId = null;
			}
			else if(event.target == $('#alreadyTimeModal').get(0)){
				$('#alreadyTimeModal').hide();
				selectedReset('.selected'); 
				selectedSeatId = null;
			}
			else if(event.target == $('#usingAddTimeModal').get(0)){
				$('#usingAddTimeModal').hide();
			}
			else if(event.target == $('#usingSeatChangeModal').get(0)){
				$('#usingSeatChangeModal').hide();
			}
		});
		
	}); // end document.ready
	
	function getSeatList(){
		$.ajax({ // 좌석 리스트 불러오기
			url : '${pageContext.request.contextPath}/user/getSeatListAll?storeId=${storeSelectSession.store_id}',
			type : 'get',

			success : function(data) {
				var str = '';
				var usingSeat = false;
				var seatId = null;
				var totalCnt = data.length;
				var useCnt = 0;
				
				for(var i=0; i<data.length; i++){	
					if(data[i].user_id != null){
						str += '<div class="using" style="font-size:50px; color:red">X</div>';
						useCnt++;
						
						if(data[i].user_id == '${userSession.user_id}'){
							seatId = data[i].seat_id;
							usingSeat = true;
						}
					}
					
					else {
						str += '<div onclick="selectedSeat(this, '+ data[i].seat_id +')">'+ data[i].seat_id +'</div>';
					}
					$('.seat_list').html(str);
				}
				
				if(usingSeat){
					if(timer != null){
						clearInterval(timer);
					}
					
					$.ajax({
						url : '${pageContext.request.contextPath}/admin/getUserInfo',
						type : 'get',
						data : {
							userId : '${userSession.user_id}',
							storeId : '${storeSelectSession.store_id}'
						},
						
						success : function(data) {
							var min = Math.floor(data.user_time/60); // 분 계산
							var sec = Math.floor(data.user_time%60); // 초 계산
							
							$('#usingSeatNum').text(seatId); // 좌석 번호 변경
							$('#min').text(min+'분');
							$('#sec').text(sec+'초');
							
							timer = setInterval(function (){
								$('#min').text(min+'분');
								$('#sec').text(sec+'초');
								
								if(sec == 1 && min == 0){ // 사용 시간 종료
									clearInterval(timer);
									deleteSeat();

								}
								else{
									sec--;
									
									if(sec < 1){
										min--;
										sec = 59;
									}
								}
							}, 1000); // end timer
							
							/* modal 시간 select option 초기화  */
							for (var i = 1; i <= 12; i++) {
								var option = '<option value='+ i + '>' + i + ' 시간</option>';
								$('#selectAddTime').append(option);
							}
							
							$('.userUsingMain_container').show();
						} // end success
					});			
				}
				
				else {
					$('#useCnt').text(useCnt); // 현재 사용 중인 컴퓨터 수 변경
					$('#totalCnt').text(totalCnt); // 전체 좌석 수 변경
					$('.userMain_container').show();
				}
			}
		});
	}
	
	// 좌석 중복 선택 시 처리
	function overlapped(seatId){
		var overlapped = false;
		
		$.ajax({ 
			url : '${pageContext.request.contextPath}/user/getSeatListAll?storeId=${storeSelectSession.store_id}',
			type : 'get',
			async : false,
			
			success:function(data){
				for(var i=0; i<data.length; i++){
					if(data[i].user_id != null){ 
						if(data[i].seat_id == seatId){
							overlapped = true;
						}
					}
				}
			} 
		});
		return overlapped;
	}
	
	/* 좌석 선택 처리 */
	function selectedSeat(obj, seatId) {
		if($(obj).hasClass('selected')){
			selectedReset(obj);
			selectedSeatId = null;
		}
	
		else{
			selectedReset('.selected');
			$(obj).css('background-color', '#3F729B');
			$(obj).css('color', 'white');
			$(obj).addClass('selected');

			selectedSeatId = seatId;
			
			$.ajax({
				url : '${pageContext.request.contextPath}/admin/getUserInfo',
				type : 'get',
				data : {
					userId : '${userSession.user_id}',
					storeId : '${storeSelectSession.store_id}'
				},
				
				success : function(data) {
					
					// 남은 시간 존재
					if(data.user_time != 0){ 
						$('#alreadySelectedInfo').children().eq(0).text('${userSession.user_name}');
						$('#alreadySelectedInfo').children().eq(1).text(seatId);
						$('#alreadySelectedInfo').children().eq(3).text(Math.floor(data.user_time/60));
						$('#alreadySelectedInfo').children().eq(4).text(Math.floor(data.user_time%60));
						$('#alreadyTimeModal').show();				
					}
					
					else {
						$('.left_area').attr('style', 'display:none');
						$('.center_area').attr('style', 'display:inline-block');
					}
				}
			});
		}
	}
	
	/* 시간 선택 처리 */
	function selectedTime(obj, time) {
		if($(obj).hasClass('selected')){
			selectedReset(obj);
			selectedTimeId = null;
		}
	
		else{
			selectedReset('.selected');
			$(obj).css('background-color', '#3F729B');
			$(obj).css('color', 'white');
			$(obj).addClass('selected');
			
			selectedTimeId = time;
		}
		
		if(selectedSeatId != null && selectedTimeId != null){ // 시간과 좌석이 모두 선택되었으면
			$('#selectedInfo').children().eq(0).text('${userSession.user_name}');
			$('#selectedInfo').children().eq(1).text(selectedSeatId + '번');
			$('#selectedInfo').children().eq(2).text(selectedTimeId + '시간(' + numberWithCommas(selectedTimeId*1000) + '원)');
			$('#addTimeModal').show();
		}
	}
	
	// 시간 충전
	function updateSeat(seatId, addTime){
		if(overlapped(seatId)){
			alert('이미 사용중인 좌석입니다.');
		}
		
		else {
			$.ajax({
				// 로그인한 아이디와 충전시간, 선택한 좌석 번호, 매장 번호 넘겨 줌.
				url: '${pageContext.request.contextPath}/user/updateAddTime', 
				type: 'get',
				async: false,
				
				data: {
					userId : '${userSession.user_id}',
					addTime : addTime*60*60,
					seatId : seatId,
					storeId : '${storeSelectSession.store_id}'
				},
				
				success:function(){
					if(isSockOpen){
						console.log('데이터 보냄');
						sendInfo(seatId, 1);
					}
				} // end success  
			}); // end ajax	
		}
		location.reload();
	}
	
	/* 선택한 좌석과 시간 초기화 */
	function selectedReset(obj) {
		$(obj).css('background-color', '');
		$(obj).css('color', '');
		$(obj).removeClass();
	}
	
	// 종료 좌석 초기화
	function deleteSeat(){
		$.ajax({
			// 유저 아이디와 스토어 번호 넘겨 줌.
			url: '${pageContext.request.contextPath}/user/deleteUsingInfo', 
			type: 'get',
			data: {
				userId: '${userSession.user_id}',
				storeId: '${storeSelectSession.store_id}'
			},
			
			success:function(){
				if(isSockOpen){
					console.log('데이터보냄');
					sendInfo($('#usingSeatNum').text(), 0); // 종료된 좌석번와 처리 넘버
				}
				location.reload();
			} 
		});
	}
	
	/* 시간 테이블 동적 생성(테이블 객체, 행, 열) */
	function createTime(obj, r, c) {
		var str = '';
		var id = 1;
		var cnt = 0;
		var price = 1000;

		for (var i = 0; i < r; i++) {
			str += '<tr>';

			for (var j = 0; j < c; j++) {
				str += '<td onclick="selectedTime(this, '+ (++cnt) +')">';
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
