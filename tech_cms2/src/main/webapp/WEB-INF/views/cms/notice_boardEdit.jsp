<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="ad_tit">공지사항 글 수정</div>

<form action="notice_boardupdatepost1.do" enctype="multipart/form-data" method="post"	id="frm" onsubmit="return validateForm('frm');">
	<table>
		<tr>
			<td style="width:150%">
				<input name="notice_board_title" type="text" id="notice_board_title"
					value="${ctnt.notice_board_title}" class="form-control"/>
			</td>
			<td>
				<input type="hidden" id="notice_board_no" name="notice_board_no" value="${ctnt.notice_board_no}"/>
				<button type="submit" class="btn btn-primary" style="margin-bottom: 5px; margin-left: 5px;">수정</button>
			</td>
		</tr>

	</table>

	<textarea name="notice_board_contents"rows="100" id="editor1">${ctnt.notice_board_contents}</textarea>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('editor1');
</script>
