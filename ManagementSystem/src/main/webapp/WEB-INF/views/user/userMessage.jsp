<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.container{
}
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
.messageUl:hover{
	-webkit-transform:scale(1.1); 
	transition: all 0.3s ease-in-out;
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
.deleteMessage:hover, .messageReply:hover, .messageDetail:hover {
	cursor : pointer;
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
#message_con{
	height : 
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
				<div id = "messageList"></div>
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
				<form class="comment-form" id = "sendMessageForm">
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="name">보내는 사람</label> <input type="text"
								class="form-control" name="send_id"
								value = "${userSession.user_id}" id = "send_id" style = "background-color : darkgrey;" readonly/>
						</div>
						<div class="col-md-12 form-group">
							<label class="name">받는 사람</label>
							<input type = "text" name = "receive_id" id = "receive_id" class = "form-control" style = "background-color : darkgrey;" value = "${storeSelectSession.store_name}" readonly >
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
$(document).ready(function(){
	$('#messageModal').hide(); //페이지 시작시 메세지 모달창 가림
	$('#writeMessageModal').hide();
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
/////////////// 안읽은메시지 알림 //////////////
function alarm(){
	$.ajax({
		url : '${pageContext.request.contextPath}' + '/user/messageCnt',
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
//var user_id = ${userSession.user_id};
var store_id = ${storeSelectSession.store_id};
var store_name = "${storeSelectSession.store_name}";
///////////// 메시지리스트 //////////////
function getMessageList(){
	$.ajax({
		url : '${pageContext.request.contextPath}' + '/user/message/',
		type : 'get',
		success : function(data){
			if(data.length > 0){
				//console.log(data[1].message_con);
				$('#messageList').html("");
				for(var i = 0; i < data.length; i++){
					str = '<div id="messageUlWrap" class = "messageUlWrap">';
					if(data[i].message_read != "Y"){
						str += '<ul id="' + data[i].message_id + '" class = "messageUl" style = "background-color : #eee;">';
					} else {
						str += '<ul id="' + data[i].message_id + '" class = "messageUl" style = "background-color : darkgrey;">';
						str += '<img src = ${pageContext.request.contextPath}/images/delete2.png onclick = "deleteMessage(' + data[i].message_id + ')" style = "width : 17px; height : 20px;"class = "deleteMessage" id = "' + data[i].message_id + '">'
					}
					str += '	<li id = "li_send_id" class = "li_send_id">보내는 사람 : ' + data[i].send_id + '</li>';
					str += '<li>시간 : ' + data[i].message_date + '</li>';
					if(data[i].message_read != "Y"){
						str += '	<li><textarea readonly cols="25" id = "li_message_con">' + data[i].message_con + '</textarea></li>';
					} else {
						str += '	<li><textarea readonly style = "background-color : #eee;" cols="25" id = "li_message_con">' + data[i].message_con + '</textarea></li>';
					}
					str += '	<input type = "button" onclick = "replyMessage(' + data[i].message_id + ')" id = "messageReply" class = "messageReply" value = "답장">';
					str += '</ul></div>';
					$('#messageList').append(str);
				} str = '';
			} else{
				$('#messageList').html("<p style = 'color : red; margin-bottom : 20px; font-size : 30px;'>※ 도착한 메시지가 없습니다.</p>");
			}
		}
	});
}
/////////// 보내기메서드 /////////////
function sendMessage(){
	if($('#message_con').val() == ""){
		alert("메시지 내용을 입력하세요");
	} else {
		$.ajax({
			url : '${pageContext.request.contextPath}' + '/member/writeMessage/',
			data : {
				store_id : store_id,
				send_id : $('#send_id').val(),
				receive_id : $('#receive_id').val(),
				message_con : $('#message_con').val()
			},
			success : function(data){
				alert("메시지를 보냈습니다.");
				$('#writeMessageModal').hide();
				$('#replyBtn').css("display","none");
				$('#message_con').val("");
			}
		});
	}
}
//////////// 삭제버튼메서드 //////////
function deleteMessage(message_id){
	$.ajax({
		url : '${pageContext.request.contextPath}' + '/member/deleteMessage/' + message_id ,
		success : function(data){
			alert("삭제에 성공하셨습니다");
			getMessageList();
		}
	});
}
///////////// 답장버튼 메서드 ///////////
function replyMessage(message_id){
	$('#writeMessageModal').show();
	$('#replyBtn').show();
	$('#sendBtn').hide();
}
///////// 답장보내기버튼 클릭 ///////
	$('#replyBtn').click(function(){
		sendMessage();
	});
///////// 쪽지함 버튼 클릭시 ///////////
$('#messageBtn').click(function(){
	$('#messageModal').show();
	getMessageList();
});
//////////// 쪽지쓰기 클릭시 ////////////
$('#writeMessage').click(function(){
	$('#writeMessageModal').show();
	$('#sendBtn').show();
});
/////////// 쪽지보내기버튼 클릭///////////
	$('#sendBtn').click(function(){
		sendMessage();
	});
	
/////////////// x 버튼 클릭하면 창 닫음 //////////////
$('#messageWriteClose').click(function(){
	$('#writeMessageModal').hide();
});

//////////// 메시지를 읽은것 처리 /////////////////
$(document).on("click",".messageUl",function(){ // 동적으로 생성된 태그들은 이런식으로 이벤트를 줘야함
	//var str = "onclick = "readChk(' + data[i].message_id + ')"";
	$(this).css("background-color","darkgrey");
	var message_id = $(this).attr("id");
	var read_message = "Y";
	$.ajax({
		url : '${pageContext.request.contextPath}' + '/member/readMessage',
		type : 'post',
		data : {
			message_id : message_id,
			message_read : read_message
		},
		success : function(data){
			getMessageList();
		}
	});
});

 //모달창 밖의 영역을 누르면 띄워져 있는 모달창을 닫음
$(window).on('click', function() {
   //jquery는 dom 객체를 jquery 객체로 한 번 감싸 리턴하므로 dom 객체를 얻어와야 비교 가능
   if (event.target == $('#messageModal').get(0)) {
	   location.reload();
   } else if (event.target == $('#writeMessageModal').get(0)){
	   $('#message_con').val("");
	   $('#replyBtn').css("display","none");
	   $('#writeMessageModal').hide();
   }
});
 
	
</script>
</html>