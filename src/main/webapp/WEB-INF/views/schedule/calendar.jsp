<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>개인일정</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
    <link rel="stylesheet" href="/resources/css/suwon.css">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

    <style>

        select, option {
            float: right;
        }

        #tab {
            border-collapse: collapse;
            width: 350px;
            height: 50px;
        }

        .pallete {
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: inline-block;
            float: left;
        }

        #schCon {
            resize: none;
        }

        /* .fc-h-event{ */
        /* height : 25px; */
        /* } */

        .fc-day-sun a {
            color: red;
        }

        .fc-daygrid-dot-event .fc-event-time {
            color: black;
        }

        .fc-daygrid-dot-event .fc-event-title {
            color: black;
        }

        .pallete {
            margin-right: 10px;
        }

        .fc-header-toolbar {
            padding: 25px;
            justify-content: space-around;
        }

        input[type=datetime-local] {
            padding: 5px;
        }

        .fc-daygrid-day-frame {
            cursor: pointer;
        }

        .btnRound {
            display: inline-block;
            float: right;
        }

        .bg-primarys {
            background: #001353;
            color: #fff;
        }

        .inputDate {
            border: 1px solid lightgray;
        }

        input[type=datetime-local] {
            border: 1px solid lightgray;
        }
    </style>
</head>
<script type="text/javascript" defer="defer">


    function findSeq() {

    }


    $(function () {


        var color;
        var schTtl;
        var schCon;
        var stTime;

        $('#insert-modal').on('hidden.bs.modal', function () {
            $('.pallete').css('border', '');
        })

        $('#update-modal').on('hidden.bs.modal', function () {
            $('.pallete').css('border', '');
        })


        var colorSet1 = ["#E72C51", "#F29649", "#AF539B", "#2E63AF", "#1CB4AD", "#6B7830"];
        for (i = 0; i < colorSet1.length; i++) {
            let colorDiv = document.createElement("div");
            colorDiv.classList.add("pallete");
            colorDiv.style.backgroundColor = colorSet1[i];
            $(colorDiv).attr('id', colorSet1[i]);
// 		$(colorDiv).attr('data-idx', 'color' + i );
            $('.colorPicker').append(colorDiv);
        }

        $('.pallete').on('click', function () {
            $('.pallete').css('border', '');
            $(this).css('border', '3px solid red');
            color = $(this).attr('id');
            console.log(color);
        })

        var request =

            $.ajax({
                url: "/schedule/calendarList", // 값 불러오기
                method: "POST",
                dataType: "json"
            });


        request.done(function (data) {

            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth();

            var calendarEl = document.getElementById('calendar');
            calendar = new FullCalendar.Calendar(calendarEl, {
                height: '700px',
                firstDay: 1,
                //eventDisplay : 'block',
                // 헤더에 표시할 툴바
                headerToolbar: {
                    left: 'prev,next',
                    center: 'title',
                    right: 'today'
                },
                initialView: 'dayGridMonth', // 초기 로드 될 때 보이는 캘린더 화면 (기본 설정 : 달)
// 		  views: {
// 			    dayGridMonth: { // name of view
// 			      titleFormat: { month: '2-digit'}
// 			      // other view-specific options here
// 			    }
// 			  },
                //navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                //editable : true, // 수정 가능?
                selectable: true, // 달력 일자 드래그 설정 가능
                droppable: false, // 드래그 앤 드롭
                events: data,
                eventTimeFormat: {
                    hour: "2-digit",
                    minute: "2-digit",
                    hour12: false
                },
                //locale : 'ko', // 한국어 설정

                //이벤트 생성
                select: function (arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다

                    let today = new Date();
                    var hours = today.getHours(); // 시
                    var minutes = today.getMinutes();
                    if (minutes < 10) {
                        minutes = "0" + minutes;
                    }
                    var currentTime = hours + ":" + minutes;

                    var stTimeSet = moment(arg.start).format('YYYY-MM-DD ') + currentTime;
                    var enTimeSet = moment(arg.end).subtract(1, 'days');
                    enTimeSet = enTimeSet.format('YYYY-MM-DD ') + "23:59";

                    //모달창 오픈시 새창 화면
                    $('#schTtl').val("");
                    $('#schCon').val("");
                    $('#modalSt').val(stTimeSet);
                    $('#modalEn').val(enTimeSet);

                    $('#insert-modal').modal();


                    color = "#E72C51";
                    $('.pallete:first-child').css('border', '3px solid red');


                    $('#save').off('click');
                    $('#save').on('click', function () {


                        schTtl = $('#schTtl').val();
                        schCon = $('#schCon').val();
                        stTime = $('#modalSt').val();
                        stTime2 = $('#modalEn').val();


                        var obj = {};
                        // Json을 담기 위해 Object 선언
                        obj.schTtl = schTtl;
                        obj.schSt = moment(stTime).format('YYYY-MM-DD HH:mm');  // 시작
                        obj.schEn = moment(stTime2).format('YYYY-MM-DD HH:mm');  // 끝
                        obj.schColor = color;
                        obj.schCon = schCon;


                        var seq = 0;

                        $.ajax({
                            url: "/schedule/findSeq",
                            dataType: "json",
                            type: "POST",
                            success: function (res) {
                                seq = res;

                                calendar.addEvent({
                                    id: seq,
                                    title: schTtl,
                                    start: obj.schSt,
                                    end: obj.schEn,
                                    allDay: false,
                                    color: color
                                })


                            }
                        })


                        $(function saveData(jsonData) {
                            $.ajax({
                                url: "/schedule/update",
                                method: "POST",
                                dataType: "json",
                                data: JSON.stringify(obj),
                                contentType: 'application/json'
                            })
                        });

                        $('#insert-modal').modal('hide');


                    })


                },

                //이벤트 삭제
                eventClick: function (info) {
                    var schCd = info.event.id;

                    let data = {"schCd": schCd};
                    //dataType : 응답
                    $.ajax({
                        url: "/schedule/findCon",
                        type: "POST",
                        dataType: "json",
                        data: JSON.stringify(data),
                        contentType: 'application/json;charset=utf-8',
                        success: function (res) {

                            $('#update-modal').modal();

                            var recentColor = info.event.backgroundColor;
                            console.log(recentColor);
                            color = recentColor;
                            console.log($('.colorPicker:eq(0)').children());
                            $.each($('.colorPicker:eq(1)').children(), function (i, v) {
// 	                	 console.log(i + "/" + v.id);
// 	                	 $(this).css('border', '2px solid black');
                                if (v.id == recentColor) {
// 	                		 alert('ok');
                                    $(this).css('border', '3px solid red');

                                }
                            })

// 	                 console.log($('.pallete').attr('id', recentColor));
// 	                 $('#'+ recentColor).css('border', '2px solid black');


                            $('#schTtlUp').val(info.event.title);
                            $('#schConUp').val(res.schCon);
                            $('#modalStUp').val(res.schSt);
                            $('#modalEnUp').val(res.schEn);

                            $('#delete').off('click');
                            $('#delete').on('click', function () {
                                if (confirm("정말로 삭제하시겠습니까?")) {
                                    $('#update-modal').modal('hide');
                                    info.event.remove();


                                    $.ajax({
                                        url: "/schedule/update",
                                        method: "DELETE",
                                        dataType: "json",
                                        data: JSON.stringify({"schCd": schCd}),
                                        contentType: 'application/json;charset=utf-8',
                                        success: function (res) {
                                            alert("삭제되었습니다.")
                                        }
                                    })

                                }
                            })

                            $('#update').off('click');
                            $('#update').on('click', function () {
                                if (confirm("수정하시겠습니까?")) {
                                    color;
                                    console.log("color" + color);
                                    var obj = {};
                                    obj.schCd = info.event.id;
                                    obj.schTtl = $('#schTtlUp').val();
                                    obj.schCon = $('#schConUp').val();
                                    obj.schSt = moment($('#modalStUp').val()).format('YYYY-MM-DD HH:mm');
                                    obj.schEn = moment($('#modalEnUp').val()).format('YYYY-MM-DD HH:mm');
                                    obj.schColor = color;
//                       		if(color == undefined){
//                       			obj.schColor = recentColor;
//                       		}else{
//                       			obj.schColor = color;
//                       		}
                                    console.log("color" + color);

                                    $('#update-modal').modal('hide');


                                    info.event.remove();
                                    calendar.addEvent({
                                        id: obj.schCd,
                                        title: obj.schTtl,
                                        start: obj.schSt,
                                        end: obj.schEn,
                                        allDay: false,
                                        color: obj.schColor
                                    })


                                    $.ajax({
                                        url: "/schedule/updateCon",
                                        method: "POST",
                                        dataType: "json",
                                        data: JSON.stringify(obj),
                                        contentType: 'application/json;charset=utf-8',
                                        success: function (res) {
                                        }
                                    })

                                }
                            })
                        }

                    })
                },

                //이벤트 수정
                eventDrop: function (info) {

                    var obj = {};

                    obj.start = moment(info.event.start).format('YYYY-MM-DD');
                    obj.end = moment(info.event.end).format('YYYY-MM-DD');
                    obj.id = info.event.id;


                    $(function modifyData() {
                        $.ajax({
                            url: "/schedule/update",
                            method: "PATCH",
                            dataType: "json",
                            data: JSON.stringify(obj),
                            contentType: 'application/json',
                        })
                    })
                },

                eventResize: function (info) {
                    var obj = {};
                    obj.start = moment(info.event.start).format('YYYY-MM-DD');
                    obj.end = moment(info.event.end).format('YYYY-MM-DD');
                    obj.id = info.event.id;


                    $(function modifyData() {
                        $.ajax({
                            url: "/schedule/update",
                            method: "PATCH",
                            dataType: "json",
                            data: JSON.stringify(obj),
                            contentType: 'application/json',
                        })
                    })
                }
            })

            calendar.render();
        })
    })
