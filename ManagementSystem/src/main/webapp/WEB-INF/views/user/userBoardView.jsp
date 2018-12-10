<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- 시간형식  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>MS</title>
<style>
.row {
	margin-top: 50px;
	color: #666;
}

.buttonsLeft {
	float: left;
	display: block;
}

.buttonsRight {
	float: right;
	display: block;
}

.comments {
	padding-top: 40px;
}

#write {
	float: right;
	margin: 20px;
}

/* 공지사항 게시판 제목 오버 */
.notice-title:hover {
	text-decoration: underline;
}

.hypertext_none {
	color: #181818;
	text-decoration: none;
	
}
.userBoardView_con *{
	font-size: 17px;
}
</style>
</head>
<body>	
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container" style="overflow: hidden; position: relative;">
		<br> <a class="nav-link, hypertext_none"
			href="${pageContext.request.contextPath}/user/userBoard?page=1&keyword=">
			<b style="font-size: 30px;">[${storeSelectSession.store_name}] -
				유저게시판</b>
		</a><br> <a id="write" class="btn btn-outline-elegant waves-effect"
			href="${pageContext.request.contextPath}/user/userBoard/write">글쓰기</a>
	</div>

	<!-- 게시글  -->
	<table class="container">
		<thead>
			<tr class="row">
				<th colspan="3" style="width: 600px; padding-left: 15px;">
					<h3 style="color: #1e1e1e; width: 80%; padding-bottom : 15px">
						<strong style="width: 100%;">${userboardvo.uboard_title}</strong>
					</h3>
				</th>
			</tr>
			<tr class="userBoardView_con">
				<th style="padding-left: 20px;">글번호 : ${userboardvo.uboard_id}</th>
				<th style="width: 60%; text-align: center;">작성자 :
					${userboardvo.writer_id}
					<c:if test='${storeSelectSession.admin_id == userboardvo.writer_id}'>
					   [관리자]
				 	</c:if></th>
				<th style="width: 100%; text-align: right; padding-right: 20px;">등록시간 : <fmt:formatDate
						value="${userboardvo.uboard_date}" pattern="yyyy-MM-dd HH:mm" /></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="3" class="col-sm-9" >
					<hr> ${userboardvo.uboard_con}
					<hr>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="container">
		<div class="buttonsLeft">
			<c:choose>
				<c:when test="${previousnum==-1}">
					<!-- <button type="button" class="btn btn-outline-elegant waves-effect">없음</button> -->
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-elegant waves-effect"
						onclick="location.href='${pageContext.request.contextPath}/user/userBoard/view/${previousnum}?page=${param.page}&keyword=${param.keyword}'">이전</button>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${nextnum==-1}">
					<!-- <button type="button" class="btn btn-outline-elegant waves-effect">없음</button> -->
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-elegant waves-effect"
						onclick="location.href='${pageContext.request.contextPath}/user/userBoard/view/${nextnum}?page=${param.page}&keyword=${param.keyword}'">다음</button>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="buttonsRight">
			<c:if test="${sessionScope.userSession.user_id == userboardvo.writer_id || sessionScope.adminSession != null}">
				<button type="button" class="btn btn-dark" data-toggle="modal"	data-target="#modalUserBoardDeleteForm">삭제</button>
				<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/user/userBoard/modify/${userboardvo.uboard_id}?page=${param.page}&keyword=${param.keyword}'">수정</button>
			</c:if>
			<button type="button" class="btn btn-dark"
				onclick="location.href='${pageContext.request.contextPath}/user/userBoard?page=${param.page}&keyword=${param.keyword}'">
				목록</button>
		</div>
		<!-- 게시글  -->
		<br>
		<!-- 댓글  -->
		<section class="comments my-5"> <!-- 코멘트 총개수 -->
		<div id="UserBoardCommentsNum" class="card-header font-weight-bold"></div>
		<div id="UserBoardReplyAllBody"></div>
		</section>

		<!-- 댓글 입력란 -->
		
			<div class="md-form mt-4">
				<label for="UserBoardReplyFormComment">댓글 입력</label>
				<textarea  class="form-control md-textarea"
					id="UserBoardReplyFormComment" rows="1" ></textarea>
				<div class="text-center my-4">
					<button id="UserBoardCommentSubmit"
						class="btn btn-default btn-sm btn-rounded">댓글 입력</button>
				</div>
			</div>
		
		<!-- 댓글 입력란 -->
		<!-- 댓글  -->
	</div>
</body>

<!-- 게시글 삭제확인 모달 -->
<div class="modal fade" id="modalUserBoardDeleteForm" tabindex="-1"	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header text-center">
				<h4 class="modal-title w-100 font-weight-bold">
					정말 <span style="color: red">삭제</span>하시나요?
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-footer d-flex justify-content-center">
				<a class="btn btn-danger"
					href="${pageContext.request.contextPath}/user/userBoard/delete/${userboardvo.uboard_id}">삭제</a>
				<a class="btn btn-dark" data-dismiss="modal">취소</a>
			</div>
		</div>
	</div>
</div>
<!-- 게시글 삭제확인 모달 끝 -->

