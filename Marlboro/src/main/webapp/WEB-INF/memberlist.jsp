<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<body>

	<table class="table">
		<tr>
			<th>이름</th>
			<th>전화번호</th>
			<th>직책</th>
			<th>부서</th>
		</tr>
		
<% String no = request.getParameter("no"); %>

		<c:forEach var="tmp" items="${mlist}">
			<tr>
				<td>${tmp.getMem_name()}</td>
				<td>${tmp.getMem_tel()}</td>
				<td>${tmp.getMem_grade()}</td>
				<td>${tmp.getMem_team()}</td>
				
			</tr>

		</c:forEach>

	</table>

</body>
</html>