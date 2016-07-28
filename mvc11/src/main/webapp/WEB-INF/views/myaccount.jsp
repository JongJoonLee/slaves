<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 계좌 정보</title>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
</head>
<body>

	<div class="container">
		<div class="row">
			<table class="table">
				<tr>
					<th style="text-align: center">고객 ID</th>
					<th style="text-align: center">성명</th>
					<th style="text-align: center">전화번호</th>
					<th style="text-align: center">우편번호</th>
					<th style="text-align: center">주소</th>
					<th style="text-align: center">상세주소</th>
					<th style="text-align: center">생년월일</th>
					<th style="text-align: center">가입일자</th>
					<th style="text-align: center">계좌번호</th>
					<th style="text-align: center">계좌생성일</th>

				</tr>

				<c:forEach var="tmp" items="${calist}">
					<tr>
						<td style="text-align: center">${tmp.getC_id()}</td>

						<td style="text-align: center">${tmp.getC_name()}</td>

						<td style="text-align: center">${tmp.getC_tel()}</td>

						<td style="text-align: center">${tmp.getC_postcode()}</td>
						<td style="text-align: center">${tmp.getC_add1()}</td>
						<td style="text-align: center">${tmp.getC_add2()}</td>
						<td style="text-align: center">${tmp.getC_birth()}</td>
						<td style="text-align: center"><c:set var="dates"
								value="${fn:split(tmp.getC_date(),' ')}" /> <c:out
								value="${dates[0]}" /></td>
						
						<td style="text-align: center">${tmp.getA_no()}</td>
						
						<td style="text-align: center">
						<c:set var="dates" value="${fn:split(tmp.getA_date(),' ')}" /> <c:out
								value="${dates[0]}" /></td>
						
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</body>
</html>