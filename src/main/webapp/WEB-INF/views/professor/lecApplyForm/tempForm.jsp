<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의계획서 상세페이지</title>
<link rel="stylesheet" href="/resources/css/inquiry1.css">
<link rel="stylesheet" href="/resources/css/inquiry2.css">
</head>
<body>
	<div id="realFormBody">
	
	<span id="lecApplyTitle">강의계획서 상세</span>
	
	<div id="div4btns">
		<button id="tempUpdateBtn" type="button" class="btn btn-secondary">수정</button>
		<button id="tempDeleteBtn" type="button" class="btn btn-secondary">삭제</button>
		<button id="realSubmitBtn" type="button" class="btn btn-secondary">제출</button>
	</div>
	
	<br><br>
	
	<ul class="nav nav-pills nav-justified form-wizard-header mb-3"
	style="width:100%;margin-left:1px;">
        <li class="nav-item">
            <a id="firstLecApplyLi" href="#account-2" data-bs-toggle="tab" data-toggle="tab" class="nav-link rounded-0 pt-2 pb-2 active">
                <i class="mdi mdi-account-circle me-1"></i>
                <span class="d-none d-sm-inline">기본사항 작성</span>
            </a>
        </li>
        <li class="nav-item">
            <a id="secondLecApplyLi" href="#profile-tab-2" data-bs-toggle="tab" data-toggle="tab" class="nav-link rounded-0 pt-2 pb-2">
                <i class="mdi mdi-pencil"></i>
                <span class="d-none d-sm-inline">세부사항 작성</span>
            </a>
        </li>
        <li class="nav-item">
            <a id="thirdLecApplyLi" href="#finish-2" data-bs-toggle="tab" data-toggle="tab" class="nav-link rounded-0 pt-2 pb-2">
                <i class="mdi mdi-clock-time-nine-outline"></i>
                <span class="d-none d-sm-inline">시간표 선택</span>
            </a>
        </li>
    </ul>
	    
	<div id="blockNum1">
	    <p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;개인정보</p>
	    <table class="lecApplyTable" border="1">
	    	<tr>
	    		<th>담당교수</th>
	    		<td><input type="text" name="empNm" size=30 value="${professor.empNm }" disabled></td>
	    		<th>교수소속</th>
	    		<td><input type="text" name="empAddr1" size=30 value="${professor.empAddr1 }" disabled></td>
	    	</tr>
	    	<tr>
	    		<th>학과전화</th>
	    		<td><input type="text" name="depTel" size=30 value="${professor.depTel }" disabled></td>
	    		<th>교수전화</th>
	    		<td><input type="text" name="empTel" size=30 value="${professor.empTel }" disabled></td>
	    	</tr>
	    </table>
	    
	    <br><br>
	    <p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;강의 기본사항</p>
	    <table class="lecApplyTable" border="1" style="z-index: 9000;">
	    	<tr>
	    		<th>년도</th>
	    		<td>
	    			<select id="lecaYr"></select>
	    		</td>
	    		<th>학기</th>
	    		<td>
	    			<select id="lecaSem">
	    				<option value="">선택</option>
	    				<option value="1학기" <c:if test="${lecApplyList[0].lecaSem == '1학기'}">selected</c:if>>1학기</option>
	    				<option value="2학기" <c:if test="${lecApplyList[0].lecaSem == '2학기'}">selected</c:if>>2학기</option>
	    			</select>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>대상학년</th>
	    		<td>
	    			<select id="lecaTrg">
	    				<option value="">선택</option>
	    				<option value="1" <c:if test="${lecApplyList[0].lecaTrg == 1}">selected</c:if>>1학년</option>
	    				<option value="2" <c:if test="${lecApplyList[0].lecaTrg == 2}">selected</c:if>>2학년</option>
	    				<option value="3" <c:if test="${lecApplyList[0].lecaTrg == 3}">selected</c:if>>3학년</option>
	    				<option value="4" <c:if test="${lecApplyList[0].lecaTrg == 4}">selected</c:if>>4학년</option>
	    			</select>
	    		</td>
	    		<th>학점</th>
	    		<td>
	    			<select id="lecaCrd">
	    				<option value="">선택</option>
	    				<option value="1" <c:if test="${lecApplyList[0].lecaCrd == 1}">selected</c:if>>1학점</option>
	    				<option value="2" <c:if test="${lecApplyList[0].lecaCrd == 2}">selected</c:if>>2학점</option>
	    				<option value="3" <c:if test="${lecApplyList[0].lecaCrd == 3}">selected</c:if>>3학점</option>
	    			</select>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>강의명</th>
	    		<td>
	    			<input type="text" id="lecaNm" size=30 placeholder="강의명을 입력해주세요." value="${lecApplyList[0].lecaNm}">
	    		</td>
	    		<th>이수구분</th>
	    		<td>
	    			<select id="lecaCate">
	    				<option value="">선택</option>
	    				<option value="전공필수" <c:if test="${lecApplyList[0].lecaCate == '전공필수'}">selected</c:if>>전공필수(전필)</option>
	    				<option value="전공선택" <c:if test="${lecApplyList[0].lecaCate == '전공선택'}">selected</c:if>>전공선택(전선)</option>
	    				<option value="교양필수" <c:if test="${lecApplyList[0].lecaCate == '교양필수'}">selected</c:if>>교양필수(교필)</option>
	    				<option value="교양선택" <c:if test="${lecApplyList[0].lecaCate == '교양선택'}">selected</c:if>>교양선택(교선)</option>
	    			</select>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>과목 카테고리</th>
	    		<td>
		    		<select id="subNm">
	    				<option value="">선택</option>
	    				<c:forEach var="lecApply" items="lecApplyList">
	    				<option value="${lecApplyList[0].subNm}" <c:if test="${lecApplyList[0].subNm != ''}">selected</c:if>>${lecApplyList[0].subNm}</option>
	    				</c:forEach>
	    			</select>
	    		</td>
	    		<th>학수번호</th>
	    		<td>
	    			<input type="text" id="subCd" name="subCd" size=32 value="" readonly>
	    		</td>
	    	</tr>
	    </table>
	    
	    <div data-simplebar id="autoMaker" style="display:none; z-index:9001;"></div>
    </div>
    
    <div id="blockNum2">
    	<p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;강의 세부사항</p>
    	<table class="lecApplyTable" border="1" style="z-index: 9000;">
    		<tr>
	    		<th>수업개요</th>
	    		<td colspan="5">
	    			<textarea id="lecaCon" rows="3" cols="90">${lecApplyList[0].lecaCon}</textarea>
	    		</td>
	    	</tr>
    		<tr>
	    		<th>교재 및 <br>참고문헌</th>
	    		<td colspan="5">
	    			<textarea id="lecaBook" rows="3" cols="90">${lecApplyList[0].lecaBook}</textarea>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>성적평가방식</th>
	    		<td colspan="2">
	    			<select id="lecaGrade">
	    				<option value="1" <c:if test="${lecApplyList[0].lecaGrade == 'GRADE'}">selected</c:if>>GRADE</option>
	    				<option value="0" <c:if test="${lecApplyList[0].lecaGrade == 'PASS/FAIL'}">selected</c:if>>PASS/FAIL</option>
	    			</select>
	    		</td>
	    		<th>최대정원</th>
	    		<td colspan="2"><input type="text" id="lecaCap" name="lecaCap" size=5 value="${lecApplyList[0].lecaCap}">&nbsp;명&emsp;※&nbsp;사이버강의는 0입력</td>
	    	</tr>
	    	<tr>
	    		<th rowspan="2">평가방법(%)</th>
	    		<td style="width:116px; font-weight:bold; text-align:center;">중간고사</td>
	    		<td style="width:116px; font-weight:bold; text-align:center;">기말고사</td>
	    		<td style="width:116px; font-weight:bold; text-align:center;">과제</td>
	    		<td style="width:116px; font-weight:bold; text-align:center;">출결</td>
	    	</tr>
	    	<tr>
	    		<td style="width:116px; text-align:center;"><input type="text" id="lecaMp" value="${lecApplyList[0].lecaMp}" size=5>&nbsp;%</td>
	    		<td style="width:116px; text-align:center;"><input type="text" id="lecaFp" value="${lecApplyList[0].lecaFp}" size=5>&nbsp;%</td>
	    		<td style="width:116px; text-align:center;"><input type="text" id="lecaTp" value="${lecApplyList[0].lecaTp}" size=5>&nbsp;%</td>
	    		<td style="width:116px; text-align:center;"><input type="text" id="lecaAp" value="${lecApplyList[0].lecaAp}" size=5>&nbsp;%</td>
	    	</tr>
    	</table>
    	
    	<br><br>
	    
	    <p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;강의 계획</p>
	    <table id="lecWeekPlan" class="lecApplyTable" border="1" style="z-index: 9000;">
	    	<tr><th>1주차</th><td colspan="5"><textarea id="weekPlan1" rows="2" cols="90">${weekPlanList[0].wpCon}</textarea></td></tr>
	    	<tr><th>2주차</th><td colspan="5"><textarea id="weekPlan2" rows="2" cols="90">${weekPlanList[1].wpCon}</textarea></td></tr>
	    	<tr><th>3주차</th><td colspan="5"><textarea id="weekPlan3" rows="2" cols="90">${weekPlanList[2].wpCon}</textarea></td></tr>
	    	<tr><th>4주차</th><td colspan="5"><textarea id="weekPlan4" rows="2" cols="90">${weekPlanList[3].wpCon}</textarea></td></tr>
	    	<tr><th>5주차</th><td colspan="5"><textarea id="weekPlan5" rows="2" cols="90">${weekPlanList[4].wpCon}</textarea></td></tr>
	    	<tr><th>6주차</th><td colspan="5"><textarea id="weekPlan6" rows="2" cols="90">${weekPlanList[5].wpCon}</textarea></td></tr>
	    	<tr><th>7주차</th><td colspan="5"><textarea id="weekPlan7" rows="2" cols="90">${weekPlanList[6].wpCon}</textarea></td></tr>
	    	<tr><th>8주차</th><td colspan="5"><textarea id="weekPlan8" rows="2" cols="90">중간고사</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>9주차</th><td colspan="5"><textarea id="weekPlan9" rows="2" cols="90">${weekPlanList[8].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>10주차</th><td colspan="5"><textarea id="weekPlan10" rows="2" cols="90">${weekPlanList[9].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>11주차</th><td colspan="5"><textarea id="weekPlan11" rows="2" cols="90">${weekPlanList[10].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>12주차</th><td colspan="5"><textarea id="weekPlan12" rows="2" cols="90">${weekPlanList[11].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>13주차</th><td colspan="5"><textarea id="weekPlan13" rows="2" cols="90">${weekPlanList[12].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>14주차</th><td colspan="5"><textarea id="weekPlan14" rows="2" cols="90">${weekPlanList[13].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>15주차</th><td colspan="5"><textarea id="weekPlan15" rows="2" cols="90">${weekPlanList[14].wpCon}</textarea></td></tr>
	    	<tr class="switchTr" style="display:none;"><th>16주차</th><td colspan="5"><textarea id="weekPlan16" rows="2" cols="90">기말고사</textarea></td></tr>
	    </table>
	    <div class="d-grid">
		    <button type="button" id="showMoreTrs" class="btn btn-secondary" style="width:250px;">더 보기</button>
		    <button type="button" id="showLessTrs" class="btn btn-secondary" style="width:250px; display:none;">닫기</button>
		</div>
    </div>
    
    <div id="blockNum3">
    	<p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;시간표 선택</p>
    	
    	<div id="blockNum3TimeTable" style="float : left; width : 400px;">
    		<table id="timeTableChoice" border="1">
    			<tr><th style="width : 70px;"></th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th></tr>
    			<tr><th>1교시</th><td></td><td></td><td></td><td></td><td></td></tr>
    			<tr><th>2교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>3교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>4교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>5교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>6교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>7교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>8교시</th><td></td><td></td><td></td><td></td><td></td></tr>
   				<tr><th>9교시</th><td></td><td></td><td></td><td></td><td></td></tr>
    		</table>
		    <button type="button" id="timeTableBtn" class="btn btn-primary" style="width:250px; margin : 10px 65px;">시간 선택하기</button>
    	</div>
    	<div id="blockNum3Time" style="width : 400px; height : 300px;">
    		<p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;희망 시간
    		</p>
    		<textarea id="textArea4time" rows="5" cols="45" disabled>${lecApplyList[0].lecaTt}</textarea>
    		
    		<br><br>
    		
    		<p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;비고</p>
    		<textarea id="lecaNote" rows="9" cols="45">${lecApplyList[0].lecaNote}</textarea>
    	</div>
    </div>
    
    <div id="div4transitionBtns" style="clear : both;">
	    <button id="previousBtn" type="button" class="btn btn-primary">이전</button>
		<button id="nextBtn" type="button" class="btn btn-primary">다음</button>
	</div>
    
    </div>
</body>
<script type="text/javascript">

	//스프링 시큐리티를 위한 토큰 처리(csrf) -> 불토엔 큰 코스로 픽스!
	let header = "${_csrf.headerName}";
	let token = "${_csrf.token}";
	
	console.log("header : " + header + ", token : " + token);

	window.onload = function() {
		
		var date = new Date();
		let year = date.getFullYear();
		
		console.log("year : " + year);
		
		str = '<option value="'+ year + '">' + year + '년</option>';
		
		$("#lecaYr").append(str);
		
		//과목명 리스트 불러오기
		$.ajax({
			url : "/professor/lecApplyForm/getSubList",
			type : "POST",
			dataType : "JSON",
			contentType : "application/json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				let sub = $('#subNm').val();
				$('#subNm').html("");
				str = '';
				str += '<option value="">선택</option>'
					$.each(res, function (i, v) {
						str += '<option value=' + v.subNm + '>' + v.subNm + '</option>';
					});
				$('#subNm').append(str);
				$('#subNm').val(sub).prop("selected",true).trigger('change');
				
			}
		});
		
		let subNm2 = "";
		
		$("#subNm").on("change", function() {
			console.log("과목명 : " + $("#subNm").val());
			subNm2 = $("#subNm").val();
			
			//과목번호 리스트 불러오기
			$.ajax({
				url : "/professor/lecApplyForm/getSubCdList",
				type : "POST",
				data : JSON.stringify(subNm2),
				dataType : "JSON",
				contentType : "application/json;charset=utf-8",
				beforeSend: function (xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(res) {
					
					console.log("res : " + res);
					
					$('#subCd').val(res);
					
				}
			});
			
		});
		
		//더보기 버튼을 누르면
		$('#showMoreTrs').on('click', function() {
			$('.switchTr').show();
			
	    	$('#showMoreTrs').hide();
	    	$('#showLessTrs').show();
		});
		//닫기 버튼을 누르면
		$('#showLessTrs').on('click', function() {
			$('.switchTr').hide();
			
	    	$('#showLessTrs').hide();
	    	$('#showMoreTrs').show();
		});
		
		//시간표 드래그 이벤트/////////////////////////////////////////////////////////////////////////////
		
		var isMouseDown = false, isHighlighted;
		
		$('#timeTableChoice td')
		.mousedown(function() {
			isMouseDown = true;
			$(this).toggleClass("highlighted");
			
			isHighlighted = $(this).hasClass("highlighted")
			
			return false;
		})
		.mouseover(function() {
			if(isMouseDown) {
				$(this).toggleClass("highlighted", isHighlighted);
			}
		})
		.bind("selectstart", function() {
			return false;
		});
		
		$(document)
		.mouseup(function() {
			isMouseDown = false;
		});
		
		//블록 클릭 시 div 변경 이벤트////////////////////////////////////////////////////////////////////////////
		if($('#firstLecApplyLi').hasClass("active")) {
			$('#blockNum1').show();
			$('#blockNum2').hide();
			$('#blockNum3').hide();
			$('#previousBtn').attr('disabled', true);
			$('#nextBtn').attr('disabled', false);
		}else if($('#secondLecApplyLi').hasClass("active")) {
			$('#blockNum1').hide();
			$('#blockNum2').show();
			$('#blockNum3').hide();
			$('#previousBtn').attr('disabled', false);
			$('#nextBtn').attr('disabled', false);
		}else if($('#thirdLecApplyLi').hasClass("active")) {
			$('#blockNum1').hide();
			$('#blockNum2').hide();
			$('#blockNum3').show();
			$('#previousBtn').attr('disabled', false);
			$('#nextBtn').attr('disabled', true);
		}
		
		$('#firstLecApplyLi').on('click', function() {
			$('#blockNum1').show();
			$('#blockNum2').hide();
			$('#blockNum3').hide();
			$('#previousBtn').attr('disabled', true);
			$('#nextBtn').attr('disabled', false);
		});
		$('#secondLecApplyLi').on('click', function() {
			$('#blockNum1').hide();
			$('#blockNum2').show();
			$('#blockNum3').hide();
			$('#previousBtn').attr('disabled', false);
			$('#nextBtn').attr('disabled', false);
		});
		$('#thirdLecApplyLi').on('click', function() {
			$('#blockNum1').hide();
			$('#blockNum2').hide();
			$('#blockNum3').show();
			$('#previousBtn').attr('disabled', false);
			$('#nextBtn').attr('disabled', true);
		});
		//////////////////////////////////////////////////////////////////////
		$('#previousBtn').on('click', function() {
			if($('#secondLecApplyLi').hasClass("active")) {
				$('#firstLecApplyLi').trigger('click');
			}else if($('#thirdLecApplyLi').hasClass("active")) {
				$('#secondLecApplyLi').trigger('click');
			}
		});
		$('#nextBtn').on('click', function() {
			if($('#firstLecApplyLi').hasClass("active")) {
				$('#secondLecApplyLi').trigger('click');
			}else if($('#secondLecApplyLi').hasClass("active")) {
				$('#thirdLecApplyLi').trigger('click');
			}
		});
		
		$('#timeTableBtn').on('click', function() {
			
			$('#textArea4time').empty();
			
			timeTable = $('#timeTableChoice');
			
			str = '';
			
			for(j = 0; j <= 4; j++) {
				for(i = 1; i <= 9; i++) {
					cellObj = timeTable.find("tr").eq(i).find("td").eq(j);
					
					if(cellObj.hasClass("highlighted")) {
						
						if(j == 0) {
							str += "월 " + i + "교시\n";
						}else if(j == 1) {
							str += "화 " + i + "교시\n";
						}else if(j == 2) {
							str += "수 " + i + "교시\n";
						}else if(j == 3) {
							str += "목 " + i + "교시\n";
						}else if(j == 4) {
							str += "금 " + i + "교시\n";
						}
					}
				}
			}
			//alert(str);
			$('#textArea4time').append(str);
		});
		
		//수정하기 버튼 클릭 시
		$('#tempUpdateBtn').on('click', function() {
			let u_lecaCd = '${lecApplyList[0].lecaCd}';
			var weekPlan = [];
			
			for(let i=1; i<=16; i++){
				weekPlan.push({wpNo : i,lecaCd : u_lecaCd, wpCon : $('#weekPlan'+i).val()})
			}
			
			if(!confirm("해당 강의계획서를 수정하시겠습니까?")) {
				alert("취소되었습니다.");
			}else {
				let dataObject = {
						lecaCd : '${lecApplyList[0].lecaCd}',
						lecaYr : $('#lecaYr').val(),
						lecaSem : $('#lecaSem').val(),
						lecaNm : $('#lecaNm').val(),
						lecaCon : $('#lecaCon').val(),
						lecaTrg : $('#lecaTrg').val(),
						lecaCrd : $('#lecaCrd').val(),
						subNm : $('#subNm').val(),
						subCd : $('#subCd').val(),
						lecaCap : $('#lecaCap').val(),
						lecaBook : $('#lecaBook').val(),
						lecaCate : $('#lecaCate').val(),
						lecaGrade : $('#lecaGrade').val(),
						lecaTt : $("#textArea4time").val(),
						lecaMp : $('#lecaMp').val(),
						lecaFp : $('#lecaFp').val(),
						lecaTp : $('#lecaTp').val(),
						lecaAp : $('#lecaAp').val(),
						weekPlanList : weekPlan,
						lecaNote : $('#lecaNote').val()
				}
				
				$.ajax({
					url : "/professor/lecApplyForm/temporaryUpdate",
					type : "POST",
					data : JSON.stringify(dataObject),
					dataType : "JSON",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(header, token);
					},
					contentType : "application/json;charset=utf-8",
					success : function(res) {
						
// 						alert(res);
						
						if(res > 0) {
							alert("수정이 완료되었습니다.");
						}else {
							alert("다시 시도해주세요.");
						}
						opener.parent.location.reload();
						window.close();
					}
				});//ajax
			}//else
		});//버튼 클릭 이벤트
		
		//삭제하기 버튼 클릭 시 
		$('#tempDeleteBtn').on('click', function() {
			
			if(!confirm("해당 강의계획서를 삭제하시겠습니까?")) {
				alert("취소되었습니다.");
			}else {
				
				let delObject = {
						lecaCd : '${lecApplyList[0].lecaCd}'
				};
				
				console.log("데이타 코드 제발 와랑툐~ : " + JSON.stringify(delObject));
				
				$.ajax({
					url : "/professor/lecApplyForm/temporaryDelete",
					type : "POST",
					data : delObject,
					dataType : "JSON",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(header, token);
					},
					success : function(res) {
						if(res > 0) {
							alert("삭제가 완료되었습니다.");
						}else {
							alert("다시 시도해주세요.");
						}
						opener.parent.location.reload();
						window.close();
					}
				});
			}
		});
		
		//제출하기 버튼 클릭 시
		$('#realSubmitBtn').on('click', function() {
			
			let u_lecaCd = '${lecApplyList[0].lecaCd}';
			var weekPlan = [];
			
			for(let i=1; i<=16; i++){
				weekPlan.push({wpNo : i,lecaCd : u_lecaCd, wpCon : $('#weekPlan'+i).val()})
			}
			
			if(!confirm("해당 강의계획서를 제출하시겠습니까?")) {
				alert("취소되었습니다.");
			}else {
				let dataObject = {
						lecaCd : '${lecApplyList[0].lecaCd}',
						lecaYr : $('#lecaYr').val(),
						lecaSem : $('#lecaSem').val(),
						lecaNm : $('#lecaNm').val(),
						lecaCon : $('#lecaCon').val(),
						lecaTrg : $('#lecaTrg').val(),
						lecaCrd : $('#lecaCrd').val(),
						subNm : $('#subNm').val(),
						subCd : $('#subCd').val(),
						lecaCap : $('#lecaCap').val(),
						lecaBook : $('#lecaBook').val(),
						lecaCate : $('#lecaCate').val(),
						lecaGrade : $('#lecaGrade').val(),
						lecaTt : $("#textArea4time").val(),
						lecaMp : $('#lecaMp').val(),
						lecaFp : $('#lecaFp').val(),
						lecaTp : $('#lecaTp').val(),
						lecaAp : $('#lecaAp').val(),
						weekPlanList : weekPlan,
						lecaNote : $('#lecaNote').val()
					}
					
					$.ajax({
						url : "/professor/lecApplyForm/tempLecApplySubmit",
						type : "POST",
						data : JSON.stringify(dataObject),
						dataType : "JSON",
						beforeSend: function (xhr) {
							xhr.setRequestHeader(header, token);
						},
						contentType : "application/json;charset=utf-8",
						success : function(res) {
							
							if(res > -5) {
								alert("제출이 완료되었습니다.");
							}else {
								alert("다시 시도해주세요.");
							}
							opener.parent.location.reload();
							window.close();
						}
					});//ajax
			}
		});
		
	}
	
</script>
</html>