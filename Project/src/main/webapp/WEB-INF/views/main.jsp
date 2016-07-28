<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

 <meta name="viewport" content="width=device-width, initial-scale=1"> 
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>로그인</title>

<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/css/font-awesome.css" rel="stylesheet">
<link href="resources/css/nav.css" rel="stylesheet">



<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<nav class="navbar navbar-findcond navbar-fixed-top">
    <div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"><img src="resources/images/logo.png" class="img-responsive" alt="" /></a>
		</div>
		<div class="collapse navbar-collapse" id="navbar">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-fw fa-bell-o"></i> 알림 <span class="badge">12</span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#"><i class="fa fa-fw fa-thumbs-o-up"></i> 알림 입니다</a></li>
						<li><a href="#"><i class="fa fa-fw fa-thumbs-o-up"></i> 알림 입니다</a></li>
						ㅍ
						<li><a href="#"><i class="fa fa-fw fa-thumbs-o-up"></i> 알림 입니다</a></li>
						
					</ul>
				</li>
				<li class="active"><a href="#">테스트 <span class="sr-only">(current)</span></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">관리자 <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">테스트</a></li>
						<li class="divider"></li>
						<li><a href="#">테스트</a></li>
						<li><a href="#exit">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<form class="navbar-form navbar-right search-form" role="search">
				<input type="text" class="form-control" placeholder="Search" />
			</form>
		</div>
	</div>
</nav>



	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script src="resources/js/jquery-1.12.3.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="resources/js/bootstrap.min.js"></script>
</body>
</html>