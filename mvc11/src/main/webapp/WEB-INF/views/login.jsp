<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
</script>
</head>

<body>

	<div class="container">

		<div class="row" id="top-menu">
		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>
		</div>


		<div class="row">
			<div class="col-lg-12">
				<h2>로그인</h2>
				<hr />
				<br /> <br />
				<h3 style="text-align: center;">테스트회사 방문을 환영합니다</h3>
				<br />
				<h4 style="text-align: center;">회원가입을 하시면 다양한 서비스를 경험하실 수 있습니다.</h4>
				<br /> <br />


				<div class="panel panel-jong" style="margin: auto;">
					<div class="panel-body" style="margin-top: 60px;">
						<form:form action="loginpost.do" method="post"> 
						

							<div class="col-md-3"></div>
							<div class="col-md-5">
								<form:input class="form-control" path="id" name="_id" type="text"
									placeholder="아이디를 입력하세요" />
								<br />
								<form:input class="form-control" path="password" name="_pw" type="password"
									placeholder="암호를 입력하세요" />
							</div>
							<div class="col-md-4" align="left" style="margin-top: 22px;">
								<input type="submit" class="btn btn-primary btn-lg" value="버튼">
							</div>

						</form:form>
					</div>
				</div>

			</div>
		</div>
	</div>


</body>
</html>
