<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/tui-grid.js"></script>
<link rel="stylesheet" href="/resources/css/tui-grid.css" type="text/css">
<link rel="stylesheet" href="/resources/css/suwon.css">
<style>
	#totalScoreObjectionLeft{
		display: inline-block;
		float: left;
		width : 50%;
	}
	.detailDiv{
		display : inline-block;
		float: right;
		width: 49%;
		box-sizing: border-box;
	}
	.hyubokhakDetail{
		width : 95%;
		height : 550px;
		background-color: #eee;
		border: 1px solid #999;
	}
	tr{
		width : 100%;
		height: 28px;
	}
	
	th{
		width : 20%;
		text-align: right;
		padding: 3px;
		background:#f4f7fd;
	}
	
	td{
		width : 30%;
		background: white;
	}
	td input{
		width : 100%;
		height : 80%;
	}
	.btns{
/* 		display : inline-block; */
 		float: right;
/*  		position : relative; */
/*  		right : 35px; */
/*  		top : 20px; */
		padding: 10px 0;
	    width: 255px;
	}
/* 	.btns button{ */
/* 		cursor : pointer; */
/* 	} */
	input[type="text"]{
		border: 1px solid #dedede;
	}
	
	textarea{
		border: 1px solid #dedede;
		resize: none;
	}
	
	#headL{
		display: inline-block;
	}
	
	#headD{
		display: inline-block;
	}
		
	.addFontColorRed {
		color: rgb(225, 39, 64);
	}
	
	.addFontColorBlue {
		color : blue;
	}
	#totalScoreObjectionRound{
		width : 100%;
		margin-left : auto;
		margin-right : auto;
	}
	textarea{
		width : 100%;
		height : 100%;
	}
</style>
<script type="text/javascript" defer="defer">
let header = "${_csrf.headerName}";
let token = "${_csrf.token}";	
function start(){
		$.ajax({
			url : "/totalScore/objectionList",
			type : 'post',
			dataType : 'JSON',
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(result) {
				
				$('#grid').empty();
				
				grid = new tui.Grid({
					el : document.getElementById('grid'),
					data : result,
					scrollX : true,
					scrollY : true,
					minBodyHeight : 510,
					columns : [
						{header : '?????? ?????? ??????',   name : 'objCd',     filter : 'select', width : 150, align : 'center' , hidden : "true"},
						{header : '?????? ?????? / ??????', name : 'lecaYrnsem',filter : 'select', width : 130, align : 'center'},
						{header : '????????????',       name : 'objDt',     filter : 'select', width : 100, align : 'center'},
						{header : '????????? ??????',     name : 'lecaCd',     filter : 'select', width : 100, align : 'center'},
						{header : '????????? ??????', 	  name : 'lecaNm',    filter : 'select', width : 130, align : 'center'},
						{header : '??????', 		  name : 'stuNo',     filter : 'select', width : 85,  align : 'center'},
						{header : '??????', 		  name : 'stuNm',     filter : 'select', width : 75,  align : 'center'},
						{header : '????????????', 		  name : 'objYn',    filter : 'select', align : 'center'}
					],
					rowHeaders: ['rowNum'],
					columnOptions: { resizable: true }
				});
				
				var dataSet = grid.getData();
				$.each(dataSet, function(i1, v1){
					if(v1.objYn == "??????"){
						grid.addCellClassName(v1.rowKey, 'objYn', "addFontColorBlue");
					}else if(v1.objYn == "??????"){
						grid.addCellClassName(v1.rowKey, 'objYn', "addFontColorRed");
					}
				});
				
				 grid.on('click', function(object){
					 flag = 0;
//                   console.log(grid.getRow(object.rowKey)[object.columnName]);
	                 var objCd = grid.getRow(object.rowKey).objCd;
// 	                 console.log("objCd >> " + objCd);
	                 
					$.ajax({
						url : "/totalScore/objDetail",
						data : { "objCd" : objCd },
						type : 'post',
						beforeSend : function(xhr){
							xhr.setRequestHeader(header, token);
						},
						success : function(result) {
							console.log(JSON.stringify(result));
							$('#no').val(grid.getRow(object.rowKey)._attributes.rowNum);
							if(result.objYn == '????????????'){
								$('#objYns').val(result.objYn);
								$('#objRpl').attr('readonly', false);
							}else{
								$('#objYns').val(result.objYn);
							}
							$('#objCd').val(objCd);
							$('#lecaNm').val(result.lecaNm);
							$('#lecaYrnsem').val(result.lecaYrnsem);
							$('#objDtt').val(result.objDt);
							$('#colDep').val(result.colDep);
							$('#yrSem').val(result.yrSem);
							$('#stuCd').val(result.stuNo);
							$('#stuNm').val(result.stuNm);
							$('#lecaGrade').val(result.lecaGrade);
							$('#slScore').val(result.slScore);
							$('#objTtl').val(result.objTtl);
							$('#objCon').html(result.objCon);
							$('#objRpl').val(result.objRpl);
							$('#lecaCd').val(result.lecaCd);
							$('#objDetail').attr('disabled', false);
							$('#yBtn').attr('disabled', false);
							$('#nBtn').attr('disabled', false);
						},
						dataType : 'json'
					});
           		});
				
			}
		});
	}
	
	$(function(){
		
		start();
		
		
		$('#objDetail').on('click', function(){
			var popup = window.open("/lectureBoard/score/totalScore?lecaCd=" + $('#lecaCd').val() );
			
			flag = 1;
		});
		
		$('#yBtn').on('click', function(){
			if($('#objYns').val() != "????????????"){
				Swal.fire({
					icon: 'warning',
					text : '?????? ?????? ?????? ????????? ?????? ???????????????.'
				})
				return false;
			}
			if(flag == 0){
				Swal.fire({
					icon: 'warning',
					text : "??????????????? ?????? ?????? ?????? ?????? ????????? ?????? ??? ????????????."
				})
				return false;
			}
			if(!($('#objRpl').val())){
				Swal.fire({
					icon: 'warning',
					text : "????????? ???????????? ???????????? ??? ????????????."
				})
			}else{
				$.ajax({
					url : "/totalScore/updateY",
					data : { 
								"objCd" : $('#objCd').val(), 
								"objRpl" : $('#objRpl').val()
							},
					type : 'post',
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					success : function(result) {
						console.log(JSON.stringify(result));
						$('#objYns').val("??????");
						$('#objRpl').attr('readonly', false);
						$('#yBtn').attr('disabled', false);
						$('#nBtn').attr('disabled', false);
						Swal.fire({
							icon: 'success',
							text : "????????????!."
						})
						start();
					},
					dataType : 'json'
				});
			}
		});
		
		$('#nBtn').on('click', function(){
			if($('#objYns').val() != "????????????"){
				Swal.fire({
					icon: 'warning',
					text : '?????? ?????? ?????? ????????? ?????? ???????????????.'
				})
				return false;
			}
			if(flag == 0){
				Swal.fire({
					icon: 'warning',
					text : "??????????????? ?????? ?????? ?????? ?????? ????????? ?????? ??? ????????????."
				})
				return false;
			}
			if(!($('#objRpl').val())){
				Swal.fire({
					icon: 'warning',
					text : "????????? ???????????? ???????????? ??? ????????????."
				})
			}else{
				$.ajax({
					url : "/totalScore/updateN",
					data : { 
								"objCd" : $('#objCd').val(), 
								"objRpl" : $('#objRpl').val()
							},
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					type : 'post',
					success : function(result) {
						console.log(JSON.stringify(result));
						$('#objYns').val("??????");
						$('#objRpl').attr('readonly', false);
						$('#yBtn').attr('disabled', false);
						$('#nBtn').attr('disabled', false);
						start();
					},
					dataType : 'json'
				});
			}
		});
	});
