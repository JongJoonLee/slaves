<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<div class="ad_tit">대외홍보 ${ctnt.tb_promote_no}번 글</div>
<div class="row"> 
<table class="table table-striped">
	<tr class="info" style="text-align: center">
		<td style="text-align: left" width="20%">글번호 : ${ctnt.tb_promote_no}</td>
		<td style="text-align: left">제목 : ${ctnt.tb_promote_title}</td>
		<td width="30%">최종등록일 : <c:set var="dates"
							value="${fn:split(ctnt.tb_promote_moddate,' ')}" /> <c:out
							value="${dates[0]}" /></td>
		<td width="10%"> 조회수 : ${ctnt.tb_promote_hit}</td>
	</tr>
</table>
</div>  		


<div style="display: block; min-height: 350px;" >${ctnt.tb_promote_contents}</div>
			
			
<br/>
<div align="center">
	<table class="table table-bordered table-condensed" style="width: 800px;">
		<tr>
			<td class="active" style="width: 100px;">이전글</td>
			<td><a href="promote_contents.do?tb_promote_no=${ctntpre.tb_promote_no}">${ctntpre.tb_promote_title}</a></td>
		</tr>
		<tr>
			<td class="active" style="width: 100px;">다음글</td>
			<td><a href="promote_contents.do?tb_promote_no=${ctntnext.tb_promote_no}">${ctntnext.tb_promote_title}</a></td>
		</tr>
	</table>
</div>
<div class="row">
	<div align="right">
		<a href="${pageContext.request.contextPath}/cms/promote.do"><button class="btn btn-primary">목록</button></a>
		<button class="btn btn-danger">삭제</button>
	</div>
</div>




