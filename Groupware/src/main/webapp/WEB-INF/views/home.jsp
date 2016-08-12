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

<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>


	<div class="container">
		<div class="row">

			<!-- 회사로고로 바꿀것 -->
			<div class="col-md-2">
				<img style="margin-top:3px;" src="resources/img/123.JPG" />
			</div>

			<!-- 검색창 -->
			<div class="col-md-6" style="margin-top:10px;">
				<form action="#" method="get" class="form-inline">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search" style="width:500px;">
						<button class="btn sr-btn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>

			</div>

			<div class="col-md-4">
			
			<i class="fa fa-sitemap" aria-hidden="true"></i>
			
			
			
			
			
			</div>



		</div>
	</div>














	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
</body>
</html>