<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
	var menuCd = "${menuCd}";
	var contextRoot = "${context_root}";
	
	
	$("#product").click(function(){
		$.doLoadPage("product");
	});
	/* 
	$("#partner").click(function(){
		$.doLoadPage("partner");
	}); */
	$("#history").click(function(){
		$.doLoadPage("history");
	});
	$("#research").click(function(){
		$.doLoadPage("research");
	});
	$("#webEdit").click(function(){
		$.doLoadPage("webEdit");
	});
	/* $("#notice").click(function(){
		$.doLoadPage("notice");
	}); */
	$("#promote").click(function(){
		$.doLoadPage("promote");
	});
	$("#recruit").click(function(){
		$.doLoadPage("recruit");
	});
	
	$("#online").click(function(){
		$.doLoadPage("online");
	});
	$("#manager").click(function(){
		$.doLoadPage("manager");
	});
	
	
		
	$.doLoadPage = function(psPageId, psSurveyId){
		if("surveyDetail" == psPageId){
			window.location.replace(contextRoot+"/goPage.do?menuId="+psPageId+"&surveyId="+psSurveyId);
			return;
		}
		window.location.replace(contextRoot+"/goPage.do?menuId="+psPageId);
		
	};
	
	$.setClassActive = function(psTagId){
		if(!psTagId){
			var vaTag = new Array();
			vaTag = ["product","partner","history","research","webEdit","notice","promote","recruit","online","manager"];
			for(var i = 0; i < vaTag.length; i++){
				$('#'+vaTag[i]).removeClass('on');
			}
			$('#product').addClass("on");
			return;
		}else{
			if($('#'+psTagId).hasClass("on")){
				return;
			};
			
			var vaTag = new Array();
			vaTag = ["product","partner","history","research","webEdit","notice","promote","recruit","online","manager"];
			for(var i = 0; i < vaTag.length; i++){
				if(vaTag[i] == psTagId){
					$('#'+psTagId).addClass("on");
				}else{
					$('#'+vaTag[i]).removeClass('on');
				}
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
	<span id="product">PRODUCT 관리</span>
	<a href="${pageContext.request.contextPath}/cms/partner.do"><span id="partner">주요고객사 관리</span></a>
	<span id="history">연혁 관리</span>
	<span id="research">연구개발내역 관리</span>
	<span id="webEdit">웹에디터</span>
	<a href="${pageContext.request.contextPath}/cms/notice.do"><span id="notice">공지사항관리</span></a>
	<span id="promote">대외홍보 관리</span>
	<span id="recruit">채용공고 관리</span>
	<span id="online">온라인접수 관리</span>
	<span id="manager">담당자관리</span> 
	
</div>