<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    
<table>
	<tr style="text-align: center">
		<td width="100px">글번호 : ${ctnt.notice_board_no}</td>
		<td>제목 : ${ctnt.notice_board_title}</td>
		<td width="150px">작성자 : ${ctnt.notice_board_writter}</td>
		<td style="text-align: right;" width="100px">최종등록일 : ${ctnt.notice_board_moddate}</td>
	</tr>
</table>
			


<div style="display: block; min-height: 500px;" >${ctnt.notice_board_contents}</div>
			
			
<br/>
<%-- <div align="center">
	<table class="table table-bordered table-condensed" style="width: 800px;">
		<tr>
			<td class="active" style="width: 100px;">이전글</td>
			<td><a href="notice_boardcontents.do?notice_board_no=${ctntpre.getNotice_board_no()}">${ctntpre.getNotice_board_title()}</a></td>
		</tr>
		<tr>
			<td class="active" style="width: 100px;">다음글</td>
			<td><a href="notice_boardcontents.do?notice_board_no=${ctntnext.getNotice_board_no()}">${ctntnext.getNotice_board_title()}</a></td>
		</tr>
	</table>
</div> --%>




