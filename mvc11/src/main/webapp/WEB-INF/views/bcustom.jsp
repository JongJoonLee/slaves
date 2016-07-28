<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
<body>

	<div class="container">
		<div class="row">

			<form:form action="bcustompost.do" commandName="command3" method="post">
			


				<form:input type="text" path="c_name" class="form-control"
					placeholder="이름" />
				<form:input type="text" path="c_tel" class="form-control"
					placeholder="전화번호" />
				<form:input type="text" path="c_postcode" class="form-control"
					placeholder="우편번호" />
				<form:input type="text" path="c_add1" class="form-control"
					placeholder="주소" />
				<form:input type="text" path="c_add2" class="form-control"
					placeholder="상세주소" />
				<form:input type="text" path="c_birth" class="form-control"
					placeholder="생년월일" />
				<hr />

				<button type="submit" class="btn btn-primary">확인</button>

			</form:form>







		</div>
	</div>




</body>
</html>