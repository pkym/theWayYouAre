<%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<%String loginName = (String)session.getAttribute("loginName");%>
<%Long memberId = (Long)session.getAttribute("memberId");%>
<%=loginName%>
<%=memberId%>


<!--글작성 버튼 jquery onclick 공식문서 작성-->
<button id="write">글작성</button>
<button id="list">글목록</button>
<a href="/board/paging">페이징 목록</a>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
    /** 글작성 페이지로 이동요청*/
    $("#write").on("click",function(){
       console.log("클릭이벤트발생");
       location.href="/board/save";
    });


    /** 리스트페이지로 이동요청*/
    $("#list").on("click",function(){
        location.href="/board/list";
    })

</script>
</body>
</html>
