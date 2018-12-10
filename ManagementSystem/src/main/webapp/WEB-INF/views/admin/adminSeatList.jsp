<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- 시간형식  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.container {
	margin-top: 20px;
}

.adminSeatList_td{
	text-align: center;
	background-color: white;
}

.adminSeatList_input{	
	width: 100%;
	text-align: center;
	border : 0px;	
}

.adminSeatList_edit{
	padding : 5px;
	border : 2px solid red;
}

.adminSeatList_header {
	overflow: hidden;
	width: 1140px;
	margin: 0 auto;
}

.hypertext_none {
	color: #181818;
	text-decoration: none;	
}
.qrModal{
	position : fixed;
	width : 100%;
	height : 100%;
	left : 0px;
    top : 0px;
    z-index : 1;
    background-color : rgba(0, 0, 0, 0.4);
    display : none;
}
.qrImg{
	text-align : center;
	position : absolute;
	top : 50%;
	left : 50%;
	margin-top : -150px;
	margin-left : -150px;
}

</style>
<title>MS</title>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="adminSeatList_header">
		<br>
		<a class="nav-link, hypertext_none" 
		href="${pageContext.request.contextPath}/admin/seat">
		<h1>[${storeSelectSession.store_name}] - 좌석관리</h1></a>
	</div>

	<div class="container">		
		<br>
		<table id="seatListTable" class="table table-striped table-bordered">
			<!-- 좌석등록 폼 -->
			<thead>
				<tr>
					<td style="background: #E6E6F2;" colspan="4"><h4>좌석 추가</h4></td>
				</tr>
				<tr>
					<th class="th-sm">좌석이름</th>
					<th class="th-sm">비용(원)</th>
					<th class="th-sm" colspan = "2">관리</th>
				</tr>
			</thead>
			<tbody>				
				<tr>
					<form>
						<td style="text-align: center;"><input type="text" id="seat_name" name="seat_name" required></td>
						<td style="text-align: center;"><input type="text" id="seat_pay" name="seat_pay" required onkeydown="check_input2_onkeydown()" style="width: 70%;" /> 원 / 시간</td>
						<td style="text-align: center;" colspan = "2"><button id="addseat_btn" type="button">등록</button><button id="reset" type="reset">초기화</button></td>
					</form>
				</tr>				
				<tr>
					<th style="background: #E6E6F2;" colspan="4"><h4>좌석 리스트</h4></th>
				</tr>
			</tbody>
			<!-- 좌석등록 폼 -->
			<!-- 좌석리스트 -->
			<thead>
				<tr>
					<th class="th-sm"><i id="seat_name_sort" class="fa fa-sort float-right" onclick="sorting('seat_name', 'desc')" aria-hidden="true"></i>좌석이름</th>
					<th class="th-sm"><i id="seat_pay_sort" class="fa fa-sort float-right"	onclick="sorting('seat_pay', 'desc')" aria-hidden="true"></i>비용(원)</th>
					<th>QR코드</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="seatlist_tbody">
				<%-- 	<c:forEach var="list" items="${seatlist}">
					<tr>
						<td>${list.seat_name}</td>
						<td style="text-align: right;">${list.seat_pay}</td>
						<td style="text-align: center;">${list.seat_qr}</td>
						<td style="text-align: center;"><button id="seat_modify"
								type="button">수정</button>
							<button id="seat_delete" type="button">삭제</button></td>
					</tr>
				</c:forEach> --%>
			</tbody>
			<!-- 좌석리스트 -->
		</table>
	</div>
	<!-- 큐알코드 확대 모달창 -->
	<div class = "qrModal" id = "qrModal">
		<div class = "qrImg" id = "qrImg"></div>
	</div>
