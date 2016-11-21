<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>웹에디터 관리</title>
<style type="text/css">
.center .ui-jqgrid {
    margin-left: auto;
    margin-right: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	function getComboList() {
		var combo = {};
		submitActionSync(
				"<spring:url value='/doWebeditorComboList.do'/>",
				null,
				function(data) {
					$.each(data, function(i, d) {
						combo[d.COM_CD] = d.COM_NM;
					});
				}
		);
		return combo;
	};
	var moCombo = getComboList();
	
	//조회
	$('#btnSearch').click(function(vsParam){
   	 	$("#jqGrid_gridList").clearGridData();
		jQuery("#jqGrid_gridList").setGridParam({
			url:'<c:url value="/doWebeditorSearchList.do"/>',
			postData : {									
				pageNo : "1",
				title : $('#srcWebnm01').val(),
				locale : $("#srcLangDiv01")[0].value
			},
		    datatype : "json"}).trigger("reloadGrid");   	    
	});
	
	//신규
	$('#btnInsert').click(function(){
		alert("신규 데이터는 다국어 데이터에 맞추어 해당 수만큼 등록이 됩니다.");
		var data = {
			DESIGN_LOCALE : $("#srcLangDiv01")[0].value
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
						{url : '<c:url value="/doWebeditorSaveList.do"/>', 
						 extraparam : {
							 DESIGN_PAGE_ID:data[idx].DESIGN_PAGE_ID,
							 DESIGN_LOCALE:data[idx].DESIGN_LOCALE,
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
						{url : '<c:url value="/doWebeditorSaveList.do"/>', 
						 extraparam : {
							 rowType:data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
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
				url:'<c:url value="/doWebeditorSearchList.do"/>',
				postData : {									
					pageNo : "1",
					title : $('#srcWebnm01').val()
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
        return "<button id=\""+options.rowId+"\" class=\"viewLineItem\" onclick=\"javascript:viewGotoDetail("+rowObject.DESIGN_PAGE_ID+", '"+rowObject.DESIGN_LOCALE+"');\">등록</button>"
    };
				
	createGrid("gridList", 
			[" 페이지명 ","DESIGN_PAGE_ID","언어","HTML","작성자","수정자","작성일자","최근수정일자"," "], 
			[
				{name:'DESIGN_PAGE_NM', index:'DESIGN_PAGE_NM',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'DESIGN_PAGE_ID', hidden:true, index:'DESIGN_PAGE_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'DESIGN_LOCALE', index:'DESIGN_LOCALE',align: 'center', width:60, frozen : true, editable: false
	    			,edittype:'select'
		    			,editoptions:{value:moCombo
		    				,dataEvents: [{
								type : 'change',
								fn:fnSetCellChange	    							
							}]}, formatter:"select"
		    			,width:220}
				,{name:'HTML', align: 'center', width:100, formatter: viewLineBtn}
				,{name:'REG_ID', index:'REG_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_ID', index:'UDT_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'REG_DT', index:'REG_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_DT', index:'UDT_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doWebeditorSearchList.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				}
	);
	
});
function viewGotoDetail(psPopupId, psPopupLocale, pbflag){
	if(!psPopupId){
		alert("데이터를 먼저 저장하신 이 후, 내용등록이 가능합니다.");
		return false;
	}else{
		var left = parseInt((screen.availWidth/2) - (window.innerWidth/2));
   		var top = parseInt((screen.availHeight/2) - (window.innerHeight/2));
   		var windowFeatures = "width=" + window.innerWidth + "px ,height=" + window.innerHeight + "px" + ",status,resizable,left=" + 0 + ",top=" + 0 + ",scrollbars = yes";
   		var title  = "newwindow";
   		
   		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/doWebeditorPopup.do"/>').attr("method", "post").attr("target", title);
		$(form).append($("<input type='hidden' name='DESIGN_PAGE_ID'>").val(psPopupId));
		$(form).append($("<input type='hidden' name='DESIGN_LOCALE'>").val(psPopupLocale)); 
   	    var temp = window.open('about:blank', title, windowFeatures);
   	    
   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
	}
};
</script>
</head>
<body>
	
	<div class="ad_tit">웹에디터 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>페이지 명 </label>
		<input type="text" id="srcWebnm01">
		&bull;<label>언어 구분 </label>
		<select id="srcLangDiv01">
			<option value="">- 전체 -</option>
			<c:if test="${fn:length(checkboxList) > 0}">
				<c:forEach var="list" varStatus="status" items="${checkboxList}">
					<option value="${list.COM_CD}">${list.COM_NM}</option>
				</c:forEach>
			</c:if>
		</select>
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