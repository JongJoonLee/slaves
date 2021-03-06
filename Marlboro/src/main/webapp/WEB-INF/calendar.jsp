<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
<link href="resources/css/custom.css" rel="stylesheet" />
<link href="resources/css/timelinejinsu.css" rel="stylesheet" />
<link href="resources/css/custom.calendar.css" rel="stylesheet" />
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
						<a href="#" class="site_title"><i class="fa fa-apple"></i> <span>
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
								<li><a><i class="fa fa-sitemap"></i> 조직도</a></li>


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
						<h3 class="calendar-title">전체 일정 보기</h3>
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

				<!-- calendar tab -->
				<div class="row cal-nav-tabs">
					<div class="col-md-3 calendar-tab-list active">
						<a href="#">전체 일정</a>
					</div>
					<div class="col-md-3 calendar-tab-monthly">
						<a href="#">월간 일정</a>
					</div>
					<div class="col-md-3 calendar-tab-weekly">
						<a href="#">주간 일정</a>
					</div>
					<div class="col-md-3 calendar-tab-daily">
						<a href="#">일간 일정</a>
					</div>
				</div>
				<!-- /calendar tab -->

				<!-- calendar content -->
				<div class="calendar-wrap">
					<div class="calendar-list">
						Calendar List Here
					</div>
					
					<div class="calendar-monthly">
						<div class="row">
							<div class="col-md-10 col-sm-6 col-xs-12">
								<span class="calendar-show-month">2016년 10월</span>
							</div>
							<div class="col-md-2 col-sm-6 col-xs-12 text-right">
								<button class="btn btn-default calendar-show-today">오늘</button>
							<div class="btn-group" role="group">
								<div class="btn-group" role="group">
									<button class="btn btn-default calendar-show-month-prev"><span class="glyphicon glyphicon-chevron-left"></span></button>
								</div>
								<div class="btn-group" role="group">
									<button class="btn btn-default calendar-show-month-next"><span class="glyphicon glyphicon-chevron-right"></span></button>
								</div>
							</div>
							</div>
						</div>
						
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="color: #FF0000;">SUN</th>
										<th>MON</th>
										<th>TUE</th>
										<th>WED</th>
										<th>THU</th>
										<th>FRI</th>
										<th style="color: #0000FF;">SAT</th>
									</tr>
								</thead>
								
								<tbody>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td>1</td>
									</tr>
									
									<tr>
										<td>2</td>
										<td>3</td>
										<td>4</td>
										<td>5</td>
										<td>6</td>
										<td>7</td>
										<td>8</td>
									</tr>
									
									<tr>
										<td>9</td>
										<td>10</td>
										<td>11</td>
										<td>12</td>
										<td>13</td>
										<td>14</td>
										<td>15</td>
									</tr>
									
									<tr>
										<td>16</td>
										<td>17</td>
										<td>18</td>
										<td>19</td>
										<td>20</td>
										<td>21</td>
										<td>22</td>
									</tr>
									
									<tr>
										<td>23</td>
										<td>24</td>
										<td>25</td>
										<td>26</td>
										<td>27</td>
										<td>28</td>
										<td>29</td>
									</tr>
									
									<tr>
										<td>30</td>
										<td>31</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="calendar-weekly">
						Weekly Calendar Here
					</div>
					
					<div class="calendar-daily">
						Daily Calendar Here
					</div>
				</div>
				<!-- /calendar content -->
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
	
	<!-- Custom Tab Actions -->
	<script>
		$('.calendar-tab-list a').on('click', function() {
			$('.calendar-title').text('전체 일정 보기');
			
			$('.calendar-tab-list').addClass('active');
			$('.calendar-tab-monthly').removeClass('active');
			$('.calendar-tab-weekly').removeClass('active');
			$('.calendar-tab-daily').removeClass('active');
			
			$('.calendar-list').css('display', 'block');
			$('.calendar-monthly').css('display', 'none');
			$('.calendar-weekly').css('display', 'none');
			$('.calendar-daily').css('display', 'none');
		});

		$('.calendar-tab-monthly a').on('click', function() {
			$('.calendar-title').text('월간 일정 보기');
			
			$('.calendar-tab-list').removeClass('active');
			$('.calendar-tab-monthly').addClass('active');
			$('.calendar-tab-weekly').removeClass('active');
			$('.calendar-tab-daily').removeClass('active');
			
			$('.calendar-list').css('display', 'none');
			$('.calendar-monthly').css('display', 'block');
			$('.calendar-weekly').css('display', 'none');
			$('.calendar-daily').css('display', 'none');
		});

		$('.calendar-tab-weekly a').on('click', function() {
			$('.calendar-title').text('주간 일정 보기');
			
			$('.calendar-tab-list').removeClass('active');
			$('.calendar-tab-monthly').removeClass('active');
			$('.calendar-tab-weekly').addClass('active');
			$('.calendar-tab-daily').removeClass('active');
			
			$('.calendar-list').css('display', 'none');
			$('.calendar-monthly').css('display', 'none');
			$('.calendar-weekly').css('display', 'block');
			$('.calendar-daily').css('display', 'none');
		});

		$('.calendar-tab-daily a').on('click', function() {
			$('.calendar-title').text('일간 일정 보기');
			
			$('.calendar-tab-list').removeClass('active');
			$('.calendar-tab-monthly').removeClass('active');
			$('.calendar-tab-weekly').removeClass('active');
			$('.calendar-tab-daily').addClass('active');
			
			$('.calendar-list').css('display', 'none');
			$('.calendar-monthly').css('display', 'none');
			$('.calendar-weekly').css('display', 'none');
			$('.calendar-daily').css('display', 'block');
		});
	</script>
</body>
</html>