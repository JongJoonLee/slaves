<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
	var menuCd = "${menuCd}";
	var contextRoot = "${context_root}";
	
	$("#menu").click(function(){
		$.doLoadPage("menu");
	});
	$("#auth").click(function(){
		$.doLoadPage("auth");
	});
	$("#user").click(function(){
		$.doLoadPage("user");
	});
	$("#panel").click(function(){
		$.doLoadPage("panel");
	});
	$("#webEdit").click(function(){
		$.doLoadPage("webEdit");
	});
	$("#basicCode").click(function(){
		$.doLoadPage("basicCode");
	});
	$("#board").click(function(){
		$.doLoadPage("board");
	});
	$("#notice").click(function(){
		$.doLoadPage("notice");
	});
	$("#mail").click(function(){
		$.doLoadPage("mail");
	});
	$("#popup").click(function(){		
		$.doLoadPage("popup");
	});
	$("#banner").click(function(){		
		$.doLoadPage("banner");
	});
	$("#multilang").click(function(){
		$.doLoadPage("multilang");
	});
	$("#survey").click(function(){
		$.doLoadPage("survey");
	});
	$("#excelUpload").click(function(){
		$.doLoadPage("excelUpload");
	});
		
	$.doLoadPage = function(psPageId, psSurveyId){
		if("surveyDetail" == psPageId){
			window.location.replace(contextRoot+"/goPage.do?menuId="+psPageId+"&surveyId="+psSurveyId);
			return;
		}
		window.location.replace(contextRoot+"/goPage.do?menuId="+psPageId);
		//$("#contents").load(contextRoot+"/goPage.do?menuId="+psPageId); 
	};
	
	$.setClassActive = function(psTagId){
		if(!psTagId){
			var vaTag = new Array();
			vaTag = ["menu","auth","user","panel","webEdit","basicCode","board","notice","mail","popup","banner","multilang","survey","excelUpload"];
			for(var i = 0; i < vaTag.length; i++){
				$('#'+vaTag[i]).removeClass('on');
			}
			$('#menu').addClass("on");
			return;
		}else{
			if($('#'+psTagId).hasClass("on")){
				return;
			};
			
			var vaTag = new Array();
			vaTag = ["menu","auth","user","panel","webEdit","basicCode","board","notice","mail","popup","banner","multilang","survey","excelUpload"];
			for(var i = 0; i < vaTag.length; i++){
				if(vaTag[i] == psTagId){
					$('#'+psTagId).addClass("on");
				}else{
					$('#'+vaTag[i]).removeClass('on');
				}
			}
			if("surveyDetail" == psTagId){
				$('#survey').addClass("on");
			}
		}
	}
});
$(window).load(function(){
	var menuCd = "${menuCd}";
	$.setClassActive(menuCd);
});
</script>
<div class="nav">
	<span id="menu">메뉴관리</span>
	<span id="auth">권한관리</span>
	<span id="user">사용자관리</span>
	<span id="panel">패널관리</span> 
	<span id="webEdit">웹에디터</span>
	<span id="basicCode">기초코드관리</span> 
	<span id="board">게시물관리</span> 
	<span id="notice">게시판관리</span>
	<!-- <span id="mail">메일링 서비스</span> --> 
	<span id="popup">popup관리</span> 
	<span id="banner">베너관리</span>
	<span id="multilang">다국어지원</span>
	<span id="survey">설문지</span>
	<span id="excelUpload">엑셀업로드</span>		
</div>