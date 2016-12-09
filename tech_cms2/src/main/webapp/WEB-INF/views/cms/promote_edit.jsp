<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="ad_tit">대외홍보 글 수정</div>

<form action="tb_promoteupdatepost1.do" enctype="multipart/form-data" method="post"	id="frm" onsubmit="return validateForm('frm');">
	<table>
		<tr>
			<td style="width:150%">
				<input name="tb_promote_title" type="text" id="tb_promote_title"
					value="${ctnt.tb_promote_title}" class="form-control"/>
			</td>
			<td>
				<input type="hidden" id="tb_promote_no" name="tb_promote_no" value="${ctnt.tb_promote_no}"/>
				<button type="submit" class="btn btn-primary" style="margin-bottom: 5px; margin-left: 5px;">수정</button>
			</td>
			
		</tr>
		

	</table>
	
	<textarea name="notice_board_contents"rows="100" id="editor1">${ctnt.tb_promote_contents}</textarea>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('editor1');
</script>
