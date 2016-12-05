<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

   

		<table class="table">
			<tr>
			<th>분류</th>
			<th>제품명</th>
			<th>첨부파일</th>
			<th>세부내용</th>
			<th>삭제</th>
			</tr>
			
			
			
			<c:forEach var="tmp" items="${listDetail}">
			<tr>
				<td>${tmp.tb_product_sub_title}</td>
				<td>${tmp.tb_product_detail_title}</td>
				<td><button class="btn btn-success">파일첨부</button></td>
				<td><button class="btn btn-primary">세부내용</button></td>
				<td><button class="btn btn-danger">삭제</button></td>
			</tr>
			</c:forEach>
		</table>

	