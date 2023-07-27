<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
</head>
<body>

<div style = "margin-top: 100px;" class="d-grid gap-2 col-6 mx-auto">
    <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#join" type="button">가입하기</button>
    <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#login" type="button">로그인하기</button>
</div>
<!--회원가입 모달창-->
<div id="join" class="modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원가입하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/member/join" method="post">
                    <input type="text" name="memberEmail" placeholder="이메일" id="memberEmail" onblur="emailCheck()">
                    <p id = "check-result"></p>
                    <input type="password" name="memberPw" placeholder="비밀번호">
                    <input type="text" name="memberName" placeholder="닉네임">
                    <input class="btn btn-light" type="submit" value="회원가입">
                </form>
            </div>
        </div>
    </div>
</div>
<!--로그인 모달창-->
<div id="login" class="modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">로그인하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/member/login" method="post">
                    <input type="text" name="memberEmail" placeholder="이메일">
                    <input type="password" name="memberPw" placeholder="비밀번호">
                    <input class="btn btn-light" type="submit" value="로그인하기">
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script>

    /** 이메일 중복 여부 체크 */
    const emailCheck = () => {
        const email =$("#memberEmail").val();
        const checkResult = $("#check-result");
        console.log("입력한 이메일", email);
        $.ajax({
            type: "post",
            url: "/member/emailCheck",
            data: {
                "memberEmail": email
            },
            success: function(res) {
                console.log("요청성공", res);
                if (res == "ok") {
                    console.log("사용가능한 이메일");
                    checkResult.css("color","green");
                    checkResult.html("사용가능한 이메일");
                } else {
                    console.log("이미 사용중인 이메일");
                    checkResult.css("color","red")
                    checkResult.html("이미 사용중인 이메일");
                }
            },
            error: function(err) {
                console.log("에러발생", err);
            }
        });
    };

</script>
</body>

</html>