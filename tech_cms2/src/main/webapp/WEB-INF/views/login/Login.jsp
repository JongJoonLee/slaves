<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/comm/login.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/comm/reset.css'/>">

<script type="text/javascript">
$(document).ready(function(){
	var browser_Lang;
	if (navigator.appName == "Netscape") {
	 	browser_Lang = navigator.language;
	} else {
	 	browser_Lang = navigator.browserLanguage;
	}

	if(localStorage.getItem("siteLang") != null 
			&& (browser_Lang.split("-")[0] != localStorage.getItem("siteLang") && window.location.href.indexOf("?language") == -1)){
		window.location.href = "?language="+localStorage.getItem("siteLang");
		return false;
	}
	
	var winLoc = window.location.href;
	if (winLoc.indexOf("login_error") != -1) {
		$("#pwMsg").empty();
		$("#pwMsg").append("아이디/비밀번호가 잘못되었습니다.");
		localStorage.clear();
	}
	
	//아이디, 패스워드 필드 포커스 토글
	$("#id, #password").blur(function(){
		$(this).parents("p").removeClass("on");
	});
	$("#id, #password").focus(function(){
		$(this).parents("p").addClass("on");
	});
	
	$("#id, #password").keydown(function(e){
		if (e.keyCode == 13) {login();}
	});
	
	$("#btnAutoLogin").click(function(){
		$("#autoLogin").val($("#autoLogin").val() == "true"? "false":"true");
		localStorage.setItem("isAuto", $("#autoLogin").val());
		//setAutoBtn();
	});

	$("#id").focus();
	
	//setAutoBtn();
	//autoLogin();
});

function login(){
	$("label[for=msg]").empty();
	if (isEmpty($("#id").val())) {
		$("#id").focus();
		$("#idMsg").append("아이디를 입력해주세요");
		return;
	}
	if (isEmpty($("#password").val())) {
		$("#password").focus();
		$("#pwMsg").append("비밀번호를 입력해주세요");
		return;
	}
	if(localStorage.getItem("isAuto") == "true"){
		localStorage.setItem("userId",$("#id").val());
		localStorage.setItem("userPw",$("#password").val());
	}
	$("#loginFrm").submit();
}

function autoLogin(){
	if(typeof(Storage) !== "undefined") {
	    // localStorage/sessionStorage
	    if(localStorage.getItem("isAuto") == "true"){
	    	$("#id").val(localStorage.getItem("userId"));
	    	$("#password").val(localStorage.getItem("userPw"));
	    	login();
	    }
	} else {
	    // Cookie
	    
	}
}

function setAutoBtn(){
	var isAuto = localStorage.getItem("isAuto");
	var btn = $("#btnAutoLogin");
	if(isAuto == "true"){
		btn.addClass("on");
	}else{
		btn.removeClass("on");
	}
}
</script>
	
<!--wrap -->
<div id="wrap lo">
	<div class="login">
		<form id="loginFrm" action="<c:url value='/j_spring_security_check'/>" method="post">
			<p class="logo"><img src="<c:url value="/resources/images/logo.jpg"/>" width="100%" alt="해운거래정보센터 CI" /></p>
			<p class="tt"><img src="<c:url value='/resources/images/check.png'/>" width="3%" alt="체크이미지" /><spring:message code="msg.idpwd.entr"/></p>
			<div class="in">
				<p><span class="tx"><spring:message code="label.id"/></span> <span><input id="id" name="j_username" type="text" title="<spring:message code='label.id.alt'/>" /></span></p>
				<!--입력 -->
				<p class="tts"><label for="msg" id="idMsg"></label></p>
				<!--//입력 -->
				<p><span class="tx"><spring:message code="label.pwd"/></span> <span><input id="password" name="j_password" type="password" title="<spring:message code='label.pwd.alt'/>" /></span></p>
				<!--입력 -->
				<p class="tts"><label for="msg" id="pwMsg"></label></p>
				<!--//입력 -->
				<!--자동로그인 전 -->
				<!-- <p id="btnAutoLogin" class="ch_btn"><span class="ch"></span> 자동 로그인</p>
				<input type="hidden" id="autoLogin" name="autoLogin" title="자동로그인"/> -->
				<!--//자동로그인 전 -->
			</div>
			<p class="lg_btn" onclick="login();"><spring:message code="label.login"/></p>
			<p class="footer"><img src="<c:url value='/resources/images/logo-s.jpg'/>" width="8%" alt="로고" />Copyright © 2016 <b>TECH FLOWER</b> All rights reserved</p>
		</form>
	</div>
</div>
<!--//wrap -->