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
</head>
<body>
${sessionScope.loginName}
${sessionScope.memberId}


<!--글작성 버튼 jquery onclick 공식문서 작성-->
<button id="write">글작성</button>
<button id="page">커뮤니티</button>
<button id="list">리스트ajax</button>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
    /** 글작성 페이지로 이동요청*/
    $("#write").on("click", function () {
        console.log("클릭이벤트발생");
        location.href = "/board/save";
    });
    /** 리스트페이지로 이동요청(페이징처리 x)*/
    $("#list").on("click", function () {
        location.href = "/board/";
    })
    /** 커뮤니티페이지로 이동요청*/
    $("#page").on("click", function () {
        location.href = "/board/paging";
    })

</script>
</body>
</html>
