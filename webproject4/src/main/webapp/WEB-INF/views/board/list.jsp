<%@ page import="java.util.List" %>
<%@ page import="com.member.board.dto.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 7:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>List</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>

<div class="table-responsive">
    <table class="table align-middle">
        <thead>
        <tr>
            <td>글쓴이</td>
            <td>게시판타입</td>
            <td>제목</td>
            <td>글쓴날짜</td>
            <td>조회수</td>
        </tr>
        </thead>
        <tbody id="boardData">
        <!--제이쿼리로 게시판리스트들을 불러옴-->
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    /** 페이지 시작시 페이징 처리된 글 목록 불러오기 */
    $(document).ready(function () {
        console.log("start1");
        $.ajax({
            type: "get",
            url: "/board/list",
            dataType: "json",
            success: function (res) {
                console.log(res);
                $.each(res, (i, item) => {
                    $("#boardData").append(
                        "<tr><td>" + item.boardWriter +
                        "</td><td>" + item.boardType +
                        "</td><td><a href='/board/detail?id=" + item.id + "'>" + item.boardTitle +
                        "</td><td>" + item.boardCreatedDate +
                        "</a></td><td>" + item.boardView + "</tr>"
                    )
                });
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 페이지 시작시 글목록 이동 번호 불러오기 */
    $(document).ready(function () {
        console.log("start2");
        $.ajax({
            type: "get",
            url: "/board/listNum",
            dataType: "json",
            success: function (res) {
                console.log(res);
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

</script>
</body>
</html>
