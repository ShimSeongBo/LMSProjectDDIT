<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <div class="card" style="position: relative; left: 0px; top: 0px;border-top:0;"> -->
<div class="card-header ui-sortable-handle" style="cursor: move;">
<h1 class="card-title font-weight-bold text-monospace">
중점지표
<i class="fas fa-chart-bar"></i>
</h1>
<div class="card-tools">
<ul class="nav nav-pills ml-auto">
<li class="nav-item">
<a class="nav-link active" href="#chart1" data-toggle="tab">등록비율</a>
</li>
<li class="nav-item">
<a class="nav-link" href="#chart2" data-toggle="tab">재적현황</a>
</li>
<li class="nav-item">
<a class="nav-link" href="#chart3" data-toggle="tab">강의평가</a>
</li>
</ul>
</div>
</div>
<div class="card-body">
<div class="tab-content p-0">

<div class="chart tab-pane active" id="chart1" style="position: relative; ">
<div class="row">
	<div class="form-group col-2">
		<select id="yr" class="select2bs4 form-control bg-gradient-info select2-hidden-accessible rc" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="college" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible rc" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-7 pl-0">
		<div id="recruitmentRate" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
</div>

<div class="chart tab-pane" id="chart2" style="position: relative;">
<div class="row">
	<div class="form-group col-2">
		<select id="yrSt" class="select2bs4 form-control bg-gradient-info  select2-hidden-accessible st" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="collegeSt" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible st" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-7 pl-0">
		<div id="recordState" class="p-0 m-0" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
</div>

<div class="chart tab-pane" id="chart3" style="position: relative;">
<div class="row">
	<div class="form-group col-2">
		<select id="yrAv" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible av" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2 ">
		<select id="semAv" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible av" style="width: 100%;color:white;" aria-hidden="true">
			<option value="">학기</option>
			<option value="1학기">1학기</option>
			<option value="2학기">2학기</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="collegeAv" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible av" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="departmentAv" class="select2bs4 form-control bg-gradient-info   select2-hidden-accessible av" style="width: 100%;color:white;" aria-hidden="true">
			<option value="0">학과</option>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-8 pl-0">
		<div id="evaluation" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
</div>

</div>
</div>
<!-- </div> -->

<div class="row mt-3">
	<label>단과대학별 중점지표</label>
</div>
<div class="row">
	<div class="form-group col-2 pl-0">
		<select id="yr" class="select2bs4 form-control  select2-hidden-accessible rc" style="width: 100%;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="college" class="select2bs4 form-control select2-hidden-accessible rc" style="width: 100%;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-7 pl-0">
		<div id="recruitmentRate" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
<div class="row">
	<label>재적상태현황</label>
</div>
<div class="row">
	<div class="form-group col-2 pl-0">
		<select id="yrSt" class="select2bs4 form-control  select2-hidden-accessible st" style="width: 100%;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2 pl-0">
		<select id="collegeSt" class="select2bs4 form-control  select2-hidden-accessible st" style="width: 100%;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-7 pl-0">
		<div id="recordState" class="p-0 m-0" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
<div class="row">
	<label>전체교원 강의평가</label>
</div>
<div class="row">
	<div class="form-group col-2 pl-0">
		<select id="yrAv" class="select2bs4 form-control  select2-hidden-accessible av" style="width: 100%;" aria-hidden="true">
			<option value="0">연도</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
			<option value="2022">2022</option>
		</select>
	</div>
	<div class="form-group col-2 ">
		<select id="semAv" class="select2bs4 form-control  select2-hidden-accessible av" style="width: 100%;" aria-hidden="true">
			<option value="">학기</option>
			<option value="1학기">1학기</option>
			<option value="2학기">2학기</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="collegeAv" class="select2bs4 form-control  select2-hidden-accessible av" style="width: 100%;" aria-hidden="true">
			<option value="0">단과대학</option>
			<c:forEach var="college" items="${collegeList}">
				<option value="${college.colCd}">${college.colNm}</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="departmentAv" class="select2bs4 form-control  select2-hidden-accessible av" style="width: 100%;" aria-hidden="true">
			<option value="0">학과</option>
		</select>
	</div>