</script>
<div id="totalScoreObjectionRound">
<div>
   <i class="mdi mdi-home" style="font-size: 1.3em"></i> <i class="dripicons-chevron-right"></i> ???????????? <i class="dripicons-chevron-right"></i> <span style="font-weight: bold;">??????????????????</span>
</div>
<div class="alert alert-light" role="alert" style="font-size: 0.9em;padding: 35px;border: 1px solid #eee;">
					<p>
						<strong>&#8251; ?????? ?????? ?????? ?????? ??????</strong>
						<br><br>
						(1)  <strong>????????????</strong>?????? ????????? ?????? ??? ???, ?????? ?????? ?????? ?????? ??? ????????????.<br>
						&emsp;- ?????????????????? ????????? ????????? ??? ??????????????? ?????? ???????????????.<br>
						<br>
						(2)????????? <strong>?????????</strong> ???????????? ?????????.
					</p>
				</div>
<br><br>
<div id="totalScoreObjectionLeft">
	<p id="headL"><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;?????????????????? ??????</p>
	<div id="grid"></div>
</div>

<div class="detailDiv">
<p id="headD"><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;?????????????????? ????????????</p>
	<input type="hidden" id="objCd">
	<table class="hyubokhakDetail">
		<tr>
			<th>NO</th>
			<td><input type="text" id="no" readonly></td>
			<th>????????????</th>
			<td><input type="text" id="objYns" readonly></td>
		</tr>
		<tr>
			<th>????????????</th>
			<td><input type="text" id="lecaCd" readonly></td>
			<th>???????????????</th>
			<td><input type="text" id="lecaNm" readonly></td>
		</tr>
		<tr>
			<th>????????????/??????</th>
			<td><input type="text" id="lecaYrnsem" readonly></td>
			<th>????????????</th>
			<td><input type="text" id="objDtt" readonly></td>
		</tr>
		<tr>
			<th>??????</th>
			<td><input type="text" id="colDep" readonly></td>
			<th>??????</th>
			<td><input type="text" id="yrSem" readonly></td>
		</tr>
		<tr>
			<th>??????</th>
			<td><input type="text" id="stuCd" readonly></td>
			<th>??????</th>
			<td><input type="text" id="stuNm" readonly></td>
		</tr>
		<tr>
			<th>??????(????????????)</th>
			<td><input type="text" id="lecaGrade" readonly></td>
			<th>??????(??????)</th>
			<td><input type="text" id="slScore" readonly></td>
		</tr>
		<tr>
			<th>????????????</th>
			<td colspan="3"><input type="text" id="objTtl" readonly></td>
		</tr>
		<tr>
			<th>?????? ??????</th>
			<td colspan="3"><textarea id="objCon" readonly></textarea></td>
		</tr>
		<tr>
			<th>???????????????</th>
			<td colspan="3"><textarea id="objRpl" readonly></textarea></td>
		</tr>
	</table>
	<div class="btns">
		<button type="button" class="btn btn-secondary" id="objDetail" disabled>????????????</button>
		<button type="button" class="btn btn-primary" id="yBtn" disabled>??????</button>
		<button type="button" class="btn btn-secondary" id="nBtn" disabled>??????</button>
	</div>
</div>
</div>