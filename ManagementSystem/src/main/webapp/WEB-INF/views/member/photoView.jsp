<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class = "container"><br>
	<div class = "photoHeader" style = "position : relative">
	<b style = "font-size : 30px; margin-top : 10px;">[${storeSelectSession.store_name}] - Photo게시판</b>
		<a id="write" class="btn btn-outline-elegant waves-effect"
			href="${pageContext.request.contextPath}/member/photoBoard/write" style = "position : absolute; right : 0px; top : 0px;">글쓰기</a>
		<hr><div><h2>${viewData.photo_title}</h2></div>
		<div id = "photo_id" style = "float : left;">글번호 : ${viewData.photo_id}</div>
		<div id = "photo_cnt" style = "float : left;">&nbsp&nbsp&nbsp조회수 : ${viewData.photo_cnt}</div>
		<div style = "float : right;">&nbsp 등록시간 : <fmt:parseDate value="${viewData.photo_date}" pattern="yyyy-MM-dd HH:mm" var = "date" />
		<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" /></div>
		<div style = "float : right;">작성자 : ${viewData.photo_upid}</div>
	</div><br><hr>
	<div class = "context">
		<div><img src = "http://52.79.242.155:8080/FileServer/resources/photoBoard/${viewData.photo_file}" style = "width : 350px; height : 350px;"></div><br>
		<div>${viewData.photo_con}</div><hr>
	</div>
	<div id = "btnDiv" style = "float : right;">
		<c:if test="${userSession.user_id == viewData.photo_upid || !empty adminSession}">
		<button type="button" class="btn btn-dark" data-toggle="modal"	data-target="#modalPhotoBoardDeleteForm">삭제</button>
		<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/member/photoBoard/modify/${viewData.photo_id}'">수정</button></c:if>
		<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/member/photoBoard?page=1'">목록</button>
	</div><br>
	<div id = reply>
		<!-- 댓글  -->
		<section class="comments my-5"> <!-- 코멘트 총개수 -->
		<div id="photoBoardCommentsNum" class="card-header font-weight-bold" style = "margin-bottom : 10px;"></div>
		<div id="photoBoardReplyAllBody"></div>
		</section>
		
		<!-- 댓글 입력란 -->
		
			<div class="md-form mt-4">
				<label for="photoBoardReplyFormComment">댓글 입력</label>
				<textarea  class="form-control md-textarea" id="photoBoardReplyFormComment" rows="1" ></textarea>
				<div class="text-center my-4">
					<button id="replySubmit" class="btn btn-default btn-sm btn-rounded">댓글 입력</button>
				</div>
			</div>
	</div>
</div>

<!-- 게시글 삭제확인 모달 -->
<div class="modal fade" id="modalPhotoBoardDeleteForm" tabindex="-1"	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
				<a class="btn btn-danger" onclick = "deletePhotoImg('${viewData.photo_file}', ${viewData.photo_id})">삭제</a>
				<a class="btn btn-dark" data-dismiss="modal">취소</a>
			</div>
		</div>
	</div>
</div>
</body>
<script>
	var store_id = ${storeSelectSession.store_id};
	var photo_id = ${viewData.photo_id};

	$(document).ready(function(){
		getReplyList(photo_id);
		countReply(photo_id);
	});
	if ("${userSession}"){
		var writeId = "${userSession.user_id}";
	} else {
		var writeId = "${storeSelectSession.store_name}[관리자]";
		var admin_id = "${adminSession.admin_id}";
	}
	
	function deletePhotoImg(fileName, id){
		$.ajax({
            async : false,
            type : 'get',
          	url : 'http://52.79.242.155:8080/FileServer/deleteFile/photo?fileName='+fileName,
            processData : false,
            contentType : false,
            
            success : function(data) {
            	$.ajax({
    				url: '${pageContext.request.contextPath}/member/photoBoard/delete/' + id, 
    				type: 'get',
    				success:function(){
    					location.href = "${pageContext.request.contextPath}/member/photoBoard?page=1";
    				}
    			}); // end ajax
            }
		 });
	}
	
	$('#replySubmit').click(function(){
		$.ajax({
			url : '${pageContext.request.contextPath}/member/photoView/photoReply',
			type : 'post',
			data : {
				photoreply_con : $('#photoBoardReplyFormComment').val(),
				photoreply_writeid : writeId,
				store_id : store_id,
				photo_id : photo_id
			},
			success : function(data){
				console.log(data);
				getReplyList(photo_id);
				countReply(photo_id);
				$('#photoBoardReplyFormComment').val("");
			}
		});
	});
	function getReplyList(photo_id){
		var str = "";
		$.ajax({
			url : '${pageContext.request.contextPath}/member/photoView/photoReplyList/' + photo_id,
			success : function(data){
				
				for(var i = 0; i < data.length; i++){
					str += "<div id = 'replyWrap' style = 'position : relative'><div id = 'reply_writeId'>" + data[i].photoreply_writeid + " (" + data[i].photoreply_date + ")</div>";
					str += "<div><input id = 'reply_con" + data[i].photoreply_id + "' value = '" + data[i].photoreply_con + "' style = 'border : none; border-radius : 5px; width : 70%; padding : 10px;' readonly></div>";

					if(data[i].photoreply_writeid == writeId || data[i].photoreply_writeid == admin_id){
						str += "<div id = 'replyBtnDiv' style = 'position : absolute; right : 0px; top : 10px;'><button id='photoBoardReplyDeleteBtn' onclick='photoBoardReplyDelete(" + data[i].photoreply_id + ")' class='btn btn-danger px-3 float-right'><i class='fa fa-trash' aria-hidden='true'></i></button>";
						str += "<button id='photoBoardReplyEditBtn" + data[i].photoreply_id + "' onclick='photoBoardReplyEdit(" + data[i].photoreply_id + ")' class='btn btn-primary px-3 float-right'><i class='fa fa-paint-brush' aria-hidden='true'></i></button></div>";
					}
					str += "<hr>";
				}
				str += "</div>";
				$('#photoBoardReplyAllBody').html(str);
			}
		});
	}
	function countReply(photo_id){
		$.ajax({
			url : '${pageContext.request.contextPath}/member/photoView/countReply/' + photo_id,
			success : function(data){
				console.log(data);
				$('#photoBoardCommentsNum').html("<p style = 'margin-bottom : 0px;'>" + data +" comments</p>")
			}
		});
	}
	function photoBoardReplyEdit(photoreply_id){
		$('#reply_con' + photoreply_id).focus().attr("readonly",false);
		$('#photoBoardReplyEditBtn' + photoreply_id ).find('i').attr("class", "fa fa-check");
		$('#photoBoardReplyEditBtn' + photoreply_id).attr("onclick","photoBoardReplyEditOk(" + photoreply_id + ")");
	}
	function photoBoardReplyEditOk(photoreply_id){
		if(confirm("댓글을 수정하시겠습니까??")){
			$.ajax({
				url : '${pageContext.request.contextPath}/member/photoView/modiReply/' + photoreply_id,
				type : 'post',
				data : {
					photoreply_con : $('#reply_con' + photoreply_id).val()
				},
				success : function(data){
					console.log("수정완료");
					getReplyList(photo_id);
				}
			});
		}
	}
	
	function photoBoardReplyDelete(photoreply_id){
		if(confirm("댓글을 삭제하시겠습니까??")){
			$.ajax({
				url : '${pageContext.request.contextPath}/member/photoView/deleteReply/' + photoreply_id,
				success : function(data){
					console.log("삭제완료");
					getReplyList(photo_id);
					countReply(photo_id);
				}
			});
		}
	}
	
	
	
	
	
</script>
</html>