<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>




	<div class="ad_tit">고객사 관리</div>
	

	<table class="table">
		<tr class="active">
			<th>고객사 명칭</th>
			<th>로고 이미지</th>
			<th>홈페이지주소</th>
			<th>삭제</th>
		</tr>
		
		
		<c:forEach var="tmp" items="${list}">
		
		<tr>
			<td><c:out value="${tmp.partner_name}"/></td>
			<td><img style="height: 30px;" src="${pageContext.request.contextPath}/<c:out value="${tmp.partner_ci}"/>"/></td>
			<td><c:out value="${tmp.partner_url}"/></td>
			<td><button class="btn btn-danger">삭제</button></td>
			
		
		
		</tr>
		
		
			
		</c:forEach>
		
		
	</table>
	
	
	<button class="btn btn-primary" data-toggle="modal" data-target="#myModal">추가</button>
		<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">주요 고객사 추가</h4>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
		
		
		
		
		
		
	
	