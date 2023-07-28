<%@ page import="com.member.board.dto.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.member.board.dto.CmtDTO" %><%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>

</head>
<body>
<button class="btn btn-light" id="list">글목록</button>
<button class="btn btn-light" id="update">수정하기</button>
<button class="btn btn-light" id="delete">삭제하기</button>
<div class="card mb-3" style="max-width: 540px;">
    <div class="row g-0">
        <div class="col-md-4">
            <c:if test="${boardDTO.fileAttached==1}">
                <img src="/upload/${boardFileDTO.storedFileName}">
            </c:if>
        </div>
    </div>
    <div style="display: none" id="boardId">${boardDTO.id}</div>
    <div class="card-body">
        <div>${boardDTO.boardType}</div>
        <div>${boardDTO.boardCreatedTime}</div>
        <h3>${boardDTO.boardTitle}</h3>
        <h4>${boardDTO.boardContents}</h4>
        <span>조회수 ${boardDTO.boardView}</span>
        <span id="cmtNum">댓글수</span>
    </div>
</div>


<!-- 댓글 쓰기 -->
<div id="cmtWrite">
    <input type="hidden" id="memberId" value="${sessionScope.memberId}">
    <input class="form-control" type="text" id="cmtWriter" value="${sessionScope.loginName}" readonly>
    <input class="form-control" type="text" id="cmtContents" placeholder="내용">
    <button class="btn btn-outline-secondary" id="cmt-btn">댓글작성</button>
</div>
<!--댓글수정 -->
<div id="cmtUpdate" style="display: none">
    <input type="hidden" id="modalId" value="${sessionScope.memberId}">
    <input class="form-control" type="text" id="modalWriter" value="${sessionScope.loginName}"
           readonly/>
    <input class="form-control" type="text" id="modalContents" name="modalContents">
    <button class="btn btn-outline-secondary" id="cmt-upd-btn">댓글수정
    </button>
    <button class="btn btn-outline-secondary" type="button" id="cmt-cancel">취소</button>
</div>
<!-- 댓글 목록 -->
<div id="cmtList">
    <div class="table-responsive">
        <table class="table align-middle">
            <thead>
            <tr>
                <td>작성자</td>
                <td>댓글내용</td>
                <td>글쓴날짜</td>
                <td>수정하기</td>
                <td>삭제하기</td>
            </tr>
            </thead>
            <tbody id="cmtTable">
            </tbody>
        </table>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
    const boardId = $("#boardId").text();
    const memberId = $("#memberId").val();
    /** 글 수정 페이지로 이동 요청 */
    $("#update").on('click', function () {
        location.href = "/board/update?id=" + boardId;
    });

    /** 리스트 페이지로 이동요청*/
    $("#list").on("click", function () {
        location.href = "/board/";
    });

    /** 글 삭제하기 요청*/
    $("#delete").on('click', function () {
        location.href = "/board/delete?id=" + boardId;
    });

    /** 페이지 시작시 댓글 목록 불러오기 */
    $(document).ready(function () {
        $.ajax({
            type: "get",
            url: "/board/detail/cmt?id=" + boardId,
            dataType: "json",
            success: function (res) {
                $.each(res, (i, item) => {
                    $("#cmtTable").append("<tr class='" + item.id + "'><td>" + item.cmtWriter +
                        "</td><td id='" + item.id + "'>" + item.cmtContents +
                        "</td><td>" + item.cmtCreatedTime +
                        "</td><td><button class='upd-btn' data-cmt-id='" + item.id + "'>수정</button></td>" +
                        "<td><button class='del-btn' data-cmt-id='" + item.id + "'>삭제</button></td></tr>"
                    )
                });
                $("#cmtNum").append("<span>"+res.length+"</span>");
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 댓글 작성시 댓글 저장하고 불러오기*/
    $(document).on('click', "#cmt-btn", function () {
        const cmtWriter = $("#cmtWriter").val();
        const cmtContents = $("#cmtContents").val();
        console.log(cmtContents + cmtWriter);
        $.ajax({
            type: "post",
            url: "/cmt/save",
            data: {
                "boardId": boardId,
                "memberId": memberId,
                "cmtWriter": cmtWriter,
                "cmtContents": cmtContents
            },
            success: function (res) {
                console.log(res)
                $("#cmtTable").prepend(
                    "<tr class='" + res.id + "'><td>" + res.cmtWriter +
                    "</td><td id='" + res.id + "'>" + res.cmtContents +
                    "</td><td>" + res.cmtCreatedTime +
                    "</td><td><button class='upd-btn' data-cmt-id='" + res.id + "'>수정</button></td>" +
                    "<td><button class='del-btn' data-cmt-id='" + res.id + "'>삭제</button></td></tr>"
                );
                $("#cmtContents").val('');
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 댓글 삭제버튼 클릭시 댓글 삭제하기 */
    $("#cmtTable").on("click", ".del-btn", function () {
        let cmtId = $(this).data("cmt-id");
        // 댓글 쓴 사람만 삭제하도록 처리하기 (memberId로 처리)
        $.ajax({
            type: "delete",
            url: "/cmt/" + cmtId,
            success: function () {
                alert("댓글이 삭제되었습니다");
                $("tr").remove("." + cmtId);
                //location.reload();
            },
            error: function (err) {
                console.log("요청실패", err);
            }
        });
    });

    /** 댓글 수정버튼 팝업 취소 요청 */
    $("#cmt-cancel").on("click", function () {
        // 댓글 수정창은 숨기고 다시 댓글 창이 보이도록 설정
        $("#cmtUpdate").css('display', 'none');
        $("#cmtWrite").css('display', 'block');
    });

    /** 댓글 수정버튼 클릭시 팝업 요청 */
    $(document).on("click", ".upd-btn", function () {
        let cmtId = $(this).data("cmt-id");
        $.ajax({
            type: "get",
            url: "/cmt/update/" + cmtId,
            success: function (res) {
                // 댓글 창을 숨기고 댓글 수정창을 띄워준다
                $("#cmtUpdate").css('display', 'block');
                $("#cmtWrite").css('display', 'none');
                $("#modalContents").val(res.cmtContents);
                // 댓글 수정창에 있는 댓글 버튼에 data 속성을 추가해줌
                $('#cmt-upd-btn').attr('data-cmt-id', cmtId)
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 댓글 수정 요청 */
    $(document).on("click", "#cmt-upd-btn", function () {
        let cmtId = $(this).data("cmt-id");
        let cmtContents = $("#modalContents").val();
        $.ajax({
            type: "post",
            url: "/cmt/update",
            data: {
                "id": cmtId,
                "cmtContents": cmtContents
            },
            success: function (res) {
                // 댓글 수정창은 숨기고 다시 댓글 창이 보이도록 설정
                $("#cmtUpdate").css('display', 'none');
                $("#cmtWrite").css('display', 'block');
                // 해당 댓글의 내용이 바뀌도록 한다
                $("#" + cmtId).html(res.cmtContents);
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

</script>
</body>
</html>
