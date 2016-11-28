<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>다국어 설정</title>
<style type="text/css">
.center .ui-jqgrid {
    margin-left: auto;
    margin-right: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	function getComboList() {
		var combo = {"":""};
		submitActionSync(
			"<spring:url value='/doLocaleComboList.do'/>",
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
			url:'<c:url value="/doLanguageSearch.do"/>',
			postData : {									
				pageNo : "1",
				message : $('#srcMsg01').val(),
				locale : $('#srcCtrDiv01').val()
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
        var cm = grid.jqGrid('getColProp','MSG_CODE');
        cm.editable = true;
        
		grid.jqGrid("editRow", rowId);
		cm.editable = false;
		
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
						{url : '<c:url value="/doLanguageSave.do"/>', 
						 extraparam : {
							 MSG_CODE:data[idx].MSG_CODE,
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
						{url : '<c:url value="/doLanguageSave.do"/>',
						 extraparam : {
							 MSG_CODE:document.getElementById(vsRowId+"_MSG_CODE").value,
							 rowType:data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultValue); 
								var cm = objGrid.jqGrid('getColProp','MSG_CODE');
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
				url:'<c:url value="/doLanguageSearch.do"/>',
				postData : {									
					pageNo : "1",
					message : $('#srcMsg01').val(),
					locale : $('#srcCtrDiv01').val()
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
	
	function fnSelectRow(row, e){
		
	};
				
	createGrid("gridList", 
			[" * 메세지 코드 "," 다국어","메세지","Description","URL","사용여부","입력날짜","입력자","최근수정일자","최근수정자"," "], 
			[
				{name:'MSG_CODE', index:'MSG_CODE',align: 'center', width:150, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'LOCALE', index:'LOCALE',align: 'center', width:60, frozen : true, editable: true
	    			,edittype:'select'
	    			,editoptions:{value:moCombo
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"select"
	    			,width:220}
	    		,{name:'MESSAGE', index:'MESSAGE',align: 'center', width:300, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'DESCRIPTION', index:'DESCRIPTION',align: 'center', width:300, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'URL', index:'URL',align: 'center', width:150, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USE_YN', index:'USE_YN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"Y:N"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'REG_DT', index:'REG_DT',align: 'center', width:60, editable: false}
	    		,{name:'REG_ID', index:'REG_ID',align: 'center', width:60, editable: false}
	    		,{name:'UDT_DT', index:'UDT_DT',align: 'center', width:60, editable: false}
	    		,{name:'UDT_ID', index:'UDT_ID',align: 'center', width:60, editable: false}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doLanguageSearch.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				}
	);
	
});
</script>
</head>
<body>
	
	<div class="ad_tit">다국어 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>메세지 명</label>
		<input type="text" id="srcMsg01">
		&bull;<label>언어</label>
		<select id="srcCtrDiv01">
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