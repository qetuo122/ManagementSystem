<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MS</title>
<style>
.title_text {
	font-size: 40px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.table tbody tr td {
	font-size: 18px;
	text-align: center;
}

.table tbody tr td input[type=text]{
	width: 100%;
	padding-left: 5px;
	padding-right: 5px;
}

.type_select {
	width: 100%;
	padding: 5px;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<div class="title_text">[${storeSelectSession.store_name}] - 상품 관리</div>
		<form action="insertFood" id="addForm"  method="POST"  enctype="multipart/form-data">
		<table id="addTable" class="table table-bordered table-hover table-striped">
			<thead class="thead-dark">
				<tr>
					<th scope="col" colspan="6" style="font-size: 20px">상품 추가</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 15%">타입</td>
					<td style="width: 14%">이름</td>
					<td style="width: 16%">가격</td>
					<td style="width: 15%">재고</td>
					<td style="width: 20%">사진</td>
					<td style="width: 20%">관리</td>
				</tr>
				<tr>
					<td>
						<select class="type_select" name ="food_type">
							<option value="0">타입 선택</option>
							<option value="korean">korean</option>
							<option value="japan">japan</option>
							<option value="western">western</option>
							<option value="dessert">dessert</option>
							<option value="drink">drink</option>
						</select>
					</td>
					<td><input type="text" name="food_name" placeholder="ex) 콜라"/></td>
					<td><input type="text" name="food_price" placeholder="ex) 3000" style="width: 80%; margin-right: 5px"/>원</td>
					<td><input type="text" name="food_stock" placeholder="ex) 50" style="width: 80%; margin-right: 5px"/>개</td>
					<td>
						<input type="file" name="report"/>
						<input type="hidden" name="food_photo"> <!-- 커맨드 객체를 위한 폼 -->
					</td>				
					<td>
						<input type="hidden" name="store_id" value="${storeSelectSession.store_id }"/>
						<input type="button" value="등록" onclick="insertFood()"/>
						<input type="button" value="초기화" id="resetBtn"/>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		
		<form id="listForm">
		<table id="listTable" class="table table-bordered table-hover table-striped table_font">
			<thead class="thead-dark">
				<tr>
					<th scope="col" colspan="6" style="font-size: 20px">상품 리스트</th>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
		</form>
	</div>
	<script>
		var modifyCheck = false; // 수정 버튼 스위칭
	
		$(document).ready(function() {
			getFoodList();
			
			/* 초기화 버튼 */
			// 동적 생성이 아닌 기존에 작성되어있기에 DOM 트리 생성 후 실행하는 함수인 document.ready 안에 들어오는것이 적절.
			$('#resetBtn').on('click', function () {
				$('.type_select').val('0'); // select 값 초기화
				$('input[type=text]').val(''); // 입력 값 초기화
			});	
		}); // end document.ready
		
		/* 등록 버튼 */
		function insertFood(){
			if(!invalidCheck('addTable', 'X')){ // 유효성 통과 못할 시
				return false;
			}
			
			var registerConfirm = confirm('등록하시겠습니까?');
			if(!registerConfirm){
				return false;
			}
			
			var formData = new FormData($('#addForm')[0]);
			
			 $.ajax({
                 async : false,
                 type : 'POST',
               	 url : 'http://52.79.242.155:8080/FileServer/uploadFile/food',
                 data : formData,
                 processData : false,
                 contentType : false,
                 
                 success : function(data) {
                	$('#addTable input[name=food_photo]').val(data); // hidden form에 파일 이름 저장
                	$('#addForm').submit();
                 }
			 });
		}		
		
		/* 삭제 버튼 */
		function deleteFood(id, foodName, fileName){
			
			$.ajax({
                async : false,
                type : 'get',
              	url : 'http://52.79.242.155:8080/FileServer/deleteFile/food?fileName='+fileName,
                processData : false,
                contentType : false,
                
                success : function(data) {
                	$.ajax({
        				url: '${pageContext.request.contextPath}/admin/deleteFood?storeId=${storeSelectSession.store_id}&foodId='+id,
        				type: 'get',
        					
        				success:function(){
        					getFoodList();
        				}
        			}); // end ajax
                }
			 });
		}
		
		/* 수정 버튼 */
		function updateFood(id, foodName, foodPrice, foodStock){
			// 처음으로 수정 버튼 눌럿을 때
			if(!modifyCheck){ 
				var foodInfo = [foodName, foodPrice, foodStock];
				var inputName = ['food_name', 'food_price', 'food_stock'];
				
				$('#'+id+' > td:not(:first):not(:last):not(:nth-child(2))').addClass('changeForm'); // 첫 번째와 두번째, 마지막 td를 제외한 td에 클래스 추가
				$('.changeForm').each(function (index, item) {
					$(item).html('<input type="text" name='+ inputName[index] +' value='+ foodInfo[index] +'>');
				
				});
				modifyCheck = true;
			}
			// 두 번째로 수정 버튼 눌렀을 때
			else { 
				if(!invalidCheck('listTable', foodName)){ // 유효성 검사 통과 못할 시
					return false;
				} 
				
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/updateFood?storeId=${storeSelectSession.store_id}&foodId='+id,
					type: 'get',
					data: $('#listForm').serialize(),
						
					success:function(){
						modifyCheck = false;
						getFoodList();
					}
				});
			}
		}
		
		/* 음식 리스트 전부 가져오기 */
		function getFoodList(){
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/getFoodInfoAll?storeId=${storeSelectSession.store_id}',
				type: 'get',
					
				success:function(data){
					var str = '<tr><td>#</td><td>타입</td><td>이름</td><td>가격</td><td>재고</td><td>관리</td></tr>';
					for(var i=0; i<data.length; i++){
						str += '<tr id='+ data[i].food_id +'>';
						str += '<td style="width:10%">'+ data[i].food_id +'</td>';
						str += '<td style="width:15%">'+ data[i].food_type +'</td>';
						str += '<td>'+ data[i].food_name +'</td>';
						str += '<td>'+ numberWithCommas(data[i].food_price) +'</td>';
						str += '<td>'+ data[i].food_stock +'</td>';
						str += '<td style="width:20%"><input type="button" value="수정" onclick="updateFood('+ data[i].food_id + ', \'' + data[i].food_name + '\', ' + data[i].food_price + ', ' + data[i].food_stock + ')"/>';
						str += ' <input type="button" value="삭제" onclick="deleteFood('+ data[i].food_id + ', \'' + data[i].food_name + '\', \'' + data[i].food_photo +'\')"/></td>';
						str += '</tr>';
					}
					$('#listTable > tbody').html(str); // tbody의 마지막에 행 추가
				}
			});
		}
		
		/* 유효성 검사 */
		function invalidCheck(tableId, beforeName){
			var regNumber = /^[0-9]*$/; // 숫자만 입력되었는지 검사
			var regBlank = /[\s]/g; // 공백 검사
			
			var foodType = $('#'+tableId+' .type_select').val(); // 선택된 타입
			var foodName = $('#'+tableId+' input[name=food_name]').val(); // 입력된 상품 이름 
			var foodPrice = $('#'+tableId+' input[name=food_price]').val(); // 입력된 상품 가격
			var foodStock = $('#'+tableId+' input[name=food_stock]').val(); // 입력된 상품 재고
			
			if(foodType == '0' || regBlank.test(foodName) || regBlank.test(foodPrice) || regBlank.test(foodStock)){
				alert('입력란을 모두 채워주세요.');
				return false;
			}
			
			if((!regNumber.test(foodPrice)) || (!regNumber.test(foodStock))){
				alert('가격과 재고는 숫자만 입력 가능합니다.');
				return false;
			}
			
			// 수정 눌렀을 때 컬럼의 음식 이름과 입력된 음식 이름이 일치하지 않을 경우에만 검사
			if(beforeName != foodName){
				var result = true;
				$.ajax({
					url: '${pageContext.request.contextPath}/admin/getFoodInfoAll?storeId=${storeSelectSession.store_id}',
					type: 'get',
					async: false,
					
					success:function(data){
						for(var i=0; i<data.length; i++){
							if(data[i].food_name == foodName){
								alert('이미 등록된 상품입니다.');
								result = false;
							}
						}
					}
				});
				return result;
			}
			return true;
		}
		
		/* 가격에 콤마 표시 */
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
 	</script>
</body>
</html>