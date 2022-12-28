<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .date {
        margin-top: 3px;
        font-size: 11px;
        font-weight: 400;
        line-height: 19px;
        letter-spacing: 0;
        color: #666;
    }

    .header {
        padding: 12px 15px 12px;
    }

    .header {
        position: relative;
        border-top: 1px solid #333;
        border-bottom: 1px solid #ebebeb;
    }

    .title {
        max-height: 57px;
        font-size: 14px;
        line-height: 19px;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        word-wrap: break-word;
        overflow: hidden;
    }

    p {
        display: block;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
    }

    /*  공지사항 시작 */
    .current-page {
        margin-top: 13px;
        font-size: 25px;
    }

    .current-page {
        font-family: 'Noto Serif KR', serif;
        font-weight: 600;
        line-height: 1;
        letter-spacing: 0;
        vertical-align: middle;
        color: #3364c4;
    }

    항
        /*  공지사항 끝  */
        /*  다운로드 시작 */
    .download {
        padding: 10px 8px;
        margin: 20px 0;
    }

    .download {
        border: 1px solid #ebebeb;
        background: #f7f7f7;
    }

    /*  다운로드 끝  */
    /*  footer 시작   */
    .btn.prev {
        padding: 0px 35px 0 15px;
    }

    .btn.prev {
        border-right: 1px dashed #b3b2b2;
        text-align: left;
    }

    .btn {
        height: 52px;
        padding: 0px 15px;
    }

    .btn {
        display: inline-block;
        width: 50%;
        vertical-align: top;
        text-decoration: none;
    }

    .title .clip {
        max-height: 34px;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        word-wrap: break-word;
        overflow: hidden;
    }

    .arrow.prev {
        padding-left: 40px;
    }

    .btn .arrow {
        margin-top: 11px;
        font-size: 11px;
        line-height: 12px;
    }

    .btn .arrow {
        display: block;
        position: relative;
        font-weight: 500;
        letter-spacing: 0;
        color: #888;
    }

    .arrow.prev::after {
        background: url(/resources/image/icon-view-arrow_lg.png) 0 0/auto 8px no-repeat;
    }

    .arrow.prev::after {
        left: 0;
    }

    .arrow::after {
        content: '';
        display: block;
        position: absolute;
        position: absolute;
        top: 50%;
        -ms-transform: translate(0, -50%);
        -moz-transform: translate(0, -50%);
        -o-transform: translate(0, -50%);
        -webkit-transform: translate(0, -50%);
        transform: translate(0, -50%);
    }

    ::after, *::before {
        box-sizing: border-box;
    }

    ::after, ::before {
        box-sizing: inherit;
    }

    .btn-list {
        font-size: 11px;
    }

    .btn-list {
        display: inline-block;
        position: absolute;
        z-index: 1;
        padding: 15px;
        font-weight: 500;
        line-height: 1;
        letter-spacing: -0.025em;
        text-decoration: none;
        color: #888;
        background: #fff;
        position: absolute;
        left: 50%;
        -ms-transform: translate(-50%, 0);
        -moz-transform: translate(-50%, 0);
        -o-transform: translate(-50%, 0);
        -webkit-transform: translate(-50%, 0);
        transform: translate(-50%, 0);
    }
</style>

<!-- 게시판상세 -->
<!-- ================================================= -->
<!-- MAIN-CONTENT -->
<!-- ================================================= -->
<div class="container-fluid">

    <!-- 111111 -->
    <div class="row">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
            <div class="card">

                <p class="current-page">공사사항</p>
                <header class="header">
                    <h3 class="title">${form.noticeTtl}</h3>
                    <p class="date">
                        <fmt:formatDate value="${form.noticeReg}" pattern="yyyy/MM/dd"/>
                    </p>
                </header>
                <input type="hidden" name="noticeCd" value="${form.noticeCd}"/>
                <p>
                    ${form.noticeCon}
                </p>
                <div class="download">
                    <a href="#">2023정시_모집인원_변경안내.pdf(636 KB)</a>
                </div>
                <div>
                    <footer class="footer">
                        <c:set var="standardNoticeCd" value="${form.noticeCd}"/>
                        <a href="/notice/list/${standardNoticeCd - 1}/detail" class="btn next">
                        <p class="btn prev">
                        <span class="title">
                            <span class="clip">이전글 제목 넣기 / 이전글 없음</span>
                        </span>
                            <a href="/notice/list" class="btn-list">목록보기</a>
                            <span class="arrow prev">
                            "이전글" ::after
                        </span>
                        </p>
                        <a href="/notice/list/${standardNoticeCd + 1}/detail" class="btn next">
                    <span class="title">
                        <span class="clip">다음글 제목 넣기 / 다음글 없음</span>
                    </span>
                            <span class="arrow next">
                        "다음글"
                        ::after
                    </span>
                        </a>
                    </footer>
                </div>
            </div>
        </div>
    </div>

    <%--<div class="row justify-content-end mt-3">--%>
    <%--    <button class="btn btn-outline-primary m-1" type="button"--%>
    <%--            onclick="location.href='/notice/update/${form.noticeCd}'">수정--%>
    <%--    </button>--%>
    <%--    <button class="btn btn-outline-danger m-1" type="button"--%>
    <%--            onclick="location.href='/notice/delete/${form.noticeCd}'">삭제--%>
    <%--    </button>--%>
    <%--    <button class="btn btn-primary m-1" type="button" onclick="location.href='/notice/list'">목록--%>
    <%--    </button>--%>
    <%--</div>--%>

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
