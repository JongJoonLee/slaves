<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>




	<div class="ad_tit">고객사 관리</div>
	
	<div class="search" id="searchArea">
	
	
	<c:forEach var="tmp" items="${list}">
	<c:out value="${tmp.partner_name}"/>
	</c:forEach>
	

	</div>
	
