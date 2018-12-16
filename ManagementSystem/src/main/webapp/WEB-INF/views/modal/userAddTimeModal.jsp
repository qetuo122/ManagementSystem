<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

/* 시간충전 modal창 내용 */
.modal_contents {
	background-color: #fefefe;
	margin: auto;
	padding: 15px;
	border: 1px solid #888;
	border-radius: 20px;
	width: 600px;
	text-align: center;
}

/* modal창 감싸고 있는 배경 Div */
.add_time_modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

.add_time_btn {
	width: 150px;
	background-color: #f8585b;
	border: none;
	border-radius: 10px;
	color: #fff;
	padding: 15px 0;
	margin-top: 10px;
	text-align: center;
	font-size: 18px;
	cursor: pointer;
}

.add_time_btn:hover {
	opacity: 0.7;
}

/* close 버튼 */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	font-size: 28px;
	font-family: sans-serif;
}

.selected_info {
	font-size: 24px;
}

select {
	width: 200px; /* 원하는 너비설정 */
	padding: .7em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background:	url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; /* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

/* 모바일 최적화 */
@media ( max-width : 767px ) {
	.modal_contents {
		width: 350px;
	}
	.modal_contents h3 {
		font-size: 25px;
	}
	.modal_contents div {
		height: 90px;
	}
}
</style>

<!-- 사용 전 시간 추가 modal -->
<div id="addTimeModal" class="add_time_modal">
	<div class="modal_contents">
		<h3>
			<b>◈ 충전 후 바로 사용 가능합니다.</b><span class="close">&times;</span>
		</h3>
		
		<div id="selectedInfo" class="selected_info">
			<span style="font-weight: bold"></span>님, <!-- 사용자 이름 -->
			<span style="color: red; font-weight: bold"></span>자리에 <!-- 좌석 번호  -->
			<span style="color: red; font-weight: bold"></span>을 충전하시겠습니까? <!-- 충전 시간(가격) -->
		</div>
		
		<button id="addTimeBtn" class="add_time_btn">충전하기</button>
	</div>
</div>

<!-- 사용 전 시간 추가 modal (충전 시간 존재) -->
<div id="alreadyTimeModal" class="add_time_modal">
	<div class="modal_contents">
		<h3>
			<b>◈ 남은 시간이 존재합니다.</b><span class="close">&times;</span>
		</h3>
		
		<div id="alreadySelectedInfo" class="selected_info">
			<span style="font-weight: bold"></span>님, <!-- 사용자 이름 -->
			<span style="color: red; font-weight: bold"></span>번 자리를 선택하셨습니다.<br>
			남은시간은 <span style="color: red; font-weight: bold"></span>분
			<span style="color: red; font-weight: bold"></span>초 입니다.
		</div>
		
		<button id="alreadyTimeBtn" class="add_time_btn">충전하기</button>
		<button id="startBtn" class="add_time_btn">바로 시작하기</button>
	</div>
</div>

<!-- 사용 중 시간 추가 modal -->
<div id="usingAddTimeModal" class="add_time_modal">
	<div class="modal_contents">
		<h3>
			<b>◈ 충전하실 시간을 선택하세요</b><span class="close">&times;</span>
		</h3>
		
		<select id="selectAddTime">
			<option value="0">select Time</option>
		</select> <br>
		
		<button id="usingAddTimeBtn" class="add_time_btn">충전하기</button>
	</div>
</div>

<!-- 사용 중 자리 변경 modal -->
<div id="usingSeatChangeModal" class="add_time_modal">
	<div class="modal_contents" style="overflow: auto">
		<h3>
			<b>◈ 변경하실 좌석을 선택하세요</b> <span class="close">&times;</span>
		</h3>
		<button id="usingSeatChangeBtn" class="add_time_btn">자리이동</button>
		
		<div class="seat_list"></div>
		
	</div>
</div>