</body>
<script>
	$(document).ready(function() {
		getSeatList()
	});

	var seat_t = '';
	var session_store_id = '${storeSelectSession.store_id}';
	
	var order_by = "seat_name";
	var sort = "asc";

	function sorting(na,so){
		
		order_by = na;
		sort = so;
		
		console.log('sorting 함수 내 order_by : ' + order_by);
		console.log('sorting 함수 내 sort : ' + sort);
		
		getSeatList(); 
		
		if(order_by=='seat_name'){
			if(sort=='desc'){
				$("#seat_name_sort").attr("onclick","sorting('seat_name', 'asc')")
			} else {
				$("#seat_name_sort").attr("onclick","sorting('seat_name', 'desc')")
			}
		}
		
		if(order_by=="seat_pay"){
			if(sort=="desc"){
				$("#seat_pay_sort").attr("onclick","sorting('seat_pay', 'asc')")
			} else {
				$("#seat_pay_sort").attr("onclick","sorting('seat_pay', 'desc')")
			}
		}
		
	}	
	
	
	function getSeatList() { // 좌석 리스트 출력				
	
		console.log('list 함수 내 order_by : ' + order_by);
		console.log('list 함수 내 sort : ' + sort);	
		
		$.ajax({
			type : 'get',
			url : '${pageContext.request.contextPath}/admin/seat/list',
			
			data : {
				store_id : session_store_id,
				order_by : order_by,
				sort : sort
			},

			success : function(data) {
				console.log(data);
				$('#seatlist_tbody').html('<tr><td colspan="4" style="text-align: center;">좌석이 존재하지 않습니다</td></tr>');
				$(data).each(
						function(index, item) {
							seat_t += '<tr><td class="adminSeatList_td">'
							seat_t += '<input id="AdminSeatNameInput' + item.seat_id + '" value="' + item.seat_name	+ '" readonly="true" class="adminSeatList_input" /></td><td class="adminSeatList_td">';
							seat_t += '<input id="AdminSeatPayInput' + item.seat_id + '" value="' + item.seat_pay + '" readonly="true" class="adminSeatList_input" /></td><td class="adminSeatList_td" style = "padding : 0px;">';
							if(item.seat_qr == "" || item.seat_qr == null){
								seat_t += '<input type="button" id="seat_qr_btn' + item.seat_id + '" value="생성하기" readonly="true" class="seat_qr_btn" onclick = "makeQr(' + item.seat_id + ')" style = "margin-top : 16px;"/><div id = "seat_qr" style = "display : none;"></div></td><td class="adminSeatList_td">';
							} else {
								seat_t +='<img src = "' + item.seat_qr + '" style = "width : 50px;" id = "qrImage" onclick = "goQr(' +  "'" + item.seat_qr + "'" + ')"></td><td class="adminSeatList_td">';
							}
							seat_t += '<input type="button" id="seat_modify_btn' + item.seat_id + '" onclick="seat_modify_mode(' + item.seat_id + ')" type="button" value="수정"></button>';
							seat_t += '<input type="button" id="seat_delete_btn' + item.seat_id + '" onclick="seat_delete(' + item.seat_id + ')" type="button" value="삭제"></button></td></tr>';
							$('#seatlist_tbody').html(seat_t);
						});
				seat_t = '';
			}
		});
	}

	$('#addseat_btn').click(function() {//좌석 추가
		var seat_name = $('#seat_name').val().trim();
		var seat_pay = $('#seat_pay').val().trim();
		var seat_qr = $('#seat_qr').val();

		if (seat_pay && seat_name) {
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/admin/seat',
				dataType : 'text',
				data : {
					seat_name : seat_name,
					seat_pay : seat_pay,
					seat_qr : seat_qr,
					store_id : session_store_id
				},

				success : function(data) {
					console.log('좌석등록완료');
					getSeatList();
					$('#seat_name').val('');
					$('#seat_pay').val('');
					$('#seat_qr').val('');
				}
			});
		} else {
			alert("좌석정보를 입력해주세요 :p");
		}
	});

	function seat_delete(seat_id) { // 좌석삭제
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인

			$.ajax({
				type : 'delete',
				url : '${pageContext.request.contextPath}/admin/seat/' + seat_id,
				success : function(data) {
					console.log('삭제확인');
					getSeatList();
				}
			});
		}
	};
	
	function seat_modify(seat_id) { // 댓글 수정 작업
		if (confirm("수정하시겠습니까??") == true){    //확인

			var seat_name = $('#AdminSeatNameInput' + seat_id ).val().trim();
			var seat_pay = $('#AdminSeatPayInput' + seat_id ).val().trim();
			console.log(seat_name);
			console.log(seat_pay);
			console.log(seat_qr);
		
			$.ajax({
				type : 'put',
				url : '${pageContext.request.contextPath}/admin/seat/' + seat_id,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "put"
				},
				
				data : JSON.stringify({
					seat_name : seat_name,
					seat_pay : seat_pay,
				}),			
			
				success : function(data) {
					console.log('수정확인');
					getSeatList();
				}
			});
		}
	};
	
	function seat_modify_mode(seat_id) { // 댓글수정 클릭시
		$('#AdminSeatNameInput' + seat_id ).attr("readonly", false);		
		$('#AdminSeatPayInput' + seat_id ).attr("readonly", false);
		$('#AdminSeatQRInput' + seat_id ).attr("readonly", false);
		
		$('#AdminSeatPayInput' + seat_id ).attr("onkeydown","check_input2_onkeydown()"); //댓글 수정클릭시 숫자만
		$('#AdminSeatQRInput' + seat_id ).attr("type","file");
		$('#AdminSeatNameInput' + seat_id ).focus();
		
		$('#AdminSeatNameInput' + seat_id ).attr("class","adminSeatList_edit");//댓글 수정클릭시 모양바뀜		
		$('#AdminSeatPayInput' + seat_id ).attr("class","adminSeatList_edit");//댓글 수정클릭시 모양바뀜		
		$('#AdminSeatQRInput' + seat_id ).attr("class","adminSeatList_edit");//댓글 수정클릭시 모양바뀜		
		$('#seat_modify_btn' + seat_id ).attr("value","입력")//댓글 수정클릭시 모양바뀜
		$('#seat_modify_btn' + seat_id ).attr("class","adminSeatList_edit")//댓글 수정클릭시 모양바뀜
		$('#seat_modify_btn' + seat_id ).attr("onclick","seat_modify(" + seat_id + ")");
		$('#seat_delete_btn' + seat_id ).attr("value","취소");//댓글 수정클릭시 모양바뀜
		$('#seat_delete_btn' + seat_id ).attr("onclick","getSeatList()");//댓글 수정클릭시 모양바뀜
	}

	 
	function check_input2_onkeydown(){ //숫자만 입력
	      var theForm=document.frm1;
	      if( !( (event.keyCode >= 48 && event.keyCode<=57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode==8 )  ){
	           alert("숫자만 입력해 주세요 :p");
	           event.returnValue=false;
	      } 
	}

	function makeQr(seat_id){
		var encode = escape("seat_id=" + seat_id + "&store_id=" + session_store_id + "&choe=UTF-8"); // 주소뒤에 파라미터값을 넘기려면 encode된 상태로 넘겨야한다.
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/addQr/',
			type : 'post',
			data : {
				seat_id : seat_id,
				seat_qr : "https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=http://13.125.241.30/MS/user/qrLogin?" + encode
			},
			success : function(data){
				$.ajax({
					url : '${pageContext.request.contextPath}/admin/addQr/' + seat_id,
					type : 'get',
					success : function(data2){
						$('#seat_qr_btn' + seat_id ).remove();
						$('#seat_qr').show().html('<img src = "' + data2 + '" style = "width : 50px; padding : 0px;" id = "qrImage" onclick = "goQr(' + "'" + data2 + "'" + ')">');
					}
				});
			}
		});
	}
	
	function goQr(data2){
		$('#qrModal').show();
		$('#qrImg').html("<img src = '" +data2+ "'>");
	}
	$(window).on("click",function(){
		 if (event.target == $('#qrModal').get(0)) {
			 $('#qrModal').hide();
		 }
	});

</script>
</html>