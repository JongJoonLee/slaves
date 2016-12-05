<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>




	<div class="ad_tit">고객사 관리 </div>
	<div align="right">
	<button class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="margin-bottom: 5px;">
	추가</button></div>
	

	<table class="table">
		<tr class="active">
			<th>고객사 명칭</th>
			<th>로고 이미지</th>
			<th>홈페이지주소</th>
			<th>이미지변경</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		
		
		<c:forEach var="tmp" items="${list}">
		
		<tr>
			<td><c:out value="${tmp.partner_name}"/></td>
			<td><img style="height: 30px;" src="${pageContext.request.contextPath}/<c:out value="${tmp.partner_ci}"/>"/></td>
			<td><c:out value="${tmp.partner_url}"/></td>
			<td><button class="btn btn-success">첨부</button></td>
			<td><button class="btn btn-primary" data-toggle="modal" data-target="#updatemodal${tmp.partner_no}">수정</button></td>
			<td>
			<form action="partnerDelete.do" method="post">
			<input type="hidden" name="partner_no" value="${tmp.partner_no}"/>
			<button type="submit" class="btn btn-danger">삭제</button>
			
			</form>
			</td>
			
		
		
		</tr>
		
		<!-- 수정 모달 -->
	<div class="modal fade" id="updatemodal${tmp.partner_no}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel2">주요 고객사 수정</h4>
	      </div>
	      <form method="post" action="partnerUpdate.do">
		      <div class="modal-body">
			  	   <input type="hidden" name="partner_no" value="${tmp.partner_no}"/>
				   <input name="partner_name" id="partner_name" type="text" class="form-control" value="${tmp.partner_name}"/>
				   <input name="partner_url" id="partner_url" type="text" class="form-control" value="${tmp.partner_url}"/>	
			      
		      </div>
		      <div class="modal-footer">
			     	<button type="button" class="btn btn-success" data-dismiss="modal">로고첨부</button>
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!-- 수정 모달 끝-->
		
		
			
		</c:forEach>
		
		
	</table>
	
	
	
	<!--고객사추가 Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">주요 고객사 추가</h4>
	      </div>
	       <form method="post" action="partnerPost.do">
		      <div class="modal-body">
			    	
			    	<input name="partner_name" id="partner_name" type="text" class="form-control" placeholder="고객사 명칭 입력"/>
				   <input name="partner_url" id="partner_url" type="text" class="form-control" placeholder="홈페이지 주소 입력"/>	
			      
		      </div>
		      <div class="modal-footer">
			     	<button type="button" class="btn btn-success" data-dismiss="modal">로고첨부</button>
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!--고객사추가 Modal 끝 -->	
	
	
	
		
		
		
		
	
	