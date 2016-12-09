<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="ad_tit">대외홍보 글쓰기</div>

<form action="promote_writepost1.do" enctype="multipart/form-data" method="post"	id="frm" onsubmit="return validateForm('frm');">
	<table>
		<tr>
			<td style="width:150%">
				<input name="tb_promote_title" type="text" id="tb_promote_title"
					placeholder="제목을 입력하세요" class="form-control"/>
			</td>
			<td>
				<%-- <input type="hidden" id="notice_board_writter" name="notice_board_writter" value="${userBeans.username}"/> --%>
				<button type="submit" class="btn btn-primary" style="margin-bottom: 5px; margin-left: 5px;">글쓰기</button>
			</td>
		</tr>

	</table>

	<textarea name="tb_promote_contents"rows="100" id="editor1"></textarea>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('editor1');
</script>
