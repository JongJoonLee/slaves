<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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




		<div class="row" style="padding-left: 15px; padding-right: 15px;">


			<table class="table table-striped table-condensed">
				<tr style="text-align: center">
					<td width="100px">글번호 : ${ctnt.getNo()}</td>
					<td>제목 : ${ctnt.getTitle()}</td>
					<td width="150px">작성자 : ${ctnt.getId()}</td>
					<td style="text-align: right;" width="100px">${ctnt.getDate()}</td>
				</tr>
			</table>

			<div style="display: block; height: 500px">${ctnt.getContents()}</div>
			
			
			<c:set var="session" value="${_id}"/>
			
			<c:if test="${session eq ctnt.getId()}">
			<div align="right">
				<a href="boardedit.do?no=${ctnt.getNo()}" class="btn btn-primary">수정</a>
				<a href="boarddelete.do?no=${ctnt.getNo()}" class="btn btn-danger">삭제</a>
			</div>
			
			</c:if>
			
			

			<div align="center">
				<table class="table table-bordered table-condensed" style="width: 800px;">
					<tr>
						<td class="active" style="width: 100px;">이전글</td>
						<td><a href="boardcontent.do?no=${ctntpre.getNo()}">${ctntpre.getTitle()}</a></td>
					</tr>
					<tr>
						<td class="active" style="width: 100px;">다음글</td>
						<td><a href="boardcontent.do?no=${ctntnext.getNo()}">${ctntnext.getTitle()}</a></td>
					</tr>
				</table>
			</div>

			<c:import url="footer.jsp"></c:import>
		</div>
	</div>



	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$(".dropdown").hover(
							function() {
								$('.dropdown-menu', this).not(
										'.in .dropdown-menu').stop(true, true)
										.slideDown("400");
								$(this).toggleClass('open');
							},
							function() {
								$('.dropdown-menu', this).not(
										'.in .dropdown-menu').stop(true, true)
										.slideUp("400");
								$(this).toggleClass('open');
							});
				});
	</script>
</body>
</html>