<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>1
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	$(document).ready(
			function() {
				$(".dropdown").hover(
						function() {
							$('.dropdown-menu', this).not('.in .dropdown-menu')
									.stop(true, true).slideDown("400");
							$(this).toggleClass('open');
						},
						function() {
							$('.dropdown-menu', this).not('.in .dropdown-menu')
									.stop(true, true).slideUp("400");
							$(this).toggleClass('open');
						});
			});

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
	};

	initMap();
</script>
</head>
<body>

	<div class="container">

		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>


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
							<img src="resources/img/b.jpg" alt="...">
							<div class="carousel-caption">a</div>
						</div>

						<div class="item">
							<img src="resources/img/b.jpg" alt="...">
							<div class="carousel-caption">b</div>
						</div>

						<div class="item">
							<img src="resources/img/b.jpg" alt="...">
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
							<a href="notice_boardlist.do">	<span class="label label-default">More</span></a>
							</h3></td>


					</tr>
					<c:forEach var="tmp1" items="${btitle}">
						<tr>
							<td><a href="notice_boardcontent.do?no=${tmp1.getNo()}">${tmp1.getTitle()}</a></td>
						</tr>
					</c:forEach>


				</table>



				<hr />

			</div>



			<div class="col-md-4">
			
			
				<table class="table">
					<tr>
						<td><h3>SNS 이야기</h3></td>
						<td align="right"><h3>
								<span class="label label-default">More</span>
							</h3></td>


					</tr>
					<tr>
						<td>가나다라</td>
					</tr>


				</table>



				<hr />
			
			
			
			
			</div>

		</div>



		<c:import url="footer.jsp"></c:import>


	</div>




</body>
</html>