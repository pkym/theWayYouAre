<%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Write</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body>
<%String loginName = (String) session.getAttribute("loginName");%>
<%Long memberId = (Long) session.getAttribute("memberId");%>

<form action="/board/save" method="post" onsubmit="return checkAll()">
    <input type="hidden" name="memberId" value="<%=memberId%>">
    <input class="form-control" type="text" name="boardWriter" value="<%=loginName%>"><br>
    <label for="type">게시판 선택</label>
    <select class="form-select" name="boardType" id="type">
        <option value="자유게시판">자유게시판</option>
        <option value="질문&답변">질문&답변</option>
        <option value="육아">육아</option>
        <option value="제보/알림">제보/알림</option>
    </select>
    <input class="form-control" type="text" name="boardTitle" id="title" placeholder="제목"><br>
    <textarea class="form-control" name="boardContents" id="contents" placeholder="내용을 입력하세요"></textarea><br>
    <input type="submit" value="작성">
</form>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>

    /** 빈칸 삽입 방지 */
    function checkAll(){
        if($("title").val()==null||$("#contents").val()==null){
            alert("제목과 내용을 입력하세요")
            return false;
        }return true;
    }

</script>



</body>

</html>
