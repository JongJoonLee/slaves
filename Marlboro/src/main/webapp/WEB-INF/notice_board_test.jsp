<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<div class="raw">
			<table>
				<tr>
					<td>글번호</td>
					<td>제목</td>
					<td>날짜</td>
				</tr>



				<c:forEach var="tmp" items="${blist}">


					<tr>
						<td style="text-align: center">${tmp.getNo()}</td>
						<td><c:choose>
								<c:when test="${fn:length(tmp.getTitle())>20}">
									<a href="boardcontent.do?no=${tmp.getNo()}"><c:out
											value="${fn:substring(tmp.getTitle(),0,20)}" />...</a>
								</c:when>
								<c:otherwise>
									<a href="boardcontent.do?no=${tmp.getNo()}">${tmp.getTitle()}</a>
								</c:otherwise>
							</c:choose></td>
						<td style="text-align: center"><c:set var="dates"
								value="${fn:split(tmp.getDate(),' ')}" /> <c:out
								value="${dates[0]}" /></td>
					</tr>
				</c:forEach>
			</table>



		</div>

	</div>





</body>
</html>