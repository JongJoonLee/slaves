<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form" %>
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
		<div class="row" style="padding-left: 15px;">

			<div class="col-md-2">

				<img style="max-width: 100%; height: auto;"
					src="resources/img/123123.PNG" />
			</div>



			<div class="col-md-10">



				<form:form action="notice_boardwritepost1.do" method="post">



					<table>
						<tr>
							<td><form:input path="title" 
							name="title" type="text" id="_title"
									class="form-control" placeholder="제목을 입력하세요"
									style="width: 860px; margin-right: 3px;" /></td>
								<form:input path="id" type="hidden" id="id" name="id" value="${_id}"/>
							<td><button type="submit" class="btn btn-primary">글쓰기</button></td>
						</tr>

					</table>

					<form:textarea path="contents" name="contents" rows="100" id="editor1"></form:textarea>
				</form:form>


			</div>









		</div>

		<c:import url="footer.jsp"></c:import>
	</div>

	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="resources/js/jquery.twbsPagination.min.js"></script>
	<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>



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

	<script>
		CKEDITOR.replace('editor1');
	</script>
</body>
</html>