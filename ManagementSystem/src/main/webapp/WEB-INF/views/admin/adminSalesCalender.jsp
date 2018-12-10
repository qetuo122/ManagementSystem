<%@page import="com.bit.ms.member.model.StoreVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<html>

<%
	Calendar cal = Calendar.getInstance();

	/* int year = cal.get(Calendar.YEAR);
	int months = cal.get(Calendar.MONTH);
	int month = months + 1;

	int date = cal.get(Calendar.DATE);

	request.setAttribute("year", year);
	request.setAttribute("month", month);
	request.setAttribute("date", date); */

	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	String dateToday = Integer.toString(year-1) + Integer.toString(month+2) + "00";

	if(strYear != null) {
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	} else {
	}
	
	int nowMonth = month + 1;
	
	// 현재 시간 지정
	
	// 년도/월 셋팅
	cal.set(year, month, 1);

	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int starts = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int start = starts - 1;
	int newLine = 0;
	
	int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	// 해당월의 마지막일로 캘린더 설정.
	cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	int lastDayOfLastWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	// 오늘 날짜 저장.
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
	
	request.setAttribute("year", year);
	request.setAttribute("month", month);
	request.setAttribute("date", date);
	
	request.setAttribute("dateToday", dateToday);
	request.setAttribute("nowMonth", nowMonth);
	
	request.setAttribute("startDay", startDay);
	request.setAttribute("endDay", endDay);
	request.setAttribute("start", start);
	request.setAttribute("newLine", newLine);
	request.setAttribute("intToday", intToday);
	request.setAttribute("firstDayOfWeek", firstDayOfWeek);
	request.setAttribute("lastDayOfLastWeek", lastDayOfLastWeek);
	
%>


<head>
<meta charset="UTF-8">
<title>MS</title>

<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>

<style type="text/css">

.sales_ModalTable {
	border: 1px !important;
	border-color: black !important;
	border-style: solid !important;
	width: 110px !important;
}

.sales_month {
	border: 1px !important;
	border-color: #CECECE !important;
	border-style: solid !important;
}

.sales_Table {
	border: 1px !important;
	border-color: #CECECE !important;
	border-style: solid !important;
	padding: 5px !important;
}
td.sales_Table:hover {
	background-color: #F8E0F7;
}

.sales_date {
	vertical-align: middle;
	font-size: 27px;
    color: #282828;
    font-weight: bold;
}

.sales_hidden {
	border: 1px;
	border-color: #CECECE;
	border-style: solid;
	padding: 15px;
	font-size: 15px;
}

</style>

</head>
<body>

<br>
<h1 style="text-align: center;"><font color="brown"> ${storeSelectSession.store_name } </font><font color="black"> 매출 현황 </font></h1>
<br>

<div class="container" style="width:712px;">
	
	<!--날짜 네비게이션  -->
