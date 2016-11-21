<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
	var SURVEY_ID = "${surveyId }";
	
	$('#btnList').click(function(){
		$.doLoadPage("survey");
	});
	
	$(".list_btn span").click(function(){
		var vsBtnId = arguments[0].currentTarget.id;
		var vsDId = "";
		var vnDIdLeng = 0;
		var vnLength = 0;
		if(vsBtnId.indexOf("Upd") > 0){
			//해당항목 수정
			
			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId,"NOW_UDT");
			
		}else if(vsBtnId.indexOf("Del_") > 0){
			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			//해당항목 삭제
			
			$.ajax({
	    		url:'<c:url value="/doDeleteJustOne.do"/>',
	    		type: "POST",
	    		async: false,
	    		data: {
	    			SURVEY_ID : SURVEY_ID,
	    			SURVEY_DID : vsDId
	    		},
	    		dataType: "json",
	    		success:function(result){
	    			if(!!result && result.result == "success"){
	    				alert("완료 되었습니다.");
	    				$.doLoadPage("surveyDetail",SURVEY_ID);
						return false;
	    			}else{
	    				alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	    				return false;
	    			}	    			
	    		},
	    		error:function(e){
	    			alert("error::"+JSON.stringify(e));
	    		}
	    	});
		}else if(vsBtnId.indexOf("BefIns_") > 0){
			//해당항목 이전 삽입

			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId, "BEF_INS");
		}else if(vsBtnId.indexOf("AftIns_") > 0){
			//해당항목 이후 삽입

			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId, "AFT_INS");
		}else if(vsBtnId.indexOf("AftIns") > 0){
			//젤 뒤에 삽입
			surveyPopup(SURVEY_ID,null,"END_INS");
		}else if(vsBtnId.indexOf("Del") > 0){
			//전체 삭제
			if(confirm('전체삭제를 하게 될 경우, 모든 항목이 삭제 됩니다. 계속 하시겠습니까?')){
				if(!!SURVEY_ID){
					$.ajax({
			    		url:'<c:url value="/doDeleteAllDetail.do"/>',
			    		type: "POST",
			    		async: false,
			    		data: {
			    			SURVEY_ID : SURVEY_ID
			    		},
			    		dataType: "json",
			    		success:function(result){
			    			if(!!result && result.result == "success"){
			    				alert("완료 되었습니다.");
			    				$.doLoadPage("surveyDetail",SURVEY_ID);
								return false;
			    			}else{
			    				alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
			    				return false;
			    			}	    			
			    		},
			    		error:function(e){
			    			alert("error::"+JSON.stringify(e));
			    		}
			    	});
				}
			}else{
				return;
			}
		}else {
			//alert("그외");
		}
		//"ipbDID_"		
	});
	
	$(".btns span").click(function(){
		var vsBtnId = arguments[0].currentTarget.id;
		var vsDId = "";
		var vnDIdLeng = 0;
		var vnLength = 0;
		if(vsBtnId.indexOf("Upd") > 0){
			//해당항목 수정
			
			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId,"NOW_UDT");
			
		}else if(vsBtnId.indexOf("Del_") > 0){
			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			//해당항목 삭제
			
			$.ajax({
	    		url:'<c:url value="/doDeleteJustOne.do"/>',
	    		type: "POST",
	    		async: false,
	    		data: {
	    			SURVEY_ID : SURVEY_ID,
	    			SURVEY_DID : vsDId
	    		},
	    		dataType: "json",
	    		success:function(result){
	    			if(!!result && result.result == "success"){
	    				alert("완료 되었습니다.");
	    				$.doLoadPage("surveyDetail",SURVEY_ID);
						return false;
	    			}else{
	    				alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
	    				return false;
	    			}	    			
	    		},
	    		error:function(e){
	    			alert("error::"+JSON.stringify(e));
	    		}
	    	});
		}else if(vsBtnId.indexOf("BefIns_") > 0){
			//해당항목 이전 삽입

			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId, "BEF_INS");
		}else if(vsBtnId.indexOf("AftIns_") > 0){
			//해당항목 이후 삽입

			vnDIdLeng = vsBtnId.lastIndexOf("_")+1;
			vnLength = vsBtnId.length;
			vsDId = $('#ipbDID_'+vsBtnId.substring(vnDIdLeng,vnLength)).val();
			
			surveyPopup(SURVEY_ID,vsDId, "AFT_INS");
		}else if(vsBtnId.indexOf("AftIns") > 0){
			//젤 뒤에 삽입
			surveyPopup(SURVEY_ID,null,"END_INS");
		}else if(vsBtnId.indexOf("Del") > 0){
			//전체 삭제
			if(confirm('전체삭제를 하게 될 경우, 모든 항목이 삭제 됩니다. 계속 하시겠습니까?')){
				if(!!SURVEY_ID){
					$.ajax({
			    		url:'<c:url value="/doDeleteAllDetail.do"/>',
			    		type: "POST",
			    		async: false,
			    		data: {
			    			SURVEY_ID : SURVEY_ID
			    		},
			    		dataType: "json",
			    		success:function(result){
			    			if(!!result && result.result == "success"){
			    				alert("완료 되었습니다.");
			    				$.doLoadPage("surveyDetail",SURVEY_ID);
								return false;
			    			}else{
			    				alert("오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
			    				return false;
			    			}	    			
			    		},
			    		error:function(e){
			    			alert("error::"+JSON.stringify(e));
			    		}
			    	});
				}
			}else{
				return;
			}
		}else {
			//alert("그외");
		}
		//"ipbDID_"		
	});
	
});  

