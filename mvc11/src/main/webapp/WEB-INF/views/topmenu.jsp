
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- TOP - MENU START -->








<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button class="navbar-toggle" type="button" data-toggle="collapse"
			data-target=".js-navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="index.do">H O M E</a>
	</div>

	<div class="collapse navbar-collapse js-navbar-collapse">
		<ul class="nav navbar-nav">



			<li><a href="#">회사소개</a></li>
			<li><a href="#">생산제품</a></li>
			<li><a href="notice_boardlist.do">공지사항</a></li>
			<li><a href="#">인재채용</a></li>
			<li><a href="#">Q & A</a></li>
		</ul>





		<c:set var="session" value="${_id}" />

		<c:choose>

			<c:when test="${session eq null}">

				<ul class="nav navbar-nav navbar-right">

					<li class="active"><a href="login.do?prev=${prev}">로그인</a></li>
					<li class="active"><a href="joinpage.do">회원가입</a></li>
				</ul>
			</c:when>
			<c:otherwise>



				<!-- 마이어카운트 시작 -->
				<ul class="nav navbar-nav navbar-right">
					<li class="active dropdown"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-expanded="false"> ${_name} <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li class="divider"></li>
							<li><a href="logout.do?prev=${prev}">로그아웃</a></li>
						</ul></li>
					<!-- 마이어카운트 끝 -->
				</ul>

			</c:otherwise>
		</c:choose>




	</div>
	<!-- /.nav-collapse -->
</nav>



<!-- TOP - MENU END -->