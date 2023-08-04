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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98c8661be0a413b412d7315735b24e96"></script>
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
    <div class="table">
    </div>
    <!--구글 -->
    <table border="1" id="table">
        <thead>
        <td>약국 이름</td>
        <td>약국 위치</td>
        <td>위도</td>
        <td>경도</td>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div id="map" style="width:500px;height:400px;"></div>



</c:if>
<c:if test="${sessionScope.memberId == null}">
    <!-- 자연스럽게 로그인 페이지로 이동할 수 있는 방법 찾기-->
    <a type="button" class="btn btn-light" href="/">로그인하세요</a>
</c:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<script>
    /** 지도 API */
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(35.1394294, 126.7964119), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };
    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    $(document).ready(function(){
        let bplcNm = [];
        let rdnWhlAddr = [];
        let latitude = [];
        let longitude = [];
        var positions= [];
        const tbody = $('#table tbody');
        $.ajax({
            method:'get',
            url: "https://apis.data.go.kr/B551232/OAMS_PARMACY_01/GET_OAMS_PARMACY_01",
            dataType:'xml',
            data:{
                serviceKey:"ZKiieHbBwQGTkPhH0wZRgTVdfaeRSRiBaykZfbj9U9gd3PhlZ/SYdi0o32aqiLK1k4fxqf/AqUMu4n3kghRqHQ==",
                pageNo:1,
                numOfRows:10,
                STATION_NAME:"광주송정역"
            },

            success : function(result){
                // 데이터 확인
                console.log(result);
                let xml = $(result).find("response");
                let len = xml.find("item").length;
                for (var i = 0; i< len; i++){
                    bplcNm[i]= xml.find("item").eq(i).find("bplcNm").text();
                    rdnWhlAddr[i] = xml.find("item").eq(i).find("rdnWhlAddr").text();
                    latitude[i] = xml.find("item").eq(i).find("latitude").text();
                    longitude[i] = xml.find("item").eq(i).find("longitude").text();
                }

                for (j = 0; j<len; j++){
                    var tr = "<tr>"+
                        "<td>"+bplcNm[j]+"</td>"+
                        "<td>"+rdnWhlAddr[j]+"</td>"+
                        "<td>"+latitude[j]+"</td>"+
                        "<td>"+longitude[j]+"</td>"+
                        +"</tr>";
                    tbody.append(tr);
                }

                for (k=0; k<len; k++){
                    var positioe = {
                        title:bplcNm[k],
                        lating: new kakao.maps.LatLng(latitude[k],longitude[k])
                    };
                    positions.push(positioe);
                }
                var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

                for (var e = 0; e< positions.length; e++) {
                    console.log(e)
                    // 마커 이미지의 이미지 크기 입니다
                    var imageSize = new kakao.maps.Size(24, 35);

                    // 마커 이미지를 생성합니다
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        map: map, // 마커를 표시할 지도
                        position: positions[e].latlng, // 마커를 표시할 위치
                        title : positions[e].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                        image : markerImage // 마커 이미지
                    });
                    marker.setMap(map);
                }
            },
            error: function(error){
                console.log("erro");
            }
        })
    });

    /** 페이지 시작시 조회수 top5 글 목록 불러오기
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
    });*/
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
