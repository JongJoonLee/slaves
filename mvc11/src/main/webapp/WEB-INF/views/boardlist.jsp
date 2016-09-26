<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

		<div class="row" id="top-menu">
		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>
		</div>
		<div class="row" style="padding-left: 25px;">


			<!-- 검색 시작 -->

			<form action="boardsearch.do" method="get">
				<div class="form-inline" align="right"
					style="padding-top: 5px; padding-bottom: 5px;">
					<div class="form-group">
						<select id="s_type" name="s_type" class="form-control">
							<option value="title"
								${param.s_type=="title" ? 'selected="selected"':''}>제목</option>
							<option value="id"
								${param.s_type=="content" ? 'selected="selected"':''}>이름</option>

							<option value="date"
								${param.s_type=="date" ? 'selected="selected"':''}>날짜</option>
						</select>
					</div>

					<div class="form-group">
						<input type="text" name="s_text" id="s_text" class="form-control" />
						<button type="submit" class="btn btn-primary">검색</button>
					</div>
				</div>
			</form>
			<!-- 검색 끝 -->





			<div class="col-md-2">

				<img style="max-width: 100%; height: auto;"
					src="resources/img/123123.PNG" />

				<hr />

				<H4>회사소개</H4>

				<hr />

				<H4 style="color: #337ab7;">참여마당</H4>
				<hr style="border-bottom: 2px solid #337ab7;" />

				<ul style="list-style: none; padding-left: 0; margin-left: 0;">
					<li><a href="notice_boardlist.do"><i class="fa fa-cog"
							aria-hidden="true"></i>&nbsp;공지사항</a></li>
					<li><a href="boardlist.do"><i class="fa fa-cog"
							aria-hidden="true"></i>&nbsp;자유게시판</a></li>
				</ul>
				<hr />



				<H4>TEST상품</H4>

				<hr />

				<H4>인재채용</H4>

				<hr />






			</div>

















			<div class="col-md-10">







				<table class="table table-striped table-condensed">
					<tr style="text-align: center">
						<th style="text-align: center" width="100px">번호</th>
						<th style="text-align: center">제목</th>
						<th width="100px" style="text-align: center">작성자</th>
						<th width="100px" style="text-align: center">조회수</th>
						<th width="200px" style="text-align: center">날짜</th>
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

							<td style="text-align: center">${tmp.getId()}</td>

							<td style="text-align: center">${tmp.getHit()}</td>

							<td style="text-align: center"><c:set var="dates"
									value="${fn:split(tmp.getDate(),' ')}" /> <c:out
									value="${dates[0]}" /></td>
						</tr>
					</c:forEach>
				</table>



				<table style="width: 100%;">
					<tr>
						<td width="80%" align="center" colspan="10"><ul
								id="pagination-demo" class="pagination-sm"></ul></td>
						<td width="20%" align="right" colspan="2"><c:set
								var="session" value="${_id}" /> <c:choose>
								<c:when test="${session eq null}">
									<a href="login.do?prev=boardwrite.do" class="btn btn-primary">
										글작성 </a>
								</c:when>
								<c:otherwise>
									<a href="boardwrite.do" class="btn btn-primary"> 글작성 </a>

								</c:otherwise>
							</c:choose></td>

					</tr>
				</table>










			</div>



			<hr />

		</div>













		<c:import url="footer.jsp"></c:import>
	</div>

	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="resources/js/jquery.twbsPagination.min.js"></script>

	


	<script>
		$('#pagination-demo')
				.twbsPagination(
						{
							totalPages : "<c:out value='${cont}'/>",

							visiblePages : 10,
							/* href : '?&page={{number}}', */
							href : "?page={{number}}&s_type=<c:out value='${type}'/>&s_text=<c:out value='${txt}'/>",
							onPageClick : function(event, page) {
								//alert(page);
								$('#page-content').text('Page ' + page);
							}
						});

		$('#txt_search').bind(
				'keyup',
				function(event) {
					if (event.which == 13) {
						var type = $('#s_type').val();
						var txt = $('#s_text').val();

						$(location).attr('href',
								"boardlist.do?type=" + type + "&txt=" + txt);
					}
				});
	</script>



	


</body>
</html>