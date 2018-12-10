<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><!-- 시간형식  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
		<br> <a class="nav-link, hypertext_none" href="${pageContext.request.contextPath}/admin/CEOBoard?page=1&keyword=">
			<b style="font-size: 30px;">CEO게시판</b></a><br><br>
			<a id="write" class="btn btn-outline-elegant waves-effect" href="${pageContext.request.contextPath}/admin/CEOBoardWrite">글쓰기</a>
	</div>

	<!-- 게시글  -->
	<table class="container">
		<thead>
			<tr class="row">
				<th colspan="3" style="width: 600px; padding-left: 15px;">
					<h3 style="color: #1e1e1e; width: 80%; padding-bottom : 15px">
						<strong style="width: 100%;">${CEOBoard_view.cboard_title}</strong>
					</h3>
				</th>
			</tr>
			<tr class="userBoardView_con">
				<th style="padding-left: 20px;">글번호 : ${CEOBoard_view.cboard_id}</th>
				<th style="width: 60%; text-align: center;">작성자 : ${CEOBoard_view.writer_cid }</th>
				<th style="width: 100%; text-align: right; padding-right: 20px;">등록시간 : <fmt:formatDate
						value="${CEOBoard_view.cboard_date}" pattern="yyyy-MM-dd HH:mm" /></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="3" class="col-sm-9" >
					<hr> ${CEOBoard_view.cboard_con}
					<hr>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="container">
		<div class="buttonsLeft">
			<c:choose>
				<c:when test="${preNum == -1}">
					<!-- <button type="button" class="btn btn-outline-elegant waves-effect">없음</button> -->
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-elegant waves-effect"
						onclick="location.href='${pageContext.request.contextPath}/admin/CEOBoardView/view/${preNum}?page=${param.page}&keyword=${param.keyword}'">이전</button>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${nextNum == -1}">
					<!-- <button type="button" class="btn btn-outline-elegant waves-effect">없음</button> -->
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-elegant waves-effect"
						onclick="location.href='${pageContext.request.contextPath}/admin/CEOBoardView/view/${nextNum}?page=${param.page}&keyword=${param.keyword}'">다음</button>
				</c:otherwise>
			</c:choose>
		</div>
	<div class="buttonsRight">
			<c:if test="${sessionScope.adminSession.admin_id == CEOBoard_view.writer_cid}">
				<button type="button" class="btn btn-dark" data-toggle="modal"	data-target="#CEOBoardDelete">삭제</button>
				<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/admin/CEOBoard/modify/${CEOBoard_view.cboard_id}?page=${param.page }&keyword=${param.keyword }'">수정</button>
			</c:if>
			<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/admin/CEOBoard?page=${param.page }&keyword=${param.keyword }'">목록</button>
	</div>
	<!-- 게시글  -->
		<br>
		<!-- 댓글  -->
		<section class="comments my-5"> <!-- 코멘트 총개수 -->
		<div id="CEOBoardCommentsNum" class="card-header font-weight-bold"></div>
		<div id="CEOBoardReplyAllBody"></div>
		</section>

		<!-- 댓글 입력란 -->
		
			<div class="md-form mt-4">
				<label for="CEOBoardReplyFormComment">댓글 입력</label>
				<textarea  class="form-control md-textarea"	id="CEOBoardReplyFormComment" rows="1" ></textarea>
				<div class="text-center my-4">
					<button class="btn btn-default btn-sm btn-rounded" id="CEOBoardCommentSubmit">댓글 입력</button>
				</div>
			</div>
		
		<!-- 댓글 입력란 -->
		<!-- 댓글  -->
</div>

<!-- 게시글 삭제확인 모달 -->
<div class="modal fade" id="CEOBoardDelete" tabindex="-1"	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header text-center">
				<h4 class="modal-title w-100 font-weight-bold">
					정말 <span style="color: red">삭제</span>하시나요?
				</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-footer d-flex justify-content-center">
				<a class="btn btn-danger" href="${pageContext.request.contextPath}/admin/CEOBoardView/delete/${CEOBoard_view.cboard_id}">삭제</a>
				<a class="btn btn-dark" data-dismiss="modal">취소</a>
			</div>
		</div>
	</div>
