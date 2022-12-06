<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
									cursorshover="true">공지사항코드</th>
								<th class="sorting sorting_desc" tabindex="0"
									aria-controls="example1" rowspan="1" colspan="1"
									aria-label="Browser: activate to sort column ascending"
									cursorshover="true" aria-sort="descending">강의코드</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Platform(s): activate to sort column ascending"
									cursorshover="true">제목</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Engine version: activate to sort column ascending"
									cursorshover="true">내용</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="Engine version: activate to sort column ascending"
									cursorshover="true">등록일</th>
								<th class="sorting" tabindex="0" aria-controls="example1"
									rowspan="1" colspan="1"
									aria-label="CSS grade: activate to sort column ascending"
									cursorshover="true">수정일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="LectureNotice" items="${LectureNoticeList}" varStatus="stat">
							<c:if test="${stat.count%2!=0 }"><tr class="odd"></c:if>
							<c:if test="${stat.count%2==0 }"><tr class="even"></c:if>
							<td class="dtr-control sorting_1" tabindex="0">${LectureNotice.lntcCd}</td>
								<td>${LectureNotice.lecaCd }</td>
								<td><a href="${LectureNotice.lntcCd }#">${LectureNotice.lntcTtl}</a></td>
								<td>${LectureNotice.lntcCon }</td>
								<td><fmt:formatDate value="${LectureNotice.lntcReg }" pattern="yyyy년 MM월 dd일"/> </td>
								<td><fmt:formatDate value="${LectureNotice.lntcUpd }" pattern="yyyy년 MM월 dd일"/> </td>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<th rowspan="1" colspan="1">공지사항코드</th>
								<th rowspan="1" colspan="1">강의코드</th>
								<th rowspan="1" colspan="1">제목</th>
								<th rowspan="1" colspan="1">내용</th>
								<th rowspan="1" colspan="1">작성일</th>
								<th rowspan="1" colspan="1">수정일</th>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
