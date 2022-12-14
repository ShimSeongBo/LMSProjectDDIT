<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String name = String.valueOf(session.getAttribute("name"));
%>
<link rel="stylesheet" type="text/css" href="/resources/css/schRcmd.css">
<script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript">

let header = "${_csrf.headerName}";
let token = "${_csrf.token}";

function fn_add(data){
	
	$("#stuImg").attr("src", "/upload"+data.stuPic);
	$("#stuNo").attr("value", data.stuNo);
	$(".stuNo").html(data.stuNo);
	$("#stuNm").attr("value", data.stuNm);
	$(".stuNm").html(data.stuNm);
	$("#stuNme").attr("value", data.stuNme);
	$('#colCd').val(data.colNm);
	$('#department').val(data.depNm);
	$('.depNm').html(data.depNm);
	$('#stuYr').val(data.stuYr);
	$('#stuSem').val(data.stuSem);
	$("#stuBir").attr("value", data.stuBir);
	$("#stuTel").attr("value", data.stuTel);
	$("#stuZip").attr("value", data.stuZip);
	$("#stuAddr1").attr("value", data.stuAddr1);
	$("#stuAddr2").attr("value", data.stuAddr2);
	$("#proNo").attr("value", data.proNo);
	$("#empNm").html(data.empNm);
	$("#sclhRcmd").html(data.sclHistory.sclhRcmd);
	$(".sclhDt").html(data.sclHistory.sclhDt);
	$("#recommendation").attr("value", data.sclHistory.sclhCd);
	$("#reject").attr("value", data.sclHistory.sclhCd);
	
}

function loadSearchList(){
	
	let stratYr = $("#stratYr").val();
	let approval = $("#approval").val();
	let yr = $("#yr").val();
	let sem = $("#sem").val();
	let name = $("#name").val();
	
	
	let data = {
		stuNo : stratYr,
		sclhYn : approval,
		sclhYr : yr,
		sclhSem : sem,
		stuNm : name
	};


	$.ajax({
		url : "/professor/schlStuSearch",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(result) {
			$("#list").html("");
			let str = "";
			
// 			console.log("result" + result);
			
			if(result.length == 0){
				str = "<tr class='text-center p-0'>";
				str += "<td colspan='11'>????????? ????????? ????????????.</td>";
				str += "</tr>";
				$("#list").html(str);
				return;
			}
			$.each(result,function(index, sclHistory){
				
				str += `
					<tr>
						<td class="dtr-control sorting_1" tabindex="0" style="text-align:center;">\${index+1}</td>
						<td>\${sclHistory.stuNo}</td>
						<td>
							<div class="image">
								\${sclHistory.stuNm}
							</div>
						</td>
						<td>
							\${sclHistory.sclhYr}??? \${sclHistory.sclhSem}??????
						</td>
						<td>\${sclHistory.empNm}</td>
						<td id="YOrN\${index}">\${sclHistory.sclhYn}</td>
						<td>
							<button class="btn btn-block btn-outline-secondary btn-sm btnDetail"
								value="\${sclHistory.sclhCd}, \${sclHistory.stuNo}" data-toggle="modal" data-target="#modal-lg" >?????? ??????</button>
						</td>
					</tr> `;
					
			});
			$("#list").append(str);
			
			for(let i=0;i<result.length; i++){
				if($("#YOrN"+i).html()=="????????????"){
					$("#YOrN"+i).css("color", "blue");
				}else if($("#YOrN"+i).html()=="??????"){
					$("#YOrN"+i).css("color", "red");
				}else if($("#YOrN"+i).html()=="???????????????"){
					$("#YOrN"+i).css("color", "green");
				}
			}
		}
	});
}

