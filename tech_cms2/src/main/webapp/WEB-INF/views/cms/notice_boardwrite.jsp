<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="ad_tit">공지사항 글쓰기</div>

<form action="notice_boardwritepost1.do" method="post"	id="frm" onsubmit="return validateForm('frm');">
	<table>
		<tr>
			<td style="width:150%">
				<input name="notice_board_title" type="text" id="notice_board_title"
					placeholder="제목을 입력하세요" class="form-control"/>
			</td>
			<td>
				<input type="hidden" id="notice_board_writter" name="notice_board_writter" value="${userBeans.username}"/>
				<button type="submit" class="btn btn-primary" style="margin-bottom: 5px; margin-left: 5px;">글쓰기</button>
			</td>
		</tr>

	</table>

	<textarea name="notice_board_contents"rows="100" id="editor1"></textarea>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('editor1');
</script>
