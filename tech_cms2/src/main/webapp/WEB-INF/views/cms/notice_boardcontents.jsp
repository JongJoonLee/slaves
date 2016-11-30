<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<div class="ad_tit">공지사항 ${ctnt.notice_board_no}번 글</div>
<div class="row"> 
<table class="table table-striped">
	<tr class="info" style="text-align: center">
		<td style="text-align: left" width="20%">글번호 : ${ctnt.notice_board_no}</td>
		<td style="text-align: left">제목 : ${ctnt.notice_board_title}</td>
		<td width="10%">작성자 : ${ctnt.notice_board_writter}</td>
		<td width="30%">최종등록일 : <c:set var="dates"
							value="${fn:split(ctnt.notice_board_moddate,' ')}" /> <c:out
							value="${dates[0]}" /></td>
		<td width="10%"> 조회수 : ${ctnt.notice_board_hit}</td>
	</tr>
</table>
</div>  		


<div style="display: block; min-height: 350px;" >${ctnt.notice_board_contents}</div>
			
			
<br/>
<div align="center">
	<table class="table table-bordered table-condensed" style="width: 800px;">
		<tr>
			<td class="active" style="width: 100px;">이전글</td>
			<td><a href="notice_boardcontents.do?notice_board_no=${ctntpre.notice_board_no}">${ctntpre.notice_board_title}</a></td>
		</tr>
		<tr>
			<td class="active" style="width: 100px;">다음글</td>
			<td><a href="notice_boardcontents.do?notice_board_no=${ctntnext.notice_board_no}">${ctntnext.notice_board_title}</a></td>
		</tr>
	</table>
</div>
<div class="row">
	<div align="right">
		<a href="${pageContext.request.contextPath}/cms/notice.do"><button class="btn btn-primary">목록</button></a>
		<button class="btn btn-danger">삭제</button>
	</div>
</div>