$(function(){
	
	loadSearchList();
	
	$("#search").on("click",loadSearchList);
	
	let sclhYn = $(".sclhYn").val();
	console.log("sclhYn??????? " + sclhYn)
	
	$(document).on("click", ".btnDetail", function(){
// 		alert("??????????");
		
		let stuDetail = $(this).val();
		let sclhCd = stuDetail.substr(0,5)
		let stuNo = stuDetail.substr(7,10)
		let myData = {
			"sclhCd":sclhCd,
			"detailStu":stuNo
		}
		console.log("???????????? ????????? " + stuDetail + " sclhCd: " + sclhCd + " stuNo: " + stuNo);
		
		$.ajax({
			type: 'post',
			url: '/professor/schStuRcmd',
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(myData),
			beforeSend:function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success :function(data){
				console.log("????????????????????? ", data.sclHistory.sclhRcmd);
				fn_add(data);
				
				$.ajax({
					type: 'post',
					url: '/professor/stuSclList',
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(myData),
					beforeSend:function(xhr){
						xhr.setRequestHeader(header, token);
					},
					success :function(result){
						console.log("2????????? ", result[0]);
						
						let str = "";
						if(result != null && result.length != 0){
							for(let i=0; i < result.length; i++){
								
								str += `
								<tr>
									<td>\${i+1}</td>
									<td>\${result[i].sclNm}</td>
									<td>\${result[i].sclhYr}??? \${result[i].sclhSem}??????</td>
									<td>\${result[i].sclhAmt}</td>
									<td>\${result[i].empNm}</td>
								</tr>
								
								`
							}
						}else{
							
							str = `
							<tr>
								<td colspan='5'>?????? ????????? ????????? ????????????.</td>
							</tr>
							`
						}
						
						$("#sclList").html(str);
						
						
						
					},
					error:function(request, status, error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
					
				});
				
			},
			error:function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		});
		
	});
	
	$(document).ready(function () {
		$("#recommendation").on("click", function(){
			
			let sclhCd = $(this).val();
			console.log("sclhCd: " + sclhCd);
			let myData = {
					"sclhCd":sclhCd
			}
			
		 Swal.fire({
	            title: '??? ????????? ?????? ???????????????????',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '??????',
	            cancelButtonText: '??????'
		 }).then(function(dlt) {
			 	if(dlt.isConfirmed){
					$.ajax({
						type: 'post',
						url: '/professor/deanRcmd',
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(myData),
						beforeSend:function(xhr){
							xhr.setRequestHeader(header, token);
						},
						success :function(result){
							
							console.log("????????? ??????! ?????? " + result);
							 Swal.fire(
				                    '?????? ??????',
				                    '??????????????? ?????? ???????????????.',
				                    'success'
				                ).then(function(){
						        	window.location.reload(true);			        	
						        });
							
						},
						error:function(request, status, error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
						
					});
				}
				
			});
		
			
		});
		
	});
		
	$(document).ready(function () {
		$("#reject").on("click", function(){
			
			let sclhCd = $(this).val();
			console.log("sclhCd: " + sclhCd);
			let myData = {
					"sclhCd":sclhCd
			}
			Swal.fire({
	            title: '????????? ?????? ???????????????????',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '??????',
	            cancelButtonText: '??????'
		 }).then(function(dlt) {
			 if(dlt.isConfirmed){
					$.ajax({
						type: 'post',
						url: '/professor/rejectRcmd',
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(myData),
						beforeSend:function(xhr){
							xhr.setRequestHeader(header, token);
						},
						success :function(result){
							
							console.log("????????? ??????! ?????? " + result);
							
						},
						error:function(request, status, error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
						
					});
				
		 		}
			
			});
			
		});
	
	});
	
	$("#savePdfBtn").on("click", function(){
		//?????? ?????? div id
		html2canvas($('#sclPdf')[0], {
			//logging : true,		// ????????? ?????? ??????
			//proxy: "html2canvasproxy.php",
			allowTaint : true, // cross-origin allow
			useCORS : true, // CORS ????????? ??????????????? ????????? ????????? ????????? ??????
			scale : 2
		// ?????? 96dpi?????? ???????????? ??? ?????? ??????
		}).then(
				function(canvas) {
					// ???????????? ???????????? ??????
					var imgData = canvas.toDataURL('image/png');
					var imgWidth = 190; // ????????? ?????? ??????(mm) / A4 ?????? 210mm
					var pageHeight = imgWidth * 1.414; // ?????? ????????? ?????? ?????? ?????? A4 ??????
					var imgHeight = canvas.height * imgWidth / canvas.width;
					var heightLeft = imgHeight;
					var margin = 10; // ?????? ????????? ????????????
					var doc = new jsPDF('p', 'mm');
					var position = 10;
					// ??? ????????? ??????
					doc.addImage(imgData, 'PNG', margin, position, imgWidth,
							imgHeight);
					heightLeft -= pageHeight;
					// ?????? ??????
					doc.save('?????????_?????????.pdf');
				});
	});
	
	
});
</script>
<style>
	.mycard {
		padding: 0px;
		border-radius: 0.25rem;
		min-width: 0px;
		text-align: left;
	}
</style>

<div class="row">
	<div class="alert alert-light col" role="alert">
		<!-- ????????? ???????????? -->
		<p>
			<strong>
			??? ????????? ??????????????? ??????????????? ????????? ?????? ????????? ???????????????.
			</strong>
		</p>
	</div>
</div>

<!-- ?????? ?????? -->
<div class="row mt-3">
	<div class="form-group col-2 ">
		<select id="stratYr" class="form-control" style="width: 100%;">
			<option value="">?????? ??????</option>
			<option value="2023">2023</option>
			<option value="2022">2022</option>
			<option value="2021">2021</option>
			<option value="2020">2020</option>
			<option value="2019">2019</option>
			<option value="2012">2012</option>
		</select>
	</div>
	<div class="form-group col-2">
		<select id="approval" class="form-control" style="width: 100%;">
			<option value="">?????? ??????</option>
			<option value="AP002">????????????</option>
			<option value="AP003">??????</option>
			<option value="AP004">????????? ??????</option>
			<option value="AP005">?????? ??????</option>
		</select>
	</div>
	<div class="form-group col-2 ">
		<select id="yr" class="form-control" style="width: 100%;">
			<option value="">????????????</option>
			<option value="2023">2023</option>
			<option value="2022">2022</option>
			<option value="2021">2021</option>
			<option value="2020">2020</option>
			<option value="2019">2019</option>
			<option value="2012">2012</option>
		</select>
	</div>
	<div class="form-group col-2 ">
		<select id="sem" class="form-control" style="width: 100%;">
			<option value="">?????? ??????</option>
			<option value="1">1</option>
			<option value="2">2</option>
		</select>
	</div>
	<div class="form-gruop col-3">
		<input id="name" type="text" class="form-control" placeholder="?????? ??????" />
	</div>

	<div class="form-group col-1">
		<button id="search" type="button" class="btn btn-primary" value="">??????</button>
	</div>
</div>

<div style="text-align:center; overflow:scroll; width:100%; height:600px;">
	<table class="table table-head-fixed text-nowrap table-striped table-bordered table-condensed table-sm">
		<thead>
			<tr class="text-center">
				<th width="3%">No</th>
				<th width="10%">??????</th>
				<th width="10%">??????</th>
				<th width="10%">?????? ??????/??????</th>
				<th width="10%">?????????</th>
				<th width="10%">????????????</th>
				<th width="10%">?????? ??????</th>
			</tr>
		</thead>
		<tbody id="list">
			
		</tbody>
	</table>
</div>

<!-- ?????? -->
<div class="modal fade" id="modal-lg" style="display: none;"aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">?????? ?????? ??????</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">??</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-12">
					<div class="container-fluid">
						<div class="row">
							<div class="col-4" style="text-align:center;">
								<img class="img-thumbnail" width="180px;" height="250px;" id="stuImg">
							</div>
							<div class="col-8 mycard">
								<div class="container">
									<div class="row mt-1 mb-2">
										<div class="col-6">
											<label for="stuNo" class="form-label">??????</label> 
											<input type="text" class="form-control stuNo" id="stuNo" name="stuNo" readonly />
										</div>
									</div>
									<div class="row mb-2">
										<div class="col-6">
											<label for="stuNm" class="form-label">??????</label> 
											<input type="text" class="form-control stu stuNm" id="stuNm" name="stuNm" readonly />
										</div>
										<div class="col-6">
											<label for="stuNm" class="form-label">???????????? ??????</label> 
											<input type="text" class="form-control stu stuNm" id="" name="" readonly />
										</div>
									</div>
									<div class="row mb-2">
										<div class="form-group col-6">
											<label for="colCd" class="form-label">????????????</label> <input
												type="text" class="form-control stu" id="colCd" name="colCd"
												readonly />
										</div>
										<div class="col-6">
											<label for="department" class="form-label">??????</label> <input
												type="text" class="form-control stu" id="department"
												name="depCd" readonly />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-12">
					<div class="card collapsed-card mt-4 mb-4 mycard ">
						<div class="card-header">
							<h3 class="card-title">?????? ??????</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse">
									<i class="fas fa-plus"></i>
								</button>
							</div>
						</div>

						<div class="card-body" style="display: none;">
							<div class="row mt-2 mb-2">
								<div class="col-4">
									<label>??????</label> <input type="text" class="form-control stu"
										id="stuYr" name="stuYr" readonly />
								</div>
								<div class="col-4">
									<label>??????</label> <input type="text" class="form-control stu"
										id="stuSem" name="stuSem" readonly />
								</div>
								<div class="col-4">
									<label for="stuNme" class="form-label">?????? ??????</label> 
									<input type="text" class="form-control stu" id="stuNme" name="stuNme"
										readonly />
								</div>
							</div>
							<div class="row mt-3 mb-2">
								<div class="col-4">
									<label for="stuZip" class="form-label">????????????</label> <input
										type="text" class="form-control stu" id="stuZip" name="stuZip"
										readonly />
								</div>
								<div class="col-4">
									<label for="stuBir" class="form-label">????????????</label> <input
										type="text" class="form-control stu" id="stuBir" name="stuBir"
										readonly />
								</div>
								<div class="col-4">
									<label for="stuTel" class="form-label">????????????</label> <input
										type="text" class="form-control stu" id="stuTel" name="stuTel"
										readonly />
								</div>
							</div>
							<div class="row mt-3 mb-2">
								<div class="col-6">
									<label for="stuAddr1" class="form-label">????????????</label> <input
										type="text" class="form-control stu" id="stuAddr1"
										name="stuAddr1" readonly />
								</div>
								<div class="col-6">
									<label for="stuAddr2" class="form-label">????????????</label> <input
										type="text" class="form-control stu" id="stuAddr2"
										name="stuAddr2" readonly />
								</div>
							</div>
						</div>
					</div>
					
					<div class="card collapsed-card mt-4 mb-4 mycard ">
						<div class="card-header">
							<h3 class="card-title">?????? ??????</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse">
									<i class="fas fa-plus"></i>
								</button>
							</div>
						</div>

						<div class="card-body table-responsive p-0"
							style="height: 230px;">
							<table class="table table-head-fixed text-nowrap">
								<thead>
									<tr>
										<th>no</th>
										<th>????????? ???</th>
										<th>????????????</th>
										<th>?????????</th>
										<th>?????????</th>
									</tr>
								</thead>
								<tbody id="sclList">
								</tbody>
							</table>
						</div>

					</div>
					
					<div id="stuBtn" align="right">
						<button type="button" id="recommendationStu" class="btn btn-outline-success" 
							data-toggle="modal" data-target="#modal-default">????????? ?????? ??????</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="modal-default"
			style="display: none; z-index: 1041" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">????????? ?????? ??????</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">??</span>
					</button>
				</div>
				<div class="modal-body" style="padding:0px;">
					<div id="sclPdf">
						<div class="hpa" style="width: 210mm; height: 296.99mm;">
							<div class="hcD" style="left: 20mm; top: 25mm;">
								<div class="hcI">
									<div class="hls ps19"
										style="line-height: 8.29mm; white-space: nowrap; left: 0mm; top: -0.44mm; height: 8.82mm; width: 170mm;">
										<span class="hrt cs12">????????? ?????????</span>
									</div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 13.90mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 20.67mm; height: 4.23mm; width: 170mm;">
										<div style="position:absolute;right: 90px;">
											<span class="hrt cs9">?????? :</span><span class="hrt cs9 depNm"></span>
										</div>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
									</div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 27.45mm; height: 4.23mm; width: 170mm;">
										<div style="position:absolute;right: 90px;">
											<span class="hrt cs9">?????? :</span><span class="hrt cs9 stuNo"></span>
										</div>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
									</div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 34.22mm; height: 4.23mm; width: 170mm;">
										<div style="position:absolute;right: 90px;">
											<span class="hrt cs9">?????? :</span><span class="hrt cs9 stuNm"></span>
										</div>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
									</div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 40.99mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps0"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 47.77mm; height: 4.23mm; width: 170mm;">
										<span class="hrt cs9">??? ?????? ?????? :</span>
									</div>
									<div class="hls ps0"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 54.54mm; height: 4.23mm; width: 0mm;"></div>
									<div class="hls ps0"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 120.96mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps0"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 127.73mm; height: 4.23mm; width: 170mm;">
										<span class="hrt cs9">?????? ?????? ???????????? ???????????????.&nbsp;</span>
									</div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 134.51mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 141.28mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 148.05mm; height: 4.23mm; width: 170mm;">
										<span class="hrt cs10">???????????? : &nbsp;</span>
										<span class="hrt cs10" id="empNm"></span>
										<span class="htC" style="left: 1.06mm; width: 9.17mm; height: 100%;"></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<img alt="" src="/resources/upload/img/????????????sh.jpg">
										<span class="hrt cs10">(???)</span>
									</div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 154.83mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps20"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 161.60mm; height: 4.23mm; width: 170mm;">
										<span class="hrt cs10">????????? : &nbsp;</span>
										<span class="hrt cs10"><%=name %></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<span class="htC" style="left: 1.06mm; width: 11.99mm; height: 100%;"></span>
										<img alt="" src="/resources/upload/img/????????????ys.jpg">
										<span class="hrt cs10">(???)</span>
									</div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 181.92mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 188.69mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 195.47mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 202.24mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: 209.01mm; height: 4.23mm; width: 170mm;"></div>
									<div class="hls ps19"
										style="line-height: 4.44mm; white-space: nowrap; left: 0mm; top: 215.73mm; height: 5.29mm; width: 170mm;">
										<span class="hrt cs11 sclhDt"></span>
									</div>
									<div class="hls ps19"
										style="line-height: 21.71mm; white-space: nowrap; left: 0mm; top: 224.47mm; height: 21.71mm; width: 170mm;">
										<div class="hsR"
											style="top: 0mm; left: 0mm; margin-bottom: 0mm; margin-right: 0mm; width: 86.99mm; height: 21.71mm; display: inline-block; position: relative; vertical-align: middle; background-repeat: no-repeat;"></div>
									</div>
								</div>
							</div>
							<div class="htb"
								style="left: 21mm; width: 170.97mm; top: 80.75mm; height: 66.42mm;">
								<textarea rows="10" cols="90" placeholder="????????? ???????????? ?????? ???????????? ?????????" id="sclhRcmd"></textarea>
							</div>
							<div style="text-align:center; margin-top: 125%;">
								<img alt="" src="/resources/upload/img/yeonSu_logo.png">
							</div>
							<input type="hidden" id="proNo">
						</div>
					
					</div>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" id="savePdfBtn" class="btn btn-outline-danger">PDF ??????</button>
					<div>
						<button type="button" id="reject" class="btn btn-outline-danger">??????</button>
						<button type="button" id="recommendation" class="btn btn-outline-success">??????</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>