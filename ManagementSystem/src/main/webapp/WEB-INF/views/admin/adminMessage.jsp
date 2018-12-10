<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.messageModal, .writeMessageModal{
	position : fixed;
	width : 100%;
	height : 100%;
	left : 0px;
    top : 0px;
    z-index : 1;
    background-color : rgba(0, 0, 0, 0.4);
    display : none;
}
.messageWrap, .messageWriteWrap{
	position : absolute;
	top : 5%;
	left : 50%;
	width : 700px;
	background-color : white;
	text-align : center;
	border-radius: 10px;
	margin-left : -350px;
	height : 83%;
	overflow : overlay;
}
.messageListTitle{
	margin-top : 30px;
	font-weight : bold;
}
#writeMessage{
	position : absolute;
	right : 20px;
	top : 30px;
	border : none;
	font-weight : bold;
	font-size : 15px;
}
.post {
	padding: 0 1.5%;
	height : 80%;
}
.comment-form .form-control {
	border: 0px;
	background: #eee;
	min-height: 40px;
}
.comment-form>.row {
	margin: 0 -1.5%;
}
.comment-form [class*="col-"] {
	padding: 0 1.5%
}
.form-group {
	margin-bottom: 35px !important;
}
.messageTitle {
	margin-top: 10%;
	font-size : 35px;
	font-weight : bold;
	position : relative;
}
hr{
	margin-bottom : 40px !important;
}
#userId {
	background-color : darkgray;
	font-weight : bold;
	font-size : 20px;
}
@media ( min-width :992px) {
	.post {
		width: 50%;
		max-width: 500px;
		margin: 0 auto;
		background-color : white;
		border-radius : 10px;
		height : 80%;
	}
	.comment-form label {
		position: absolute;
		width: 200px;
	}
	.comment-form .name, .comment-form .email, .comment-form .message {
		top: -27px;
		font-weight: bold;
	}
}
@media ( min-width :1200px) {
	.post {
		max-width: 525px;
		height : 80%;
	}
}
#submit {
	font-size : 15px;
}
.messageTitle p {
	text-align : center;
	padding-top : 20px;
}
.receiveWrap{
	width : 100%;
}
.messageUl{
	padding: 15px 10px;
	text-align: center;
	width: 250px;
	height: 250px;
	border-right : 3px solid #8e8e8e;
	border-bottom : 3px solid #8e8e8e;
	margin-left: 65px;
	list-style: none;
	margin-bottom: 30px;
	border-radius: 10px;
	position : relative;
}
.messageUlWrap{
	float: left;
}
.messageUl textarea {
	padding: 10px;
	margin-top: 10px;
	margin-bottom: 4px;
	height: 120px;
	border-radius: 5px;
}
.messageReply, .messageDetail{
	margin: 0px 6px;
	font-size: 15px;
	color: white;
	background-color:#3f51b5;
	text-decoration: none;
	padding: 6px;
	border-radius: 5px;
	width : 70px;
	border : none;
}
.deleteMessage{
	position : absolute;
	right : 10px;
	top : 10px;
}
.deleteMessage:hover, .messageReply:hover {
	cursor : pointer;
}
.storeList{
	position : absolute;
	left : 25px;
	top : 100px;
	height : 35px;
}
.messageUl:hover{
	-webkit-transform:scale(1.1); 
	transition: all 0.3s ease-in-out;
}
.messageWriteClose{
   position : absolute;
   top : 0px;
   right : 5px;
   font-size : 30px;
}
.messageWriteClose:hover{
   color : grey;
   cursor : pointer;
}
.readCnt{
	position : absolute;
	background-color : red;
	margin-left : 30px;
	font-size : 15px;
	padding : 1px 7px;
	color : white;
	display : none;
	border-radius : 10em;
	z-index : 1;
	right : -5px;
	top : -8px;
}
.messageBtn{
	background-image : url("${pageContext.request.contextPath}/images/message1.png");
	background-size : 100%;
	float : right;
	width : 70px;
	height : 55px;
	border-radius: 10px;
}
.messageIconWrap:hover{
	cursor : pointer;
	-webkit-transform:scale(1.3); 
	transition: all 0.3s ease-in-out;
}
.messageBtn:hover{
	background-image : url('${pageContext.request.contextPath}/images/openMessage.png');
}
</style>
</head>
<body>
<span class = "messageIconWrap" style = "position : absolute; top : 90%; left : 3%">
	<span id = "messageBtn" class = "messageBtn"></span>
	<span id = "readCnt" class = "readCnt"></span>
