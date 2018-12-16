<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MS</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	height: 100%;
}

.title_text {
	font-size: 40px;
	margin-bottom: 20px;
}

.orderMain_container {
	text-align: center;
	padding: 30px;
	height: 100%;
}

.left_area, .right_area {
	overflow: auto;
	height: 95%;
	padding: 15px 15px 0 15px; 
	border: 1px solid black;
	border-radius: 15px;
	margin-bottom: 15px;
}

.left_area {
	float: left;
	width: 35%;
}

.menu_display {
	height: 100%;
}
.right_area {
	float: right;
	width: 63%;
}

/* 선택한 메뉴를 보여주는 테이블을 감싸고 있는 div */
.order_table_wrap {
	overflow: auto;
	background-color: white;
}

.order_table {
	width: 100%;
	
}

.order_table td {
	height: 50px;
	font-size: 24px;
}

.plus, .minus {
	line-height:30px;
	background-color: gray;
	color: white;
	font-size: 30px;
	width:30px;
	height:30px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.minus {
	opacity: 0.4;
}

.plus:hover, .minus:hover {
	opacity: 0.7;
}

.total_cancel_btn, .pay_btn {
	width: 46%;
	height: 85px;
	border: none;
	border-radius: 10px;
	color: white;
	cursor: pointer;
	font-size: 26px;
}

.total_cancel_btn:hover, .pay_btn:hover {
	opacity: 0.7;
}

.total_cancel_btn {
	background-color: #1C2331;
}

.pay_btn {
	background-color: #CC0000;
}

.food_cnt {
	margin-left: 10px;
	margin-right: 10px;
}

.total_price_wrap {
	background-color: lightgray;
	border-radius: 10px;
	width: 50%;
	float: left;
	text-align: left;
	vertical-align: bottom;
	padding: 5px 10px 5px 10px;
	font-size: 25px;
}

.order_btn_wrap {
	width: 50%;
	float: right;
	text-align: right;
}

.cancel_btn:hover {
	cursor: pointer;
	color: red;
}

/* 음식 nav bar */
.menu_nav {
	width: 100%;
}

.selected {
	background-color: #ffbb33;
}

.menu_nav ul li {
	list-style: none;
	color: white;
	background-color: #2d2d2d;
	display: inline-block;
	line-height: 50px;
	vertical-align: middle;
	text-align: center;
	width: 140px;
}

.menu_nav ul li a {
	text-decoration: none;
	color: white;
	display: block; /* 글씨 부분 뿐만 아니라 전체 영역 클릭 가능 */
	width: 140px;
}

.menu_nav ul li a:hover {
	color: red;
	background-color: #4d4d4d;
}

.menu_content_wrap {
	position: relative;
	overflow: auto;
}

.menu_content {
	margin: 0 auto;
	width: 90%;
	font-size: 23px;
}

.menu_content > div > div {
	float: left;
	width: 24.4%; /* inline-block 속성에 속성 사이 간격 마진이 디폴트로 있으므로 */
	height: 46%;
	margin: 0 0.6% 0.6% 0px; /* top right bottom left */
	border: 1px solid black;
	border-radius: 10px;
}

.menu_content > div > div:hover {
	opacity: 0.7;
	cursor: pointer;
}

.menu_content div img {
	height: 50%;
}

.menu_display {
	display: none;
}

.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 35%;
	padding: 16px;
	color: black;
	font-weight: bold;
	font-size: 30px;
	border-radius: 0 3px 3px 0;
}

.prev {
	left: -1%;
}

.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  	background-color: rgba(0,0,0,0.8);
}