<table width="701px" cellspacing="1" cellpadding="1" bgcolor="#CECECE" style="border:1px solid #CECECE">
	<tr>
		<td height="60px">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" >
					
						<!-- 이전해 -->
						<a href="<c:url value='/admin/salesCalender' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
							<b><img src="${pageContext.request.contextPath}/images/ArrowDouble_Left.png" style="width: 30px; height: 30px;"/></b>
							<c:set var="dateToday" value="${year-2}${month+1}${'00'}" />
						</a>
						
						<!-- 이전달 -->
						<%if(month > 0 ){ %>
						<a href="<c:url value='/admin/salesCalender' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
							<b><img src="${pageContext.request.contextPath}/images/Arrow_Left.png" style="width: 28px; height: 28px;"/></b>
	                    	<c:set var="dateToday" value="${year-1}${month}${'00'}" />
	                    </a>
	                    
	                    <!-- 1월에서의 이전달 -->
	                    <%} else {%>
	                    	<a href="<c:url value='/admin/salesCalender' />?year=<%=year-1%>&amp;month=<%=month+11%>" target="_self">							
							<b><img src="${pageContext.request.contextPath}/images/Arrow_Left.png" style="width: 28px; height: 28px;"/></b>
							<c:set var="dateToday" value="${year-2}${month+12}${'00'}" />
							</a>
	                    <%} %>
	                    	<span class="sales_date">&nbsp;&nbsp; <%=year%>년 <%=month+1%>월 &nbsp;&nbsp;</span>
	                    
	                    <!-- 다음달 -->
	                    <%if(month < 11 ){ %>
						<a href="<c:url value='/admin/salesCalender' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">
	                    	<b><img src="${pageContext.request.contextPath}/images/Arrow_Right.png" style="width: 28px; height: 28px;"/></b>
							<c:set var="dateToday" value="${year-1}${month+2}${'00'}" />
						</a>
						
						<!-- 12월에서의 다음달 -->
						<%}else{%>
							<a href="<c:url value='/admin/salesCalender' />?year=<%=year+1%>&amp;month=<%=month-11%>" target="_self">	
							<b><img src="${pageContext.request.contextPath}/images/Arrow_Right.png" style="width: 28px; height: 28px;"/></b>
							<c:set var="dateToday" value="${year}${month-10}${'00'}" />
							</a>
							
						<!-- 다음해 -->
						<%} %>
						<a href="<c:url value='/admin/salesCalender' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">
							<b><img src="${pageContext.request.contextPath}/images/ArrowDouble_Right.png" style="width: 30px; height: 30px;"/></b>
	                    	<c:set var="dateToday" value="${year}${month+1}${'00'}" />
	                    </a>
	                    
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
	<table>
		<thead>
			<!-- 달력 머리부분 -->
			<tr bgcolor="#CECECE">
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;"><font color="red">일</font></div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;">월</div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;">화</div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;">수</div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;">목</div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;">금</div>
				</td>
				<td class="sales_Table" width="100px" height="40px">
					<div align="center" style="font-weight: bold;"><font color="#529DBC">토</font></div>
				</td>
			</tr>
		</thead>
		
		<tbody>
		
				<%-- <fmt:formatDate value="${sales.sales_day}" type pattern="yyyyMMdd" /> --%>
			
			<!-- 달력 몸통부분 -->
				<tr>
				<!-- 날짜 시작전 공백 만들기 -->
					<c:forEach var="i" begin="1" end="${ start }">
						<td class="sales_Table" width="100px" height="100px" valign="top" align="left" nowrap></td>
						<c:set var="newLine" value="${newLine + 1}" />
					</c:forEach>
					
					<c:forEach var="i" begin="1" end="${ endDay }">
						<c:set var="index" value="${index + 1}"></c:set>
						<c:set var="dateToday" value="${dateToday + 1}"></c:set>
						
						<c:choose> 
						
							<%-- 오늘 날짜 칸 만들기 --%>
							<c:when test="${ dateToday eq intToday}"> 
									<td data-target="#layerpop" data-toggle="modal" id="indexId${ index }" value="${ index }" class="sales_Table salesText" width="100px" height="100px" valign="top" align="left" nowrap bgcolor="#C8C8C8">
									<p><font style="font-weight: bold; color: PURPLE;">${ index }</font></p>
									<p><font style="font-weight: bold; color: #282828;">
									<p>
									
									<c:set var="total" value="0"></c:set>
									
									<c:forEach items="${ salesList }" var="sales">
										<c:if test="${ storeSelectSession.store_id eq sales.store_id }">
										<c:if test="${ dateToday eq sales.salesDate }">
											<%-- 총 매출 : ${ sales.sales_total }
											음식 매출 : ${ sales.sales_food }
											좌석 매출 : ${ sales.sales_seat } --%>
											<c:set var="total" value="${total + sales.sales_total}"></c:set>
										</c:if>
										</c:if>
									</c:forEach>
										<c:if test="${total != 0 }">
										[총 매출] <br> <c:out value="${total }"></c:out>
										</c:if>
									</p></font></p></td>
							</c:when> 
						
							<%-- 일요일 날짜 칸 만들기 --%>
							<c:when test="${((i-(8-firstDayOfWeek)) % 7) == 1}"> 
									<td data-target="#layerpop" data-toggle="modal" id="indexId${ index }" value="${ index }" class="sales_Table salesText" width="100px" height="100px" valign="top" align="left" nowrap>
									<p><font style="font-weight: bold; color: RED;">${ index }</font></p>
									<p><font style="font-weight: bold; color: GRAY;">
									<p>
									
									<c:set var="total" value="0"></c:set>
									
									<c:forEach items="${ salesList }" var="sales">
										<c:if test="${ storeSelectSession.store_id eq sales.store_id }">
										<c:if test="${ dateToday eq sales.salesDate }">
											<%-- 총 매출 : ${ sales.sales_total }
											음식 매출 : ${ sales.sales_food }
											좌석 매출 : ${ sales.sales_seat } --%>
											<c:set var="total" value="${total + sales.sales_total}"></c:set>
										</c:if>
										</c:if>
									</c:forEach>
										<c:if test="${total != 0 }">
										[총 매출] <br> <c:out value="${total }"></c:out>
										</c:if>
									</p></font></p></td>
							</c:when> 
							
							<%-- 토요일 날짜 칸 만들기 --%>
							<c:when test="${((i-(8-firstDayOfWeek)) % 7) == 0}"> 
									<td data-target="#layerpop" data-toggle="modal" id="indexId${ index }" value="${ index }" class="sales_Table salesText" width="100px" height="100px" valign="top" align="left" nowrap>
									<p><font style="font-weight: bold; color: #529DBC;">${ index }</font></p>
									<p><font style="font-weight: bold; color: GRAY;">
									<p>
									
									<c:set var="total" value="0"></c:set>
									
									<c:forEach items="${ salesList }" var="sales">
										<c:if test="${ storeSelectSession.store_id eq sales.store_id }">
										<c:if test="${ dateToday eq sales.salesDate }">
											<%-- 총 매출 : ${ sales.sales_total }
											음식 매출 : ${ sales.sales_food }
											좌석 매출 : ${ sales.sales_seat } --%>
											<c:set var="total" value="${total + sales.sales_total}"></c:set>
										</c:if>
										</c:if>
									</c:forEach>
										<c:if test="${total != 0 }">
										[총 매출] <br> <c:out value="${total }"></c:out>
										</c:if>
									</p></font></p></td>
							</c:when> 
							
							<%-- 평일 날짜 칸 만들기 --%>
							<c:otherwise> 
									<td data-target="#layerpop" data-toggle="modal" id="indexId${ index }" value="${ index }" class="sales_Table salesText" width="100px" height="100px" valign="top" align="left" nowrap>
									<p><font style="font-weight: bold; color: BLACK;">${ index }</font></p>
									<p><font style="font-weight: bold; color: GRAY;">
									<p>
									
									<c:set var="total" value="0"></c:set>
									
									<c:forEach items="${ salesList }" var="sales">
										<c:if test="${ storeSelectSession.store_id eq sales.store_id }">
										<c:if test="${ dateToday eq sales.salesDate }">
											<%-- 총 매출 : ${ total }
											음식 매출 : ${ sales.sales_food }
											좌석 매출 : ${ sales.sales_seat } --%>
											<c:set var="total" value="${total + sales.sales_total}"></c:set>
										</c:if>
										</c:if>
									</c:forEach>
										<c:if test="${total != 0 }">
										[총 매출] <br> <c:out value="${total }"></c:out>
										</c:if>
									</p></font></p></td>
							</c:otherwise> 
						</c:choose>
						
							<%-- <c:if test="${ intToday eq sales.sales_day }">
							${ sales.sales_total }
							</c:if> --%>
							
						<!-- 칸이 7개 만들어지면 아랫줄로 넘기기 -->
						<c:if test="${((i-(8-firstDayOfWeek)) % 7) == 0}">
							<tr>
							</tr>
						</c:if>
						
					</c:forEach>
					
					<!-- 날짜 채운후 공백 만들기 -->
					<c:if test="${ lastDayOfLastWeek != '7' }">
						<c:forEach var="i" begin="1" end="${ 7-lastDayOfLastWeek }">
							<td class="sales_Table" width="100px" height="80px" valign="top" align="right" nowrap>
							</td>
						</c:forEach>
					</c:if>
					
				</tr>
		</tbody>
		
	</table>
	<br>
	<input type="button" name="excelConvertBtn" id="excelConvertBtn" value="${nowMonth}월 매출 엑셀로 다운로드" style="cursor:hand;" />

	<%-- <h1>${year }</h1>
	<h1>${month }</h1>
	<h1>${date }</h1>
	<h1>${ intToday }</h1>
	<h1>${dateToday }</h1>
	<h1>${sales.sales_day}</h1>
	<h1>${lastDayOfLastWeek}</h1>
	<h1>${firstDayOfWeek}</h1>
	<h1>${date }</h1>
	<h1>${admin.store_id }</h1>
	<h1>${sessionScope.store_id }</h1>
	<h1>${storeSelectSession.store_id }</h1>
	<h1>${nowMonth }</h1> --%>
	
	<canvas id="myChart" style="margin-left: 5px;"></canvas>
	
