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
    <link rel="stylesheet" href="style.css">
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
    <select id="station" onchange="select(this.value)">
        <option value="평동">평동역</option>
        <option value="도산">도산역</option>
        <option value="광주송정역">광주송정역</option>
        <option value="송정공원">송정공원역</option>
        <option value="공항">공항역</option>
        <option value="김대중컨벤션센터">김대중컨벤션센터역</option>
        <option value="상무">상무역</option>
        <option value="운천">운천역</option>
        <option value="쌍촌">쌍촌역</option>
        <option value="화정">화정역</option>
        <option value="농성">농성역</option>
        <option value="돌고개">돌고개역</option>
        <option value="양동시장">양동시장역</option>
        <option value="금남로5가">금남로5가역</option>
        <option value="금남로4가">금남로4가역</option>
        <option value="문화전당">문화전당역</option>
        <option value="남광주">남광주역</option>
        <option value="학동">학동역</option>
        <option value="소태">소태역</option>
        <option value="녹동">녹동역</option>
    </select>
    <button id="subBtn" type="button" onclick="submit()">검색</button>

    <table border="1" id="table" style="width: 800px;">
        <thead>
        <td>약국 이름</td>
        <td>약국 위치</td>
        <td>위도</td>
        <td>경도</td>
        <td>영업중</td>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div class="map_wrap">
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

        <div id="menu_wrap" class="bg_white">

            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </div>


</c:if>
<c:if test="${sessionScope.memberId == null}">
    <!-- 자연스럽게 로그인 페이지로 이동할 수 있는 방법 찾기-->
    <a type="button" class="btn btn-light" href="/">로그인하세요</a>
