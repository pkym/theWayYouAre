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
<% BoardDTO boardDTO = (BoardDTO) request.getAttribute("boardDTO");%>
<p id="boardId"><%=boardDTO.getId()%>
</p>
<%=boardDTO.getBoardType()%>
<%=boardDTO.getBoardView()%>
<%=boardDTO.getBoardTitle()%>
<%=boardDTO.getBoardContents()%>

<button id="list">글목록</button>
<button id="update">수정하기</button>
<button id="delete">삭제하기</button>


<!-- 댓글 쓰기 -->
<div id="cmtWrite">
    <input type="hidden" id="memberId" value="<%=session.getAttribute("memberId")%>">
    <input class="form-control" type="text" id="cmtWriter" value="<%=session.getAttribute("loginName")%>" readonly>
    <input class="form-control" type="text" id="cmtContents" placeholder="내용">
    <button class="btn btn-outline-secondary" id="cmt-btn">댓글작성</button>
</div>
<% List<CmtDTO> cmtDTOList = (List<CmtDTO>) request.getAttribute("cmtDTOList");%>
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
            <%
                for (CmtDTO cmt : cmtDTOList) {
            %>
            <tr class="align-middle">
                <td><%=cmt.getCmtWriter()%>
                </td>
                <td><%=cmt.getCmtContents()%>
                </td>
                <td><%=cmt.getCmtCreatedTime()%>
                </td>
                <td>
                    <button id="update-btn"  >수정</button>
                </td>
                <td>
                    <button id="delete-btn">삭제</button>
                </td>
            </tr>
            <%
                }
                ;
            %>
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

    /** 비동기적으로 댓글 저장하고 불러오기*/
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
                    "</td><td><button>수정</button></td>" +
                    "<td><button>삭제</button></td></tr>"
                );
                $("#cmtContents").val('');
            },
            error: function (err) {
                console.log(err);
            }
        });
    });

    /** 비동기식으로 댓글 수정하기 */
    $('#update-btn').on('click', function () {

    })

</script>
</body>
</html>