</span>
<!-- ///////////메시지 모달창/////////// -->
		<div class = "messageModal" id = "messageModal">
			<div class="messageWrap">
				<h1 class="messageListTitle">메시지 리스트</h1>
				<div id = "adminStoreList" class = "adminStoreList"></div>
				<input type = "button" class = "btn btn-outline-elegant waves-effect" id = "writeMessage" value = "쪽지쓰기">
				<hr>
				<div id = "messageList">
				<p id = "messageText"style = "color : red; margin-bottom : 20px; font-size : 30px;">※ 매장을 먼저 선택하세요.</p></div>
			</div>
		</div>
<!--///////////////// 쪽지쓰기 모달창/////////////////// -->
	<div class = "writeMessageModal" id = "writeMessageModal">
		<div class="post">
			<div class="contact">
				<div class="messageTitle">
					<p>메시지 남기기</p>
					<span class = "messageWriteClose" id = "messageWriteClose">x</span>
				</div>
				<hr>
				<form class="comment-form">
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="name">보내는 사람</label> <input type="text"
								class="form-control" name="send_id"
								value = "${storeSelectSession.store_name}" id = "send_id" style = "background-color : darkgrey;" readonly/>
						</div>
						<div class="col-md-12 form-group">
							<label class="name">받는 사람</label>
							<div id = "sendWrap" style = "width : 100%; float : left;"></div>
							<div class = "receiveWrap">
							<input type = "text" id = "receiveReply" class = "form-control" style = "display : none; background-color : darkgrey;" readonly >
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 form-group">
							<label class="message">메시지 내용</label>
							<textarea class="form-control" cols="47" rows="7"
								placeholder="Message" name="message_con" id = "message_con" required></textarea>
						</div>
						<div class="col-md-12 form-group">
							<input type="button" class="btn btn-block btn-lg btn-success"
								value="메시지 남기기" id = "sendBtn">
							<input type="button" class="btn btn-block btn-lg btn-success"
								value="메시지 남기기" id = "replyBtn" style = "display : none">	
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script>
	var send_id = "";
	var adminStore_id = ${storeSelectSession.store_id};
	$(document).ready(function(){
		$('#messageModal').hide(); //페이지 시작시 메세지 모달창 가림
		$('#writeMessageModal').hide(); // 페이지 시작시 쪽지쓰기 모달창 가림
		setInterval(function () { 
			alarm();
		}, 1000);
	});
	/* 스크롤따라 움직이는 Div */
	var currentPosition = parseInt($('.messageIconWrap').css('top'));

	$(window).scroll(function() {
		var position = $(window).scrollTop();
		$('.messageIconWrap').stop().animate({
			'top' : position + currentPosition + 'px'
		}, 1000);
	});
	///////////////// 안읽은 메시지 알림/////////////////
	function alarm(){
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/admin/messageCnt',
			success : function(data){
				console.log(data);
				var readCnt = data;
				if(readCnt > 0){
					$('#readCnt').css("display", "block");
					$('#readCnt').text(readCnt);
				} else {
					$('#readCnt').css("display", "none");
				}
			}
		});
	}
	
	///////////// 쪽지함 클릭 /////////////
	$('#messageBtn').click(function(){
		var storeList = "";
		$('#messageModal').show(); //쪽지함을 클릭하면 모달창 뜸
		$.ajax({ //사용자가 갖고있는 매장목록 select
			url : '${pageContext.request.contextPath}' + '/admin/storeList',
			type : 'get',
			success : function(data){
				storeList = '<select id = "storeList" class = "storeList"><option>매장을 선택하세요</option>';
				for(var j = 0; j < data.length; j++){
					storeList += '<option>' + data[j].store_name + '</option>';
				} //리스트 반복문 끝
				storeList += '</select>';
				$('#adminStoreList').html(storeList);
			}
		});
		storeList = "";
	});
	////////////////// 메시지리스트 불러오는 메서드 //////////////
	function getMessageList(){
		var isUser = "";
		var str = '';
		var selectedStore = $('#adminStoreList option:selected').val(); // 선택된 스토어 이름
			$.ajax({
			url : '${pageContext.request.contextPath}' + '/admin/message',
			type : 'post',
			data : {
				receive_id : $('#send_id').val(),
				store_name : selectedStore
			},
			success : function(data){
				if(selectedStore == "매장을 선택하세요"){
					$('#messageList').html("<p style = 'color : red; margin-bottom : 20px; font-size : 30px;'>※ 매장을 먼저 선택하세요.</p>");
				} else {
					if(data.length > 0){
					//console.log(data[1].message_con);
					$('#messageList').html("");
						for(var i = 0; i < data.length; i++){
							str = '<div id="messageUlWrap" class = "messageUlWrap">';
							if(data[i].message_read != "Y"){
								str += '<ul id="' + data[i].message_id + '" class = "messageUl" style = "background-color : #eee;">';
							} else {
								str += '<ul id="' + data[i].message_id + '" class = "messageUl" style = "background-color : darkgrey;">';
								str += '<img src = "${pageContext.request.contextPath}/images/delete2.png" onclick = "deleteMessage(' + data[i].message_id + ')"style = "width : 17px; height : 20px;"class = "deleteMessage" id = "' + data[i].message_id + '">'
							}
							str += '	<li id = "li_send_id" class = "li_send_id">보내는 사람 : ' + data[i].send_id + '</li>';
							str += '<li>시간 : ' + data[i].message_date + '</li>';
							if(data[i].message_read != "Y"){
								str += '	<li><textarea readonly cols="25" id = "li_message_con">' + data[i].message_con + '</textarea></li>';
							} else {
								str += '	<li><textarea readonly style = "background-color : #eee;" cols="25" id = "li_message_con">' + data[i].message_con + '</textarea></li>';
							}
							str += '	<input type = "button" onclick = "messageReply(' + data[i].message_id + ')" class = "messageReply" value = "답장">';
							str += '<div id = "messageRead" style = "display : none;">' + data[i].message_read + '</div>';
							str += '</ul></div>';
							$('#messageList').append(str);
						} str = '';
					} else{
						$('#messageList').html("<p style = 'color : red; margin-bottom : 20px; font-size : 30px;'>※ 도착한 메시지가 없습니다.</p>");
					}
				}
			}
		});
	}
	////////////// 매장목록이 바뀔때 메시지 리스트를 가져옴 ///////////
	$('#adminStoreList').change(function(){
		//console.log(selectedStore);
		//console.log($('#send_id').val());
		getMessageList();
	});
	/////////////쪽지 삭제 이벤트/////////////
	function deleteMessage(message_id){
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/member/deleteMessage/' + message_id,
			success : function(data){
				alert("메시지 삭제 성공");
				getMessageList();
			}
		});//삭제 ajax 끝
	}
	 /////////////쪽지 답장 이벤트//////////////
	function messageReply(message_id){
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/member/messageDetail/' + message_id,
			type : 'get',
			success : function(data){
				console.log(data);
				$('#sendList').remove();
				$('#writeMessageModal').show();
				$('#send_id').val(data.receive_id);
				$('#sendWrap').css("display","none");
				$('#receiveReply').css("display","block");
				$('#receiveReply').val(data.send_id);
				$('#replyBtn').show();
				$('#sendBtn').hide();
			}
		});
	}

	///////////// 쪽지쓰기버튼 이벤트///////////////
	var userList = [];
	var list = "";
	$('#writeMessage').click(function(){
		$('#writeMessageModal').show(); //쪽지쓰기를 클릭하면 모달창 뜸
		$('#sendWrap').css("display","block");
		$('#sendBtn').show();
		$('#receiveReply').hide();
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/member/sendList',
			type : 'get',
			success : function(data){
				list = "<select class = 'sendList' id = 'sendList' style = 'width : 100%; height : 40px; padding : 3px;'><option>사용자를 선택하세요</option>";
				list += "<option>전체보내기</option>";
				for(var i = 0; i < data.length; i++){
					userList.push(data[i].user_id);
					list += "<option name = 'send_id'>" + data[i].user_id + "</option>";
				}
				list += "</select>";
				$('#sendWrap').html(list);
			} 
		});
		list = "";
	});
	///////////// 사용자 매장 선택 /////////////////
	/* $(document).on("change", "#sendList", function(){ //받는사람 리스트 변경 이벤트
		send_id = $('#sendList option:selected').val(); //선택된 아이디값을 가져옴
		//console.log(adminStore_id); 관리자의 스토어 번호
		//console.log(userList); 사용자 목록
		var store_name = "<select class = 'store_name' id = 'store_name' style = 'width : 100%; height : 40px; padding : 3px;'><option>사용자의 매장을 선택하세요</option>";
			$.ajax({
				url : '${pageContext.request.contextPath}' + '/member/sendStore/' + send_id,
				success : function(data2){
					//console.log(data);
					for(var j = 0; j < data2.length; j++){
						store_name += "<option id = '" + data2[j].store_id + "'>" + data2[j].store_name + "</option>";
					}
				store_name += "</select>";
				$('#selectStore').html(store_name);
				} //매장이름 가져오기 성공 끝
			}); // 보내는아이디에 해당하는 매장번호 구하는 ajax 끝
		}); */
	///////////////// 쪽지 보내기버튼 이벤트////////////////
	var sendOk = "";
	$('#sendBtn').click(function(){
		var store_id = adminStore_id;
		var receive_id = $('#sendList option:selected').val();
		if (receive_id == "전체보내기"){
			for(var i = 0; i < userList.length; i++){
				receive_id = userList[i];
				sendMessage(store_id, receive_id, sendOk); // 전체보내기일 경우 useList만큼 쪽지보내기 반복
			}
		} else {
			sendMessage(store_id, receive_id, sendOk); // 전체보내기가 아닐경우 해당아이디에 한번만 보냄
		}
		if(sendOk == "true"){
			alert("메시지를 보냈습니다");
		}
	});
	
	/////////////////  답장보내기버튼 이벤트//////////////////
	$('#replyBtn').click(function(){
		var receive_id = $('#receiveReply').val();
		var store_id = adminStore_id;
		sendMessage(store_id,receive_id, sendOk);
		if(sendOk == "true"){
			alert("답장을 보냈습니다");
		}
	}); //메시지 보내기 이벤트 끝
	
	////////////// 메시지 보내기 함수 ///////////////
	function sendMessage(store_id,receive_id,sendOk){
		if($('#message_con').val() == ""){
			alert("메시지 내용을 입력하세요.");
		} else if($('#sendList option:selected').val() == "사용자를 선택하세요"){
			alert("올바른 사용자를 선택하세요.");
		} else {
			$.ajax({
				url : '${pageContext.request.contextPath}' + '/member/writeMessage',
				data : { //보내는사람, 받는사람, 받는사람의 매장아이디, 제목, 내용
					store_id : store_id,
					send_id : $('#send_id').val(),
					receive_id : receive_id,
					message_con : $('#message_con').val()
				},
				success : function(data){
					$('#replyBtn').css("display","none");
					$('#writeMessageModal').hide(); //쪽지쓰기 모달창 끔
					$('#messageModal').show(); // 리스트 모달창 뜸
					$('#message_con').val("");
					sendOk = true;
				},// 성공 끝
				error : function(){
					sendOk = false;
				}
			}); // ajax 끝
		}
	}
	// 메시지 읽은 표시
	$(document).on("click",".messageUl",function(){ // 동적으로 생성된 태그들은 이런식으로 이벤트를 줘야함
		//var str = "onclick = "readChk(' + data[i].message_id + ')"";
		$(this).css("background-color","darkgrey").css("color","white");
		var message_id = $(this).attr("id");
		var read_message = "Y";
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/member/readMessage',
			type : 'post',
			data : {
				message_id : message_id,
				message_read : read_message,
			},
			success : function(data){
				getMessageList();
			}
		});
	});
	 $('#messageWriteClose').click(function(){
         $('#writeMessageModal').hide();
      });
	///////////////모달창 밖의 영역을 누르면 띄워져 있는 모달창을 닫음
    $(window).on('click', function() {
      //jquery는 dom 객체를 jquery 객체로 한 번 감싸 리턴하므로 dom 객체를 얻어와야 비교 가능
       if (event.target == $('#messageModal').get(0)) {
    	   location.reload();
       } else if (event.target == $('#writeMessageModal').get(0)){
    	   getMessageList();
    	   $('#message_con').val("");
    	   $('#replyBtn').css("display","none");
    	   $('#writeMessageModal').hide();
       } 
    });
		
</script>
</html>