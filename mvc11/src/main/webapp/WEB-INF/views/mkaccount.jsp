<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신규계좌개설</title>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
</head>
<body>

	<div class="container">
		<div class="row">
			<br />
			<br />


			<form:form action="mkaccountpost.do" method="post" class="form-horizontal">
				<div class="form-group">
					<label for="a_no" class="col-sm-2 control-label">계좌번호</label>
					<div class="col-sm-10">
						 <form:input path="a_no" type="text" class="form-control" name="a_no" id="a_no"
							value="${ano}" /> 
						
							
					</div>
				</div>
				<div class="form-group">
					<label for="c_id" class="col-sm-2 control-label">고객번호</label>
					<div class="col-sm-10">
						 <form:input path="c_id" type="text" name="c_id" class="form-control" id="c_id"
							value= "${cid}" /> 
							
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-primary">등록하기</button>
					</div>
				</div>
			</form:form>


		</div>
	</div>
</body>
</html>