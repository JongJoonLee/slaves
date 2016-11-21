<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>설문지 관리</title>
<style type="text/css">
.center .ui-jqgrid {
    margin-left: auto;
    margin-right: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var menuCd = "${menuCd}";
	var contextRoot = "${context_root}";
		
	//조회
	$('#btnSearch').click(function(vsParam){
   	 	$("#jqGrid_gridList").clearGridData();
		jQuery("#jqGrid_gridList").setGridParam({
			url:'<c:url value="/doSurveyList.do"/>',
			postData : {									
				pageNo : "1",
				SURVEY_NM : $('#srcTitle01').val()
			},
		    datatype : "json"}).trigger("reloadGrid");   	    
	});
	
	//신규
	$('#btnInsert').click(function(){	
		var data = {};		
		var jData = data != undefined?data:{};
		var grid = $("#gridList").find("table[id^=jqGrid]");
		var rowDatas = grid.getRowData();
		var rowId = jData.ROW_ID != undefined?jData.ROW_ID:rowDatas.length+1;
		var position = jData.POSITION != undefined?jData.POSITION:"first";
		//신규추가의 경우 상태값을 insert로 설정
		jData["rowType"] = "C";
		grid.jqGrid('addRowData', rowId, jData, position || 'first');
		grid.setRowData(rowId, jData);
		
		grid.jqGrid('restoreRow',rowId);
       // var cm = grid.jqGrid('getColProp','SURVEY_NM');
       // cm.editable = true;
        
		grid.jqGrid("editRow", rowId);
		//cm.editable = false;
		
		return rowId;
	});
	
	//삭제
	$('#btnDelete').click(function(){	
		var objGrid = $("#gridList").find("table[id^=jqGrid]");
		var vaRowIds = objGrid.jqGrid('getGridParam', 'selarrrow');
		if(vaRowIds.length == 0 || !vaRowIds){
			alert("선택한 데이터가 없습니다.");
			return;
		}
		for(var i = vaRowIds.length; i > 0; i--){
			var data = objGrid.getRowData(vaRowIds[i-1]);
			if(data.rowType == "C"){
				objGrid.delRowData(vaRowIds[i-1]);
			}else if(data.rowType == "U" || data.rowType == ""){
				objGrid.setRowData(vaRowIds[i-1], {rowType:"D"});
			}
		}
	});	
	
	//저장
	$('#btnSave').click(function(){	
		
		//rowType 이 U 인 데이터만 받아와서
		//한번에 update 실행
		//실행 이 후 , 다시 조회하는 걸로??ㅋ
		
		var arrJSON = new Array();
		var rowArr;
		var objGrid = $("#gridList").find("table[id^=jqGrid]");
		var selRows = objGrid.getDataIDs();  // 모든row
		var data = objGrid.getRowData();
		var vnChangeCnt = 0;
		var vnSuccess = 0;
		var vnFail = 0;
		
		if(data.length == 0){return;};
		
		for(var idx = (data.length-1); idx >= 0; idx--){
			if(data[idx].rowType == "D" || data[idx].rowType == "U"){
				vnChangeCnt++;
				
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doSurveySave.do"/>', 
						 extraparam : {
							 SURVEY_ID : data[idx].SURVEY_ID,
							 rowType:data[idx].rowType	 
						 },
						 aftersavefunc : function(psId, e){
							 vnSuccess++;
						 },
						 errorfunc : function(psId, e){
							 vnFail++;
						 }}
				);
			}else if(data[idx].rowType == "C"){
				vnChangeCnt++;
				var vsRowId = selRows[idx];
				if(!document.getElementById(vsRowId+"_SURVEY_NM").value){
					alert("설문명은 필수입력 항목입니다.");
					return;
				}
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doSurveySave.do"/>', 
						 extraparam : {
							 rowType : data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultValue); 
								var cm = objGrid.jqGrid('getColProp','SURVEY_NM');
						        cm.editable = true;
						        
						        objGrid.jqGrid("editRow", psId);
								cm.editable = false;
								return;
							 }
						 },
						 errorfunc : function(psId, e){
							 vnFail++;
						 }}
				);
			}
		};
		
		if(vnChangeCnt === 0){
			alert('수정된 데이터가 없습니다.');
		};
		if(vnFail === 0 && vnSuccess > 0){
			alert('저장이 완료되었습니다.');
			$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
			jQuery("#jqGrid_gridList").setGridParam({
				url:'<c:url value="/doSurveyList.do"/>',
				postData : {									
					pageNo : "1",
					SURVEY_NM : $('#srcTitle01').val()
				},
			    datatype : "json"}).trigger("reloadGrid");   
		};
	});
	
	//결과 엑셀파일 저장 버튼 클릭
	$("#btnExcel").click(function(){
		
		var objGrid = $("#gridList").find("table[id^=jqGrid]");
		var vaRowIds = objGrid.jqGrid('getGridParam', 'selarrrow');
		var postData = {};
		var vaTempData = new Array();
		
		if(vaRowIds.length == 0 || !vaRowIds){
			alert("선택한 데이터가 없습니다.");
			return;
		}else if(vaRowIds.length > 1){
			alert("결과 파일은 하나의 설문만 저장이 가능합니다. 한건만 선택하여 저장하시기 바랍니다.");
			return;
		}
		
		for(var i = 0; i < vaRowIds.length; i++){
			var data = objGrid.getRowData(vaRowIds[i]);
			if(data.rowType == "C"){
				alert("선택한 데이터 중 신규로 아직 저장되지 않은 데이터가 존재합니다. 저장 후 출력해 주세요.");
				return;
			}else{
				if(!!data){
					vaTempData.push(data.SURVEY_ID);
				}
			}
		}
		$.ajax({
    		url:'<c:url value="/doSurveyExcelDownload.do"/>',
    		type: "POST",
    		async: false,
    		data: {param:vaTempData},
    		dataType: "json",
    		success:function(result){
    			$.download('<c:url value="/surveyExcelDown.do"/>'
    					,'filename='+result.filename
    					+'&file='+result.file
    					+'&temp=true'
    					+'&filePath='+result.filePath
    					+'&SVR_FILE_NM='+result.filename
    					+'&FILE_NM='+result.filename
    					,'post' );	    			
    		},
    		error:function(e){
    			alert("설문에 임한 사용자가 없어서 결과파일 생성에 실패하였습니다.");
    			//alert("error::"+JSON.stringify(e));
    		}
    	});
	});
	
	jQuery.download = function(url, data, method){
	    if( url && data ){ 
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    };
	};
	
	function getContext(){return "${pageContext.request.contextPath}/";}
	
	//그리드 데이터 수정 시 이벤트 처리
	function fnSetCellChange(e){
		var target = e.target.id;
		var rowId = target.split("_")[0];	//수정된 cell의 아이디를 통해 수정된 row정보를 가져옴
		
		var grid = $("#gridList").find("table[id^=jqGrid]");
		var rowData = grid.getRowData(rowId);
		if(rowData.rowType != "C" && rowData.rowType != "U" && rowData.rowType != "D"){
			//수정한 row가 신규추가 또는 삭제예정이 아닐 경우 update로 상태값 변경
			grid.setRowData(rowId, {rowType:"U"});
		}
	};
	
	function viewLineBtn(cellvalue, options, rowObject) {
        return "<button id=\""+options.rowId+"\" class=\"viewLineItem\" onclick=\"javascript:viewGotoDetail("+rowObject.SURVEY_ID+");\">설문지 상세 설정</button>"
    };
    
    function pickdates(id){
		jQuery("#"+id+"_SURVEY_STARTDT","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+id+"_SURVEY_ENDDT","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	};
	
	function fnRowSelector(poData, psFncId){
		jQuery("#"+poData["ROW_ID"]+"_SURVEY_STARTDT","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+poData["ROW_ID"]+"_SURVEY_ENDDT","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	};
	
	createGrid("gridList", 
			[" * 설문 키","설문 제목","내용","설문 설명","설문관련 이미지url","설문 대상","메인알림여부","설문시작일자","설문종료일자", "생성일자","생성자", "수정일자", "수정자", "삭제여부", "삭제일자", "삭제자"," "], 
			[
				{name:'SURVEY_ID', index:'SURVEY_ID',align: 'center', hidden:true, width:100, editable: false,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_NM', index:'SURVEY_NM',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_CONT', align: 'center', width:100, formatter: viewLineBtn}
				,{name:'SURVEY_CONT', index:'SURVEY_CONT',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_IMG', index:'SURVEY_IMG',align: 'center', hidden:true, width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_TARGET', index:'SURVEY_TARGET',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_MAIN', index:'SURVEY_MAIN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'SURVEY_STARTDT', index:'SURVEY_STARTDT',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'SURVEY_ENDDT', index:'SURVEY_ENDDT',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'INS_DATE', index:'INS_DATE',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'INS_ID', index:'INS_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UPT_DATE', index:'UPT_DATE',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UPT_ID', index:'UPT_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'DEL_GBN', index:'DEL_GBN',align: 'center', hidden:true, width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'DEL_DATE', index:'DEL_DATE',align: 'center', hidden:true, width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'DEL_ID', index:'DEL_ID',align: 'center', hidden:true, width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doSurveyList.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				}
		,fnRowSelector
	);
});

function viewGotoDetail(psSurveyId, pbflag){
	if(!psSurveyId){
		alert("데이터를 먼저 저장하신 이 후, 내용등록이 가능합니다.");
		return false;
	}else{
		$.doLoadPage("surveyDetail",psSurveyId);
	}
};
</script>
</head>
<body>
	
	<div class="ad_tit">설문지 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>설문 명</label>
		<input type="text" id="srcTitle01">
		<span id="btnSearch">조회</span>
		<span id="btnInsert">신규</span>
		<span id="btnSave" class="save" >저장</span>
		<span id="btnDelete" class="cl" >삭제</span>
		<span id="btnExcel" class="cl" >결과 파일저장</span>
	</div>
	
	<div class="box">
		<div id="mainList" style="margin: 0 auto; overflow-x:scroll;">
			<div id="gridList"></div>
		</div>
	</div>
</body>
</html>