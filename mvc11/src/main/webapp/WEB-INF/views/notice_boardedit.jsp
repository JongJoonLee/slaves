<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 작성</title>

<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/font-awesome.css" rel="stylesheet" />
<link href="resources/css/mystyle.css" rel="stylesheet" />
<link href="resources/css/footer-v6.css" rel="stylesheet" />
<link rel='stylesheet' type='text/css'
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>
</head>
<body>

	<div class="container">

		<div class="row" id="top-menu">
		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>
		</div>
		<div class="row" style="padding-left: 15px;">

			<div class="col-md-2">
				<img style="max-width: 100%; height: auto;"
					src="resources/img/123123.PNG" />
					
				<hr/>
				
				<H4>회사소개</H4>
				
				<hr/>
				
				<H4 style="color:#337ab7;">참여마당</H4>
				<hr style="border-bottom: 2px solid #337ab7;" />
				
				<ul style="list-style:none; padding-left:0; margin-left:0;">
				<li><a href="notice_boardlist.do"><i class="fa fa-cog" aria-hidden="true"></i>&nbsp;공지사항</a></li>
				<li><a href="boardlist.do"><i class="fa fa-cog" aria-hidden="true"></i>&nbsp;자유게시판</a></li>
				</ul>
				<hr/>
				
				
				
				<H4>TEST상품</H4>
				
				<hr/>
				
				<H4>인재채용</H4>
				
				<hr/>



			</div>



			<div class="col-md-10">



				<form:form action="notice_boardeditpost1.do?no=${ctnt.getNo()}" method="post" id="frm"  onsubmit="return validateForm('frm');">



					<table>
						<tr>
							<td><form:input path="title" name="title" type="text"
									id="_title" class="form-control" placeholder="제목을 입력하세요"
									style="width: 860px; margin-right: 3px;"
									value="${ctnt.getTitle()}" /></td>
							<form:input path="id" type="hidden" id="id" name="id"
								value="${_id}" />
							<td><button type="submit" class="btn btn-primary">글쓰기</button></td>
						</tr>

					</table>

					<form:textarea path="contents" name="contents" rows="100" id="editor1"></form:textarea>
					<textarea id="abc" style="display:none;">${ctnt.getContents()}</textarea>
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



	

	<script>
		CKEDITOR.replace('editor1');
		
		var t1 = $('#abc').val();
		CKEDITOR.instances.editor1.setData(t1);
	</script>
	
	<script type="text/javascript">
		function validateForm(frm) {

			
			var title = $("#_title").val();//.text();
			var contents = $("#editor1").val();
			
			
			if(title==""&&contents==""){
				alert("모든항목을 입력해 주세요");
				return false;
			}
			else{
				
				return true;
			}
		}
	</script>
	
	
</body>
</html>