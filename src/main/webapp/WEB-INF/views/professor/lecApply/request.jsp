<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의계획서 신청</title>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
	<div>
    	<i class="mdi mdi-home" style="font-size: 1.3em"></i> <i class="dripicons-chevron-right"></i> 강의개설관리 <i class="dripicons-chevron-right"></i> <span style="font-weight: bold;">강의계획서 신청</span>
  	</div>
  	<div class="row" id="keywardBox">
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="교번" id="proNo" name="proNo" readonly="readonly">
		</div>
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="성명" id="empNm" name="empNm" readonly="readonly">
		</div>
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="연락처" id="empTel" name="empTel" readonly="readonly">
		</div>
	</div>
  	<div class="row" id="keywardBox">
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="소속" id="depNm" name="depNm" readonly="readonly">
		</div>
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="직책" id="proPos" name="proPos" readonly="readonly">
		</div>
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="재직상태" id="empRet" name="empRet" readonly="readonly">
		</div>
	  	<div class="col-2">
			<input type="text" class="form-control" placeholder="생년월일" id="empReg" name="empReg" readonly="readonly">
		</div>
		<sec:csrfInput/>
	</div>
	
	<br>
	
	<i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;임시저장된 강의계획서 조회
	<button type="button" class="btn btn-primary" id="newLecApplyBtn">신규강의계획서 작성</button>
	<p id="tellCnt">
		[총 <span id="cntSpan"></span>건]
	</p>
	
	<br>
	
	<!-- 임시저장 계획서 리스트 -->
	<div class="card">
	<div class="card-body">
		<div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">
				<div class="col-sm-12">
					<table id="example1"
						class="table table-bordered table-striped dataTable dtr-inline"
						aria-describedby="example1_info">
						<thead>
							<tr>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Rendering engine: activate to sort column ascending"
									cursorshover="true">년도/학기</th>
								<th class="sorting sorting_desc" tabindex="0"
									aria-controls="example1" rowspan="1" colspan="1"
									aria-label="Browser: activate to sort column ascending"
									cursorshover="true" aria-sort="descending">학년</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Platform(s): activate to sort column ascending"
									cursorshover="true">과목번호</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Engine version: activate to sort column ascending"
									cursorshover="true">과목명</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">개설이수구분</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">학점</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">성적평가방식</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">저장일시</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">자세히보기</th>
							</tr>
						</thead>
						<tbody id="proList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>


</body>
<script type="text/javascript" defer="defer">
	window.onload = function () {
		console.log("여기까지 오긴하냐?");

		//스프링 시큐리티를 위한 토큰 처리(csrf) -> 불토엔 큰 코스로 픽스!
		let header = "${_csrf.headerName}";
		let token = "${_csrf.token}";

		console.log("header : " + header + ", token : " + token);

		//교수 개인정보 가져오기
		$.ajax({
			url: "/professor/lecApply/proInfo",
			type: "POST",
			dataType: "JSON",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function (data) {
				console.log("이건 오냐?");
				$('#proNo').val(data.proNo);
				$('#empNm').val(data.empNm);
				$('#empTel').val(data.empTel);
				$('#proPos').val(data.proPos);
				$('#depNm').val(data.depNm);
				$('#empRet').val(data.empRet);
				$('#empReg').val(data.empReg);
				
			}
		});
		
		//임시저장 강의계획서 리스트 가져오기
// 		$.ajax({
// 			url : "/lecApply/getTempList",
// 			type : "POST",
// 			contentType : "application/json;charset=utf-8",
// 			dataType : "JSON",
// 			success : function(res) {
				
// 				$.each(res, function(i,v){
// 					res[i]['btn'] = '<button class="btn btn-outline-secondary btn-sm" style="font-family:Nunito,sans-serif;" onclick="getTempSyllabus(' + v.lecaCd + ')">강의계획서</button>';
// 				});
				
// 				grid = new tui.Grid({
// 					el : document.getElementById('grid'),
// 					data : res,
// 					scrollX : true,
// 					scrollY : true,
// 					bodyHeight : 380,
// 					columns : [
// 						{header : '년도/학기', name : 'lecaCon', filter : 'select', width : 150, align : 'center'},
// 						{header : '학년', name : 'lecaTrg', filter : 'select', width : 70, align : 'center'},
// 						{header : '과목번호', name : 'subCd', filter : 'select', width : 100, align : 'center'},
// 						{header : '과목명', name : 'lecaNm', filter : 'select'},
// 						{header : '개설이수구분', name : 'lecaCate', width : 100, align : 'center'},
// 						{header : '학점', name : 'lecaCrd', width : 50, align : 'center'},
// 						{header : '성적평가방식', name : 'lecaGrade', width : 100, align : 'center'},
// 						{header : '저장일시', name : 'lecaRoom', filter : 'select'},
// 						{header : '자세히 보기', name : 'btn', width : 120, align : 'center'}
// 					],
// 					columnOptions: {
// 				        resizable: true
// 				    }
// 				});
// 			}
// 		});
		
	}
	//신규강의계획서 작성 버튼 클릭 이벤트
	$('#newLecApplyBtn').on('click', function() {
		window.open("/professor/lecApplyForm/requestForm", "lecApplyForm", "width=1000, height=800, left=100, top=50");
	});

</script>
</html>
