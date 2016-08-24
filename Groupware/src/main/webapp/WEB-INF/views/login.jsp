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
<title>로그인</title>

<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/font-awesome.css" rel="stylesheet" />
<link href="resources/css/mystyle.css" rel="stylesheet" />

<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

	<div class="container">
		<div class="row" style="margin-top: 300px;">
			<div class="col-md-8">

				<img width="100%" src="resources/img/red.png" />


			</div>


			<div style="margin-top: 50px;" class="col-md-4">

				<h2>회사이름로고</h2>

				<form action="#" method="post">
					<input style="margin-bottom: 15px;" type="text"
						class="form-control" placeholder="User ID" /> <input
						style="margin-bottom: 15px;" type="password" class="form-control"
						placeholder="Password" />
					

					<div class="dropdown">
						
					
						<button class="btn btn-default dropdown-toggle" type="button"
							id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" style="margin-right: 30px;">
							한국어 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu"
							aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#">한국어</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1"
								href="#">ENGLISH</a></li>
							
						</ul>
						<button style="margin-left: 175px;" class="btn btn-primary" type="submit" >LOGIN</button>
					</div>




				</form>





			</div>


		</div>
	</div>







	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>





</body>
</html>