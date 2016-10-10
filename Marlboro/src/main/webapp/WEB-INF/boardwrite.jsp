<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="resources/css/font-awesome.css" rel="stylesheet">
<!-- 엔프로그레스 -->
<link href="resources/css/nprogress.css" rel="stylesheet">
<!-- jQuery 커스텀 스크롤바 -->
<link href="resources/css/jquery.mCustomScrollbar.min.css"
	rel="stylesheet" />

<!-- Custom Theme Style -->
<link href="resources/css/custom.css" rel="stylesheet">
<link href="resources/css/timelinejinsu.css" rel="stylesheet">
</head>
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col menu_fixed">

				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.do" class="site_title"><i class="fa fa-apple"></i>
							<span> DOUNGSUNG</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="resources/images/img.jpg" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>환영합니다,</span>
							<h2>김진수님 (PI팀/부장)</h2>
							<br /> <br />

						</div>
					</div>
					<!-- /menu profile quick info -->

					<br /> <br />

					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>카테고리</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-home"></i> Home</a></li>



								<li><a><i class="fa fa-envelope"></i> 메일 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">전체 메일함</a></li>
										<li><a href="#">받은 메일함</a></li>
										<li><a href="#">보낸 메일함</a></li>
										<li><a href="#">임시 보관함</a></li>
										<li><a href="#">내게 쓴 메일함</a></li>
										<li><a href="#">스팸 메일함</a></li>
										<li><a href="#">휴지통</a></li>
									</ul></li>

								<li><a><i class="fa fa-desktop"></i> 근태관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">출근 등록</a></li>
										<li><a href="#">퇴근 등록</a></li>
										<li><a href="#">외근 등록</a></li>
										<li><a href="#">출장 등록</a></li>
										<li><a href="#">초과 근무 등록</a></li>
										<li><a href="#">휴일 근무 등록</a></li>
									</ul></li>

								<li><a><i class="fa fa-file-text"></i> 결재관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a>Workflow<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">양식함</a></li>
												<li><a href="#">결재함</a></li>
												<li><a href="#">결재진행함</a></li>
												<li><a href="#">반려함</a></li>
												<li><a href="#">임시저장함</a></li>
											</ul></li>

										<li><a>비용 처리<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">법인카드 승인내역</a></li>
												<li><a href="#">비용처리 진행함</a></li>
												<li><a href="#">비용처리 완료함</a></li>
												<li><a href="#">비용처리 취소함</a></li>
												<li><a href="#">비용처리 내역 조회</a></li>
											</ul></li>

										<li><a>구매 요청<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">결재 전송함</a></li>
												<li><a href="#">결재 진행함</a></li>
												<li><a href="#">반려함</a></li>
												<li><a href="#">작성중 문서</a></li>
											</ul></li>

										<li><a>예산 관리<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">임시 저장함</a></li>
												<li><a href="#">진행함</a></li>
												<li><a href="#">완료함</a></li>
												<li><a href="#">취소함</a></li>
											</ul></li>

										<li><a>명함 신청<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">반려된 문서</a></li>
												<li><a href="#">접수 대기 문서</a></li>
												<li><a href="#">완료 현황</a></li>
											</ul></li>

										<li><a>판촉물 신청<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">반려된 문서</a></li>
												<li><a href="#">접수 대기 문서</a></li>
												<li><a href="#">완료 현황</a></li>
											</ul></li>

										<li><a>홍보 업무 신청<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">반려된 문서</a></li>
												<li><a href="#">진행 현황</a></li>
												<li><a href="#">완료 현황</a></li>
											</ul></li>

										<li><a>건축물 관리<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">승인 대기 문서</a></li>
												<li><a href="#">반려된 문서</a></li>
												<li><a href="#">완료 현황</a></li>
											</ul></li>
									</ul></li>

								<li><a><i class="fa fa-newspaper-o"></i> 공고 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a>공지 사항<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">임시 저장</a></li>
												<li><a href="#">승인 대기</a></li>
												<li><a href="#">반려함</a></li>
												<li><a href="#">게시 만료</a></li>

											</ul></li>

										<li><a>설문 조사<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">설문 참여</a></li>
												<li><a href="#">설문 결과</a></li>
											</ul></li>

										<li><a>방문 일지<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">일일 방문 일지</a></li>
												<li><a href="#">장기 방문 일지</a></li>
												<li><a href="#">협력 업체</a></li>
											</ul></li>
									</ul></li>

								<li><a><i class="fa fa-briefcase"></i> 업무 일지 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">전체 일지 보기</a></li>
										<li><a href="#">업무 일지 작성</a></li>
									</ul></li>


								<li><a><i class="fa fa-calendar"></i> 스케줄 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">전체 일정 보기</a></li>
										<li><a href="#">일정 작성</a></li>
									</ul></li>

								<li><a><i class="fa fa-question-circle"></i> 지원 요청 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">Helpdesk</a></li>
										<li><a href="#">완료함</a></li>

									</ul></li>

								<!-- <li><a><i class="fa fa-question-circle"></i> 지원요청</a></li> -->
								<li><a><i class="fa fa-commenting"></i> 라운지</a></li>
								<li><a><i class="fa fa-sitemap"></i> 조직도</a></li>


							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->





					<!-- /menu footer buttons -->
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Settings">
							<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="FullScreen">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Lock"> <span
							class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Logout">
							<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
						</a>
					</div>
					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>

					<ul class="nav navbar-nav navbar-right">
						<li class=""><a href="javascript:;"
							class="user-profile dropdown-toggle" data-toggle="dropdown"
							aria-expanded="false"> <img src="resources/images/img.jpg"
								alt="">김진수 <span class=" fa fa-angle-down"></span>
						</a>
							<ul class="dropdown-menu dropdown-usermenu pull-right">
								<li><a href="javascript:;">프로필</a></li>
								<li><a href="javascript:;"> <!-- <span class="badge bg-red pull-right">50%</span> -->
										<span>정보수정</span>
								</a></li>
								<!-- <li><a href="javascript:;">Help</a></li> -->
								<li><a href="login.html"><i
										class="fa fa-sign-out pull-right"></i>로그아웃</a></li>
							</ul></li>

						<li role="presentation" class="dropdown"><a
							href="javascript:;" class="dropdown-toggle info-number"
							data-toggle="dropdown" aria-expanded="false"> <i
								class="fa fa-envelope-o"></i> <span class="badge bg-green">4</span>
						</a>
							<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
								role="menu">
								<li><a> <span class="image"><img
											src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
											<span>이종준님</span> <span class="time">3 분전</span>
									</span> <span class="message"> 김진수님 결재좀 부탁드립니다. </span>
								</a></li>
								<li><a> <span class="image"><img
											src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
											<span>이종준님</span> <span class="time">5 분전</span>
									</span> <span class="message"> 김진수님 결재 올렸습니다. 확인 부탁드립니다. </span>
								</a></li>
								<li><a> <span class="image"><img
											src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
											<span>아이유님</span> <span class="time">7 분전</span>
									</span> <span class="message"> 기아자동차에서 손님 오셨습니다. </span>
								</a></li>
								<li><a> <span class="image"><img
											src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
											<span>John Smith</span> <span class="time">30 분전</span>
									</span> <span class="message"> Hello! Jinsu kim. Nice to meet
											you! </span>
								</a></li>
								<li>
									<div class="text-center">
										<a> <strong>모든 쪽지 보기</strong> <i class="fa fa-angle-right"></i>
										</a>
									</div>
								</li>
							</ul></li>
					</ul>
					</nav>
				</div>

			</div>
			<!-- /top navigation -->




			<!-- page content -->
			<div class="right_col" role="main">

				<div class="row">
					<div class="col-md-9 col-sm-6 col-xs-12">
						<h3>&nbsp;</h3>
					</div>

					<div
						class="col-md-3 col-sm-6 col-xs-12 form-group pull-right top_search">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="사원검색">
							<span class="input-group-btn">
								<button class="btn btn-default" style="margin: 0;" type="button">
									<i class="fa fa-search" aria-hidden="true"></i>
								</button>
							</span>
						</div>
					</div>
				</div>




				<div class="row">
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">



								<form:form action="boardwritepost1.do" method="post">



									<table>
										<tr>
											<td><form:input path="title" name="title" type="text"
													id="_title" class="form-control" placeholder="제목을 입력하세요"
													style="width: 860px; margin-right: 3px;" /></td>
											<form:input path="id" type="hidden" id="id" name="id"
												value="${_id}" />
											<td><button type="submit" class="btn btn-primary">글쓰기</button></td>
										</tr>

									</table>

									<form:textarea path="contents" name="contents" rows="100"
										id="editor1"></form:textarea>
								</form:form>


							</div>









						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="resources/js/jquery.twbsPagination.min.js"></script>
	<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>



	<script type="text/javascript">
		$(document).ready(
				function() {
					$(".dropdown").hover(
							function() {
								$('.dropdown-menu', this).not(
										'.in .dropdown-menu').stop(true, true)
										.slideDown("400");
								$(this).toggleClass('open');
							},
							function() {
								$('.dropdown-menu', this).not(
										'.in .dropdown-menu').stop(true, true)
										.slideUp("400");
								$(this).toggleClass('open');
							});
				});
	</script>

	<script>
		CKEDITOR.replace('editor1');
	</script>
</body>
</html>