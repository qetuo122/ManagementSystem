<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>MS</title>
<meta charset="utf-8">
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
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<h4 style="color: #1e1e1e;">
					<strong>${view.notice_title}</strong>
				</h4>
				<!-- 날짜 시간 모두 나오는것을 날짜만 나오게 표시 -->
				<fmt:parseDate value="${view.notice_date}" pattern="yyyy-MM-dd HH:mm" var="date" />
				<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />
			</div>
			<div class="col-sm-9" style="height: 400px">
				<p></p>
				${view.notice_con}
			</div>
		</div>
		<hr />
		<div class="buttonsLeft">
			<button type="button" class="btn btn-outline-elegant waves-effect"
				onclick="location.href='${pageContext.request.contextPath}/member/notice/${view.notice_id-1}'">이전</button>
			<button type="button" class="btn btn-outline-elegant waves-effect"
				onclick="location.href='${pageContext.request.contextPath}/member/notice/${view.notice_id+1}'">다음</button>
		</div>
		<div class="buttonsRight">
			<c:if test="${view.admin_id eq adminSession.admin_id}">
			<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalNoticeDeleteForm">삭제</button>
			<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/admin/notice/modify/${view.notice_id}'">수정</button>
			</c:if>
			<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/member/notice?page=1'">
				<i class="fa fa-th-list pr-2" aria-hidden="true"></i>목록</button>
		</div>

		<!-- 공지사항 댓글은 admin만 보기,입력가능 -->
		<c:if test="${!empty adminSession}">
		<section class="comments my-5">
			<!-- 코멘트 총개수 -->
			<div id="commentsNum" class="card-header font-weight-bold"></div>
			<div id="replyAllBody"></div>
		</section>

		<!-- 댓글 입력란 -->
		<div class="md-form mt-4">
			<label for="replyFormComment">댓글 입력</label>
			<textarea class="form-control md-textarea" id="replyFormComment" rows="1"></textarea>
			<div class="text-center my-4">
				<button id="commentSubmit" class="btn btn-default btn-sm btn-rounded">댓글 입력</button>				
				<input id="admin_id" type="hidden" value="${adminSession.admin_id}" />
			</div>
		</div>
		</c:if>
	</div>
</body>

<!-- 게시글 삭제확인 모달 -->
<div class="modal fade" id="modalNoticeDeleteForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
				<a class="btn btn-danger" href="${pageContext.request.contextPath}/admin/notice/delete/${view.notice_id}">삭제</a>
				<a class="btn btn-dark" data-dismiss="modal">취소</a>
			</div>
		</div>
	</div>
</div>
<!-- 게시글 삭제확인 모달 끝 -->

<!-- 댓글 삭제확인 모달 -->
<div class="modal fade right" id="modalReplyDeleteForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-side modal-bottom-right modal-dialog-centered" role="document">
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
				<a class="btn btn-danger" href="${pageContext.request.contextPath}/admin/notice/delete/${view.notice_id}">삭제</a>
				<a class="btn btn-dark" data-dismiss="modal">취소</a>
			</div>
		</div>
	</div>
</div>
<!-- 댓글 삭제확인 모달 끝-->

<script>
	$(document).ready(function() {
		getAllList();
	});
	
	var notice_id = '${view.notice_id}';
	var reply = '';

	function getAllList() {
		$.ajax({
				type : 'get',
				url : '${pageContext.request.contextPath}/reply/all/' + notice_id,
				dataType : 'json',
				success : function(data) {
					$('#commentsNum').html(data.length + ' comments');
					$('#replyAllBody').html('');
				$(data).each(function(index, item) {
					$('#commentsNum').html(data.length + ' comments');
						reply += '<div class="media d-block d-md-flex mt-4">';
						reply += '<img class="card-img-64 rounded-circle z-depth-1 d-flex mx-auto mb-3" src="https://post-phinf.pstatic.net/MjAxODAzMjJfMjY4/MDAxNTIxNzAxODU2MTQy.V91kaps6gaHaHS6JhzoHGT98PuoEv8kSz3zjgWT4kOAg.ffqd0efJQR_23lCWLTjDfjS3Hd-jfqEjSxNLCilQMScg.JPEG/%EC%88%98%EB%A7%8C%EA%B0%80%EC%A7%80%ED%91%9C%EC%A0%95%EC%9D%98%EB%A0%89%EC%8B%9C%EA%B3%A0%EC%96%91%EC%9D%B4_02.jpg?type=w1200">';
						reply += '<div class="media-body text-center text-md-left ml-md-3 ml-0">';
						reply += '<h5 class="font-weight-bold mt-0">';
						reply += '<button id="replyDeleteBtn' + item.reply_id + '" onclick="replyDelete(' + item.reply_id + ')" type="button" class="btn btn-danger px-3 float-right"><i class="fa fa-trash" aria-hidden="true"></i></button>';
						reply += '<button id="replyEditBtn' + item.reply_id + '" onclick="replyEdit(' + item.reply_id + ')" type="button" class="btn btn-primary px-3 float-right"><i class="fa fa-paint-brush" aria-hidden="true"></i></button>';
						reply += '<a class="text-default">' + item.admin_id + '</a></h5>';
						reply += '<input id="replyInput' + item.reply_id +'" class="form-control w-75" value="'+ item.reply_con +'" style="border: 0px; background: white;" readonly="true"></input><hr /></div></div>';
					$('#replyAllBody').html(reply);
				});
				reply = '';
			}
		});
	};

	$('#commentSubmit').click(function() {
		var reply_con = $('#replyFormComment').val(); //댓글내용을 가져옴
		var admin_id = '${adminSession.admin_id}'; //세션에서 admin_id를 가져옴
		var store_id = ${storeSelectSession.store_id}; //세션에서 store_id를 가져옴

		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/reply',
			dataType : 'text',
			data : {
				notice_id : notice_id,
				admin_id : admin_id,
				reply_con : reply_con,
				store_id : store_id
			},
			success : function(data) {
				console.log('댓글작성완료');
				getAllList();
				$('#replyFormComment').val('');
			}
		});
	});

	//댓글 삭제
	function replyDelete(reply_id) {
		$.ajax({
			type : 'delete',
			url : '${pageContext.request.contextPath}/reply/' + reply_id,
			success : function(data) {
				console.log('삭제확인');
				getAllList();
			}
		});
	};
	
	//댓글 수정확인 누를시
	function replyModify(reply_id) {
		var reply_con = $('#replyInput' + reply_id).val();

		$.ajax({
			type : 'put',
			url : '${pageContext.request.contextPath}/reply/' + reply_id,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "put"
			},
			data : JSON.stringify({
				reply_con : reply_con
			}),
			success : function(data) {
				console.log('수정확인');
				getAllList();
			}
		});
	};
	
	//댓글수정 클릭시
	function replyEdit(reid) {
		$('#replyInput' + reid).attr("readonly", false);
		$('#replyInput' + reid).focus();
		$('#replyEditBtn' + reid).find('i').attr("class", "fa fa-check"); //댓글 수정클릭시 모양바뀜
		$('#replyEditBtn' + reid).attr("onclick", 'replyModify(' + reid + ')');
	};
</script>
</html>