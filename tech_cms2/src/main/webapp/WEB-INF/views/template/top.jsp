<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<script type="text/javascript">
$(document).ready(function(){
	$.gotoMainPage = function(){
		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/main"/>').attr("method", "post");

   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
	};
	$.gotoLogout = function(){
		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/j_spring_security_logout"/>').attr("method", "post");

   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
	};
});
</script>
<div class="top">
	<div class="logo" onclick="$.gotoMainPage();"><img src="<c:url value='/resources/images/logo.jpg'/>" width="200" height="29" alt="" /></div>
	<div class="join"><span class="nm">${userBeans.username} 님</span> <em>|</em> <span class="log_btn" onclick="$.gotoLogout();">로그아웃</span></div>
</div>