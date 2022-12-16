<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    request.setCharacterEncoding("utf-8");
    String memNo = (String) (session.getAttribute("memNo"));
%>

<div class="container-fluid">

    <div class="row">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
            <div class="card">
                <h2 class="card-header">상세보기</h2>
                <input type="hidden" id="memCd" value="${menNo}">
                <div class="card-body m-3">
                    <div class="row">
                        <table class="table table-bordered">

                            <tbody>
                            <tr>
                                <th style="width:10%">제목</th>
                                <td colspan="5" class="table-title">${form.qnaTtl}</td>

                            </tr>

                            <tr>
                                <th style="width:5%">작성자</th>
                                <td style="width:5%" class="table-title">작성자 넣기</td>
                                <th style="width:5%">날짜</th>
                                <td style="width:5%" class="table-title">${form.qnaDt}</td>
                                <th style="width:5%">날짜</th>
                                <td style="width:5%" class="table-title">${form.qnaDt}</td>
                                <th style="width:5%">조회수</th>
                                <td style="width:5%" class="table-title">조회수넣기</td>
                            </tr>
                            <tr>
                                <td colspan="6" class="table-title">
                                    <p class="m-3">${form.qnaCon}</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <form action="addReply" method="post">
                        <sec:csrfInput/>
                        <input type="hidden" name="parentId" value="${form.qnaCd}"/>
                    </form>

                    <!-- ================================================= -->
                    <!-- 버튼 시작 -->
                    <!-- ================================================= -->
                    <div class="row justify-content-end mt-3">
                        <button class="btn btn-outline-primary m-1" type="button"
                                onclick="location.href='/qna/update/${form.qnaCd}'">수정
                        </button>
                        <button class="btn btn-outline-danger m-1" type="button"
                                onclick="location.href='/qna/delete/${form.qnaCd}'">삭제
                        </button>
                        <button class="btn btn-primary m-1" type="button" onclick="location.href='/qna/main'">목록
                        </button>
                    </div>
                    <!-- ================================================= -->
                    <!-- 버튼 끝 -->
                    <!-- ================================================= -->


<%--                    <c:set var="qnarCon" value="${form.qnaReplyVO.qnarCon}" />--%>

<%--                    <!-- 답변 있는경우 -->--%>
<%--                    <c:if test="${not empty qnarCon}">--%>
<%--                        <div id="reply">--%>
<%--                            <div id="repWriter">학사관리팀</div>--%>
<%--                            <div id="date">--%>
<%--                                <label id="qnarDt">작성일</label>--%>
<%--                                <div id="qnarDate">--%>
<%--                                    <fmt:formatDate value="${form.qnaReplyVO.qnarDt }" />--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <hr style="border: 1px solid #dedede; clear: both;">--%>
<%--                            <textarea id="repCon" readonly>${form.qnaReplyVO.qnarCon }</textarea>--%>
<%--                        </div>--%>
<%--                    </c:if>--%>

<%--                    <br style="clear: both;">--%>
<%--                    <!-- 답변 없을 경우 -->--%>
<%--                    <c:if test="${sessionScope.memSession.managerVO.mgrCd != null }">--%>
<%--                        <c:if test="${empty form.qnaReplyVO.qnarCon}">--%>
<%--                            <div id="qnaReplyArea">--%>
<%--                                <div id="answer">답변</div>--%>
<%--                                <div id="answerArea">--%>
<%--                                    <textarea id="insertA"></textarea>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <br style="clear: both;">--%>
<%--                            <c:if test="${sessionScope.memSession.managerVO.mgrCd != null }">--%>
<%--                                <button type="button" class="btn btn-secondary" id="qnaReplInsertBtn">자동입력</button>--%>
<%--                                <input type="button" onclick="qnarInsert(${form.qnaCd});"--%>
<%--                                       id="qnarInsert" class="btn btn-primary" value="등록">--%>
<%--                            </c:if>--%>
<%--                        </c:if>--%>
<%--                    </c:if>--%>

<%--                    <!-- 답변 있는 경우 만들어지는 버튼 -->--%>
<%--                    <c:if test="${not empty form.qnaReplyVO.qnarCon}">--%>
<%--                        <c:if test="${sessionScope.memSession.managerVO.mgrCd != null }">--%>
<%--                            <input type="button" id="replUpdate" data-qnacd='${form.qnaCd}'--%>
<%--                                   data-qnarcon='${form.qnaReplyVO.qnarCon }'--%>
<%--                                   class="btn btn-primary" value="수정" />--%>
<%--                            <input type="button" id="replUpdateBtn"--%>
<%--                                   data-qnacd='${form.qnaCd}' class="btn btn-primary" value="등록"--%>
<%--                                   style="display: none;" />--%>
<%--                        </c:if>--%>
<%--                    </c:if>--%>

                </div>
            </div>
        </div>
    </div>
</div>

<script>

    function f_alert() {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#5969FF',
            cancelButtonColor: '#EF172C',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                )
            }
        });

    }

</script>
