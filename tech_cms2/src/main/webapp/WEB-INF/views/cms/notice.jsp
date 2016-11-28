<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<script type="text/javascript"
	src="../resources/js/jquery.twbsPagination.js"></script>



	

<div class="ad_tit">공지사항 관리</div>

<div class="row">
	<!-- 검색 시작 -->
	<div class="col-md-10">
		<form action="notice_boardsearch.do" method="get">
			<div class="form-inline" align="right"
				style="padding-top: 5px; padding-bottom: 5px;">
				<div class="form-group">
					<select id="s_type" name="s_type" class="form-control">
						<option value="notice_board_title"
							${param.s_type=="notice_board_title" ? 'selected="selected"':''}>제목</option>
						<option value="notice_board_writter"
							${param.s_type=="notice_board_writter" ? 'selected="selected"':''}>글쓴이</option>
						<option value="notice_board_contents"
							${param.s_type=="notice_board_contents" ? 'selected="selected"':''}>내용</option>
					</select>
				</div>

				<div class="form-group">
					<input style="padding-top: 0px; padding-bottom: 0px;" type="text"
						name="s_text" id="s_text" class="form-control" />
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- 검색 끝 -->

<div class="row">

	<div class="col-md-10">

		<table class="table table-striped table-condensed">
			<tr style="text-align: center">
				<th style="text-align: center" width="100px">번호</th>
				<th style="text-align: center">제목</th>
				<th width="100px" style="text-align: center">작성자</th>
				<th width="100px" style="text-align: center">조회수</th>
				<th width="200px" style="text-align: center">날짜</th>
			</tr>





			<c:forEach var="tmp" items="${list}">
				<tr>
					<td style="text-align: center">${tmp.notice_board_no}</td>

					<td><c:choose>
							<c:when test="${fn:length(tmp.notice_board_title)>40}">
								<a href="#"><c:out
										value="${fn:substring(tmp.notice_board_title,0,40)}" />...</a>
							</c:when>
							<c:otherwise>
								<a href="#">${tmp.notice_board_title}</a>
							</c:otherwise>
						</c:choose></td>

					<td style="text-align: center">${tmp.notice_board_writter}</td>

					<td style="text-align: center">${tmp.notice_board_hit}</td>

					<td style="text-align: center"><c:set var="dates"
							value="${fn:split(tmp.notice_board_moddate,' ')}" /> <c:out
							value="${dates[0]}" /></td>
				</tr>
			</c:forEach>
		</table>
		
		<ul id="pagination-demo" class="pagination-sm"></ul>



		<table style="width: 100%;">
			<tr>
				<td width="80%" align="center" colspan="10"><ul
						id="pagination-demo" class="pagination-sm"></ul></td>
				<td width="20%" align="right" colspan="2"><c:set var="session"
						value="${_id}" /> <c:choose>
						<c:when test="${session eq null}">
							<a href="login.do?prev=notice_boardwrite.do"
								class="btn btn-primary"> 글작성 </a>
						</c:when>
						<c:otherwise>
							<a href="notice_boardwrite.do" class="btn btn-primary"> 글작성 </a>

						</c:otherwise>
					</c:choose></td>

			</tr>
		</table>

	</div>


</div>
<script>
	

	
	$('#pagination-demo').twbsPagination({
		totalPages : "<c:out value='${cont}'/>",
		visiblePages : 10,
		startPage: 1,
        
        initiateStartPageClick: false,
		
		/* href : '?&page={{number}}', */
		href : "?page={{number}}&s_type=<c:out value='${s_type}'/>&s_text=<c:out value='${s_text}'/>",
		onPageClick : function(event, page) {
			
			
			$('#page-content').text('Page' + page);
		}
	});
	/* alert(page); */


</script>