</div>


<!-- 모달 창 -->

<div class="modal fade" id="layerpop" >
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- header -->
			<div class="modal-header">
				<!-- header title -->
				<h4 class="modal-title">세부 매출 기록</h4>
				<!-- 닫기(x) 버튼 -->
				<button type="button" class="close" data-dismiss="modal">×</button>
			</div>
			
			<!-- body -->
			<div id="salesViewText" class="modal-body">
			<table>
				<thead>
					<tr>
						<th class="sales_ModalTable" style="text-align: center;">판매 번호</th>
						<th class="sales_ModalTable" style="text-align: center;">종합 매출</th>
						<th class="sales_ModalTable" style="text-align: center;">음식 매출</th>
						<th class="sales_ModalTable" style="text-align: center;">좌석 매출</th>
					</tr>
				</thead>
				<tbody id="sales_text">
					
				</tbody>
			</table>
	
			<%-- <c:forEach items="${ salesList }" var="sales">
					총 매출 : ${ sales.sales_total }
					음식 매출 : ${ sales.sales_food }
					좌석 매출 : ${ sales.sales_seat }
					<br>
			</c:forEach> --%>
			</div>
			
			<!-- Footer -->
			<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<!-- 숨겨진 테이블 ( 엑셀에 출력될것 ) -->
