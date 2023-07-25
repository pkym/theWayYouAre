<%@ page import="java.util.List" %>
<%@ page import="com.member.board.dto.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/24
  Time: 7:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<% List<BoardDTO> boardDTOList = (List<BoardDTO>) request.getAttribute("boardList");%>
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
        <tbody>
        <%
            for (BoardDTO board : boardDTOList) {
        %>
        <tr class="align-middle">
            <td><%=board.getBoardWriter()%>
            </td>
            <td><%=board.getBoardType()%>
            </td>
            <td><a href="/board?id=<%=board.getId()%>"><%=board.getBoardTitle()%></a>
            </td>
            <td><%=board.getBoardCreatedTime()%>
            </td>
            <td><%=board.getBoardView()%>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
</div>


</body>
</html>