</c:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
        integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script>
    let bplcNm = [];
    let rdnWhlAddr = [];
    let latitude = [];
    let longitude = [];
    let dtlStateNm = [];
    let places = [];
    const tbody = $('#table tbody');
    var container = document.getElementById('map');//지도를 담을 영역의 DOM 레퍼런스
    var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
    var map;
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});
    var customWindow = new kakao.maps.CustomOverlay({zIndex:1});
    var markers = [];
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }
    //---------------------------------------------------------Clearing Function-------------------------------------------------------------------------//
    function submit(){
        var listEl = document.getElementById('placesList');
        places = [];
        if(listEl.children>0){
            removeAllChildNods("listEl");
        }
        clearTable();

        dataSend();

        console.log(listEl.children);

    }
    //---------------------------------------------------------SelectBar Function-------------------------------------------------------------------------//
    var selectV;
    function select(value){
        selectV = value;
    }
    //---------------------------------------------------------Table Reset Function-----------------------------------------------------------------------//
    function clearTable(){
        $("#table tbody tr").remove();

    }
    //---------------------------------------------------------Table Mapping Function---------------------------------------------------------------------//
    function tableMapping(len, xml){
        for (var i = 0; i< len; i++){
            bplcNm[i]= xml.find("item").eq(i).find("bplcNm").text();
            rdnWhlAddr[i] = xml.find("item").eq(i).find("rdnWhlAddr").text();
            latitude[i] = Number(xml.find("item").eq(i).find("latitude").text());
            longitude[i] = Number(xml.find("item").eq(i).find("longitude").text());
            dtlStateNm[i] = xml.find("item").eq(i).find("dtlStateNm").text();
        }
        for (var i=0; i<len; i++){
            var placesTemp = new Object();
            placesTemp.bplcNm = bplcNm[i];
            placesTemp.rdnWhlAddr = rdnWhlAddr[i];
            placesTemp.latitude = latitude[i];
            placesTemp.longitude = longitude[i];
            placesTemp.dtlStateNm = dtlStateNm[i];
            places.push(placesTemp);
        }
        console.log(places);
        for (var j = 0; j<len; j++){
            var tr = "<tr>"+
                "<td>"+bplcNm[j]+"</td>"+
                "<td>"+rdnWhlAddr[j]+"</td>"+
                "<td>"+latitude[j]+"</td>"+
                "<td>"+longitude[j]+"</td>"+
                "<td>"+dtlStateNm[j]+"</td>"+
                +"</tr>";
            tbody.append(tr);
        }
        return places;
    }
    //---------------------------------------------------------KAKAO Mapping Function--------------------------------------------------------------------//
    function mapping(arr){

        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(arr[0], arr[1]), //지도의 중심좌표.
            level: 4 //지도의 레벨(확대, 축소 정도)
        };
        map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    }
    //---------------------------------------------------------Average latitude Function--------------------------------------------------------------------//
    function aLat(){
        var sum = 0;
        for(var i = 0; i<latitude.length; i++){
            sum += latitude[i];
        }
        console.log(sum/latitude.length);
        return sum/latitude.length;
    }
    //---------------------------------------------------------Average Longitude Function--------------------------------------------------------------------//
    function aLong(){
        var sum = 0;
        for(var i = 0; i<longitude.length; i++){
            sum += Number(longitude[i]);
        }
        console.log(sum/longitude.length);
        return sum/longitude.length;
    }

    //---------------------------------------------------------Marker Hover Event Infomation Function--------------------------------------------------------//
    function displayInfowindow(marker, title) {
        var content = '<span class="info-title">' +'<img class="infoImg" src="markerIcon.png"/>'+ title + '</span>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
        //---------------------------------------------------------Customizing Infowindow Function--------------------------------------------------------------//
        var infoTitle = document.querySelectorAll('.info-title');
        infoTitle.forEach(function(e) {
            var w = 120;
            var ml = w/2;

            e.parentElement.style.left = "50%";
            e.parentElement.style.marginLeft = -ml+"px";
            e.parentElement.style.width = w+"px";
            e.parentElement.previousSibling.style.display = "none";
            e.parentElement.parentElement.style.border = "0px";
            e.parentElement.parentElement.style.background = "unset";
        });
    }
    //---------------------------------------------------------Data List Insert Li Element Function----------------------------------------------------------//
    function getListItem(index, places) {
        console.log(places);
        var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.bplcNm + '</h5>';

        if (places.rdnWhlAddr) {
            itemStr += '    <span>' + places.rdnWhlAddr + '</span>' +
                '   <span class="jibun gray">' +  places.rdnWhlAddr  + '</span>';
        }
        itemStr += '  <span class="tel">' + places.dtlStateNm  + '</span>' +'</div>';
        el.innerHTML = itemStr;
        el.className = 'item';
        return el;
    }

    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }
    //---------------------------------------------------------Places Marker Function----------------------------------------------------------------------//
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다


        for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].latitude, places[i].longitude),
                marker = addMarker(placePosition, i,places[i].bplcNm),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function(marker, title) {
                kakao.maps.event.addListener(marker, 'mouseover', function() {
                    displayInfowindow(marker, title);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                });

                itemEl.onmouseover =  function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout =  function () {
                    infowindow.close();
                };
            })(marker, places[i].bplcNm);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }
    //---------------------------------------------------------API Ajax Communication Function--------------------------------------------------------------//
    function dataSend(){

        const tbody = $('#table tbody');
        $.ajax({
            method:'get',
            url: "https://apis.data.go.kr/B551232/OAMS_PARMACY_01/GET_OAMS_PARMACY_01",
            dataType:'xml',
            data:{
                serviceKey:"ZKiieHbBwQGTkPhH0wZRgTVdfaeRSRiBaykZfbj9U9gd3PhlZ/SYdi0o32aqiLK1k4fxqf/AqUMu4n3kghRqHQ==",
                pageNo:1,
                numOfRows:10,
                STATION_NAME:selectV
            },

            success : function(result){
                // 데이터 확인
                console.log(result);
                let xml = $(result).find("response");
                let len = xml.find("item").length;
                if(len>0){
                    tableMapping(len,xml);
                    mapping([aLat(),aLong()]);
                    displayPlaces(places);
                }else{
                    alert("해당 역 인근에 약국이 없습니다.");
                }
            },
            error: function(error){
                console.log("error");
            }
        })
    }


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