<table style="text-align: center; display: none;">
	<thead>
		<tr>
			<th class="sales_hidden">판매 시간</th>
			<th class="sales_hidden">판매 번호</th>
			<th class="sales_hidden">종합 매출</th>
			<th class="sales_hidden">음식 매출</th>
			<th class="sales_hidden">좌석 매출</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ salesList }" var="sales">
			<c:if test="${ storeSelectSession.store_id eq sales.store_id }">
				<c:if test="${ nowMonth eq sales.salesMonth }">
					<tr>
						<td class="sales_hidden">${ sales.salesTime }</td>
						<td class="sales_hidden">${ sales.sales_id }</td>
						<td class="sales_hidden">${ sales.sales_total }</td>
						<td class="sales_hidden">${ sales.sales_food }</td>
						<td class="sales_hidden">${ sales.sales_seat }</td>
					</tr>
				</c:if>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<script>
	$(document).ready(function() {
		
		var getText = '';
		
		 /* $(document).on("click",".salesText",function(){ */
		$('.salesText').click(function() {
			
			var getText = $(this).attr('value');
			
			$("#getText").val(getText);
			
		});
	
		$('.salesText').click(function() {
			var salesText = '';
			var indexId = $(this).attr('value');
			var nowMonth = ${nowMonth};
			var storeId = ${storeSelectSession.store_id};
			//console.log(getText);
			console.log(nowMonth);
			$.ajax({
				type : 'get',
				url : '${pageContext.request.contextPath}/admin/salesInfo/' + indexId,
				data : {
					storeId : storeId,
					nowMonth : nowMonth
				},
				success : function(data) {
					// console.log(data);
					// console.log(data.length);
					str = '';
					for( var i=0; i < data.length ; i++) {
						str += '<tr>';
						str += '<td class="sales_ModalTable" id ="sales_id" style="text-align: center; vertical-align: middle;">' + data[i].sales_id + '</td>';
						str += '<td class="sales_ModalTable" id ="sales_id" style="text-align: center; vertical-align: middle;">' + data[i].sales_total + '</td>';
						str += '<td class="sales_ModalTable" id ="sales_id" style="text-align: center; vertical-align: middle;">' + data[i].sales_food + '</td>';
						str += '<td class="sales_ModalTable" id ="sales_id" style="text-align: center; vertical-align: middle;">' + data[i].sales_seat + '</td>';
						str += '</tr>';
					}
					$('#sales_text').html(str);
					
					
					// $('#sales_id').html(data[0].sales_id);
					
					/* // $('#indexId').html(data.length + ' comments');
					$('#salesViewText').html('');
					$(data).each(function(index, item) {
						// $('#indexId').html(data.length + ' comments');
						salesText += '<c:forEach items="${ salesList }" var="sales">';
						salesText += '<c:if test="${ indexId eq sales.sales_day }">';
						salesText += '총 매출 : ${ sales.sales_total }';
						salesText += '음식 매출 : ${ sales.sales_food }';
						salesText += '좌석 매출 : ${ sales.sales_seat }';
						salesText += '</c:if>';
						salesText += '</c:forEach>';
					$('#salesViewText').html(salesText);
					
					});
					
					salesText = ''; */
					
					// $('#indexId').val('');
				
				}
			});
		});
	});
		 
