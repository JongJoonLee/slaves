<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!-- ======================================================================
다음 추가는 다음 문항을 확인한 이후 따라간다.

1.다음 문항이 소문항으로 존재한다면 소문항 추가만 가능
2.다음 문항이 소문항이 없고, 다음 대문항이라면 대문항 추가 및 소문항 추가 둘다 가능 (다음항목이 없더라도 같은 방식)
 -> x+1.0 or x.y+1 선택가능
======================================================================


======================================================================
이전 추가는 현재 문항을 따라간다.

1. 현재 문항이 x.0 이라면 이전 문항을 확인
 -> x-1.0 or x-1.y-1 선택 가능
2. 현재 문항이 x.1 이상의 소문항 이라면 소문항만 추가
======================================================================


======================================================================
마지막 추가는 제일 마지막 항목을 따라간다.

1. 제일 마지막 문항의 대문항 번호 x+1.0 or 제일 마지막 문항의 소문항 번호 x.y+1 선택가능
2. 데이터가 없다면 1.0 
====================================================================== -->

<html>
<head>
<title>설무지 문항 추가</title>

<link href="<c:url value='/resources/css/jquery/jquery-ui.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.min.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/admin.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/reset.css'/>"
	rel="stylesheet">

<script src="<c:url value='/resources/js/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery/jquery-1.11.0.min.js'/>"></script>
<script
	src="<c:url value='/resources/js/jquery/jquery-ui-1.11.2.custom.min.js'/>"></script>
