<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>인덱스</title>

<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/font-awesome.css" rel="stylesheet" />
<link href="resources/css/mystyle.css" rel="stylesheet" />
<link href="resources/css/footer-v6.css" rel="stylesheet" />
<link rel='stylesheet' type='text/css'
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>


<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9TEWZ1WTrfrDiOb2y8KxPtZJt98IOW3I&callback=initMap"
	async defer></script>
<script type="text/javascript">
	function initMap() {
		// Create a map object and specify the DOM element for display.
		var map = new google.maps.Map(document.getElementById('map'), {
			center : {
				lat : 35.153178,
				lng : 129.059263
			},
			scrollwheel : false,
			zoom : 15
		});
		
		var marker = new google.maps.Marker({
		    position:{
				lat : 35.153178,
				lng : 129.059263
			},
		    map: map,
		    title: 'TEST COMPANY'
		  });
		
		
	};

	initMap();
</script>
<style type="text/css">
/*YOUR CSS SHOULD LOOK LIKE THIS*/

/* unvisited link grey */
#top-menu a:link {
	color: #777;
}
/* visited link grey */
#top-menu a:visited {
	color: #777;
}
/* mouse over link blue */
#top-menu a:hover {
	color: #777;
}
/* selected link blue */
#top-menu a:active {
	color: #777;
}
/* !IMPORTANT ONLY ADD THIS CLASS TO YOUR ACTIVE PAGE LINK ( Color Blue )*/
.activePage a {
	color: #0CF !important
}



</style>




</head>
<body>
	<div id="fb-root"></div>
	<script>
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.7";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>


	<div class="container">
	
		<div class="row" id="top-menu">
		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>
		</div>

		<div class="row">

			<div class="col-md-3"></div>
			<div class="col-md-6"></div>


			<div class="col-lg-8">

				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="resources/img/a1a1.JPG" height="30px">
							<div class="carousel-caption"></div>
						</div>

						<div class="item">
							<img src="resources/img/b2b2.JPG" height="30px">
							<div class="carousel-caption"></div>
						</div>

						<div class="item">
							<img src="resources/img/a3a3.JPG" height="30px">
							<div class="carousel-caption">c</div>
						</div>
					</div>



					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>

				</div>



			</div>



			<div class="col-lg-4">
				<div id="map"
					style="width: 100%; height: 420px; border: 1px solid #cccccc"></div>
			</div>
		</div>


		<div class="row">

			<div class="col-md-4">
				<div class="row" style="margin: 1px">
					<img style="max-width: 100%; height: auto;"
						src="resources/img/b1.jpg">
				</div>
				<div class="row" style="margin: 1px">
					<img style="max-width: 100%; height: auto;"
						src="resources/img/b2.jpg">
				</div>
			</div>


			<div class="col-md-4">

				<table class="table">
					<tr>
						<td><h3>공지사항</h3></td>
						<td align="right"><h3>
								<a href="notice_boardlist.do"> <span
									class="label label-default">More</span></a>
							</h3></td>


					</tr>
					<c:forEach var="tmp1" items="${btitle}">
						<tr>
							<td><a href="notice_boardcontent.do?no=${tmp1.getNo()}">${tmp1.getTitle()}</a></td>
						</tr>
					</c:forEach>


				</table>



				
			</div>



			<div class="col-md-4">


				<table class="table">
					<tr>
						<td><h3>SNS 이야기</h3></td>
						<td align="right"><h3>
								<span style="margin-top:3px;" class="fa fa-facebook-square"></span>
							</h3></td>


					</tr>
					
				<tr>
				<td style="margin:0px;">

				<!-- 페이스북 페이지연동 -->
				<div class="fb-page" style="width: 100%; height: 100%"
					data-href="https://www.facebook.com/OverwatchKR" data-width="500"
					data-hide-cover="false" data-show-facepile="false"
					data-show-posts="false"></div>
				<!-- 페이스북 페이지연동 끝 -->
				</td>
				</tr>
				</table>




			



			</div>

		</div>



		<c:import url="footer.jsp"></c:import>


	</div>




</body>
</html>