<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Bootstrap Real Estate Website Template">
<meta name="author" content="KimaroTec">

<title>ASAD ESTATE | Real Estate bootstrap Website Template</title>

<!-- Bootstrap core CSS -->
<link href="./css/normalize.css" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/animate.css" rel="stylesheet">
<!-- Ico font CSS -->
<link href="./css/font-awesome.css" rel="stylesheet">
<link href="./css/icofont.css" rel="stylesheet">
<link href="./css/themify-icons.css" rel="stylesheet">
<!-- Style CSS -->
<link href="./css/style.css" rel="stylesheet">

<!-- Google Fonts -->
<link
	href='http://fonts.googleapis.com/css?family=Lato:400,300,400italic,700,700italic,900'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800,300italic,400italic'
	rel='stylesheet' type='text/css'>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="js/html5shiv.js"></script>          
        <![endif]-->
<!-- Favicons -->
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">

</head>
<body>
	<jsp:include page="top_bar.jsp"></jsp:include>


	<jsp:include page="fixedmenu.jsp"></jsp:include>



	<section id="one-parallax"
		class="post-wrapper-top dm-shadow clearfix parallax"
		style="background-image: url('img/bkimg.JPG');"
		data-stellar-background-ratio="0.6" data-stellar-vertical-offset="20">
	<div class="overlay1 dm-shadow">
		<div class="container">
			<div class="post-wrapper-top-shadow">
				<span class="s1"></span>
			</div>
			<div class="col-lg-12">
				<ul class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li><a href="#">Pages</a></li>
					<li>Login Page</li>
				</ul>
				<h2>Login Page</h2>
			</div>
		</div>
	</div>
	</section>
	<!-- end post-wrapper-top -->


	<section class="generalwrapper dm-shadow clearfix">
	<div class="container">
		<div class="row">

			<div id="content" class="col-md-8 col-md-offset-2 clearfix">

				<div class="col-lg-6 col-md-6 col-sm-12">
					<div class="widget clearfix">
						<div class="title">
							<h3>Login Form</h3>
						</div>
						<form id="loginform" method="post" name="loginform" action="#">
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user"></i></span>
									<input type="text" class="form-control" placeholder="Username">
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock"></i></span>
									<input type="password" class="form-control"
										placeholder="Password">
								</div>
							</div>
							<div class="form-group">
								<div class="checkbox">
									<label> <input type="checkbox"> Remember me
									</label>
								</div>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-primary">Sign in</button>
							</div>
						</form>
					</div>
				</div>
				<!-- end login -->

				<div class="col-lg-6 col-md-6 col-sm-12">
					<div class="widget clearfix">
						<div class="title">
							<h3>Register Form</h3>
						</div>
						<form id="registerform" method="post" name="registerform"
							action="#">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="First name">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Last name">
							</div>
							<div class="form-group">
								<input type="email" class="form-control" placeholder="Email">
							</div>
							<div class="form-group">
								<input type="password" class="form-control"
									placeholder="Password">
							</div>
							<div class="form-group">
								<input type="text" class="form-control"
									placeholder="Re-enter password">
							</div>
							<div class="form-group">
								<input type="submit" class="btn btn-primary"
									value="Register an account">
							</div>
						</form>
					</div>
				</div>
				<!-- end register -->
			</div>
			<!-- end content -->

		</div>
		<!-- end row -->
	</div>
	<!-- end container --> </section>


	<jsp:include page="footer.jsp"></jsp:include>

	<a class="showit scrollToTop" href="#" id="backToTop"><i
		class="fa fa-angle-up"></i></a>
	<!-- Bootstrap core and JavaScript's
        ================================================== -->
	<script src="js/jquery-1.12.3.min.js"></script>
	<script src="js/jquery-migrate-1.2.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/jquery.parallax.js"></script>
	<script src="js/jquery.fitvids.js"></script>
	<script src="js/jquery.unveilEffects.js"></script>

	<script src="js/bootstrap-select.js"></script>
	<script src="js/jquery.fancybox.pack.js"></script>
	<script src="js/nicescroll.js"></script>
	<script src="js/main.js"></script>




</body>
</html>