</div>
<!-- 게시글 삭제확인 모달 끝 -->
</body>
<script>
	$(document).ready(function(){
		getCEOBoardReplyList();
	});

	var cboard_id = '${CEOBoard_view.cboard_id}'; // 게시글 번호
	var cboard_reply = '';
	
	// 댓글 리스트 뽑기
	function getCEOBoardReplyList(){
		$.ajax({
			type : 'get',
			url : '${pageContext.request.contextPath}/admin/CEOBoard/reply/all/'+ cboard_id,
			success :function(data){
				$('#CEOBoardCommentsNum').text(data.length + ' comments');
				$('#CEOBoardReplyAllBody').text('');
				$(data).each(function(index, item) {
					cboard_reply += '<div class="media d-block d-md-flex mt-4">';
					cboard_reply += '<div class="media-body text-center text-md-left ml-md-3 ml-0">';
					cboard_reply += '<h5 class="font-weight-bold mt-0">';

					//수정삭제버튼
					if (  ("${sessionScope.adminSession}" != "") && ("${sessionScope.adminSession.admin_id}" == item.cboard_reply_writer)  ) {
													
						cboard_reply += '<button id="CEOBoardReplyDeleteBtn' + item.cboard_reply_id + '" onclick="CEOBoardReplyDelete('+ item.cboard_reply_id + ')" type="button" class="btn btn-danger px-3 float-right"><i class="fa fa-trash" aria-hidden="true"></i></button>';
						cboard_reply += '<button id="CEOBoardReplyEditBtn'	+ item.cboard_reply_id + '" onclick="CEOBoardReplyEdit(' + item.cboard_reply_id + ')" type="button" class="btn btn-primary px-3 float-right"><i class="fa fa-paint-brush" aria-hidden="true"></i></button>';
					}
					
					cboard_reply += '<a class="text-default">' + item.cboard_reply_writer;
					cboard_reply += '</a></h5><input id="CEOBoardReplyInput' + item.cboard_reply_id +'" class="form-control w-75" value="'+ item.cboard_reply_con +'" style="border: 0px; background: white;" readonly="true"></input><hr/></div></div>';
					
					// jquery for문 돌린 결과를 id='CEOBoardReplyAllBody'에 담아줌
					$('#CEOBoardReplyAllBody').html(cboard_reply);
									});
					// 그리고 다시 초기화시키고 시작!
					cboard_reply = '';
			}
		});
	}

	// 댓글 작성
	$('#CEOBoardCommentSubmit').click(function(){
		
		var cboard_reply_con = $('#CEOBoardReplyFormComment').val(); // 댓글 내용 가져옴
		var reply_writer_id = "${sessionScope.adminSession.admin_id}"; // 세션에서 writer_id를 가져옴
		
		if(cboard_reply_con){
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/admin/CEOBoard/reply',
				data : {
					cboard_id : cboard_id,
					cboard_reply_writer : reply_writer_id,
					cboard_reply_con : cboard_reply_con,
				},
				success : function(data){
					console.log(data);
					getCEOBoardReplyList();
					$('#CEOBoardReplyFormComment').val('');
				}
			});
		} else {
			alert("댓글을 입력하세요 :)");
		}
		
	});
	
	function CEOBoardReplyDelete(cboard_reply_id) {
		if(confirm("정말 삭제하시겠습니까??") == true){
			$.ajax({
				type : 'delete',
				url : '${pageContext.request.contextPath}/admin/CEOBoard/reply/' + cboard_reply_id,
				success : function(data) {
					console.log('삭제확인');
					getCEOBoardReplyList();
				}
			});
		}
	}
	
	function CEOBoardReplyModify(cboard_reply_id){
		if(confirm("수정하시겠습니까?") == true){
			var cboard_reply_con = $('#CEOBoardReplyInput' + cboard_reply_id).val();
			console.log(cboard_reply_con);
			
			$.ajax({
				type : 'put',
				url : '${pageContext.request.contextPath}/admin/CEOBoard/reply/' + cboard_reply_id,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "put"
				},
				data : JSON.stringify({
					cboard_reply_con : cboard_reply_con
				}),
				
				success : function(data){
					console.log('수정확인');
					getCEOBoardReplyList();
				}
				
			});
		}
	}
	
	function CEOBoardReplyEdit(cboard_reply_id){ // 댓글 수정 버튼 클릭시
		$('#CEOBoardReplyInput' + cboard_reply_id).attr("readonly", false);
		$('#CEOBoardReplyInput' + cboard_reply_id).focus();
		$('#CEOBoardReplyEditBtn' + cboard_reply_id).find('i').attr("class", "fa fa-check"); //댓글 수정클릭시 모양바뀜
		$('#CEOBoardReplyEditBtn' + cboard_reply_id).attr("onclick", "CEOBoardReplyModify(" + cboard_reply_id + ")");
	}
	

	</script>
	
</html>