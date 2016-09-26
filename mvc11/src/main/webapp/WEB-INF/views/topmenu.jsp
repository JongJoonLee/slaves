
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- TOP - MENU START -->








<nav class="navbar navbar-white navbar-static-top navbar-fixed-top" style="max-width: 1200px; display:block;  margin-left: auto; margin-right: auto;">
	<div class="navbar-header">
		<button class="navbar-toggle" type="button" data-toggle="collapse"
			data-target=".js-navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand2" href="index.do"><img src="resources/img/logo.jpg" style="margin-bottom: 25px; margin-top: 0px;"/></a>
	</div>

	<div class="collapse navbar-collapse js-navbar-collapse">
		<ul class="nav navbar-nav" >


				
			<li style="margin-top: 15px;"><font SIZE="5" COLOR="black"><a href="#">회사소개</a></font></li>
			<li style="margin-top: 21px; color: #C4C4C4;" >&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			<li style="margin-top: 15px;"><font SIZE="5" COLOR="black"><a href="#">생산제품</a></font></li>
			<li style="margin-top: 21px; color: #C4C4C4;">&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			<li style="margin-top: 15px;"><font SIZE="5" COLOR="black"><a href="notice_boardlist.do">공지사항</a></font></li>
			<li style="margin-top: 21px; color: #C4C4C4;">&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			<li style="margin-top: 15px;"><font SIZE="5" COLOR="black"><a href="#">인재채용</a></font></li>
			<li style="margin-top: 21px; color: #C4C4C4;">&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			<li style="margin-top: 15px;"><font SIZE="5" COLOR="black"><a href="#">Q & A</a></font></li>
		</ul>
		
		
		

		<c:set var="session" value="${_id}" />

		<c:choose>

			<c:when test="${session eq null}">

				<ul class="nav navbar-nav navbar-right" >

					<li style="margin-top: 10px;"><a href="login.do?prev=${prev}">로그인</a></li>
					<li style="margin-top: 10px;"><a href="joinpage.do">회원가입</a></li>
				</ul>
			</c:when>
			<c:otherwise>



				<!-- 마이어카운트 시작 -->
				<ul class="nav navbar-nav navbar-right" >
					<li class="active dropdown"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-expanded="false" style="margin-top: 5px;padding-top: 10px; margin-right: 4px;"> ${_name} <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu" >
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