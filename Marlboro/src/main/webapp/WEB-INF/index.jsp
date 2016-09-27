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
<link href="resources/css/font-awesome.css"	rel="stylesheet">
<!-- �����α׷��� -->
<link href="resources/css/nprogress.css" rel="stylesheet">
<!-- jQuery Ŀ���� ��ũ�ѹ� -->
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

					<div class="col-md-3 col-sm-6 col-xs-12 form-group pull-right top_search">
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

				<!-- <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>���� �� �ڸ�</h3>
                
                
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
											��������
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
												<a class="title" href="#">��»�� �߷�</a>
												<p>�ؿܿ������� Ȳ���� �븮�� �Ի��߽��ϴ�.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">08</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">16�� �ǰ����� �ȳ�</a>
												<p>16�⵵ �ǰ����� �ȳ��Դϴ�..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">9�� ù°�� �Ĵ�ǥ �ȳ�</a>
												<p>9�� 1�� ���̹�, ��̹�, ����, ���</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">9�� 8�� ���� �ȳ�</a>
												<p>9�� 8�� ���� �ȳ�</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">1</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">���Ի�� ���� �ȳ�</a>
												<p>���Ի������ ....</p>
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
											������
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
												<a class="title" href="#">�ȳ��Ͻʴϱ�? ������</a>
												<p>�����ڵ��� ���ȣ �븮 �Դϴ�.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">����ī�� 9�� ī�� ����</a>
												<p>�ȳ��Ͻʴϱ�? ������ ����. ���� ī�� 9�� ī�� ������ �߼�...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">���� 10�� ������ �߼۵Ǿ����ϴ�.</a>
												<p>���������� 10���� VIP������ ������ �߼�...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">������ �븮 / �ؿܿ������� ���縦 ��û�մϴ�.</a>
												<p>������ ������ ���縦 ��û�մϴ�..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">�ȳ��ϼ��� �����������..</a>
												<p>10���� �湮�ϰڽ��ϴ�.</p>
											</div>
										</article>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="message-item top" style="margin-bottom: 15px;">
								<div class="form-group">
									<form action="">
										<div class="row">
											<div class="col-md-12">
												<textarea class="form-control" id="message" rows="4" style="resize: none; overflow: hidden;" placeholder="������ ����, ��� ���� ������ ������."></textarea>
											</div>
										</div>
										<div class="row" style="margin-top: 15px;">
											<div class="col-md-10"><h3 style="margin: 4px 0; color: #2A3F54;">�̾߱�</h3></div>
											<div class="col-md-2" style="padding-left: 0;">
												<input type="submit" class="form-control" value="�ۼ�"/>
											</div>
										</div>
									</form>
								</div>
						</div>

						<div class="row">
							<div class="col-md-12">


								<div class="qa-message-list" id="wallmessages">



									<div class="message-item" id="m18">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ ���� / PI��</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">���� ���� ���� �����~~ ����� ������
												�����~~~ ����� ���� ������ �� ���</div>
										</div>
									</div>

									<div class="message-item" id="m20">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ ���� / PI��</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�ذ� �������� ����� ó�� ���� �׶���
												�׸����� ��� �ٽ� �� �� ����� �� ����</div>
										</div>
									</div>

									<div class="message-item" id="m19">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ �븮 / �ؿܿ�����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">��� �� �� �����ε� �� �ϰ� �� �����
												�ϰ� �� ������ ������ ��~~~!!! ��`!!!!!</div>
										</div>
									</div>

									<div class="message-item" id="m19">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ �븮 / �ؿܿ�����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�ذ� �������� ����� ó������ �׶���
												�׸����� ��� �ٽ� ���� �� ���� �� ���� �������� ���� ����� ����� ������ ����� ����� ���� ������
												�����</div>
										</div>
									</div>

									<div class="message-item" id="m18">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ �븮 / �ؿܿ�����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�̾��� ��� �Ⱦ��ְ� ������ ���� �Ź���
												�� �޸�� �������� ����~</div>
										</div>
									</div>


									<div class="message-item" id="m17">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ �븮 / �ؿܿ�����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">������ �� �����̶� ����ϴ� �� �̶� �׸�
												������ �� ������</div>
										</div>
									</div>

									<div class="message-item" id="m16">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ �븮 / �ؿܿ�����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 10�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=Oleg+Kolesnichenko">Oleg Kolesnichenko</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�� �ȴٰ� ����ϸ� �ȵȴٰ� ������ �츰
												�Բ� ����</div>
										</div>
									</div>

									<div class="message-item" id="m5">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=amiya"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ ���� / PI��</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 08�� 11��
																	37��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=amiya">amiya</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">����� ���� ������ �� ���</div>
										</div>
									</div>

									<div class="message-item" id="m4">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=russell"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">����� ��� / ����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 03�� 10��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=russell">russell</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�ٽ� �� �� �� ���� �� ���� ��������
												���� ����� ����� ������ �����</div>
										</div>
									</div>

									<div class="message-item" id="m3">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=juggornot"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">Ȳ���� �븮 / �濵������</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 09�� 02�� 09��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=juggornot">juggornot</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�ذ� �������� ����� ó�� ���� �׶���
												�׸����� ���</div>
										</div>
									</div>

									<div class="message-item" id="m2">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=one_eyed"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">������ ���� / �濵������</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 08�� 29�� 15��
																	27��</span>
															</span>
															<!-- <span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=one_eyed">one_eyed</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">����� ��� ���ϰ� �;����� ��
												�̾��ϴٰ� �ߴ� ��</div>
										</div>
									</div>

									<div class="message-item" id="m1">
										<div class="message-inner">
											<div class="message-head clearfix">
												<div class="avatar pull-left">
													<a href="./index.php?qa=user&qa_1=muboy"><img
														class="img1"
														src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png"></a>
												</div>
												<div class="user-detail">
													<h5 class="handle">James / ��Ʈ�� ����</h5>
													<div class="post-meta">
														<div class="asker-meta">
															<span class="qa-message-what"></span> <span
																class="qa-message-when"> <span
																class="qa-message-when-data">2016�� 08�� 27�� 14��
																	27��</span>
															</span>
															<!-- 	<span class="qa-message-who">
												<span class="qa-message-who-pad">by </span>
												<span class="qa-message-who-data"><a href="./index.php?qa=user&qa_1=muboy">muboy</a></span>
											</span> -->
														</div>
													</div>
												</div>
											</div>
											<div class="qa-message-content">�����ŵ� �� �ҽ��� ������� ������
												�𸥴ٰ� ���� ������ �� �� �ӿ��� Ŀ���� ���� �ʸ� ���ݾ� ���� ����� ��</div>
										</div>
									</div>




								</div>




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
											������ ����
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
												<a class="title" href="#">���콺 ������ ��</a>
												<p>���콺�� 130���� �ʿ�......</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">Ű���� ������ ��</a>
												<p>Ű���尡 �� ������ ���� 130���� �ʿ�....</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">ȸ�ĺ� ��û</a>
												<p>ȸ�ĺ� ��û....</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">��Ʈ�� ���� ��û</a>
												<p>���Ի�� �Ի�� ���� ��Ʈ���� ��û�մϴ�..</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">PC ���� ��û</a>
												<p>PC�� ���ĵǾ� �ֽ� ������� ��ü �ٶ��ϴ�.</p>
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
											������û(Helpdesk)
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
												<a class="title" href="#">���嵿�� POP�ܸ��� �����Դϴ�.</a>
												<p>�ȳ��ϼ���. ���忡 ������Դϴ�. POP�ܸ��� �������� ���� ���� ��û�ٶ��ϴ�.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">24</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">���Ű����� �����Ͱ� �̻��ؿ�.</a>
												<p>�μ�� A4������ ������ ��ʰ� ����ɴϴ�. Ȯ�ιٶ��ϴ�.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">17</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">�濵������ ����PC ���˹ٶ��ϴ�.</a>
												<p>������ �Դϴ�. ���� ��Ҵ��� �̻��������. ���˹ٶ��ϴ�.</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">14</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">SAP�� �� �ȵ˴ϴ�.</a>
												<p>�ݰ����ϴ�. ������ �븮 �Դϴ�. SAP ���α׷� ����� �ڲ� ������ �߳׿�. ����...</p>
											</div>
										</article>
										<article class="media event">
											<a class="pull-left date">
												<p class="month">April</p>
												<p class="day">10</p>
											</a>
											<div class="media-body">
												<a class="title" href="#">�׷����� �μⰡ �ȵǿ�.</a>
												<p>�Ĵ�ǥ�� �μ��Ϸ��� �ȵ˴ϴ�. Ȯ�� ��Ź �����~</p>
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