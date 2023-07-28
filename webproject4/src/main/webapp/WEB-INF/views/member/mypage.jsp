<%--
  Created by IntelliJ IDEA.
  User: keeyoungmin
  Date: 2023/07/28
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Update</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<!-- 버튼 목록-->
<div style="margin-top: 300px">
    <div class="d-grid gap-2 col-6 mx-auto">
        <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#myModal" type="button">회원정보수정하기
        </button>
        <button class="btn btn-secondary" id="delete">탈퇴하기</button>
        <button class="btn btn-light" id="cancel">취소</button>
    </div>
</div>
<!-- 회원정보 수정 모달창 -->
<div id="myModal" class="modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원정보수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" id="memberId" value="${updateMember.id}"><br>
                이메일: <input class="form-control" type="text" id="memberEmail" value="${updateMember.memberEmail}"
                            readonly>
                비밀번호: <input class="form-control" type="password" id="memberPw" value="${updateMember.memberPw}">
                이름: <input class="form-control" type="text" id="memberName"
                           value="${updateMember.memberName}"><br>
                <button class="btn btn-light" id="upd-btn">회원정보수정</button>
            </div>
        </div>
    </div>
</div>


</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script>
    let memberId = $("#memberId").val();
    /** 취소버튼클릭시 메인으로 이동*/
    $("#cancel").on("click", function () {
        location.href = "/member/";
    });

    /** 회원 탈퇴하기 */
    $("#delete").on("click", function () {
        alert("탈퇴하시겠습니까?");
        location.href = "/member/" + memberId;
    });

    /** 회원 수정하기 */
    $("#upd-btn").on("click", function () {
        let memberName = $("#memberName").val();
        let memberPw = $("#memberPw").val();
        let memberEmail = $("#memberEmail").val();
        console.log(memberId+memberName+memberPw);
        $.ajax({
            type: "post",
            url: "/member/update",
            data: {
                "id": memberId,
                "memberEmail" : memberEmail,
                "memberName": memberName,
                "memberPw": memberPw
            },
            success: function(res){
                alert("수정되었습니다")
                console.log(res);
            },
            error: function(err){
                alert("다시 시도하세요")
                console.log(err);
            }
        });
    });


</script>


</html>