function surveyPopup(psSurveyId, psSurveyDid, psPosition){
	if(!psSurveyId){
		return false;
	}else{
		var left = parseInt((screen.availWidth/2) - (window.innerWidth/2));
   		var top = parseInt((screen.availHeight/2) - (window.innerHeight/2));
   		var windowFeatures = "width=" + window.innerWidth/2/*((window.innerWidth*2)/3)-10*/ + "px ,height=" + window.innerHeight + "px" + ",status,resizable,left=" + 100 + ",top=" + 0 + ",scrollbars = yes";
   		var title  = "newwindow";
   		
   		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/doSurveyDetailList.do"/>').attr("method", "post").attr("target", title);

   		$(form).append($("<input type='hidden' name='SURVEY_ID'>").val(psSurveyId));
   		$(form).append($("<input type='hidden' name='SURVEY_DID'>").val(psSurveyDid));
   		$(form).append($("<input type='hidden' name='SURVEY_POSITION'>").val(psPosition));
   	    var temp = window.open('about:blank', title, windowFeatures);
   	    
   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
	}
};
</script>
</head>
<body>	
	<div class="box">
	
	<div class="survey_list">
		<p class="list_btn">
			<span id="btnList"><img src="<c:url value='/resources/images/icon_list.png'/>" alt=""/>&nbsp;&nbsp;목록</span>
			<span id="btnAftIns"><img src="<c:url value='/resources/images/icon_plus.png'/>" alt=""/>&nbsp;&nbsp;항목추가</span>
			<span id="btnDel"><img src="<c:url value='/resources/images/icon_del.png'/>" alt=""/>&nbsp;&nbsp;삭제</span>
		</p>
	</div>
	
	<div class="ad_tit">설문지 상세 설정</div>
	
	<c:set var="dataList" value="${detailList}"/>
	<c:forEach var="idx" begin="0" end="${fn:length(dataList)}">
		<c:choose>
			<c:when test="${(dataList[idx].SURVEY_TYPE) == 'MO'}">
				<!-- 객관형 설문 -->
				<div id="div_${dataList[idx].SURVEY_DID}" >
					<div class="sur">
						<p class="btns">
						<input type="hidden" id="ipbDID_${dataList[idx].SURVEY_DID}" value="${dataList[idx].SURVEY_DID }">
						<span id="btnBefIns_${dataList[idx].SURVEY_DID}" class="save">이전 추가</span>
						<span id="btnAftIns_${dataList[idx].SURVEY_DID}" class="save">다음 추가</span>
						<span id="btnUpd_${dataList[idx].SURVEY_DID}" class="save">수정</span>
						<span id="btnDel_${dataList[idx].SURVEY_DID}" class="save">삭제</span>
						</p>
					<p>${dataList[idx].SURVEY_NO}.${dataList[idx].SURVEY_DNO} ${dataList[idx].SURVEY_CONTENT}</p><br>
					<p>
					<c:forEach var="exmIdx" begin="0" end="${fn:length(dataList[idx].exampleList) -1}">
						<span><input type="radio" id="sel_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}_${dataList[idx].exampleList[exmIdx].SURVEY_DE_NO}" 
							name="sel_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}" 
							value="${dataList[idx].exampleList[exmIdx].E_SURVEY_CONTENT}"> ${dataList[idx].exampleList[exmIdx].E_SURVEY_CONTENT}</span><br><br>
					</c:forEach>
					</p>
					</div>
				</div>
			</c:when>
			<c:when test="${(dataList[idx].SURVEY_TYPE) == 'MM'}">
				<!-- 객관형 다중선택 설문 -->
				<div id="div_${dataList[idx].SURVEY_DID}" >
					<div class="sur">
						<p class="btns">
						<input type="hidden" id="ipbDID_${dataList[idx].SURVEY_DID}" value="${dataList[idx].SURVEY_DID }">
						<span id="btnBefIns_${dataList[idx].SURVEY_DID}" class="save">이전 추가</span>
						<span id="btnAftIns_${dataList[idx].SURVEY_DID}" class="save">다음 추가</span>
						<span id="btnUpd_${dataList[idx].SURVEY_DID}" class="save">수정</span>
						<span id="btnDel_${dataList[idx].SURVEY_DID}" class="save">삭제</span>
						</p>
					<p>${dataList[idx].SURVEY_NO}.${dataList[idx].SURVEY_DNO} ${dataList[idx].SURVEY_CONTENT}</p><br>
					<p>
					<c:forEach var="exmIdx" begin="0" end="${fn:length(dataList[idx].exampleList) -1}">
						<span><input type="checkbox" id="chk_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}_${dataList[idx].exampleList[exmIdx].SURVEY_DE_NO}" 
							name="chk_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}_${dataList[idx].exampleList[exmIdx].SURVEY_DE_NO}" 
							value="${dataList[idx].exampleList[exmIdx].E_SURVEY_CONTENT}"> ${dataList[idx].exampleList[exmIdx].E_SURVEY_CONTENT}</span><br><br>
					</c:forEach>
					</p>
					</div>
				</div>
			</c:when>
			<c:when test="${(dataList[idx].SURVEY_TYPE) == 'S'}">
				<!-- 주관형 설문 -->
				<div id="div_${dataList[idx].SURVEY_DID}" >
					<div class="sur">
						<p class="btns">
						<input type="hidden" id="ipbDID_${dataList[idx].SURVEY_DID}" value="${dataList[idx].SURVEY_DID }">
						<span id="btnBefIns_${dataList[idx].SURVEY_DID}" class="save">이전 추가</span>
						<span id="btnAftIns_${dataList[idx].SURVEY_DID}" class="save">다음 추가</span>
						<span id="btnUpd_${dataList[idx].SURVEY_DID}" class="save">수정</span>
						<span id="btnDel_${dataList[idx].SURVEY_DID}" class="save">삭제</span>
						</p>
					<p>${dataList[idx].SURVEY_NO}.${dataList[idx].SURVEY_DNO} ${dataList[idx].SURVEY_CONTENT}</p><br>
					<p>
					<c:forEach var="exmIdx" begin="0" end="${fn:length(dataList[idx].exampleList) -1}">
						<textarea id="textarea_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}_${dataList[idx].exampleList[exmIdx].SURVEY_DE_NO}" 
							name="sel_${dataList[idx].SURVEY_NO}${dataList[idx].SURVEY_DNO}" rows="10" cols="120"></textarea>
					</c:forEach>
					</p><br><br>
					</div>
				</div>
			</c:when>
			<c:when test="${(dataList[idx].SURVEY_TYPE) == 'A'}">
				<!-- 형가형 설문 -->
				<p>A</p>
			</c:when>
			<c:otherwise>
			
			</c:otherwise>
		</c:choose>
	</c:forEach>	
	
	</div>
