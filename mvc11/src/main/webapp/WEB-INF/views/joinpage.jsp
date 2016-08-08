<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<script src="resources/js/jquery-1.12.3.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

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
					aria-hidden="true"></i><b> &nbsp;회원가입양식</b><br />


				<form:form action="joinpagepost.do" method="post">
					<table style="margin-top: 10px;" class="table table-condensed">
						<tr>
							<td>아이디</td>
							<td><form:input type="text" path="id" /></td>
							<td><a href="#" class="btn btn-primary">중복체크</a></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><form:input type="password" path="password" id="_pw" /></td>
						</tr>
						<tr>
							<td>비밀번호확인</td>
							<td><input type="password" id="_rpw" /></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><form:input type="text" path="name" /></td>
							<td>성별</td>
							<td><label class="radio-inline"> <form:input
										path="sex" type="radio" name="inlineRadioOptions"
										id="inlineRadio1" value="option1" /> 남자
							</label> <label class="radio-inline"> <form:input path="sex"
										type="radio" name="inlineRadioOptions" id="inlineRadio2"
										value="option2" /> 여자
							</label></td>

						</tr>
						<tr>
							<td>생년월일</td>
							<td><form:input type="text" path="birthday" /></td>
						</tr>
						<tr>
							<td>e-mail</td>
							<td><form:input type="email" path="email" /></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><form:input type="text" path="tel" /></td>
						</tr>



						<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
						<tr>
							<td>우편번호</td>
							<td><form:input path="postcode" type="text" name="postcode"
									class="postcodify_postcode5" /></td>
							<td><button type="button" id="postcodify_search_button">검색</button></td>
						</tr>
						<tr>
							<td>도로명주소</td>
							<td><form:input path="address1" type="text"
									class="postcodify_address" /></td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td><form:input path="address2" type="text"
									class="postcodify_details" /></td>
						</tr>



					</table>
					<button type="submit">회원가입</button>
				</form:form>


			</div>
		</div>

	</div>

	<script>
		$(function() {
			$("#postcodify_search_button").postcodifyPopUp();
		});
	</script>
</body>
</html>