</div>
<div class="row">
	<div class="col-8 pl-0">
		<div id="evaluation" style="width: 1200px; height: 600px;"></div>
	</div>
</div>
<script src="/resources/adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/adminlte/plugins/select2/js/select2.full.min.js"></script>
<script src="/resources/adminlte/dist/js/demo.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	$(function() {

		$('.select2').select2();
		//Initialize Select2 Elements
		$('.select2bs4').select2({
			theme : 'bootstrap4'
		});

		$(".rc").on("change", function() {
			recruitmentRateChart();
		});

		$(".st").on("change", function() {
			recordStateChart();
		});

		$(".av").on("change", function() {
			if (this.id == "collegeAv") {
				departmentByCollege.call(this, "departmentAv");
			}
			evaluationChart();
		});

	});

	function departmentByCollege(p_id) {
		let data = {
			colCd : this.value
		};

		$
				.ajax({
					url : "/ketIndicators/departmentByCollege",
					type : "get",
					data : data,
					contentType : "application/json;utf-8",
					success : function(result) {
						let str = "";
						console.log(result);
						if (!result.length) {
							str += "<option value='0'>학과</option>";
							str += "<option value='0'>학과가 없습니다</option>";
						} else {
							str += "<option value='0'>학과</option>";
							$
									.each(
											result,
											function(p_inx, p_val) {
												str += `<option value='\${p_val.depCd}'>\${p_val.depNm}</option>`;
											});
						}
						$("#" + p_id).html(str);
					}
				});
	}

	google.charts.load('current', {
		'packages' : [ 'corechart', 'bar' ]
	});
	google.charts.setOnLoadCallback(recruitmentRateChart);
	google.charts.setOnLoadCallback(recordStateChart);
	google.charts.setOnLoadCallback(evaluationChart);

	function recruitmentRateChart() {

		// 2차원배열 [[차트이름, 범례1, 범례2]
		//		,[행명, 데이터1, 데이터2]
		//		,[행명, 데이터1, 데이터2]]

		let colCd = $("#college").val();
		let ajaxData = {
			yr : $("#yr").val(),
			colCd : colCd
		}

		$
				.ajax({
					url : "/ketIndicators/recruitmentRateChart",
					type : "get",
					data : ajaxData,
					success : function(result) {
						let data = new google.visualization.DataTable();
						data.addColumn("string", "신입생 충원율");
						data.addColumn("number", "입학생");
						data.addColumn("number", "미달");
						let arr = [];
						$
								.each(
										result,
										function(p_inx, keyIndicator) {
											if (colCd == 0) {
												arr
														.push([
																keyIndicator.colNm,
																keyIndicator.recruitmentRate,
																keyIndicator.capacity
																		- keyIndicator.recruitmentRate == 0 ? 1
																		: keyIndicator.capacity
																				- keyIndicator.recruitmentRate ]);
												return;
											}
											arr
													.push([
															keyIndicator.depNm,
															keyIndicator.recruitmentRate,
															keyIndicator.capacity
																	- keyIndicator.recruitmentRate == 0 ? 1
																	: keyIndicator.capacity
																			- keyIndicator.recruitmentRate ]);

										});
						data.addRows(arr);

						var options_fullStacked = {
							isStacked : 'percent',
							colors : [ "#FF8200", "#dcdcdc" ],
							height : 600,
							legend : {
								position : 'top',
								maxLines : 4
							},
							hAxis : {
								minValue : 0,
								ticks : [ 0, .25, .5, .75, 1 ]
							},
							animation : {
								duration : 1000,
								easing : 'out',
								startup : true
							}
						};
						var view = new google.visualization.DataView(data);
						view.setColumns([ 1 ]);
						recruitChart = new google.visualization.BarChart(
								document.getElementById('recruitmentRate'));
						recruitChart.draw(data, options_fullStacked);
					}// end success
				})// end ajax
	}// end function 

	function recordStateChart() {

		let colCd = $("#collegeSt").val()
		let ajaxData = {
			yr : $("#yrSt").val(),
			colCd : colCd
		}

		$
				.ajax({
					url : "/ketIndicators/recordStateChart",
					type : "get",
					data : ajaxData,
					success : function(result) {
						console.log(result);
						let data = new google.visualization.DataTable();
						data.addColumn("string", "학생 학적현황");
						data.addColumn("number", "총학생");
						data.addColumn("number", "재학");
						data.addColumn("number", "휴학");
						data.addColumn("number", "제적");
						data.addColumn("number", "졸업");
						let arr = [];
						let maxData = 1; // 차트 렌더링시 max에 맞춰서 랜더링

						for (let i = 0; i < result.length; i++) {
							if (maxData < result[i].allStu) {
								maxData = result[i].allStu;
							}
						}

						$
								.each(
										result,
										function(p_inx, keyIndicator) {
											if (colCd == 0) {
												arr
														.push([
																keyIndicator.colNm,
																keyIndicator.allStu == 0 ? maxData * 0.02
																		: keyIndicator.allStu,
																keyIndicator.inSchool == 0 ? maxData * 0.02
																		: keyIndicator.inSchool,
																keyIndicator.leaveOfAbsence == 0 ? maxData * 0.02
																		: keyIndicator.leaveOfAbsence,
																keyIndicator.expelled == 0 ? maxData * 0.02
																		: keyIndicator.expelled,
																keyIndicator.graduate == 0 ? maxData * 0.02
																		: keyIndicator.graduate ]);
												return;
											}
											arr
													.push([
															keyIndicator.depNm,
															keyIndicator.allStu == 0 ? maxData * 0.02
																	: keyIndicator.allStu,
															keyIndicator.inSchool == 0 ? maxData * 0.02
																	: keyIndicator.inSchool,
															keyIndicator.leaveOfAbsence == 0 ? maxData * 0.02
																	: keyIndicator.leaveOfAbsence,
															keyIndicator.expelled == 0 ? maxData * 0.02
																	: keyIndicator.expelled,
															keyIndicator.graduate == 0 ? maxData * 0.02
																	: keyIndicator.graduate ]);

										});
						data.addRows(arr);
						var options = {
							height:600,
							colors : [ "#34314c", "#47b8e0", "#ffc952",
									"#ff7473", "#a5d296", "#addeea" ],
							vAxis : {
								viewWindow : {
									max : maxData * 1.2,
									min : 0
								}
							},
							animation : {
								duration : 1000,
								easing : 'out',
								startup : "true"
							},
						};

						var chart = new google.visualization.ColumnChart(
								document.getElementById('recordState'));
						chart.draw(data, options);
					}// end success
				}); // end ajax
	}// end function

	function evaluationChart() {

		let colCd = $("#collegeAv").val();
		let depCd = $("#departmentAv").val();

		let ajaxData = {
			yr : $("#yrAv").val(),
			sem : $("#semAv").val(),
			colCd : colCd,
			depCd : depCd
		}

		$.ajax({
			url : "/ketIndicators/evaluationChart",
			type : "get",
			data : ajaxData,
			success : function(result) {
				console.log("evaluationChart : ", result);
				let data = new google.visualization.DataTable();
				data.addColumn("string", "강의평가 평점평균");
				data.addColumn("number", "평균점수");
				let arr = [];
				$.each(result, function(p_inx, keyIndicator) {
					if (colCd == 0) {
						arr.push([
								keyIndicator.colNm,
								keyIndicator.evlRate == 0 ? 0.1
										: keyIndicator.evlRate ]);
						return;
					} else if (colCd != 0 && depCd == 0) {
						arr.push([
								keyIndicator.depNm,
								keyIndicator.evlRate == 0 ? 0.1
										: keyIndicator.evlRate ]);
						return;
					}
					arr.push([
							keyIndicator.empNm,
							keyIndicator.evlRate == 0 ? 0.1
									: keyIndicator.evlRate ]);
				});

				data.addRows(arr);

				var options = {
						height:600,
					hAxis : {
						maxValue : 4.5
					},
					legend : {
						position : "top",
						maxLines : 4
					},
					animation : {
						duration : 1000,
						easing : 'out',
						startup : true
					}
				};
				var chart = new google.visualization.BarChart(document
						.getElementById("evaluation"));
				chart.draw(data, options);
			}
		});
	}
</script>