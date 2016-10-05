<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Groupware</title>

<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="resources/css/font-awesome.css"	rel="stylesheet">
<!-- 엔프로그레스 -->
<link href="resources/css/nprogress.css" rel="stylesheet">
<!-- jQuery 커스텀 스크롤바 -->
<link href="resources/css/jquery.mCustomScrollbar.min.css" rel="stylesheet" />

<!-- Custom Theme Style -->
<link href="resources/css/custom.css" rel="stylesheet">
<link href="resources/css/timelinejinsu.css" rel="stylesheet">
</head>

<!-- <body class="nav-md footer_fixed">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col"> -->
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col menu_fixed">

				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.do" class="site_title"><i class="fa fa-apple"></i> <span>
								DOUNGSUNG</span></a>
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
								<li><a href="member.do"><i class="fa fa-sitemap"></i> 조직도</a></li>


							</ul>
						</div>

						<!-- <div class="menu_section">
                <h3>Live On</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-bug"></i> Additional Pages <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="e_commerce.html">E-commerce</a></li>
                      <li><a href="projects.html">Projects</a></li>
                      <li><a href="project_detail.html">Project Detail</a></li>
                      <li><a href="contacts.html">Contacts</a></li>
                      <li><a href="profile.html">Profile</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-windows"></i> Extras <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="page_403.html">403 Error</a></li>
                      <li><a href="page_404.html">404 Error</a></li>
                      <li><a href="page_500.html">500 Error</a></li>
                      <li><a href="plain_page.html">Plain Page</a></li>
                      <li><a href="login.html">Login Page</a></li>
                      <li><a href="pricing_tables.html">Pricing Tables</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="#level1_1">Level One</a>
                        <li><a>Level One<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu"><a href="level2.html">Level Two</a>
                            </li>
                            <li><a href="#level2_1">Level Two</a>
                            </li>
                            <li><a href="#level2_2">Level Two</a>
                            </li>
                          </ul>
                        </li>
                        <li><a href="#level1_2">Level One</a>
                        </li>
                    </ul>
                  </li>                  
                  <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>
                </ul>
              </div> -->

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
											<a> <strong>모든 쪽지 보기</strong> <i
												class="fa fa-angle-right"></i>
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

					<div class="col-md-3 col-sm-6 col-xs-12 form-group pull-right top_search">
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

				<!-- <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>내용 들어갈 자리</h3>
                
                
              </div>
            </div>
          </div> -->


				<div class="row">
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											공지사항
											<!--  <small>Sessions</small> -->
										</h2>
										<!-- <ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul> -->
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">08</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">경력사원 발령</a>
												<p>해외영업팀에 황보석 대리가 입사했습니다.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">08</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">16년 건강검진 안내</a>
												<p>16년도 건강검진 안내입니다..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">9월 첫째주 식단표 안내</a>
												<p>9월 1일 현미밥, 백미밥, 잡곡밥, 콩밥</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">9월 8일 포럼 안내</a>
												<p>9월 8일 포럼 안내</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">신입사원 교육 안내</a>
												<p>신입사원들은 ....</p>
											</div>
										</article>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											메일함
											<!--  <small>Sessions</small> -->
										</h2>
										<!-- <ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul> -->
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">안녕하십니까? 김부장님</a>
												<p>현대자동차 김상호 대리 입니다.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">현대카드 9월 카드 명세서</a>
												<p>안녕하십니까? 김진수 고객님. 현대 카드 9월 카드 명세서를 발송...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">쿠팡 10월 쿠폰이 발송되었습니다.</a>
												<p>김진수님은 10월달 VIP고객으로 쿠폰을 발송...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">이종준 대리 / 해외영업팀가 결재를 요청합니다.</a>
												<p>이종준 ㄷ리가 결재를 요청합니다..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">안녕하세요 김진수부장님..</a>
												<p>10월에 방문하겠습니다.</p>
											</div>
										</article>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					
					<!-- 타임라인 -->
					
					
					<div class="col-md-6">
						<div class="message-item top" style="margin-bottom: 15px;">
								<div class="form-group">
									<form action="">
										<div class="row">
											<div class="col-md-12 col-sm-12 col-xs-12">
												<textarea class="form-control" id="message" rows="4" style="resize: none; overflow: hidden;" placeholder="지금의 상태, 기분 등을 나누어 보세요."></textarea>
											</div>
										</div>
										<div class="row" style="margin-top: 15px;">
											<div class="col-md-10 col-sm-8 col-xs-6"><h3 style="margin: 4px 0; color: #2A3F54;">이야기</h3></div>
											<div class="col-md-2 col-sm-4 col-xs-6" style="padding-left: 0;">
												<input type="submit" class="form-control" value="작성"/>
											</div>
										</div>
									</form>
								</div>
						</div>

						<div class="row">
							<div class="col-md-12">

								<c:forEach var="tmp" items="${timeline}">
								<div class="qa-message-list" id="wallmessages">


									
									<div class="message-item">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">${tmp.getMem_name()} ${tmp.getMem_grade()} / ${tmp.getMem_team()}</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">${tmp.getTime_date()}</span>
															</span>
															
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">${tmp.getTime_contents()}</div>
										</div>
									</div>



								</div>
							</c:forEach>




							</div>
						</div>

						<!-- </div>
						</div> -->

					</div>
					
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											결재할 문서
											<!--  <small>Sessions</small> -->
										</h2>
										<!-- <ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul> -->
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">마우스 구매의 건</a>
												<p>마우스를 130개가 필요......</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">키보드 구매의 건</a>
												<p>키보드가 다 고장이 나서 130개가 필요....</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">회식비 요청</a>
												<p>회식비 요청....</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">노트북 구매 요청</a>
												<p>신입사원 입사로 인해 노트북을 요청합니다..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">PC 변경 요청</a>
												<p>PC가 노후되어 최신 사양으로 교체 바랍니다.</p>
											</div>
										</article>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											지원요청(Helpdesk)
											<!--  <small>Sessions</small> -->
										</h2>
										<!-- <ul class="nav navbar-right panel_toolbox">
									<li><a class="collapse-link"><i
											class="fa fa-chevron-up"></i></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown" role="button" aria-expanded="false"><i
											class="fa fa-wrench"></i></a>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Settings 1</a></li>
											<li><a href="#">Settings 2</a></li>
										</ul></li>
									<li><a class="close-link"><i class="fa fa-close"></i></a>
									</li>
								</ul> -->
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">공장동에 POP단말기 고장입니다.</a>
												<p>안녕하세요. 현장에 조재원입니다. POP단말기 고장으로 인해 수리 요청바랍니다.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">구매개발팀 프린터가 이상해요.</a>
												<p>인쇄시 A4용지에 검은색 토너가 묻어나옵니다. 확인바랍니다.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">경영지원팀 공용PC 점검바랍니다.</a>
												<p>이재희 입니다. 게임 깔았더니 이상해졌어요. 점검바랍니다.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">SAP가 잘 안됩니다.</a>
												<p>반갑습니다. 이종준 대리 입니다. SAP 프로그램 사용중 자꾸 에러가 뜨네요. 점검...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">그룹웨어에서 인쇄가 안되요.</a>
												<p>식단표를 인쇄하려니 안됩니다. 확인 부탁 드려요~</p>
											</div>
										</article>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">
					Copylight &copy;<a href="#">Jinsu Kim.</a>
				</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>









	<!-- jQuery -->
	<script src="resources/js/jquery-3.1.1.min.js"></script>
	<!-- Bootstrap -->
	<script src="resources/js/bootstrap.js"></script>
	<!-- FastClick -->
	<script src="resources/js/fastclick.js"></script>
	<!-- NProgress -->
	<script src="resources/js/nprogress.js"></script>
	<!-- jQuery custom content scroller -->
	<script
		src="resources/js/jquery.mCustomScrollbar.concat.min.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="resources/js/custom.js"></script>
</body>
</html>