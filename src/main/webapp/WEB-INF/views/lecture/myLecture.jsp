<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<html>
<head>
<style type="text/css">
#book {
	top: 0px;
}
</style>
<title>Home</title>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var date = new Date();
	let year = date.getFullYear();
	let month = date.getMonth()+1;
	var semester;
	console.log(month)
// 	var color = [ 'primary', 'info', 'danger', 'warning', 'secondary', 'dark' ];

	if (month == '1' ||month == '2' ||month == '3' || month == '4' || month == '5' || month == '6')
		semester = 1;
	else if (month == '9' || month == '10' || month == '11' || month == '12')
		semester = 2;

	let lectureListYear = year + "년도 " + semester + "학기 강의목록";
	console.log(lectureListYear);

	$(function() {
		$("#lectureListYear").text(lectureListYear);
	})
</script>
</head>
<body>

	<div class="col" align="center">
		<div class="card-header">
			<h1 class="card-title">
				<strong id="lectureListYear"> 담당 강의</strong>
			</h1>
		</div>
		<br>
		<div class="col-sm-12">
			<c:forEach var="row" items="${lecture}" varStatus="stat">
				<div class="small-box bg-info"
					style="width: 250px; display: inline-block;">
					<div class="inner">
						<h4>${row.lecApply.lecaNm}</h4>
						<p>${row.lecApply.lecaYr}년도&nbsp;${row.lecApply.lecaSem}학기</p>
					</div>
					<div class="icon" id="book">
						<i class="ion-ios-book"></i>
					</div>
					<a href="/lectureBoard/board/lectureBoard?lecaCd=${row.lecaCd}"
						class="small-box-footer">강의실 가기 <i
						class="fas fa-arrow-circle-right"></i></a>
				</div>
			</c:forEach>
<!-- 		이게 뭐지??	<tr> -->
<%-- 				<td class="dtr-control sorting_1" tabindex="0">${row.lecApply.lecaCd}</td> --%>
<!-- 				<td></td> -->
<!-- 				<td></td> -->
<!-- 				<td></td> -->
<%-- 				<td>${row.department.depNm}</td> --%>
<%-- 				<td>${row.employee.empNm}</td> --%>
<%-- 				<td>${row.lecApply.lecaCap}</td> --%>
<%-- 				<td>${row.lecApply.lecaCate}</td> --%>
<!-- 			</tr> -->

		</div>
	</div>
</body>
</html>
