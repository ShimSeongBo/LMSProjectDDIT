<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 정보</title>

<script type="text/javascript" src="/resources/js/tui-grid.js"></script>
<script type="text/javascript" src="/resources/js/spinner.js"></script>
<link rel="stylesheet" href="/resources/css/tui-grid.css" type="text/css">
<link rel="stylesheet" href="/resources/css/topTable.css" type="text/css">
<style type="text/css">
#tgradeTable {
	width : 100%;
	height : 70px;
	border : 1px solid lightgray;
	border-collapse: collapse;
	text-align : center;
	background-color: white;
}
#tgradeTable td, #tgradeTable th{
	padding-top : 5px;
	padding-bottom : 5px;
}
#tgradeTable tr:first-child, #tgradeTable tr:nth-child(2){
	background : rgb(244,247,253);
	color : black;
}
#tgradeListRound{
	width : 100%;
}
#tgradeListSelect{
	display:inline-block;
	margin-left : 2%;
}
</style>
</head>
<script type="text/javascript" defer="defer">
let header = "${_csrf.headerName}";
let token = "${_csrf.token}";
	var memFnm;

	//성적 건수 가져오기
	function getCnt(yrNsem) {
		
		yrNsem = $(yrNsem).val();
		console.log("뭐임? ",yrNsem);
		
		let dataObject = {
			yrNsem : yrNsem
		};
		
		$.ajax({
			url : "/totalScore/getCnt",
			type : "POST",
			data : JSON.stringify(dataObject),
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			dataType : "JSON",
			success : function(res) {

				$("#cntSpan").text(res);
			}
		});
	}

	function getListAgain(yrNsem) {
		
		yrNsem = $(yrNsem).val();
		
		let dataObject = {
			yrNsem : yrNsem
		};
		
		$.ajax({
			url : "/tgrade/getListAgain",
			type : "POST",
			data : JSON.stringify(dataObject),
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			dataType : "JSON",
			success : function(res) {
				
				//그리드 비우고 다시 불러오기
				$('#grid').empty();
				
				grid = new tui.Grid({
					el : document.getElementById('grid'),
					data : res,
					scrollX : true,
					scrollY : true,
					bodyHeight : 250,
					columns : [
						{header : '년도/학기', filter : 'select', name : 'lecaCon', align : 'center'},
						{header : '과목번호', filter : 'select', name : 'subCd', align : 'center'},
						{header : '교과목명', filter : 'select', name : 'lecaNm'},
						{header : '이수구분', filter : 'select', name : 'lecaCate', align : 'center'},
						{header : '학점', filter : 'select', name : 'lecaCrd', align : 'center'},
						{header : '성적평가', filter : 'select', name : 'lecaGrade', align : 'center'},
						{header : '등급', filter : 'select', name : 'lecaNote', align : 'center'},
						{header : '평점', filter : 'select', name : 'lecaRoom', align : 'center'}
					],
					columnOptions : {
						resizable : true
					}
				});
			}
		});
	}
	
	window.onload = function() {
		
		//로딩중 화면 띄우기
// 		loadingWithMask();
// 		setTimeout(closeLoadingWithMask, 2000);
		
		//성적 건수 가져오기
		getCnt();
		
		//개인정보 가져오기
		$.ajax({
			url : "/totalScore/getInfo",
			type : "POST",
			dataType : "JSON",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				//학번(memCd), 이름(memNm), 생년월일(stuBir), 연락처(stuTel),
				//단과대학/전공(memNme), 입학정보(memAddr1), 변동(memAddr2), 수강신청학년(memMl)
				$('#stuNo').val(res.stuNo);
				$('#stuNm').val(res.stuNm);
				$('#stuBir').val(res.stuBir);
				$('#stuTel').val(res.stuTel);
				$('#depNm').val(res.depNm);
				$('#stuRgb').val(res.stuRgb);
				$('#stuSem').val(res.stuSem);
				$('#yrNsem').val(res.stuYr);
				
				stuPic = res.stuPic;
			}
		});
		
		//년도 및 학기 불러오기
		$.ajax({
			url : "/totalScore/getYrAndSem",
			type : "GET",
			dataType : "JSON",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				str = '';
				
				$.each(res, function(i, v) {
					str += '<option value="'+ v.lecaYr + v.lecaSem + '">' + v.lecaYr + '/' + v.lecaSem + '학기</option>';
				});
				
				$('#cateYrNSem').append(str);
			}
		});
		
		//전체 성적 불러오기
		$.ajax({
			url : "/tgrade/getList",
			type : "POST",
			dataType : "JSON",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(res) {
				
				grid = new tui.Grid({
					el : document.getElementById('grid'),
					data : res,
					scrollX : true,
					scrollY : true,
					bodyHeight : 250,
					columns : [
						{header : '년도/학기', filter : 'select', name : 'lecaCon', align : 'center'},
						{header : '과목번호', filter : 'select', name : 'subCd', align : 'center'},
						{header : '교과목명', filter : 'select', name : 'lecaNm'},
						{header : '이수구분', filter : 'select', name : 'lecaCate', align : 'center'},
						{header : '학점', filter : 'select', name : 'lecaCrd', align : 'center'},
						{header : '성적평가', filter : 'select', name : 'lecaGrade', align : 'center'},
						{header : '등급', filter : 'select', name : 'lecaNote', align : 'center'},
						{header : '평점', filter : 'select', name : 'lecaRoom', align : 'center'}
					],
					columnOptions : {
						resizable : true
					}
				});
			}
		});
		
		//백분율환산기준표 띄우기
		//percentageTable
		$('#percentageTable').on('click', function() {
			window.open("/tgrade/crdStandardPdf");
		});
		
		//사진 띄우기
		$('#photoBtn').on('click', function() {
			
			//memFnm : 이미지 이름.확장자
			if(memFnm == null) {
				alert("등록된 사진이 없습니다.");
			}else {
				
				const img = new Image();
				img.src = "/resources/profileImg/" + memFnm;
				console.log("width : " + img.width + ", height : " + img.height);
				
				window.open(
						"/tgrade/getPhoto?memFnm=" + memFnm,
						"photo",
						"width = 175, height = 210, left = 300, top = 150, history = no, resizable = no, status = no, scrollbars = yes, menubar = no"
				);
			}
		});
	}
