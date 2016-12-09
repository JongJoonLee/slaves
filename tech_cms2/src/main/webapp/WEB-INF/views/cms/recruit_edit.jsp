<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="ad_tit">채용공고 글 수정</div>

<form action="tb_recruitupdatepost1.do" enctype="multipart/form-data" method="post"	id="frm" onsubmit="return validateForm('frm');">
	<table>
		<tr>
			<td style="width:150%">
				<input name="tb_recruit_title" type="text" id="tb_recruit_title"
					value="${ctnt.tb_recruit_title}" class="form-control"/>
			</td>
			<td>
				<input type="hidden" id="tb_recruit_no" name="tb_recruit_no" value="${ctnt.tb_recruit_no}"/>
				<button type="submit" class="btn btn-primary" style="margin-bottom: 5px; margin-left: 5px;">수정</button>
			</td>
			
		</tr>
		

	</table>
	
	<textarea name="tb_recruit_contents"rows="100" id="editor1">${ctnt.tb_recruit_contents}</textarea>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

<script>
	CKEDITOR.replace('editor1');
</script>
