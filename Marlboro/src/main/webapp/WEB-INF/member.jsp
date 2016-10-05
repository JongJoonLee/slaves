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

<!-- ��Ʈ��Ʈ�� -->
<link href="resources/css/bootstrap.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="resources/css/font-awesome.css" rel="stylesheet">
<!-- �����α׷��� -->
<link href="resources/css/nprogress.css" rel="stylesheet">
<!-- jQuery Ŀ���� ��ũ�ѹ� -->
<link href="resources/css/jquery.mCustomScrollbar.min.css"
	rel="stylesheet" />

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
							<span>ȯ���մϴ�,</span>
							<h2>�������� (PI��/����)</h2>
							<br /> <br />

						</div>
					</div>
					<!-- /menu profile quick info -->

					<br /> <br />

					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>ī�װ�</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-home"></i> Home</a></li>



								<li><a><i class="fa fa-envelope"></i> ���� <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">��ü ������</a></li>
										<li><a href="#">���� ������</a></li>
										<li><a href="#">���� ������</a></li>
										<li><a href="#">�ӽ� ������</a></li>
										<li><a href="#">���� �� ������</a></li>
										<li><a href="#">���� ������</a></li>
										<li><a href="#">������</a></li>
									</ul></li>

								<li><a><i class="fa fa-desktop"></i> ���°��� <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">��� ���</a></li>
										<li><a href="#">��� ���</a></li>
										<li><a href="#">�ܱ� ���</a></li>
										<li><a href="#">���� ���</a></li>
										<li><a href="#">�ʰ� �ٹ� ���</a></li>
										<li><a href="#">���� �ٹ� ���</a></li>
									</ul></li>

								<li><a><i class="fa fa-file-text"></i> ������� <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a>Workflow<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�����</a></li>
												<li><a href="#">������</a></li>
												<li><a href="#">����������</a></li>
												<li><a href="#">�ݷ���</a></li>
												<li><a href="#">�ӽ�������</a></li>
											</ul></li>

										<li><a>��� ó��<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">����ī�� ���γ���</a></li>
												<li><a href="#">���ó�� ������</a></li>
												<li><a href="#">���ó�� �Ϸ���</a></li>
												<li><a href="#">���ó�� �����</a></li>
												<li><a href="#">���ó�� ���� ��ȸ</a></li>
											</ul></li>

										<li><a>���� ��û<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">���� ������</a></li>
												<li><a href="#">���� ������</a></li>
												<li><a href="#">�ݷ���</a></li>
												<li><a href="#">�ۼ��� ����</a></li>
											</ul></li>

										<li><a>���� ����<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�ӽ� ������</a></li>
												<li><a href="#">������</a></li>
												<li><a href="#">�Ϸ���</a></li>
												<li><a href="#">�����</a></li>
											</ul></li>

										<li><a>���� ��û<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�ݷ��� ����</a></li>
												<li><a href="#">���� ��� ����</a></li>
												<li><a href="#">�Ϸ� ��Ȳ</a></li>
											</ul></li>

										<li><a>���˹� ��û<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�ݷ��� ����</a></li>
												<li><a href="#">���� ��� ����</a></li>
												<li><a href="#">�Ϸ� ��Ȳ</a></li>
											</ul></li>

										<li><a>ȫ�� ���� ��û<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�ݷ��� ����</a></li>
												<li><a href="#">���� ��Ȳ</a></li>
												<li><a href="#">�Ϸ� ��Ȳ</a></li>
											</ul></li>

										<li><a>���๰ ����<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">���� ��� ����</a></li>
												<li><a href="#">�ݷ��� ����</a></li>
												<li><a href="#">�Ϸ� ��Ȳ</a></li>
											</ul></li>
									</ul></li>

								<li><a><i class="fa fa-newspaper-o"></i> ���� <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a>���� ����<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">�ӽ� ����</a></li>
												<li><a href="#">���� ���</a></li>
												<li><a href="#">�ݷ���</a></li>
												<li><a href="#">�Խ� ����</a></li>

											</ul></li>

										<li><a>���� ����<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">���� ����</a></li>
												<li><a href="#">���� ���</a></li>
											</ul></li>

										<li><a>�湮 ����<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="#">���� �湮 ����</a></li>
												<li><a href="#">��� �湮 ����</a></li>
												<li><a href="#">���� ��ü</a></li>
											</ul></li>
									</ul></li>

								<li><a><i class="fa fa-briefcase"></i> ���� ���� <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">��ü ���� ����</a></li>
										<li><a href="#">���� ���� �ۼ�</a></li>
									</ul></li>


								<li><a><i class="fa fa-calendar"></i> ������ <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">��ü ���� ����</a></li>
										<li><a href="#">���� �ۼ�</a></li>
									</ul></li>

								<li><a><i class="fa fa-question-circle"></i> ���� ��û <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#">Helpdesk</a></li>
										<li><a href="#">�Ϸ���</a></li>

									</ul></li>

								<!-- <li><a><i class="fa fa-question-circle"></i> ������û</a></li> -->
								<li><a><i class="fa fa-commenting"></i> �����</a></li>
								<li><a><i class="fa fa-sitemap"></i> ������</a></li>


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
									alt="">������ <span class=" fa fa-angle-down"></span>
							</a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
									<li><a href="javascript:;">������</a></li>
									<li><a href="javascript:;"> <!-- <span class="badge bg-red pull-right">50%</span> -->
											<span>��������</span>
									</a></li>
									<!-- <li><a href="javascript:;">Help</a></li> -->
									<li><a href="login.html"><i
											class="fa fa-sign-out pull-right"></i>�α׾ƿ�</a></li>
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
												<span>�����ش�</span> <span class="time">3 ����</span>
										</span> <span class="message"> �������� ������ ��Ź�帳�ϴ�. </span>
									</a></li>
									<li><a> <span class="image"><img
												src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
												<span>�����ش�</span> <span class="time">5 ����</span>
										</span> <span class="message"> �������� ���� �÷Ƚ��ϴ�. Ȯ�� ��Ź�帳�ϴ�. </span>
									</a></li>
									<li><a> <span class="image"><img
												src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
												<span>��������</span> <span class="time">7 ����</span>
										</span> <span class="message"> ����ڵ������� �մ� ���̽��ϴ�. </span>
									</a></li>
									<li><a> <span class="image"><img
												src="resources/images/img.jpg" alt="Profile Image" /></span> <span>
												<span>John Smith</span> <span class="time">30 ����</span>
										</span> <span class="message"> Hello! Jinsu kim. Nice to meet
												you! </span>
									</a></li>
									<li>
										<div class="text-center">
											<a> <strong>��� ���� ����</strong> <i
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

					<div
						class="col-md-3 col-sm-6 col-xs-12 form-group pull-right top_search">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="����˻�">
							<span class="input-group-btn">
								<button class="btn btn-default" style="margin: 0;" type="button">
									<i class="fa fa-search" aria-hidden="true"></i>
								</button>
							</span>
						</div>
					</div>
				</div>




				<div class="row">
					<div class="col-md-3">
						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">

										<h2>
											������
											<!--  <small>Sessions</small> -->
										</h2>
										<div class="clearfix"></div>

									</div>


									<div class="x_content">
										<div class="row">
											<div class="col-sm-12">
												<div class="panel-group" id="accordion">

													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
															
															
															
															
															
																<a data-toggle="collapse" data-parent="#accordion"  onclick="sendAjax('memberlist.do?no=1')"
																	href="#collapseFour" aria-expanded="true" aria-controls="#collapseFour">
																	<span class="glyphicon glyphicon-file"> </span>ȸ��</a>
																	
															
																	
																	
																	
																	
															</h4>
														</div>
														<div id="collapseFour" class="panel-collapse collapse in">
															<div class="list-group">
																<a href="#" class="list-group-item active" >ȸ���</a> <a
																	href="#" class="list-group-item">ȸ���ù°</a> <a href="#"
																	class="list-group-item">ȸ��Ե�°</a> <a href="#"
																	class="list-group-item">ȸ��Լ�°</a> <a href="#"
																	class="list-group-item">ȸ��Գ�°</a>
															</div>
														</div>
													</div>
													
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#3" aria-expanded="true" aria-controls="#3" onclick="sendAjax('memberlist.do?no=2')"><span
																	class="glyphicon glyphicon-file"> </span>�濵������</a>
															</h4>
														</div>
														<div id="3" class="panel-collapse collapse">
															<div class="list-group">
																<a href="#" class="list-group-item active">�濵������ �μ���</a> <a
																	href="#" class="list-group-item">�濵������ ����</a> <a href="#"
																	class="list-group-item">�濵������ �븮</a> <a href="#"
																	class="list-group-item">�濵������ ����</a> <a href="#"
																	class="list-group-item">�濵������ ���</a>
															</div>
														</div>
													</div>
													
													
													
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#4" aria-expanded="true" aria-controls="#4" onclick="sendAjax('memberlist.do?no=3')"><span
																	class="glyphicon glyphicon-file"> </span>������</a>
															</h4>
														</div>
														<div id="4" class="panel-collapse collapse">
															<div class="list-group">
																<a href="#" class="list-group-item active">������ ��</a> <a
																	href="#" class="list-group-item">��������</a> <a href="#"
																	class="list-group-item">����������</a> <a href="#"
																	class="list-group-item">�������븮</a> <a href="#"
																	class="list-group-item">���������</a>
															</div>
														</div>
													</div>
													
													
													
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a data-toggle="collapse" data-parent="#accordion"
																	href="#5" aria-expanded="true" aria-controls="#5" onclick="sendAjax('memberlist.do?no=4')"><span
																	class="glyphicon glyphicon-file"> </span>���꼳����</a>
															</h4>
														</div>
														<div id="5" class="panel-collapse collapse">
															<div class="list-group">
																<a href="#" class="list-group-item active">����</a> <a
																	href="#" class="list-group-item">����</a> <a href="#"
																	class="list-group-item">�븮</a> <a href="#"
																	class="list-group-item">����</a> <a href="#"
																	class="list-group-item">���</a>
															</div>
														</div>
													</div>


													
												</div>
											</div>

										</div>





									</div>
								</div>
							</div>
						</div>
					</div>




					<div class="col-md-9">

						<div class="row">
							<div class="col-md-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											������
											<!--  <small>Sessions</small> -->
										</h2>
										<div class="clearfix"></div>

									</div>


									<div class="x_content" id="changeView">
									
									
									
									
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
	<script src="resources/js/jquery.mCustomScrollbar.concat.min.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="resources/js/custom.js"></script>
	
	 <script type="text/javascript">
 
		 var sendAjax =  function(url) {

			var postString = "";
			$.ajax({

				type: "GET",
				url: url,
				data: postString,
				 
				success: function(msg) {
					
					document.getElementById("changeView").innerHTML = msg;
				}
			});
		 };
 
  </script>
	

</body>
</html>