</body>
</html>


<!-- <div id="div_01" >
		<div class="search">
			<input type="hidden" id="ipbDID_01" value="1">
			<span id="btnBefIns_01" class="save">이전 추가</span>
			<span id="btnAftIns_01" class="save">다음 추가</span>
			<span id="btnUpd_01" class="save">수정</span>
			<span id="btnDel_01" class="save">삭제</span>
		</div>
		<p>1.1 BPA-NET 시스템을 사용하지 않는 이유는 무엇입니까?</p><br>
		<input type="radio" id="sel_01_1" name="sel_01" value="1"> 현재 사용하고 있는 정보시스템이 따로 있다<br><br>
		<input type="radio" id="sel_01_2" name="sel_01" value="2"> 업무와 관련성이 적어 사용하지 않는다<br><br>
		<input type="radio" id="sel_01_3" name="sel_01" value="3"> 가입절차가 복잡하여 접근하기 힘들다<br><br>
		<input type="radio" id="sel_01_4" name="sel_01" value="4"> 다양한 브라우저에서 지원이 되지 않는다<br><br>
		<input type="radio" id="sel_01_5" name="sel_01" value="5"> BPA-NET에 대해 잘 모른다<br><br>
		<input type="radio" id="sel_01_6" name="sel_01" value="6"> 원하는 콘텐츠 또는 정보가 없다<br> <br>
		<input type="radio" id="sel_01_7" name="sel_01" value="7"> 기타 (<input id="ipbBigo_01" name="ipbBigo_01" type="text" style="border: 0px;">)<br><br>
		<div class="search"></div>
	</div>
	
	<div id="div_02" >
		<div class="search">			
			<span id="btnBefIns_02" class="save">이전 추가</span>
			<span id="btnAftIns_02" class="save">다음 추가</span>
			<span id="btnUpd_02" class="save">수정</span>
			<span id="btnDel_02" class="save">삭제</span>
		</div>
		<p>2.1 BPA-NET 시스템을 사용하지 않는 이유는 무엇입니까?</p><br>
		<input type="radio" id="sel_02_1" name="sel_02" value="1"> 현재 사용하고 있는 정보시스템이 따로 있다<br><br>
		<input type="radio" id="sel_02_2" name="sel_02" value="2"> 업무와 관련성이 적어 사용하지 않는다<br><br>
		<input type="radio" id="sel_02_3" name="sel_02" value="3"> 가입절차가 복잡하여 접근하기 힘들다<br><br>
		<input type="radio" id="sel_02_4" name="sel_02" value="4"> 다양한 브라우저에서 지원이 되지 않는다<br><br>
		<input type="radio" id="sel_02_5" name="sel_02" value="5"> BPA-NET에 대해 잘 모른다<br><br>
		<input type="radio" id="sel_02_6" name="sel_02" value="6"> 원하는 콘텐츠 또는 정보가 없다<br> <br>
		<input type="radio" id="sel_02_7" name="sel_02" value="7"> 기타 (<input id="ipbBigo_02" name="ipbBigo_02" type="text" style="border: 0px;">)<br><br>
		<div class="search"></div>
	</div> -->