<script src="<c:url value='/resources/js/common/common.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#btnSave").click(function(){
		if(!$.doChkValidation()){
			alert("문항 추가, 설문 내용, 설문 타입 은 필수입력 항목입니다.");
			return;
		}
		var vnCnt = 0;
		var vaList = ["divAns1","divAns2","divAns3","divAns4","divAns5","divAns6","divAns7","divAns8","divAns9","divAns10"
		              ,"divAns11","divAns12","divAns13","divAns14","divAns15","divAns16","divAns17","divAns18","divAns19","divAns20"];
		var vaListData = ["ipbAns1","ipbAns2","ipbAns3","ipbAns4","ipbAns5","ipbAns6","ipbAns7","ipbAns8","ipbAns9","ipbAns10"
		              ,"ipbAns11","ipbAns12","ipbAns13","ipbAns14","ipbAns15","ipbAns16","ipbAns17","ipbAns18","ipbAns19","ipbAns20"];
		var vaMulList = ["divMulAns1","divMulAns2","divMulAns3","divMulAns4","divMulAns5","divMulAns6"
		              ,"divMulAns7","divMulAns8","divMulAns9","divMulAns10"
		              ,"divMulAns11","divMulAns12","divMulAns13","divMulAns14"
		              ,"divMulAns15","divMulAns16","divMulAns17","divMulAns18"
		              ,"divMulAns19","divMulAns20"];
		var vaMulListData = ["ipbMulAns1","ipbMulAns2","ipbMulAns3","ipbMulAns4","ipbMulAns5","ipbMulAns6"
			              ,"ipbMulAns7","ipbMulAns8","ipbMulAns9","ipbMulAns10"
			              ,"ipbMulAns11","ipbMulAns12","ipbMulAns13","ipbMulAns14"
			              ,"ipbMulAns15","ipbMulAns16","ipbMulAns17","ipbMulAns18"
			              ,"ipbMulAns19","ipbMulAns20"];
		
		var vsType = '${SURVEY_POSITION}';
		var vsContentType = $("#selQuesType").val();
		var vsUrl = "";
		var voData = {};
		
		//voData.push('"' + 1 + '":"' + 1 + '"');
		//voData.push('"' + 2 + '":"' + 2 + '"');
		//voData.push('"' + 3 + '":"' + 3 + '"');
		voData['SURVEY_ID'] = '${SURVEY_ID}';
		voData['SURVEY_CONTENT'] = $("#ipbSurveyContent").val();
		voData['SURVEY_TYPE'] = vsContentType;
		
		if("MO" == vsContentType){
			for(var i = 0; i < vaList.length; i++){
				if(document.getElementById(vaList[i]).style.display != "none"){
					voData[vaListData[i]] = document.getElementById(vaListData[i]).value;
					voData["hidden"+(i+1)] = document.getElementById("hidden"+(i+1)).value;
					vnCnt++;					
				}	
			}
		}else if("S" == vsContentType){
			
		}else if("MM" == vsContentType){
			for(var i = 0; i < vaMulList.length; i++){
				if(document.getElementById(vaMulList[i]).style.display != "none"){
					voData[vaMulListData[i]] = document.getElementById(vaMulListData[i]).value;
					voData["hiddenMul"+(i+1)] = document.getElementById("hiddenMul"+(i+1)).value;
					vnCnt++;					
				}	
			}
		}
		voData['COUNT'] = vnCnt;
		
		if("BEF_INS" == vsType){
			//이전 추가
			vsUrl = '<c:url value="/doInsertBefDetail.do"/>';
			
			//server 에서는 해당 SURVEY_ID 에 대항하는 
			//대문항 추가일 경우 해당 TB_SERVEY_DETAIL 대문항 번호가 같거나 큰 대문항을 모두 +1 씩 업데이트
			//소문항 추가일 경우 SERVEY_ID,SERVEY_NO 이 같고 SERVEY_DNO 이 같거나 큰 소문항 데이터를 모두 +1 씩 업데이트
			//소문항 이 큰 데이터가 없을 경우 하지 않아도 된다
			//이전은 자신도 포함
			voData['SURVEY_NO'] = $('#ipbSurveyNo').val();
			voData['SURVEY_DNO'] = $('#ipbSurveyDNo').val();
			
			
		}else if("AFT_INS" == vsType){
			//다음 추가
			vsUrl = '<c:url value="/doInsertAftDetail.do"/>';
			
			//server 에서는 해당 SURVEY_ID 에 대항하는 
			//대문항 추가일 경우 이후의 TB_SERVEY_DETAIL 대문항 번호가 같거나 큰 대문항을  모두 +1 씩 업데이트
			//소문항 추가일 경우 SERVEY_ID,SERVEY_NO 이 같고 SERVEY_DNO 이 같거나 큰 소문항 데이터를 모두 +1 씩 업데이트
			//소문항이 큰 데이터가 없을 경우 하지 않아도 된다.
			//이후는 자신은 포함하지 않음
			voData['SURVEY_NO'] = $('#ipbSurveyNo').val();
			voData['SURVEY_DNO'] = $('#ipbSurveyDNo').val();
			
			
		}else if("NOW_UDT" == vsType){
			//수정
			vsUrl = '<c:url value="/doUpdateDetail.do"/>';
			voData['SURVEY_DID'] = '${SURVEY_DID}';
			voData['SURVEY_NO'] = '${SURVEY_NO}';
			voData['SURVEY_DNO'] = '${SURVEY_DNO}';
		}else if("END_INS" == vsType){
			//항목 추가
			vsUrl = '<c:url value="/doInsertLastDetail.do"/>';
			
			voData['SURVEY_NO'] = $('#ipbSurveyNo').val();
			voData['SURVEY_DNO'] = $('#ipbSurveyDNo').val();	
		}
		debugger;
		$.ajax({
    		url:vsUrl,
    		type: "POST",
    		async: false,
    		data: voData,
    		dataType: "json",
    		success:function(result){
    			if(!!result && result.result == "success"){
    				alert("완료");
    				window.close();		
    				window.opener.$.doLoadPage("surveyDetail","${SURVEY_ID}");
    			}else{
    				alert("시스템에 문제가 발생하였습니다. 관리자에게 문의하세요");
    				return false;
    			}	    			
    		},
    		error:function(e){
    			alert("error::"+JSON.stringify(e));
    		}
    	});
		//window.close();		
		//window.opener.$.doLoadPage("surveyDetail","${SURVEY_ID}");
	});
	
	$.doChkValidation = function(){
		if(!$("#ipbSurveyNo").val() || !$("#ipbSurveyDNo").val()){
			return false;
		}else if("필수입력 항목" == $("#ipbSurveyNo").val() || "필수입력 항목" == $("#ipbSurveyDNo").val()){
			return false;
		};
		if(!$("#ipbSurveyContent").val()){
			return false;
		}
		if(!$("#selQuesType").val()){
			return false;
		}
		return true;
	};
	
	$.doChangeSurveyNum = function(psVal){
		var vnSurveyNo = psVal;
		var vnIdxComm;
		if(!!vnSurveyNo){
			vnIdxComm = vnSurveyNo.indexOf(".");
			$("#ipbSurveyNo").val(vnSurveyNo.substring(0,vnIdxComm));
			$("#ipbSurveyDNo").val(vnSurveyNo.substring(vnIdxComm+1,vnSurveyNo.length));
			alert("문항 번호는 한번 설정하면 임의로 수정이 불가합니다.");
		}else{
			$("#ipbSurveyNo").val("필수입력 항목");
			$("#ipbSurveyDNo").val("필수입력 항목");
		}
	};
	
	$.doChangeSurveyType = function(psVal){
		switch(psVal){
		case "" :
			$("#divQuesType1").hide();
			$("#divQuesType2").hide();
			$("#divQuesType3").hide();
			break;
		case "MO" :
			$("#divQuesType1").show();
			$("#divQuesType2").hide();
			$("#divQuesType3").hide();
			break;
		case "S" :
			$("#divQuesType1").hide();
			$("#divQuesType2").show();
			$("#divQuesType3").hide();
			break;
		case "MM" :
			$("#divQuesType1").hide();
			$("#divQuesType2").hide();
			$("#divQuesType3").show();
			break;
		default :
			
			break;
		
		};
	};
	
	//보기 항목 추가
	$("#ipbAnsAdd").click(function(){
		var vaList = ["divAns1","divAns2","divAns3","divAns4","divAns5","divAns6","divAns7","divAns8","divAns9","divAns10"
		              ,"divAns11","divAns12","divAns13","divAns14","divAns15","divAns16","divAns17","divAns18","divAns19","divAns20"];
		for(var i = 0; i < vaList.length; i++){
			if(document.getElementById(vaList[i]).style.display != "none" && document.getElementById(vaList[i+1]).style.display == "none"){
				$("#"+vaList[i+1]).show();break;
			}	
		}
	});
	
	//보기 항목 삭제
	$("#ipbAnsRemove").click(function(){
		var vaList = ["divAns1","divAns2","divAns3","divAns4","divAns5","divAns6","divAns7","divAns8","divAns9","divAns10"
		              ,"divAns11","divAns12","divAns13","divAns14","divAns15","divAns16","divAns17","divAns18","divAns19","divAns20"];
		for(var i = 0; i < vaList.length; i++){
			if(document.getElementById(vaList[i]).style.display != "none" && document.getElementById(vaList[i+1]).style.display == "none"){
				if(vaList[i] == "divAns1"){
					break;
				}
				$("#"+vaList[i]).hide();break;
			}
		}
	});
	
	//다건 보기 항목 추가
	$("#ipbMulAnsAdd").click(function(){
		var vaList = ["divMulAns1","divMulAns2","divMulAns3","divMulAns4","divMulAns5","divMulAns6"
		              ,"divMulAns7","divMulAns8","divMulAns9","divMulAns10"
		              ,"divMulAns11","divMulAns12","divMulAns13","divMulAns14"
		              ,"divMulAns15","divMulAns16","divMulAns17","divMulAns18"
		              ,"divMulAns19","divMulAns20"];
		for(var i = 0; i < vaList.length; i++){
			if(document.getElementById(vaList[i]).style.display != "none" && document.getElementById(vaList[i+1]).style.display == "none"){
				$("#"+vaList[i+1]).show();break;
			}	
		}
	});
	
	//다건 보기 항목 삭제
	$("#ipbMulAnsRemove").click(function(){
		var vaList = ["divMulAns1","divMulAns2","divMulAns3","divMulAns4","divMulAns5","divMulAns6"
		              ,"divMulAns7","divMulAns8","divMulAns9","divMulAns10"
		              ,"divMulAns11","divMulAns12","divMulAns13","divMulAns14"
		              ,"divMulAns15","divMulAns16","divMulAns17","divMulAns18"
		              ,"divMulAns19","divMulAns20"];
		for(var i = 0; i < vaList.length; i++){
			if(document.getElementById(vaList[i]).style.display != "none" && document.getElementById(vaList[i+1]).style.display == "none"){
				if(vaList[i] == "divMulAns1"){
					break;
				}
				$("#"+vaList[i]).hide();break;
			}
		}
	});
	
});
</script>

