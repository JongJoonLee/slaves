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
				<img style="margin-top: 3px;" src="resources/img/123.JPG" />
			</div>

			<!-- 검색창 -->
			<div class="col-md-6" style="margin-top: 10px;">
				<form action="#" method="get" class="form-inline">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search"
							style="width: 500px;">
						<button class="btn sr-btn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>

			</div>

			<div class="col-md-4" style="margin-top: 15px;">

				<a href="#"> <i class="fa fa-sitemap" aria-hidden="true"></i>
				</a> &nbsp;&nbsp;&nbsp; <a href="#"> <i class="fa fa-info-circle"
					aria-hidden="true"></i> &nbsp;&nbsp;&nbsp;
				</a> <a href="#"> <i class="fa fa-sign-in" aria-hidden="true"></i>
				</a>
			</div>
		</div>

		<!-- 상단 네비게이션 바 -->
		<div class="row">
			<nav class="navbar navbar-default">
				<div class="container-fluid">


					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">

							<li><a href="#">전자우편</a></li>
							<li><a href="#">전자결재</a></li>
							<li><a href="#">일정</a></li>
							<li><a href="#">문서관리 </a></li>
							<li><a href="#">업무지원</a></li>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">마이페이지</a></li>

						</ul>

						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><i class="fa fa-star" aria-hidden="true"></i>즐겨찾기</a></li>

						</ul>
					</div>
					<!-- /.navbar-collapse -->
				</div>
				<!-- /.container-fluid -->
			</nav>


		</div>


		<div class="row">
			<div class="col-md-3">
				<table class="table">
					<tr>
						<td class="success" colspan="2">사용자정보</td>
					</tr>
					<tr>
						<td><img width="100" height="120"
							src="resources/img/mypic.JPG" /></td>
						<td><b>김머시기 사원</b><br />부서 : 쫄병부<br />계정 : aaa@aaa.com<br />메일용량
							: 0 / 500Mb</td>
					</tr>

				</table>

				<table class="table">
					<tr>
						<td class="success">근태정보</td>
					</tr>
					<tr>
						<td></td>


					</tr>
				</table>


				<table class="table">
					<tr>
						<td class="success" colspan="2">전자결재</td>
					</tr>
					<tr>
						<td style="text-align: center;">결재할 문서</td>

						<td style="text-align: center;">상신한 문서</td>
					</tr>
					<tr>
						<td style="text-align: center;"><h2>0</h2></td>
						<td style="text-align: center;"><h2>0</h2></td>


					</tr>
				</table>


			</div>



			<div class="col-md-6">

				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">이야기</h3>
					</div>
					<div class="panel-body">
						<form action="#" method="post" class="form-inline">
							<div class="form-group">
								<textarea style="width: 460px;" class="form-control" rows="1"></textarea>
								<button class="btn btn-default">등록</button>
							</div>
						</form>
					</div>
				</div>
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">Panel title</h3>
						<span class="pull-right"> <!-- Tabs -->
							<ul class="nav panel-tabs">
								<li class="active"><a href="#tab1" data-toggle="tab">Tab
										1</a></li>
								<li><a href="#tab2" data-toggle="tab">Tab 2</a></li>
								<li><a href="#tab3" data-toggle="tab">Tab 3</a></li>
								<li><a href="#tab4" data-toggle="tab">Tab 4</a></li>
							</ul>
						</span>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane active" id="tab1">Lorem ipsum dolor
								sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
								tempor invidunt ut labore et dolore magna aliquyam erat, sed
								diam voluptua. At</div>
							<div class="tab-pane" id="tab2">Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet.</div>
							<div class="tab-pane" id="tab3">Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet.</div>
							<div class="tab-pane" id="tab4">Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet,
								consetetur sadipscing elitr, sed diam nonumy eirmod tempor
								invidunt ut labore et dolore magna aliquyam erat, sed diam
								voluptua. At vero eos et accusam et justo duo dolores et ea
								rebum. Stet clita kasd gubergren, no sea takimata sanctus est
								Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in
								hendrerit in vulputate velit esse molestie consequat, vel illum
								dolore eu feugiat nulla facilisis at vero eros et accumsan et
								iusto odio dignissim qui blandit praesent luptatum zzril delenit
								augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor
								sit amet,</div>
						</div>
					</div>
				</div>

				


			</div>
			<div class="col-md-3"></div>





		</div>




	</div>














	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>


</body>
</html>