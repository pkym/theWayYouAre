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

<p id="boardId">${boardDTO.id}
</p>
${boardDTO.boardType}
${boardDTO.boardView}
${boardDTO.boardTitle}
${boardDTO.boardContents}
${boardDTO.boardCreatedTime}

<button id="list">글목록</button>
<button id="update">수정하기</button>
<button id="delete">삭제하기</button>


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
        location.href = "/board/list";
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
                    $("#cmtTable").append("<tr><td>" + item.cmtWriter +
                        "</td><td>" + item.cmtContents +
                        "</td><td>" + item.cmtCreatedTime +
                        "</td><td><button class='upd-btn' data-cmt-id='" + item.id + "'>수정</button></td>" +
                        "<td><button class='del-btn' data-cmt-id='" + item.id + "'>삭제</button></td></tr>"
                    )
                });
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
                    "<tr><td>" + res.cmtWriter +
                    "</td><td>" + res.cmtContents +
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
                location.reload();
            },
            error: function (err) {
                console.log("요청실패", err);
            }
        });
    });

    /** 댓글 수정버튼 클릭시 팝업 요청 */
    $(document).on("click", ".upd-btn", function () {
        let cmtId = $(this).data("cmt-id");
        $.ajax({
            type: "get",
            url: "/cmt/update/" + cmtId,
            success: function (res) {
                $("#cmtUpdate").css('display', 'block');
                $("#cmtWrite").css('display', 'none');
                $("#modalContents").val(res.cmtContents);
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
        console.log(cmtId + cmtContents);
        $.ajax({
            type: "post",
            url: "/cmt/update",
            data: {
                "id":cmtId,
                "cmtContents": cmtContents
            },
            success: function (res) {
                console.log(res.cmtContents)
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

</script>
</body>
</html>
