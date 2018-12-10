<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.bit.ms.member.model.StoreVO"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	/* Calendar cal = Calendar.getInstance();
	
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
	
	request.setAttribute("nowMonth", nowMonth); */


    SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
    String today = format.format(new Date());
    String days = request.getParameter("days");
    StoreVO storeVo = (StoreVO)session.getAttribute("storeSelectSession");
    String fileName = storeVo.getStore_name() + "_월간매출현황_" + today;
    response.setHeader("Content-Type", "application/vnd.ms-xls");
    response.setHeader("Content-Disposition",
            "attachment; filename=" + new String((fileName).getBytes("KSC5601"), "8859_1") + ".xls");
%>

<!DOCTYPE html>
<html lang="ko" style="overflow: hidden">
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>엑셀 다운로드</title>

<style type="text/css">

.sales_hidden {
	border: thin black solid;
	mso-number-format: \@;
	padding: 15px;
	font-size: 15px;
	width: 500px;
	background:#f2f4f4;
}

</style>

</head>
<body>
	
<table width="500" style="text-align: center; width: 500;">
	<thead>
		<tr>
			<th class="sales_hidden">  판매 시간  </th>
			<th class="sales_hidden">  판매 번호  </th>
			<th class="sales_hidden">  종합 매출  </th>
			<th class="sales_hidden">  음식 매출  </th>
			<th class="sales_hidden">  좌석 매출  </th>
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

</body>

<script>
    function exportToExcel() {
        console.log("click");
        location.href= "./adminSalestoExcel";
        
    }
</script>

</html>