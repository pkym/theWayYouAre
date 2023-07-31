<%--
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
<style>
    .tab-content {
        display: none;
    }
</style>
<body>
<!--네비게이션-->
<c:if test="${sessionScope.memberId != null}">
    <nav class="navbar navbar-expand-lg bg-light">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                    <li class="nav-item">
                        <a type="button" class="nav-link" id="write">글작성</a>
                    </li>
                    <li class="nav-item">
                        <a type="button" class="nav-link" id="page">커뮤니티</a>
                    </li>
                    <li class="nav-item">
                        <a type="button" class="nav-link" id="list">커뮤니티 ajax</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                                ${sessionScope.loginName}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a type="button" class="nav-link" id="update">마이페이지</a></li>
                            <li><a type="button" class="nav-link" id="logout">로그아웃</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled">${sessionScope.memberId}</a>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-secondary" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>


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
            <div style="display: flex; margin: 0px 100px;justify-content: center; " class="btn-group ">
                <button id="tab" class="btn btn-outline-secondary ">전체</button>
                <button id="tab1" class="btn btn-outline-secondary ">자유게시판</button>
                <button id="tab2" class="btn btn-outline-secondary ">질문&답변</button>
                <button id="tab3" class="btn btn-outline-secondary ">육아</button>
                <button id="tab4" class="btn btn-outline-secondary ">제보/알림</button>
            </div>
            <div id=tabC class="tab-Content">
                <tbody id="boardData">
                <!--제이쿼리로 게시판리스트들을 불러옴-->
                </tbody>
            </div>
        </table>
        <div id="paging">
            <ul class="pagination">
                <!--제이쿼리로 페이징 숫자들을 불러옴-->
            </ul>
        </div>
    </div>
</c:if>
<c:if test="${sessionScope.memberId == null}">
    <!-- 자연스럽게 로그인 페이지로 이동할 수 있는 방법 찾기-->
    <a type="button" class="btn btn-light" href="/">로그인하세요</a>
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    /** 글작성 페이지로 이동요청*/
    $("#write").on("click", function () {
        console.log("클릭이벤트발생");
        location.href = "/board/save";
    });
    /** 커뮤니티페이지로 이동요청*/
    $("#page").on("click", function () {
        location.href = "/board/paging";
    });
    /** 커뮤니티페이지로 이동요청, ajax 사용*/
    $("#list").on("click", function () {
        location.href = "/board/";
    });
    /** 회원수정 페이지로 이동요청*/
    $("#update").on("click", function () {
        location.href = "/member/update";
    });
    /** 로그아웃 요청*/
    $("#logout").on("click", function () {
        location.href = "/member/logout";
    });
    /** 탭 기능*/
    $("#tab").on("click", function () {
        $("tr").css("display", "");
    });
    $("#tab1").on("click", function () {
        $(".자유게시판").css("display", "");
        $("tr").not($(".자유게시판")).css("display", "none");
    });
    $("#tab2").on("click", function () {
        $(".질문\\&답변").css("display", "");
        $("tr").not($(".질문\\&답변")).css("display", "none");
    });
    $("#tab3").on("click", function () {
        $(".육아").css("display", "");
        $("tr").not($(".육아")).css("display", "none");
    });
    $("#tab4").on("click", function () {
        $(".제보\\/알림").css("display", "");
        $("tr").not($(".제보\\/알림")).css("display", "none");
    });


    /** 페이지 시작시 페이징 처리된 글 목록 불러오기 */
    $(document).ready(function () {
        // 게시글 불러오기
        $.ajax({
            type: "get",
            url: "/board/list",
            dataType: "json",
            success: function (res) {
                console.log(res);
                $.each(res, (i, item) => {
                    let output = "<tr class='" + item.boardType + "'><td>" + item.boardWriter +
                        "</td><td>" + item.boardType +
                        "</td><td><a href='/board/detail?id=" + item.id + "'>" + item.boardTitle +
                        "</td></a><td>" + item.boardCreatedTime +
                        "</td><td>" + item.boardView + "</tr>"
                    $("#boardData").append(
                        output
                    )
                });
            },
            error: function (err) {
                console.log(err);
            }
        });
        /** 페이징 번호들 불러오기 */
        $.ajax({
            type: "get",
            url: "/board/listNum",
            dataType: "json",
            success: function (res) {
                console.log(res);
                $(".pagination").append("<li class='page-item'><a class='page-link' id='pre' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a>");
                for (let i = res.startPage; i <= res.endPage; i++) {
                    $(".pagination").append(
                        "<li class='page-item'><button class='page-link' id='btn' data-btn='" + i + "'>" + i + "</button></li>"
                    )
                }
                ;
                $(".pagination").append("<li class='page-item'><a class='page-link' id='next' aria-label='Previous'><span aria-hidden='true'>&raquo;</span></a>");
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 버튼 클릭시 해당 게시글 가져오기*/
    $("#paging").on("click", "#btn", function () {
        // 클릭된 버튼의 색 바꿔주고 안클린된 버튼 색 되돌려주기
        $(this).css("color", "black");
        $("button").not($(this)).css("color", "");
        // 현재 클릭된 버튼의 페이지 값을 가져오기
        let i = $(this).data("btn");
        // 값을 이전이나 다음 버튼에 저장하기
        $("#pre").data("page", i);
        $("#next").data("page", i);
        // 값을 가져와 데이터 뿌리기
        $.ajax({
            type: "get",
            url: "/board/list?page=" + i,
            dataType: "json",
            success: function (res) {
                $("#boardData").replaceWith('<tbody id="boardData"></tbody>');
                $.each(res, (i, item) => {
                        $("#boardData").append(
                            "<tr class='" + item.boardType + "'><td>" + item.boardWriter +
                            "</td><td>" + item.boardType +
                            "</td><td><a href='/board/detail?id=" + item.id + "'>" + item.boardTitle +
                            "</td><td>" + item.boardCreatedTime +
                            "</a></td><td>" + item.boardView + "</tr>"
                        )
                    }
                );
            },
            error: function (err) {
                console.log(err);
            }
        });
    })


</script>
</body>
</html>