</script>
<body>
<div id="calRound">
    <div>
        <i class="mdi mdi-home" style="font-size: 1.3em"></i> <i class="dripicons-chevron-right"></i> 마이 페이지 <i
            class="dripicons-chevron-right"></i> <span style="font-weight: bold;">개인 일정 관리</span>
    </div>
    <br><br>
    <p><i class="mdi mdi-record-circle" style="color: #001353;"></i>&ensp;개인 일정 캘린더</p>
    <div id="container" class="card">
        <div id="calendar">
        </div>
    </div>
    <!-- insert Modal -->
    <div id="insert-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="compose-header-modalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-colored-header bg-primarys">
                    <h4 class="modal-title" id="compose-header-modalLabel">일정등록</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body p-3">
                    <form class="p-1">
                        <div>
                            <label>시간</label><br>
                            <input type="datetime-local" id="modalSt">
                            <input type="datetime-local" id="modalEn">
                        </div>
                        <br>
                        <div class="form-group mb-2">
                            <label for="msgto">제목</label>
                            <input type="text" id="schTtl" class="form-control">
                        </div>
                        <div class="form-group mb-2">
                            <label for="mailsubject">색상</label>
                            <div class="colorPicker" id="firstDiv"></div>
                        </div>
                        <br>
                        <div class="form-group write-mdg-box mb-3">
                            <label>내용</label>
                            <textarea id="schCon" rows="4" cols="53"
                                      style="width: 100%; border: 1px solid lightgray;"></textarea>
                        </div>
                        <div hidden="hidden" id="mgrCdHidden"></div>
                        <div hidden="hidden" id="lecApplyHidden"></div>
                        <div class="btnRound">
                            <button type="button" class="btn btn-primary" id="save">저장</button>
                            <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->



    <!-- update Modal -->
    <div id="update-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="compose-header-modalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-colored-header bg-primary">
<%--                    <h4 class="modal-title" id="compose-header-modalLabel">일정등록</h4>--%>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body p-3">
                    <form class="p-1">

                        <div>
                            <label>시간</label><br>
                            <input type="datetime-local" class="inputDate" id="modalStUp"
                                   style="border : 1px solid lightgray;">
                            <input type="datetime-local" class="inputDate" id="modalEnUp"
                                   style="border : 1px solid lightgray;">
                        </div>

                        <div class="form-group mb-2">
                            <label for="msgto">제목</label>
                            <input type="text" id="schTtlUp" class="form-control">
                        </div>
                        <div class="form-group mb-2">
                            <label for="mailsubject">색상</label>
                            <div class="colorPicker"></div>
                        </div>
                        <br>
                        <div class="form-group write-mdg-box mb-3">
                            <label>내용</label>
                            <textarea id="schConUp" rows="4" cols="53"></textarea>
                        </div>
                        <div hidden="hidden" id="mgrCdHidden"></div>
                        <div hidden="hidden" id="lecApplyHidden"></div>

                        <div class="btnRound">
                            <button type="button" class="btn btn-primary" id="update">수정</button>
                            <button type="button" class="btn btn-danger" id="delete">삭제</button>
                        </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

</div>
</body>
</html>
