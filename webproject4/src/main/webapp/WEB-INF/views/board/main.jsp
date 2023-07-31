<%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Home</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
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
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
    <!--조회수 top5 게시물-->
    <div class="card-group">
    </div>



</c:if>
<c:if test="${sessionScope.memberId == null}">
    <!-- 자연스럽게 로그인 페이지로 이동할 수 있는 방법 찾기-->
    <a type="button" class="btn btn-light" href="/">로그인하세요</a>
</c:if>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
    /** 페이지 시작시 조회수 top5 글 목록 불러오기 */
    $(document).ready(function () {
        // 게시글 불러오기
        $.ajax({
            type: "get",
            url: "/board/list5",
            dataType: "json",
            success: function (res) {
                console.log(res);
                $.each(res, (i, item) => {
                    $(".card-group").append(
                        '<div class="card">' +
                        '<a href="/board/detail?id='+item.id+'"><img src="" class="card-img-top" alt="...">' +
                        '</a><div class="card-body">' +
                        '<h5 class="card-title">' + item.boardTitle + '</h5>' +
                        '<p class="card-text">' + item.boardContents + '</p>' +
                        '<p class="card-text"><small class="text-muted">' + item.boardCreatedTime + '</small></p>' +
                        '</div></div>'
                    )
                });
            },
            error: function (err) {
                console.log(err);
            }
        });
    });
    /** 글작성 페이지로 이동요청*/
    $("#write").on("click", function () {
        console.log("클릭이벤트발생");
        location.href = "/board/save";
    });
    /** 커뮤니티페이지로 이동요청*/
    $("#page").on("click", function () {
        location.href = "/board/paging";
    })
    /** 커뮤니티페이지로 이동요청, ajax 사용*/
    $("#list").on("click", function () {
        location.href = "/board/";
    })
    /** 회원수정 페이지로 이동요청*/
    $("#update").on("click", function () {
        location.href = "/member/update";
    })
    /** 로그아웃 요청*/
    $("#logout").on("click", function () {
        location.href = "/member/logout";
    })
</script>
</body>
</html>