.dot {
	bottom: 10px;
	height: 15px;
	width: 15px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* 모바일 최적화 */
@media ( max-width : 767px ) {
	.left_area {
		width: 100%;
	}
	
	.right_area {
		width: 100%;
	}
	
	.title_text {
		font-size: 30px;
	}
	.total_price_wrap {
		font-size: 20px;
	}
	
	.total_cancel_btn, .pay_btn {
		font-size: 18px;
		height: 70px;
	}
	.menu_nav ul li, .menu_nav ul li a {
		width: 50px;
	}
	
	.orderMain_container div {
		display: inline-block;
	}
	
	tr>td{
		width: 80px;
	}
	
	.order_table td {
		font-size: 15px;
	}
	/* 수량 더하기빼기 버튼 */
	.order_table td button {
		width: 18px;
	}
	/* 헤더 글씨 */
	.navbar-nav li {
   		margin-left: 10px;
   		font-size: 1.3em;
	}
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="orderMain_container">
		<div class="title_text">[${storeSelectSession.store_name}] - 음식 주문</div>
		<div class="left_area">
			<div style="height: 15%">
				<div style="font-size: 35px">주문 내역</div>
			</div>
			<div style="height: 65%; margin-bottom: 5%" class="order_table_wrap">
				<table border="1" class="order_table">
					<tr style="background-color: lightgray">
						<td>메뉴</td>
						<td>수량</td>
						<td>가격</td>
						<td>취소</td>
					</tr>
				</table>
			</div>
			<div style="height: 15%">
				<div class="total_price_wrap">
					<div>
						주문 수량<span style="float: right" id="total_cnt">0</span>
					</div>
					<div>
						총 가격<span style="float: right" id="total_price">0</span>
					</div>
				</div>
				<div class="order_btn_wrap">
					<button class="total_cancel_btn">전체취소</button>
					<button class="pay_btn">결제하기</button>
				</div>
			</div>
		</div>
		
		<div class="right_area">
			<div style="height: 15%">
				<div style="font-size: 35px">음식 리스트</div>
			</div>
			<div class="menu_nav">
				<ul>
					<li><a class="menu_link selected" id="korean">한식</a></li>
					<li><a class="menu_link" id="japan">일식</a></li>
					<li><a class="menu_link" id="western">양식</a></li>
					<li><a class="menu_link" id="dessert">디저트</a></li>
					<li><a class="menu_link" id="drink">음료</a></li>
				</ul>
			</div>
			<div style="height: 75%" class="menu_content_wrap">
				<div style="height: 94%" class="menu_content">
					
				</div>
				<div style="height: 6%" class="paging_dot_wrap">
				
				</div>
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a> 
				<a class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
		</div>
	</div>
</body>
<script>
	var slideIndex = 1; // 페이징
	
	$(document).ready(function() {
		$('.selected').css('background-color', '#ffbb33');
		
		/* 페이지 로드 시 한식 메뉴로 초기화 */
		$.ajax({
			url : '${pageContext.request.contextPath}/user/getMenuList?foodType=korean&storeId=${storeSelectSession.store_id}',
			type : 'get',

			success : function(data) {
				if(data != ''){
					getMenuList(data);
				}
			}  
		}); // end ajax
		
		/* 메뉴 navbar 클릭 시 */
		$('.menu_link').on('click',function() {
			$('.selected').css('background-color', '');
			$('.selected').removeClass('selected');
			
			$(this).addClass('selected');
			$(this).css('background-color', '#ffbb33');
			
			$.ajax({
				url : '${pageContext.request.contextPath}/user/getMenuList?foodType='+ $(this).attr('id') + '&storeId=${storeSelectSession.store_id}',
				type : 'get',

				success : function(data) {
					if(data != ''){
						getMenuList(data);
					}
				}
			}); // end ajax
		});
		
		/* 전체취소 버튼 */
		$('.total_cancel_btn').on('click', function () {
			var str = '<tr style="background-color: lightgray"><td>메뉴</td><td>수량</td><td>가격</td><td>삭제</td></tr>';
			$('.order_table > tbody').html(str); // 선택한 메뉴 화면 초기화
			$('#total_cnt').text('0'); // 총 수량 초기화
			$('#total_price').text('0'); // 총 가격 초기화
			ordersArr = []; // 배열 초기화
		});
		
		/* 결제하기 버튼 */
		$('.pay_btn').on('click', function () {
			var ordersArr = []; // 주문 음식 담을 배열

			$('.order_table tr').each(function (index) {
				if(index != 0){
					var foodId = $(this).attr('id'); // 음식 아이디
					var foodType = $(this).attr('class'); // 음식 타입
					var foodName = $(this).children().eq(0).text(); // 음식 이름
					var foodCnt = $(this).children().children().eq(1).text();  // 음식 수량
					ordersArr.push(new OrdersList(parseInt(foodId), foodType, foodName, parseInt(foodCnt))); // 배열에 저장
				}
			});
			
			if(ordersArr == ''){ // 선택한 음식 없음
				alert('주문할 음식을 선택하세요.');
				return;
			} 
			
			console.log(ordersArr);
			var ordersConfirm = confirm('주문하시겠습니까?');
			
			if(ordersConfirm){
				
				$.ajax({
					url : '${pageContext.request.contextPath}/user/orders?storeId=${storeSelectSession.store_id}&userId=${userSession.user_id}',
					type : 'post',
					contentType: 'application/json', // 요청 타입 지정(안하면 405 오류) 
					data: JSON.stringify(ordersArr), 

					success : function() {
						location.reload();
					}  			
				}); // end ajax 
			}
		});
	});	// end document ready

	/* 음식 nav bar 분기 처리 함수 */
	function getMenuList(data){
		var pLength = getPagingCnt(data.length); // 페이징 표시
		
		var str = '';
		var first = 0;
		var last = data.length - 8;
		
		if(data.length < 8){
			last = 0;						
		}
		for(var i=0; i<pLength; i++){
			
			str += '<div class="menu_display fading">';
			for(var j=first; j<(data.length-last); j++){
				str += createTable(data[j].food_id, data[j].food_type, data[j].food_photo, data[j].food_name, data[j].food_price);
			}
			str += '</div>';
			
			first = ((i+1)*8);
			last = last - 8;
			
			if(last < 0 ){
				last = 0;
			}
		}
		$('.menu_content').html(str);
		showSlides(slideIndex);
	}
	
	/* 주문리스트 개별 취소 */
	function cancel(obj, cntId, price){
		var tr = $(obj).parent().parent();
		tr.remove(); // 라인 삭제
		
		var cnt = $(cntId).text(); // 삭제 당시 음식의 수량
		totalChange(price, 'delete', parseInt(cnt)); // 전체 수량 및 가격 변경
	}
	
	/* 동적 테이블 생성 (음식 아이디, 음식 종류, 음식 사진, 음식 이름, 음식 가격) */
	function createTable(foodId, foodType, foodPhoto, foodName, foodPrice) {
		
		var str = '<div style="padding-top: 2%" class="food_info_wrap" onclick="selectedMenu(' + foodId + ', ' + foodType + ', '+ foodPrice + ', ' + "'" + foodName + "'" + ')">';
		str += '<img src="http://52.79.242.155:8080/FileServer/resources/foodImg/'+ foodType +'/'+ foodPhoto + '"/>';
		/* str += '<img src="../resources/foodImg/'+ foodType +'/'+ foodPhoto + '"/>'; */
		str += '<div style="height: 50%; padding-top: 10%">';
		str += '<div>'+ foodName +'</div>';
		str += '<div>'+ numberWithCommas(foodPrice) +'</div>';
		str += '</div>';
		str += '</div>';
		
		return str;
	}
	
	/* 데이터 갯수에 따른 페이징 dot 표시 처리 */
	function getPagingCnt(length) {
		var str = '';
		var length = Math.ceil(length/8); // 소수점 올림 처리
		
		for(var i=0; i < length; i++){
			str += '<span class="dot" onclick="currentSlide('+ (i+1) +')"></span>';
		}
		$('.paging_dot_wrap').html(str);
		
		return length;
	}
	
	/* 페이징 화살표 클릭 시 처리 */
	function plusSlides(n) {
		showSlides(slideIndex += n);
	}

	/* 페이징 dot 클릭 시 처리  */
	function currentSlide(n) {
		showSlides(slideIndex = n);
	}

	function showSlides(n) {
		var i;
		var slides = $('.menu_display');
		var dots = $('.dot');
		  
		if (n > slides.length) {slideIndex = 1}    
		if (n < 1) {slideIndex = slides.length}
		for (i = 0; i < slides.length; i++) {
		    slides[i].style.display = "none";  
		}
		for (i = 0; i < dots.length; i++) {
		    dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex-1].style.display = "block";  
		dots[slideIndex-1].className += " active";
	} 
	
	/* 각 음식 선택 처리 */
	function selectedMenu(foodId, foodType, foodPrice, foodName){
		
		var nameId = 'name' + foodId; // 이름 td의 id 지정
		var cntId = 'cnt' + foodId; // 수량 span의 id 지정
 		var priceId = 'price' + foodId; // 가격 td의 아이디 지정
 		
		// 주문 테이블 동적 생성
		var str = '<tr id='+ foodId +' class='+ $(foodType).attr('id') +'>';
		str += '<td id='+ nameId +'>'+ foodName +'</td>';
		str += '<td><button class="minus" onclick="minusCnt('+ cntId +', '+ foodPrice + ', ' + priceId +')" disabled>-</button>';
		str += '<span id='+ cntId +' class="food_cnt">1</span>';
		str += '<button class="plus" onclick="plusCnt('+ cntId + ', '+ foodPrice +  ', ' + priceId +')">+</button></td>';
		str += '<td id='+ priceId +'>'+ foodPrice +'</td>'
		str += '<td><span class="cancel_btn" onclick="cancel(this, '+ cntId +', ' + foodPrice +')">X</span></td>'
		str += '</tr>';
	
		var beforeFoodId = $('#'+foodId).attr('id'); 
		
		if(beforeFoodId == foodId){ // 리스트에 있는 음식과 같은 음식 선택 시 수량만 변경
			$('#'+cntId).prev().attr('disabled', false);
			$('#'+cntId).prev().css('opacity', '1');
			
			var cnt = $('#'+cntId).text();
			$('#'+cntId).text(++cnt);
			
			var price = $('#'+priceId).text();
			$('#'+priceId).text(parseInt(price)+foodPrice);
		}
		else {
			$('.order_table > tbody').append(str);
		}
		totalChange(foodPrice, 'plus', 1);
	}
	
	/* 각 음식 + 카운트 처리 */
	function plusCnt(cntId, foodPrice, priceId) { // cntId는 onclick 메서드를 통해 객체로 넘어옴
		$(cntId).prev().attr('disabled', false);
		$(cntId).prev().css('opacity', '1');
		
	 	var num = $(cntId).text();
		$(cntId).text(num*1+1); // 수량변경
		
		var price = $(priceId).text();
		$(priceId).text(parseInt(price)+foodPrice); // 가격변경
		
		totalChange(foodPrice, 'plus', 1);
	}
	
	/* 각 음식 - 카운트 처리 */
	function minusCnt(cntId, foodPrice, priceId) {
		var num = $(cntId).text();
		
	 	$(cntId).text(num*1-1); // 수량변경
	 	
	 	var price = $(priceId).text();
		$(priceId).text(parseInt(price)-foodPrice); // 가격변경
		
		totalChange(foodPrice, 'minus', 1);
		
	 	if(num-1 < 2){ // 수량 1이하 안되게 처리
	 		$(cntId).prev().attr('disabled', true);
			$(cntId).prev().css('opacity', '0.3');
	 	}
	}
	
	/* 전체 수량과 가격 처리 */
	function totalChange(foodPrice, n, cnt) {
		if(n == 'plus'){
			var totalCnt = $('#total_cnt').text();
			$('#total_cnt').text(parseInt(totalCnt)+cnt); // 총 수량 계산
		
			var totalPrice = $('#total_price').text(); 
			$('#total_price').text(parseInt(totalPrice)+foodPrice); // 총 가격 계산
		}
		else if(n == 'minus') {
			var totalCnt = $('#total_cnt').text();
			$('#total_cnt').text(parseInt(totalCnt)-cnt);
		
			var totalPrice = $('#total_price').text(); 
			$('#total_price').text(parseInt(totalPrice)-foodPrice); 
		}
		else { // 개별 삭제
			var totalCnt = $('#total_cnt').text();
			$('#total_cnt').text(parseInt(totalCnt)-cnt);
		
			var totalPrice = $('#total_price').text(); 
			$('#total_price').text(parseInt(totalPrice)-(foodPrice*cnt)); 
		}
	}
	
	/* 주문한 음식 정보 생성자  */
	function OrdersList(foodId, foodType, foodName, foodCnt) {
		this.foodId = foodId;
		this.foodType = foodType;
		this.foodName = foodName;
		this.foodCnt = foodCnt;
	}
	
	/* 가격에 콤마 표시 */
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>	
</html>