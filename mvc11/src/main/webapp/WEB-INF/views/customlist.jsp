<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//KO" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<div class="row">

			<!-- 검색 시작 -->

			<form action="customsearch.do" method="get">
				<div class="form-inline" align="right"
					style="padding-top: 5px; padding-bottom: 5px;">
					<div class="form-group">
						<select id="s_type" name="s_type" class="form-control">
							<option value="c_id"
								${param.s_type=="title" ? 'selected="selected"':''}>고객
								ID</option>
							<option value="c_name"
								${param.s_type=="content" ? 'selected="selected"':''}>이름</option>

							<option value="c_date"
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



			<table class="table">
				<tr>
					<th style="text-align: center">고객ID</th>
					<th style="text-align: center">성명</th>
					<th style="text-align: center">전화번호</th>
					<th style="text-align: center">우편번호</th>
					<th style="text-align: center">주소</th>
					<th style="text-align: center">상세주소</th>
					<th style="text-align: center">생년월일</th>
					<th style="text-align: center">가입일자</th>
					<th style="text-align: center">비고</th>

				</tr>




				<c:forEach var="tmp" items="${clist}">
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
						<td style="text-align: center">
							<%-- <a href="mkaccount.do?c_id=${tmp.getC_id()}"> --%> <a
							href="mkaccount.do?c_id=${tmp.getC_id()}" class="btn btn-primary">
								계좌개설 <!-- <button type="submit" class="btn btn-primary" >계좌개설</button> -->
						</a>
						</td>
					</tr>
				</c:forEach>



			</table>
			<ul id="pagination-demo" class="pagination-sm"></ul>
		</div>
	</div>

	<script type="text/javascript" src="resources/js/jquery-1.12.3.min.js"></script>
	<script type="text/javascript"
		src="resources/js/jquery.twbsPagination.min.js"></script>
	<script>
		$('#pagination-demo').twbsPagination({
			totalPages : "<c:out value='${cont}'/>",

			visiblePages : 10,
			/* href : '?&page={{number}}', */
			href: "?page={{number}}&s_type=<c:out value='${type}'/>&s_text=<c:out value='${txt}'/>",
			onPageClick : function(event, page) {
				//alert(page);
				$('#page-content').text('Page ' + page);
			}
		});
		
		
		$('#txt_search').bind('keyup', function(event){
			if(event.which == 13){
				var type = $('#s_type').val();
				var txt = $('#s_text').val();
				
				$(location).attr('href', "customlist.do?type="+type+"&txt="+txt);
			}
		});

	</script>


</body>
</html>