</script>

<script>

	$(document).ready(function() {
		$("#excelConvertBtn").on('click', function() {
			location.href = "../admin/adminSalestoExcel/" + ${nowMonth};
		})
	})
    
</script>

<script>

	/* var ctx = document.getElementById("logChart").getContext('2d');
	var nowMonth = $('#excelConvertBtn').attr('value');
	var indexId = $('.salesText').attr('value');
	var myChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: ['${index}'],
	        datasets: [{
	
	
	            data: ['${menCount}', '${womenCount}'], //컨트롤러에서 모델로 받아온다.
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)'
	
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)'
	
	            ],
	            borderWidth: 1
	        }
	        ]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	}); */
	
	
	$(document).ready(function() {
		
		var nowMonth = ${nowMonth};
		var storeId = ${storeSelectSession.store_id};
		console.log(nowMonth);
		console.log(storeId);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminSalesChart/' + nowMonth,
            method: "GET",
            data : {
				storeId : storeId
			},
            success: function (result) {
            	console.log('짜증나는 데이터', result);
                /* var num = [];
                var sales = [];
                
                for (var i in day) {
                    num.push(result[i].sales_day);
                    sales.push(result[i].sales_total);
                } */
                
                var num = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
                var sales_total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                var sales_food = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                var sales_seat = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                var day = [];
                
                for (var i in result) {
                	day.push(result[i].sales_day);
                }
                
                for (var i in result) {
                	num.splice(day[i]-1, 1, result[i].sales_day);
                	sales_total.splice(day[i]-1, 1, result[i].sales_total);
                }
                
                for (var i in result) {
                	num.splice(day[i]-1, 1, result[i].sales_day);
                	sales_food.splice(day[i]-1, 1, result[i].sales_food);
                }
                
                for (var i in result) {
                	num.splice(day[i]-1, 1, result[i].sales_day);
                	sales_seat.splice(day[i]-1, 1, result[i].sales_seat);
                }
                
                console.log('짜증나는 데이데이~', day);
                console.log('늘어나는 팔로우~', num);
                console.log('겁없어 매출~', sales_total);
                
                var data = {
                    labels: num,
                    datasets: [{
                        label: '일간 총 매출',
                        borderColor: "#819FF7",
                        data: sales_total
                    },{
                        label: '일간 음식 매출',
                        borderColor: "#FAAC58",
                        data: sales_food,
                    },{
                        label: '일간 자리 매출',
                        borderColor: "#58FA82",
                        data: sales_seat,
                    }],
                };
                var option = {
                  //옵션 생략
                  scales: { yAxes: [{ ticks: { beginAtZero:true } }] }   // 데이터값 시작을 0부터시작
                  
                };
                
				var ctx = document.getElementById('myChart').getContext('2d');
				var myLine = new Chart(ctx, {
					type: 'line',
					data: data,
					scaleBeginAtZero : true,
					options: option
            	});
        	}
		});
	});


</script>

</body>
</html>