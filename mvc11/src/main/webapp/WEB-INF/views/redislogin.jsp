<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
</head>
<body>

	<div class="container">
		<div class="row">
			
			<form action="redislogin.do" method="get">
				<input type="text" class="form-control" placeholder="아이디" name="_id"/>
				<input type="password" class="form-control" placeholder="비밀번호" name="_pw"/>
				<input type="text" class="form-control" placeholder="이름" name="_name"/>
				<button type="submit">입력</button>
			</form>
			
				
		
		</div>
	</div>



</body>
</html>