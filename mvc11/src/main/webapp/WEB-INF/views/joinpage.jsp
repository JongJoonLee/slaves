<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>

<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/font-awesome.css" rel="stylesheet" />
<link href="resources/css/mystyle.css" rel="stylesheet" />
<link href="resources/css/footer-v6.css" rel="stylesheet" />
<link rel='stylesheet' type='text/css'
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>


</head>
<body>

	<div class="container">

		<c:import url="topmenu.jsp"></c:import>
		<div class="row" style="padding-left: 25px;">
			<div class="col-md-12">

				<h2>회원가입</h2>
				<hr />
				<br /> <br />

				<h4>개인정보 입력</h4>
				TEST사 회원가입 사항입니다<br /> 아래의 간단한 양식을 작성해 주시면 회원가입이 완료됩니다.<br /> </b> <i
					style="margin-top: 40px;" " class="fa fa-info-circle"
					aria-hidden="true"></i><b> &nbsp;회원가입양식</b><br/>



				<table style="margin-top: 10px;" class="table table-condensed">
					<tr>
						<td>아이디</td><td></td>
					</tr>
				</table>



			</div>
		</div>

	</div>
</body>
</html>