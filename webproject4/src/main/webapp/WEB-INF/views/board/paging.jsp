<%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/25
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>paging</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
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
</c:if>
<!--게시글 -->
<div class="table-responsive">
    <table class="table align-middle">
        <tr>
            <td>글쓴이</td>
            <td>게시판타입</td>
            <td>제목</td>
            <td>글쓴날짜</td>
            <td>조회수</td>
        </tr>
        <c:forEach items="${boardList}" var="board">
            <tr class="align-middle">
                <td>${board.boardWriter}</td>
                <td>${board.boardType}</td>
                <td>
                    <a href="/board/detail?id=${board.id}&page=${paging.page}">${board.boardTitle}</a>
                </td>
                <td>${board.boardCreatedTime}</td>
                <td>${board.boardView}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div>
    <c:choose>
        <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
        <c:when test="${paging.page<=1}">
            <span>[이전]</span>
        </c:when>
        <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
        <c:otherwise>
            <a href="/board/paging?page=${paging.page-1}">[이전]</a>
        </c:otherwise>
    </c:choose>

    <%--  for(int i=startPage; i<=endPage; i++)      --%>
    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
        <c:choose>
            <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
            <c:when test="${i eq paging.page}">
                <span>${i}</span>
            </c:when>

            <c:otherwise>
                <a href="/board/paging?page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:choose>
        <c:when test="${paging.page>=paging.maxPage}">
            <span>[다음]</span>
        </c:when>
        <c:otherwise>
            <a href="/board/paging?page=${paging.page+1}">[다음]</a>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
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