<script type="text/javascript">
	$(document).ready(function() {
		getUserBoardReplyList();
	});

	var uboard_id = '${userboardvo.uboard_id}';
	var uboard_reply = '';

	function getUserBoardReplyList() {
		$.ajax({
			type : 'get',
			url : '${pageContext.request.contextPath}/user/userBoard/reply/all/'+ uboard_id,
			dataType : 'json',
			success : function(data) {
				$('#UserBoardCommentsNum').html(data.length + ' comments');
				$('#UserBoardReplyAllBody').html('');
				$(data).each(function(index, item) {
						uboard_reply += '<div class="media d-block d-md-flex mt-4">';
						// uboard_reply += '<img class="card-img-64 rounded-circle z-depth-1 d-flex mx-auto mb-3" src="https://post-phinf.pstatic.net/MjAxODAzMjJfMjY4/MDAxNTIxNzAxODU2MTQy.V91kaps6gaHaHS6JhzoHGT98PuoEv8kSz3zjgWT4kOAg.ffqd0efJQR_23lCWLTjDfjS3Hd-jfqEjSxNLCilQMScg.JPEG/%EC%88%98%EB%A7%8C%EA%B0%80%EC%A7%80%ED%91%9C%EC%A0%95%EC%9D%98%EB%A0%89%EC%8B%9C%EA%B3%A0%EC%96%91%EC%9D%B4_02.jpg?type=w1200">';
						uboard_reply += '<div class="media-body text-center text-md-left ml-md-3 ml-0">';
						uboard_reply += '<h5 class="font-weight-bold mt-0">';

						//수정삭제버튼
						if (  ("${sessionScope.adminSession}" != "") || ("${sessionScope.userSession.user_id}" == item.reply_writer_id)  ) {
														
							uboard_reply += '<button id="UserBoardReplyDeleteBtn' + item.uboard_reply_id + '" onclick="UserBoardReplyDelete('+ item.uboard_reply_id + ')" type="button" class="btn btn-danger px-3 float-right"><i class="fa fa-trash" aria-hidden="true"></i></button>';
							uboard_reply += '<button id="UserBoardReplyEditBtn'	+ item.uboard_reply_id + '" onclick="UserBoardReplyEdit(' + item.uboard_reply_id + ')" type="button" class="btn btn-primary px-3 float-right"><i class="fa fa-paint-brush" aria-hidden="true"></i></button>';
						}
						
						uboard_reply += '<a class="text-default">'	+ item.reply_writer_id;
						if("${storeSelectSession.admin_id}" == item.reply_writer_id){
							uboard_reply +='     [관리자]';
						}						
						
						uboard_reply += '</a></h5><input id="UserBoardReplyInput' + item.uboard_reply_id +'" class="form-control w-75" value="'+ item.uboard_reply_con +'" style="border: 0px; background: white;" readonly="true"></input><hr /></div></div>';
				$('#UserBoardReplyAllBody').html(uboard_reply);
										});
						uboard_reply = '';
			}
		});
	}
	
	
	$('#UserBoardCommentSubmit').click(function() {
		var uboard_reply_con = $('#UserBoardReplyFormComment').val(); //댓글내용을 가져옴
		var reply_writer_id = ""; //세션에서 writer_id를 가져옴
		
		if("${userSession}"){
			reply_writer_id = "${sessionScope.userSession.user_id}"; // 세션에서 writer_id를 가져옴
		} else {
			reply_writer_id = "${sessionScope.adminSession.admin_id}"; //세션에서 writer_id를 가져옴
		}
		
		//자동정렬 주의
		var store_id = "${storeSelectSession.store_id}"; //세션에서 store_id를 가져옴	
		//자동정렬 주의
		
		if(uboard_reply_con){
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/user/userBoard/reply',
				dataType : 'text',
				data : {
					uboard_id : uboard_id,
					reply_writer_id : reply_writer_id,
					uboard_reply_con : uboard_reply_con,
					store_id : store_id
				},
				success : function(data) {
					console.log(reply_writer_id);
					console.log('댓글작성완료');
					getUserBoardReplyList();
					$('#UserBoardReplyFormComment').val('');
				}
			});	
		} else {
			alert("댓글을 입력하세요 XD");
		}
	});
	
	function UserBoardReplyDelete(uboard_reply_id) {
		if(confirm("정말 삭제하시겠습니까??") == true){
		$.ajax({
			type : 'delete',
			url : '${pageContext.request.contextPath}/user/userBoard/reply/' + uboard_reply_id,
			success : function(data) {
				console.log('삭제확인');
				getUserBoardReplyList();
			}
		});
		}
	};
	

	function UserBoardReplyModify(uboard_reply_id) { //댓글 수정확인 누를시
		if(confirm("수정하시겠습니까??") == true){
			
			var uboard_reply_con = $('#UserBoardReplyInput' + uboard_reply_id).val();
			console.log(uboard_reply_con);
			
			$.ajax({
				type : 'put',
				url : '${pageContext.request.contextPath}/user/userBoard/reply/' + uboard_reply_id,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "put"
				},
			
				data : JSON.stringify({
					uboard_reply_con : uboard_reply_con
				}),
			
				success : function(data) {
					console.log('수정확인');
					getUserBoardReplyList();
				}
			});
		}
	};

	function UserBoardReplyEdit(urid) { //댓글수정 클릭시
		$('#UserBoardReplyInput' + urid).attr("readonly", false);
		$('#UserBoardReplyInput' + urid).focus();
		$('#UserBoardReplyEditBtn' + urid).find('i').attr("class", "fa fa-check"); //댓글 수정클릭시 모양바뀜
		$('#UserBoardReplyEditBtn' + urid).attr("onclick", "UserBoardReplyModify(" + urid + ")");
	};
	
</script>

</html>