</head>
<body>
<div class="sur_con">

	<p class="close_btn">
		<img src="<c:url value='/resources/images/close_btn.jpg'/>" width="22" height="21" alt=""/>
	</p>
	<p class="sur_tit">설문지 문항 추가</p>
	
	<div class="sur_add">

		<div class="sur_add">
	
	<c:set var="pos" value="${SURVEY_POSITION}"/>
	<c:choose>
		<c:when test="${pos == 'NOW_UDT'}">
			<!-- <p>수정</p> -->
			<p>1. 문항 번호 : 
				대문항 번호 : <input id="ipbSurveyNo" name="ipbSurveyNo" type="text" value="${detailList[0].SURVEY_NO}" disabled="disabled" class="m1" style="width: 60px;">
				소문항 번호 : <input id="ipbSurveyDNo" name="ipbSurveyDNo" type="text" value="${detailList[0].SURVEY_DNO}" disabled="disabled" class="m1" style="width: 60px;">
			</p>
			
			<p>2. 설문 내용 (질의문) : <input id="ipbSurveyContent" name="ipbSurveyContent" type="text" class="m2" value="${detailList[0].SURVEY_CONTENT}">
			</p>
			
			<p>3. 설문 타입 : 
			<select id="selQuesType" name="selQuesType" class="select" onchange="$.doChangeSurveyType(this.value)">
				<c:choose>
					<c:when test="${detailList[0].SURVEY_TYPE == 'MO'}">
						<option value="">- 선택 -</option>
						<option value="MO" selected="selected">객관형 문항</option>
						<option value="S">주관형 문항</option>
						<option value="MM">다중선택형 문항</option>
					</c:when>
					<c:when test="${detailList[0].SURVEY_TYPE == 'S'}">
						<option value="">- 선택 -</option>
						<option value="MO">객관형 문항</option>
						<option value="S" selected="selected">주관형 문항</option>
						<option value="MM">다중선택형 문항</option>
					</c:when>
					<c:when test="${detailList[0].SURVEY_TYPE == 'MM'}">
						<option value="">- 선택 -</option>
						<option value="MO">객관형 문항</option>
						<option value="S">주관형 문항</option>
						<option value="MM" selected="selected">다중선택형 문항</option>
					</c:when>
					<c:otherwise>
						<option value="">- 선택 -</option>
						<option value="MO">객관형 문항</option>
						<option value="S">주관형 문항</option>
						<option value="MM">다중선택형 문항</option>
					</c:otherwise>
				</c:choose>
			</select>&nbsp;&nbsp;&nbsp;&nbsp; <em> - 객관형은 최대 20 보기까지 가능  - </em>
			</p>
			
			<c:choose>
				<c:when test="${detailList[0].SURVEY_TYPE == 'MO'}">
					<div id="divQuesType1">
						<c:if test="${fn:length(detailList[0].exampleList) > 0}">
							<c:forEach var="list" varStatus="status" items="${detailList[0].exampleList}">
								<div id="divAns${status.count}" class="ipb_style">
									<input type="hidden" id="hidden${status.count}" value="${list.SURVEY_DE_ID}">
									<input id="ipbAns${status.count}" name="ipbAns${status.count}" type="text" style="width: 500px;" value="${list.E_SURVEY_CONTENT}">
								</div>
								<c:if test="${fn:length(detailList[0].exampleList) == status.count}">
								 	<c:forEach var="dList" varStatus="dStatus" begin="${status.count}" end="${19 + status.count}">
								 		<div id="divAns${dStatus.count}" class="ipb_style" style="display: none;">
								 			<input type="hidden" id="hidden${dStatus.count}" value="">
								 			<input id="ipbAns${dStatus.count}" name="ipbAns${dStatus.count}" type="text" style="width: 500px;">
								 		</div>
								 	</c:forEach>
								</c:if>
							</c:forEach>
							<br>
							
							<span id="ipbAnsAdd" type="button" value="+">
								<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
							</span>
							<span id="ipbAnsRemove" type="button" value="-">
								<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
							</span>
						</c:if>
					</div>
					<div id="divQuesType2"  class="ipb_style" style="display: none;">
						<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
					</div>
					<div id="divQuesType3" style="display: none;">
						<div id="divMulAns1" class="ipb_style"><input type="hidden" id="hiddenMul1" value=""><input id="ipbMulAns1" name="ipbMulAns1" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul2" value=""><input id="ipbMulAns2" name="ipbMulAns2" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul3" value=""><input id="ipbMulAns3" name="ipbMulAns3" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul4" value=""><input id="ipbMulAns4" name="ipbMulAns4" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul5" value=""><input id="ipbMulAns5" name="ipbMulAns5" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul6" value=""><input id="ipbMulAns6" name="ipbMulAns6" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul7" value=""><input id="ipbMulAns7" name="ipbMulAns7" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul8" value=""><input id="ipbMulAns8" name="ipbMulAns8" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul9" value=""><input id="ipbMulAns9" name="ipbMulAns9" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul10" value=""><input id="ipbMulAns10" name="ipbMulAns10" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul11" value=""><input id="ipbMulAns11" name="ipbMulAns11" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul12" value=""><input id="ipbMulAns12" name="ipbMulAns12" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul13" value=""><input id="ipbMulAns13" name="ipbMulAns13" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul14" value=""><input id="ipbMulAns14" name="ipbMulAns14" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul15" value=""><input id="ipbMulAns15" name="ipbMulAns15" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul16" value=""><input id="ipbMulAns16" name="ipbMulAns16" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul17" value=""><input id="ipbMulAns17" name="ipbMulAns17" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul18" value=""><input id="ipbMulAns18" name="ipbMulAns18" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul19" value=""><input id="ipbMulAns19" name="ipbMulAns19" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul20" value=""><input id="ipbMulAns20" name="ipbMulAns20" type="text" style="width: 500px;"></div>
			 			<br>
			 			<span id="ipbMulAnsAdd" type="button" value="+">
							<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
						</span>
						<span id="ipbMulAnsRemove" type="button" value="-">
							<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
						</span>
					</div>
				</c:when>
				<c:when test="${detailList[0].SURVEY_TYPE == 'S'}">
					<div id="divQuesType1" style="display: none;">
						<div id="divAns1" class="ipb_style"><input type="hidden" id="hidden1" value=""><input id="ipbAns1" name="ipbAns1" type="text" style="width: 500px;"></div>
			 			<div id="divAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hidden2" value=""><input id="ipbAns2" name="ipbAns2" type="text" style="width: 500px;"></div>
			 			<div id="divAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hidden3" value=""><input id="ipbAns3" name="ipbAns3" type="text" style="width: 500px;"></div>
			 			<div id="divAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hidden4" value=""><input id="ipbAns4" name="ipbAns4" type="text" style="width: 500px;"></div>
			 			<div id="divAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hidden5" value=""><input id="ipbAns5" name="ipbAns5" type="text" style="width: 500px;"></div>
			 			<div id="divAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hidden6" value=""><input id="ipbAns6" name="ipbAns6" type="text" style="width: 500px;"></div>
			 			<div id="divAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hidden7" value=""><input id="ipbAns7" name="ipbAns7" type="text" style="width: 500px;"></div>
			 			<div id="divAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hidden8" value=""><input id="ipbAns8" name="ipbAns8" type="text" style="width: 500px;"></div>
			 			<div id="divAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hidden9" value=""><input id="ipbAns9" name="ipbAns9" type="text" style="width: 500px;"></div>
			 			<div id="divAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hidden10" value=""><input id="ipbAns10" name="ipbAns10" type="text" style="width: 500px;"></div>
			 			<div id="divAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hidden11" value=""><input id="ipbAns11" name="ipbAns11" type="text" style="width: 500px;"></div>
			 			<div id="divAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hidden12" value=""><input id="ipbAns12" name="ipbAns12" type="text" style="width: 500px;"></div>
			 			<div id="divAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hidden13" value=""><input id="ipbAns13" name="ipbAns13" type="text" style="width: 500px;"></div>
			 			<div id="divAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hidden14" value=""><input id="ipbAns14" name="ipbAns14" type="text" style="width: 500px;"></div>
			 			<div id="divAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hidden15" value=""><input id="ipbAns15" name="ipbAns15" type="text" style="width: 500px;"></div>
			 			<div id="divAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hidden16" value=""><input id="ipbAns16" name="ipbAns16" type="text" style="width: 500px;"></div>
			 			<div id="divAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hidden17" value=""><input id="ipbAns17" name="ipbAns17" type="text" style="width: 500px;"></div>
			 			<div id="divAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hidden18" value=""><input id="ipbAns18" name="ipbAns18" type="text" style="width: 500px;"></div>
			 			<div id="divAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hidden19" value=""><input id="ipbAns19" name="ipbAns19" type="text" style="width: 500px;"></div>
			 			<div id="divAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hidden20" value=""><input id="ipbAns20" name="ipbAns20" type="text" style="width: 500px;"></div>
			 			<br>
			 			<span id="ipbAnsAdd" type="button" value="+">
							<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
						</span>
						<span id="ipbAnsRemove" type="button" value="-">
							<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
						</span>
					</div>
					<div id="divQuesType2" class="ipb_style">
						<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
					</div>
					<div id="divQuesType3" style="display: none;">
						<div id="divMulAns1" class="ipb_style"><input type="hidden" id="hiddenMul1" value=""><input id="ipbMulAns1" name="ipbMulAns1" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul2" value=""><input id="ipbMulAns2" name="ipbMulAns2" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul3" value=""><input id="ipbMulAns3" name="ipbMulAns3" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul4" value=""><input id="ipbMulAns4" name="ipbMulAns4" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul5" value=""><input id="ipbMulAns5" name="ipbMulAns5" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul6" value=""><input id="ipbMulAns6" name="ipbMulAns6" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul7" value=""><input id="ipbMulAns7" name="ipbMulAns7" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul8" value=""><input id="ipbMulAns8" name="ipbMulAns8" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul9" value=""><input id="ipbMulAns9" name="ipbMulAns9" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul10" value=""><input id="ipbMulAns10" name="ipbMulAns10" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul11" value=""><input id="ipbMulAns11" name="ipbMulAns11" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul12" value=""><input id="ipbMulAns12" name="ipbMulAns12" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul13" value=""><input id="ipbMulAns13" name="ipbMulAns13" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul14" value=""><input id="ipbMulAns14" name="ipbMulAns14" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul15" value=""><input id="ipbMulAns15" name="ipbMulAns15" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul16" value=""><input id="ipbMulAns16" name="ipbMulAns16" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul17" value=""><input id="ipbMulAns17" name="ipbMulAns17" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul18" value=""><input id="ipbMulAns18" name="ipbMulAns18" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul19" value=""><input id="ipbMulAns19" name="ipbMulAns19" type="text" style="width: 500px;"></div>
			 			<div id="divMulAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul20" value=""><input id="ipbMulAns20" name="ipbMulAns20" type="text" style="width: 500px;"></div>
			 			<br>
			 			<span id="ipbMulAnsAdd" type="button" value="+">
							<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
						</span>
						<span id="ipbMulAnsRemove" type="button" value="-">
							<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
						</span>
					</div>
				</c:when>
				<c:when test="${detailList[0].SURVEY_TYPE == 'MM'}">
					<div id="divQuesType1" style="display: none;">
						<div id="divAns1" class="ipb_style"><input type="hidden" id="hidden1" value=""><input id="ipbAns1" name="ipbAns1" type="text" style="width: 500px;"></div>
			 			<div id="divAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hidden2" value=""><input id="ipbAns2" name="ipbAns2" type="text" style="width: 500px;"></div>
			 			<div id="divAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hidden3" value=""><input id="ipbAns3" name="ipbAns3" type="text" style="width: 500px;"></div>
			 			<div id="divAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hidden4" value=""><input id="ipbAns4" name="ipbAns4" type="text" style="width: 500px;"></div>
			 			<div id="divAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hidden5" value=""><input id="ipbAns5" name="ipbAns5" type="text" style="width: 500px;"></div>
			 			<div id="divAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hidden6" value=""><input id="ipbAns6" name="ipbAns6" type="text" style="width: 500px;"></div>
			 			<div id="divAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hidden7" value=""><input id="ipbAns7" name="ipbAns7" type="text" style="width: 500px;"></div>
			 			<div id="divAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hidden8" value=""><input id="ipbAns8" name="ipbAns8" type="text" style="width: 500px;"></div>
			 			<div id="divAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hidden9" value=""><input id="ipbAns9" name="ipbAns9" type="text" style="width: 500px;"></div>
			 			<div id="divAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hidden10" value=""><input id="ipbAns10" name="ipbAns10" type="text" style="width: 500px;"></div>
			 			<div id="divAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hidden11" value=""><input id="ipbAns11" name="ipbAns11" type="text" style="width: 500px;"></div>
			 			<div id="divAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hidden12" value=""><input id="ipbAns12" name="ipbAns12" type="text" style="width: 500px;"></div>
			 			<div id="divAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hidden13" value=""><input id="ipbAns13" name="ipbAns13" type="text" style="width: 500px;"></div>
			 			<div id="divAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hidden14" value=""><input id="ipbAns14" name="ipbAns14" type="text" style="width: 500px;"></div>
			 			<div id="divAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hidden15" value=""><input id="ipbAns15" name="ipbAns15" type="text" style="width: 500px;"></div>
			 			<div id="divAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hidden16" value=""><input id="ipbAns16" name="ipbAns16" type="text" style="width: 500px;"></div>
			 			<div id="divAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hidden17" value=""><input id="ipbAns17" name="ipbAns17" type="text" style="width: 500px;"></div>
			 			<div id="divAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hidden18" value=""><input id="ipbAns18" name="ipbAns18" type="text" style="width: 500px;"></div>
			 			<div id="divAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hidden19" value=""><input id="ipbAns19" name="ipbAns19" type="text" style="width: 500px;"></div>
			 			<div id="divAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hidden20" value=""><input id="ipbAns20" name="ipbAns20" type="text" style="width: 500px;"></div>
			 			<br>
			 			<span id="ipbAnsAdd" type="button" value="+">
							<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
						</span>
						<span id="ipbAnsRemove" type="button" value="-">
							<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
						</span>
					</div>
					<div id="divQuesType2" class="ipb_style" style="display: none;">
						<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
					</div>
					<div id="divQuesType3">
						<c:if test="${fn:length(detailList[0].exampleList) > 0}">
							<c:forEach var="list" varStatus="status" items="${detailList[0].exampleList}">
								<div id="divMulAns${status.count}" class="ipb_style">
									<input type="hidden" id="hiddenMul${status.count}" value="${list.SURVEY_DE_ID}">
									<input id="ipbMulAns${status.count}" name="ipbMulAns${status.count}" type="text" style="width: 500px;" value="${list.E_SURVEY_CONTENT}">
								</div>
								<c:if test="${fn:length(detailList[0].exampleList) == status.count}">
								 	<c:forEach var="dList" varStatus="dStatus" begin="${status.count}" end="${19 + status.count}">
								 		<div id="divMulAns${dStatus.count}" class="ipb_style" style="display: none;">
								 			<input id="ipbMulAns${dStatus.count}" name="ipbMulAns${dStatus.count}" type="text" style="width: 500px;">
								 			<input type="hidden" id="hiddenMul${dStatus.count}">
								 			</div>
								 	</c:forEach>
								</c:if>
							</c:forEach>
							<br>
			 				<span id="ipbMulAnsAdd" type="button" value="+">
								<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
							</span>
							<span id="ipbMulAnsRemove" type="button" value="-">
								<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
							</span>
						</c:if>
					</div>
				</c:when>
			</c:choose>
		</c:when>
		
		<c:when test="${pos == 'BEF_INS'}">
			<!-- <p>이전 추가</p> -->
			<p>1. 문항 추가 : 
			<select id="selQuesNum" name="selQuesNum" onchange="$.doChangeSurveyNum(this.value)">
				<option value="">- 선택 -</option>
				<c:forEach var="selList" items="${selList}">
					<option value="${selList.NO}.${selList.DNO}">${selList.LABEL} ( ${selList.NO}.${selList.DNO} )</option>
				</c:forEach>
			</select>
			
			대문항 번호 : <input id="ipbSurveyNo" name="ipbSurveyNo" type="text" value="필수입력 항목" class="m1" disabled="disabled" style="width: 60px;">
			소문항 번호 : <input id="ipbSurveyDNo" name="ipbSurveyDNo" type="text" value="필수입력 항목" class="m1" disabled="disabled" style="width: 60px;">
			</p>
			
			<p>2. 설문 내용 (질의문) : <input id="ipbSurveyContent" name="ipbSurveyContent" type="text" class="m2" >
			</p>
			
			<p>3. 설문 타입 : 
			<select id="selQuesType" name="selQuesType" class="select" onchange="$.doChangeSurveyType(this.value)">
				<option value="">- 선택 -</option>
				<option value="MO">객관형 문항</option>
				<option value="S">주관형 문항</option>
				<option value="MM">다중선택형 문항</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;<em> - 객관형은 최대 20 보기까지 가능  - </em><br><br>
			</p>
			
			 <div id="divQuesType1" style="display: none;">
			 	<div id="divAns1" class="ipb_style"><input type="hidden" id="hidden1" value=""><input id="ipbAns1" name="ipbAns1" type="text" style="width: 500px;"></div>
			 	<div id="divAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hidden2" value=""><input id="ipbAns2" name="ipbAns2" type="text" style="width: 500px;"></div>
			 	<div id="divAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hidden3" value=""><input id="ipbAns3" name="ipbAns3" type="text" style="width: 500px;"></div>
			 	<div id="divAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hidden4" value=""><input id="ipbAns4" name="ipbAns4" type="text" style="width: 500px;"></div>
			 	<div id="divAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hidden5" value=""><input id="ipbAns5" name="ipbAns5" type="text" style="width: 500px;"></div>
			 	<div id="divAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hidden6" value=""><input id="ipbAns6" name="ipbAns6" type="text" style="width: 500px;"></div>
			 	<div id="divAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hidden7" value=""><input id="ipbAns7" name="ipbAns7" type="text" style="width: 500px;"></div>
			 	<div id="divAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hidden8" value=""><input id="ipbAns8" name="ipbAns8" type="text" style="width: 500px;"></div>
			 	<div id="divAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hidden9" value=""><input id="ipbAns9" name="ipbAns9" type="text" style="width: 500px;"></div>
			 	<div id="divAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hidden10" value=""><input id="ipbAns10" name="ipbAns10" type="text" style="width: 500px;"></div>
			 	<div id="divAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hidden11" value=""><input id="ipbAns11" name="ipbAns11" type="text" style="width: 500px;"></div>
			 	<div id="divAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hidden12" value=""><input id="ipbAns12" name="ipbAns12" type="text" style="width: 500px;"></div>
			 	<div id="divAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hidden13" value=""><input id="ipbAns13" name="ipbAns13" type="text" style="width: 500px;"></div>
			 	<div id="divAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hidden14" value=""><input id="ipbAns14" name="ipbAns14" type="text" style="width: 500px;"></div>
			 	<div id="divAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hidden15" value=""><input id="ipbAns15" name="ipbAns15" type="text" style="width: 500px;"></div>
			 	<div id="divAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hidden16" value=""><input id="ipbAns16" name="ipbAns16" type="text" style="width: 500px;"></div>
			 	<div id="divAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hidden17" value=""><input id="ipbAns17" name="ipbAns17" type="text" style="width: 500px;"></div>
			 	<div id="divAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hidden18" value=""><input id="ipbAns18" name="ipbAns18" type="text" style="width: 500px;"></div>
			 	<div id="divAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hidden19" value=""><input id="ipbAns19" name="ipbAns19" type="text" style="width: 500px;"></div>
			 	<div id="divAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hidden20" value=""><input id="ipbAns20" name="ipbAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>
			 </div>
			 <div id="divQuesType2" class="ipb_style" style="display: none;">
			 	<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
			 </div>
			 <div id="divQuesType3" style="display: none;">
			 	<div id="divMulAns1" class="ipb_style"><input type="hidden" id="hiddenMul1" value=""><input id="ipbMulAns1" name="ipbMulAns1" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul2" value=""><input id="ipbMulAns2" name="ipbMulAns2" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul3" value=""><input id="ipbMulAns3" name="ipbMulAns3" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul4" value=""><input id="ipbMulAns4" name="ipbMulAns4" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul5" value=""><input id="ipbMulAns5" name="ipbMulAns5" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul6" value=""><input id="ipbMulAns6" name="ipbMulAns6" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul7" value=""><input id="ipbMulAns7" name="ipbMulAns7" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul8" value=""><input id="ipbMulAns8" name="ipbMulAns8" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul9" value=""><input id="ipbMulAns9" name="ipbMulAns9" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul10" value=""><input id="ipbMulAns10" name="ipbMulAns10" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul11" value=""><input id="ipbMulAns11" name="ipbMulAns11" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul12" value=""><input id="ipbMulAns12" name="ipbMulAns12" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul13" value=""><input id="ipbMulAns13" name="ipbMulAns13" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul14" value=""><input id="ipbMulAns14" name="ipbMulAns14" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul15" value=""><input id="ipbMulAns15" name="ipbMulAns15" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul16" value=""><input id="ipbMulAns16" name="ipbMulAns16" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul17" value=""><input id="ipbMulAns17" name="ipbMulAns17" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul18" value=""><input id="ipbMulAns18" name="ipbMulAns18" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul19" value=""><input id="ipbMulAns19" name="ipbMulAns19" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul20" value=""><input id="ipbMulAns20" name="ipbMulAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbMulAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbMulAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>
			 </div>
		</c:when>
		<c:when test="${pos == 'AFT_INS'}">
			<!-- <p>다음 추가</p> -->
			<p>1. 문항 추가 : 
			<select id="selQuesNum" name="selQuesNum" class="select" onchange="$.doChangeSurveyNum(this.value)">
				<option value="">- 선택 -</option>
				<c:forEach var="selList" items="${selList}">
					<option value="${selList.NO}.${selList.DNO}">${selList.LABEL} ( ${selList.NO}.${selList.DNO} )</option>
				</c:forEach>
			</select>
			
			대문항 번호 : <input id="ipbSurveyNo" name="ipbSurveyNo" type="text" value="필수입력 항목" disabled="disabled" style="width: 60px;">
			소문항 번호 : <input id="ipbSurveyDNo" name="ipbSurveyDNo" type="text" value="필수입력 항목" disabled="disabled" style="width: 60px;">
			</p>
			
			<p>
			2. 설문 내용 (질의문) : <input id="ipbSurveyContent" name="ipbSurveyContent" class="m2" type="text">
			</p>
			
			<p>
			3. 설문 타입 : 
			<select id="selQuesType" name="selQuesType" class="select" onchange="$.doChangeSurveyType(this.value)">
				<option value="">- 선택 -</option>
				<option value="MO">객관형 문항</option>
				<option value="S">주관형 문항</option>
				<option value="MM">다중선택형 문항</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;<em> - 객관형은 최대 20 보기까지 가능  - </em><br><br>
			</p>
			
			 <div id="divQuesType1" style="display: none;">
			 	<div id="divAns1" class="ipb_style"><input type="hidden" id="hidden1" value=""><input id="ipbAns1" name="ipbAns1" type="text" style="width: 500px;"></div>
			 	<div id="divAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hidden2" value=""><input id="ipbAns2" name="ipbAns2" type="text" style="width: 500px;"></div>
			 	<div id="divAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hidden3" value=""><input id="ipbAns3" name="ipbAns3" type="text" style="width: 500px;"></div>
			 	<div id="divAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hidden4" value=""><input id="ipbAns4" name="ipbAns4" type="text" style="width: 500px;"></div>
			 	<div id="divAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hidden5" value=""><input id="ipbAns5" name="ipbAns5" type="text" style="width: 500px;"></div>
			 	<div id="divAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hidden6" value=""><input id="ipbAns6" name="ipbAns6" type="text" style="width: 500px;"></div>
			 	<div id="divAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hidden7" value=""><input id="ipbAns7" name="ipbAns7" type="text" style="width: 500px;"></div>
			 	<div id="divAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hidden8" value=""><input id="ipbAns8" name="ipbAns8" type="text" style="width: 500px;"></div>
			 	<div id="divAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hidden9" value=""><input id="ipbAns9" name="ipbAns9" type="text" style="width: 500px;"></div>
			 	<div id="divAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hidden10" value=""><input id="ipbAns10" name="ipbAns10" type="text" style="width: 500px;"></div>
			 	<div id="divAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hidden11" value=""><input id="ipbAns11" name="ipbAns11" type="text" style="width: 500px;"></div>
			 	<div id="divAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hidden12" value=""><input id="ipbAns12" name="ipbAns12" type="text" style="width: 500px;"></div>
			 	<div id="divAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hidden13" value=""><input id="ipbAns13" name="ipbAns13" type="text" style="width: 500px;"></div>
			 	<div id="divAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hidden14" value=""><input id="ipbAns14" name="ipbAns14" type="text" style="width: 500px;"></div>
			 	<div id="divAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hidden15" value=""><input id="ipbAns15" name="ipbAns15" type="text" style="width: 500px;"></div>
			 	<div id="divAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hidden16" value=""><input id="ipbAns16" name="ipbAns16" type="text" style="width: 500px;"></div>
			 	<div id="divAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hidden17" value=""><input id="ipbAns17" name="ipbAns17" type="text" style="width: 500px;"></div>
			 	<div id="divAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hidden18" value=""><input id="ipbAns18" name="ipbAns18" type="text" style="width: 500px;"></div>
			 	<div id="divAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hidden19" value=""><input id="ipbAns19" name="ipbAns19" type="text" style="width: 500px;"></div>
			 	<div id="divAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hidden20" value=""><input id="ipbAns20" name="ipbAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>
			 </div>
			 <div id="divQuesType2" class="ipb_style" style="display: none;">
			 	<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
			 </div>
			 <div id="divQuesType3" style="display: none;">
			 	<div id="divMulAns1" class="ipb_style"><input type="hidden" id="hiddenMul1" value=""><input id="ipbMulAns1" name="ipbMulAns1" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul2" value=""><input id="ipbMulAns2" name="ipbMulAns2" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul3" value=""><input id="ipbMulAns3" name="ipbMulAns3" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul4" value=""><input id="ipbMulAns4" name="ipbMulAns4" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul5" value=""><input id="ipbMulAns5" name="ipbMulAns5" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul6" value=""><input id="ipbMulAns6" name="ipbMulAns6" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul7" value=""><input id="ipbMulAns7" name="ipbMulAns7" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul8" value=""><input id="ipbMulAns8" name="ipbMulAns8" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul9" value=""><input id="ipbMulAns9" name="ipbMulAns9" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul10" value=""><input id="ipbMulAns10" name="ipbMulAns10" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul11" value=""><input id="ipbMulAns11" name="ipbMulAns11" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul12" value=""><input id="ipbMulAns12" name="ipbMulAns12" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul13" value=""><input id="ipbMulAns13" name="ipbMulAns13" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul14" value=""><input id="ipbMulAns14" name="ipbMulAns14" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul15" value=""><input id="ipbMulAns15" name="ipbMulAns15" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul16" value=""><input id="ipbMulAns16" name="ipbMulAns16" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul17" value=""><input id="ipbMulAns17" name="ipbMulAns17" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul18" value=""><input id="ipbMulAns18" name="ipbMulAns18" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul19" value=""><input id="ipbMulAns19" name="ipbMulAns19" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul20" value=""><input id="ipbMulAns20" name="ipbMulAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbMulAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbMulAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>		 	
			 </div>
		</c:when>
		<c:when test="${pos == 'END_INS'}">
			<!-- <p>항목 추가의 경우 SURVEY_NO, SURVEY_DNO 이 없다. 해당 항목이 없기 때문에 신규로 등록하게 될때 해당 값으로 NO 과  DNO 을 입력 해 준다.</p> -->
			<p>
			1. 문항 추가 : 
			<select id="selQuesNum" name="selQuesNum" class="select" onchange="$.doChangeSurveyNum(this.value)">
				<option value="">- 선택 -</option>
				<c:forEach var="selList" items="${selList}">
					<option value="${selList.NO}.${selList.DNO}">${selList.LABEL} ( ${selList.NO}.${selList.DNO} )</option>
				</c:forEach>
			</select>
			
			대문항 번호 : <input id="ipbSurveyNo" name="ipbSurveyNo" type="text" value="필수입력 항목" disabled="disabled" style="width: 60px;">
			소문항 번호 : <input id="ipbSurveyDNo" name="ipbSurveyDNo" type="text" value="필수입력 항목" disabled="disabled" style="width: 60px;">
			</p>
			
			<p>
			2. 설문 내용 (질의문) : <input id="ipbSurveyContent" name="ipbSurveyContent" type="text" class="m2">
			</p>
			
			<p>
			3. 설문 타입 : 
			<select id="selQuesType" name="selQuesType" class="select" onchange="$.doChangeSurveyType(this.value)">
				<option value="">- 선택 -</option>
				<option value="MO">객관형 문항</option>
				<option value="S">주관형 문항</option>
				<option value="MM">다중선택형 문항</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;<em> - 객관형은 최대 20 보기까지 가능  - </em><br><br>
			</p>
			
			 <div id="divQuesType1" style="display: none;">
			 	<div id="divAns1" class="ipb_style"><input type="hidden" id="hidden1" value=""><input id="ipbAns1" name="ipbAns1" type="text" style="width: 500px;"></div>
			 	<div id="divAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hidden2" value=""><input id="ipbAns2" name="ipbAns2" type="text" style="width: 500px;"></div>
			 	<div id="divAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hidden3" value=""><input id="ipbAns3" name="ipbAns3" type="text" style="width: 500px;"></div>
			 	<div id="divAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hidden4" value=""><input id="ipbAns4" name="ipbAns4" type="text" style="width: 500px;"></div>
			 	<div id="divAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hidden5" value=""><input id="ipbAns5" name="ipbAns5" type="text" style="width: 500px;"></div>
			 	<div id="divAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hidden6" value=""><input id="ipbAns6" name="ipbAns6" type="text" style="width: 500px;"></div>
			 	<div id="divAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hidden7" value=""><input id="ipbAns7" name="ipbAns7" type="text" style="width: 500px;"></div>
			 	<div id="divAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hidden8" value=""><input id="ipbAns8" name="ipbAns8" type="text" style="width: 500px;"></div>
			 	<div id="divAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hidden9" value=""><input id="ipbAns9" name="ipbAns9" type="text" style="width: 500px;"></div>
			 	<div id="divAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hidden10" value=""><input id="ipbAns10" name="ipbAns10" type="text" style="width: 500px;"></div>
			 	<div id="divAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hidden11" value=""><input id="ipbAns11" name="ipbAns11" type="text" style="width: 500px;"></div>
			 	<div id="divAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hidden12" value=""><input id="ipbAns12" name="ipbAns12" type="text" style="width: 500px;"></div>
			 	<div id="divAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hidden13" value=""><input id="ipbAns13" name="ipbAns13" type="text" style="width: 500px;"></div>
			 	<div id="divAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hidden14" value=""><input id="ipbAns14" name="ipbAns14" type="text" style="width: 500px;"></div>
			 	<div id="divAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hidden15" value=""><input id="ipbAns15" name="ipbAns15" type="text" style="width: 500px;"></div>
			 	<div id="divAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hidden16" value=""><input id="ipbAns16" name="ipbAns16" type="text" style="width: 500px;"></div>
			 	<div id="divAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hidden17" value=""><input id="ipbAns17" name="ipbAns17" type="text" style="width: 500px;"></div>
			 	<div id="divAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hidden18" value=""><input id="ipbAns18" name="ipbAns18" type="text" style="width: 500px;"></div>
			 	<div id="divAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hidden19" value=""><input id="ipbAns19" name="ipbAns19" type="text" style="width: 500px;"></div>
			 	<div id="divAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hidden20" value=""><input id="ipbAns20" name="ipbAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>
			 </div>
			 <div id="divQuesType2" class="ipb_style" style="display: none;">
			 	<input id="ipbAns" type="text" disabled="disabled" style="width: 500px;">
			 </div>
			 <div id="divQuesType3" style="display: none;">
			 	<div id="divMulAns1" class="ipb_style"><input type="hidden" id="hiddenMul1" value=""><input id="ipbMulAns1" name="ipbMulAns1" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns2" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul2" value=""><input id="ipbMulAns2" name="ipbMulAns2" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns3" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul3" value=""><input id="ipbMulAns3" name="ipbMulAns3" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns4" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul4" value=""><input id="ipbMulAns4" name="ipbMulAns4" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns5" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul5" value=""><input id="ipbMulAns5" name="ipbMulAns5" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns6" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul6" value=""><input id="ipbMulAns6" name="ipbMulAns6" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns7" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul7" value=""><input id="ipbMulAns7" name="ipbMulAns7" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns8" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul8" value=""><input id="ipbMulAns8" name="ipbMulAns8" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns9" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul9" value=""><input id="ipbMulAns9" name="ipbMulAns9" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns10" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul10" value=""><input id="ipbMulAns10" name="ipbMulAns10" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns11" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul11" value=""><input id="ipbMulAns11" name="ipbMulAns11" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns12" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul12" value=""><input id="ipbMulAns12" name="ipbMulAns12" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns13" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul13" value=""><input id="ipbMulAns13" name="ipbMulAns13" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns14" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul14" value=""><input id="ipbMulAns14" name="ipbMulAns14" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns15" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul15" value=""><input id="ipbMulAns15" name="ipbMulAns15" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns16" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul16" value=""><input id="ipbMulAns16" name="ipbMulAns16" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns17" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul17" value=""><input id="ipbMulAns17" name="ipbMulAns17" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns18" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul18" value=""><input id="ipbMulAns18" name="ipbMulAns18" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns19" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul19" value=""><input id="ipbMulAns19" name="ipbMulAns19" type="text" style="width: 500px;"></div>
			 	<div id="divMulAns20" class="ipb_style" style="display: none;"><input type="hidden" id="hiddenMul20" value=""><input id="ipbMulAns20" name="ipbMulAns20" type="text" style="width: 500px;"></div>
			 	<br>
			 	<span id="ipbMulAnsAdd" type="button" value="+">
					<img src="<c:url value='/resources/images/add.png'/>" width="36" height="36" alt=""/>
				</span>
				<span id="ipbMulAnsRemove" type="button" value="-">
					<img src="<c:url value='/resources/images/mm.png'/>" width="36" height="36" alt=""/>
				</span>
			 </div>
		</c:when>
		<c:otherwise>
			<p>오류</p>
		</c:otherwise>
	</c:choose>
	
	</div>
	
	</div>
	<p class="save_bt"><span id="btnSave">저장</span></p>
</div>
</body>
</html>