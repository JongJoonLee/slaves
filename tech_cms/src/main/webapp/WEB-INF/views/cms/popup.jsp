<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>
<style type="text/css">
.center .ui-jqgrid {
    margin-left: auto;
    margin-right: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	//조회
	$('#btnSearch').click(function(vsParam){
   	 	$("#jqGrid_gridList").clearGridData();
		jQuery("#jqGrid_gridList").setGridParam({
			url:'<c:url value="/doPopupSearch.do"/>',
			postData : {									
				pageNo : "1",
				title : $('#srcUser01').val()
			},
		    datatype : "json"}).trigger("reloadGrid");   	    
	});
	
	//신규
	$('#btnInsert').click(function(){	
		var data = {
			MEMBER_CLASS_CD : "30"
		};		
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
		grid.jqGrid("editRow", rowId, false, pickdates);
		
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
						{url : '<c:url value="/doPopupSave.do"/>', 
						 extraparam : {
							 POPUP_ID:data[idx].POPUP_ID,
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
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doPopupSave.do"/>', 
						 extraparam : {
							 rowType:data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 debugger;
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultValue);
						        //objGrid.jqGrid("editRow", psId);
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
				url:'<c:url value="/doPopupSearch.do"/>',
				postData : {									
					pageNo : "1"
				},
			    datatype : "json"}).trigger("reloadGrid");   
		};
	});
	
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
        return "<button id=\""+options.rowId+"\" class=\"viewLineItem\" onclick=\"javascript:viewGotoDetail("+rowObject.POPUP_ID+");\">내용(NicEditor)</button>"
    };
    
    function viewLineBtnTiny(cellvalue, options, rowObject) {
        return "<button id=\""+options.rowId+"_tiny\" class=\"viewLineItem\" onclick=\"javascript:viewGotoDetail("+rowObject.POPUP_ID+", true);\">내용(tinyMCE)</button>"
    };
    
    function pickdates(id){
		jQuery("#"+id+"_STARTDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+id+"_ENDDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	};
	
	function fnRowSelector(poData, psFncId){
		jQuery("#"+poData["ROW_ID"]+"_STARTDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+poData["ROW_ID"]+"_ENDDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	}
				
	createGrid("gridList", 
			[" 제목 ","POPUP_ID","MENU_CD","내용(NicEditor)","내용(tinyMCE)","폭","높이","X좌표","Y좌표","시작일","종료일","사용여부","작성자","수정자","작성일자","최근수정일자"," "], 
			[
				{name:'TITLE', index:'TITLE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'POPUP_ID', hidden:true, index:'POPUP_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'MENU_CD', hidden:true, index:'MENU_CD',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'CONTENTS', align: 'center', width:100, formatter: viewLineBtn}
				,{name:'CONTENTS', hidden:true, align: 'center', width:100, formatter: viewLineBtnTiny}
				,{name:'WIDTH', index:'WIDTH',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'HEIGHT', index:'HEIGHT',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'XGPS', index:'XGPS',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'YGPS', index:'YGPS',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'STARTDAY', index:'STARTDAY',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'ENDDAY', index:'ENDDAY',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'USEYN', index:'USEYN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'REG_ID', index:'REG_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_ID', index:'UDT_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'REG_DT', index:'REG_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_DT', index:'UDT_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doPopupSearch.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				}
		,fnRowSelector
	);
	
});
function viewGotoDetail(psPopupId, pbflag){
	if(!psPopupId){
		alert("데이터를 먼저 저장하신 이 후, 내용등록이 가능합니다.");
		return false;
	}else{
		var left = parseInt((screen.availWidth/2) - (window.innerWidth/2));
   		var top = parseInt((screen.availHeight/2) - (window.innerHeight/2));
   		var windowFeatures = "width=" + window.innerWidth + "px ,height=" + window.innerHeight + "px" + ",status,resizable,left=" + 0 + ",top=" + 0 + ",scrollbars = yes";
   		var title  = "newwindow";
   		
   		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/gotoNicPopup.do"/>').attr("method", "post").attr("target", title);

   	    //$(this).siblings("input:text").each(function() {
   	    $(form).append($("<input type='hidden' name='POPUP_ID'>").val(psPopupId));
   	    if(!pbflag){
   	    	$(form).append($("<input type='hidden' name='PAGER'>").val("nicPopup"));
   	    }else{
   	    	$(form).append($("<input type='hidden' name='PAGER'>").val("tinymcePopup"));
   	    }
   	    //});
   	    var temp = window.open('about:blank', title, windowFeatures);
   	    
   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
	}
};
</script>
</head>
<body>
	
	<div class="ad_tit">팝업 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>팝업 명 </label>
		<input type="text" id="srcUser01">
		<span id="btnSearch">조회</span>
		<span id="btnInsert">신규</span>
		<span id="btnSave" class="save" >저장</span>
		<span id="btnDelete" class="cl" >삭제</span>
	</div>
	
	<div class="box">
		<div id="mainList" style="margin: 0 auto; overflow-x:scroll;">
			<div id="gridList"></div>
		</div>
	</div>
</body>
</html>