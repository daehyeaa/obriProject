<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://maps.googleapis.com/maps/api/js">
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEM3FEmY5ecJzAkXH9TDRAs1MaXpSWtME"
  type="text/javascript"></script>
<script>
var lat = '${lat}'
var lng = '${lng}'

var myCenter=new google.maps.LatLng(lat, lng);
//var myCenter=new google.maps.LatLng(37.497975, 127.027506);
var marker;

function initialize(){
var mapProp = {
  center:myCenter,
  zoom:16,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };

var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

var marker=new google.maps.Marker({
  position:myCenter,
  animation:google.maps.Animation.BOUNCE 
  });

marker.setMap(map);
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>

${address } <br>
위도 : ${lat } <br>
경도 : ${lng } <br><br>

<input type="button" value="재검색"  onClick="location.href='main'">
<br><br><br>

<div id="googleMap" style="width:500px;height:380px;"></div>
</body>
</html>