</script>
<body>
<div id="tgradeListRound">
	<div>
    	<i class="mdi mdi-home" style="font-size: 1.3em"></i> <i class="dripicons-chevron-right"></i> 성적 <i class="dripicons-chevron-right"></i> <span style="font-weight: bold;">전체 성적 조회</span>
  	</div>
  	
  	<br>
  	
  	<table id="stuInfoTable">
  		<tr>
			<td colspan="9" style="background: #F3F8FF; height: 10px;"></td>
		</tr>
		<tr>
			<th>학번</th>
			<td>
				<input type="text" class="infoText" name="stuNo" id="stuNo" readonly="readonly" style="width:50%;">
				<button type="button" class="btn btn-secondary photoBtn" id="photoBtn">
					<p class="photoP">사진</p>
				</button>
			</td>
			<th>성명</th>
			<td>
				<input type="text" class="infoText" name="stuNm" id="stuNm" readonly="readonly">
			</td>
			<th>학적</th>
			<td>
				<input type="text" class="infoText" name="stuRgb" id="stuRgb" readonly="readonly">
			</td>
			<th>연락처</th>
			<td>
				<input type="text" class="infoText" name="stuTel" id="stuTel" readonly="readonly">
			</td>
			<th></th>
		</tr>
		<tr>
			<td colspan="9" style="background: #F3F8FF; height: 5px;"></td>
		</tr>
		<tr>
			<th>소속</th>
			<td>
				<input type="text" class="infoText" name="depNm" id="depNm" readonly="readonly">
			</td>
			<th>학년</th>
			<td>
				<input type="text" class="infoText" name="yrNsem" id="yrNsem" readonly="readonly">
			</td>
			<th>학기</th>
			<td>
				<input type="text" class="infoText" name="stuSem" id="stuSem" readonly="readonly">
			</td>
			<th>생년월일</th>
			<td>
				<input type="text" class="infoText" name="stuBir" id="stuBir" readonly="readonly">
			</td>
			<th></th>
		</tr>
		<tr>
			<td colspan="9" style="background: #F3F8FF; height: 10px;"></td>
		</tr>
  	</table>

	<br><br>
	
	<i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;취득성적
	<button type="button" class="btn btn-secondary" id="percentageTable">백분율환산기준표</button>
	
	<p id="tellCnt">
		[총 <span id="cntSpan"></span>건]
	</p>
	
	<br><br>
	
	<div id="tgradeYellowBox" style="height:47px;">
		<label>년도/학기
			<select name="cateYrNSem" id="cateYrNSem" onchange="javascript:getListAgain(this);getCnt(this);">
				<option value="">전체</option>
			</select>
		</label>
		<span id="tgradeGreenText">&emsp;<i class="mdi mdi-square-medium"></i>&nbsp;현재 학기 성적은 조회할 수 없습니다.</span>
	</div>
	
	<br>
	
	<div id="grid"></div>
	
	<br>
	
	<p class="tgradePreListSelect"><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;집계정보</p>
	<table id="tgradeTable" border="1">
		<tr>
			<th colspan="2"></th>
			<th colspan="5">교양영역</th>
			<th colspan="5">전공영역</th>
		</tr>
		<tr>
			<td>신청학점</td>
			<td>취득학점</td>
			<td>교필</td>
			<td>교선</td>
			<td>소계</td>
			<td>평점 계</td>
			<td>평균 평점</td>
			<td>전필</td>
			<td>전선</td>
			<td>소계</td>
			<td>평점 계</td>
			<td>평균 평점</td>
		</tr>
		<tr>
			<td>${totalCnt}</td>
			<td>${tgrade.GP + tgrade.GS + tgrade.JP + tgrade.JS}</td>
			<td>${tgrade.GP}</td>
			<td>${tgrade.GS}</td>
			<td>${tgrade.GCNT}</td>
			<td>${tgrade.GSUM}</td>
			<td>${tgrade.GDIV}</td>
			<td>${tgrade.JP}</td>
			<td>${tgrade.JS}</td>
			<td>${tgrade.JCNT}</td>
			<td>${tgrade.JSUM}</td>
			<td>${tgrade.JDIV}</td>
		</tr>
	</table>
	</div>
	
	<br>
</body>
</html>