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
			url:'<c:url value="/doNoticeList.do"/>',
			postData : {									
				pageNo : "1",
				title : $('#srcTitle01').val()
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
        var cm = grid.jqGrid('getColProp','BOARD_CD');
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
			if(data[idx].rowType == "C"){
				var vsRowId = selRows[idx];
				$.ajax({
		    		url:'<c:url value="/doBoardCdCnt.do"/>',
		    		type: "POST",
		    		async: false,
		    		data: {
		    			boardCd : document.getElementById(vsRowId+"_BOARD_CD").value,
		    		},
		    		dataType: "json",
		    		success:function(result){
		    			if(result.result !== "true" || result.CNT > 0){
		    				alert("중복되는 게시판 코드가 있습니다.");
		    				var cm = objGrid.jqGrid('getColProp','BOARD_CD');
						    cm.editable = true;
						        
						    objGrid.jqGrid("editRow", vsRowId);
							cm.editable = false;
							
							objGrid.setSelection(vsRowId);
							return false;
		    			}		    			
		    		},
		    		error:function(e){
		    			alert("error::"+JSON.stringify(e));
		    		}
		    	});
			}
		};
		
		for(var idx = (data.length-1); idx >= 0; idx--){
			if(data[idx].rowType == "D" || data[idx].rowType == "U"){
				vnChangeCnt++;
				
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doNoticeSave.do"/>', 
						 extraparam : {
							 BOARD_CD:data[idx].BOARD_CD,
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
				if(!document.getElementById(vsRowId+"_BOARD_CD").value){
					alert("게시판코드는 필수입력 항목입니다.");
					return;
				}
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doNoticeSave.do"/>', 
						 extraparam : {
							 BOARD_CD : document.getElementById(vsRowId+"_BOARD_CD").value,
							 rowType : data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultValue); 
								var cm = objGrid.jqGrid('getColProp','BOARD_CD');
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
				url:'<c:url value="/doNoticeList.do"/>',
				postData : {									
					pageNo : "1",
					title : $('#srcTitle01').val()
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
					
	createGrid("gridList", 
			[" * 게시판코드","게시판제목","메일링여부","파일업로드 여부","의견작성 여부","등록여부","작성여부","RSS 여부", "Subscription 여부","Description", "리스트 사이즈", "등록자", "수정자", "등록일자", "수정일자"," "], 
			[
				{name:'BOARD_CD', index:'BOARD_CD',align: 'center', width:100, editable: false,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'TITLE', index:'TITLE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'MAIL_YN', index:'MAIL_YN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'FILE_UPLOAD', index:'FILE_UPLOAD',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'COMMENT_REG', index:'COMMENT_REG',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'REG', index:'REG',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'VW_YN', index:'VW_YN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'RSS_YN', index:'RSS_YN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'SUBSCRIPTION', index:'SUBSCRIPTION',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
				,{name:'DESCRIPTION', index:'DESCRIPTION',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'LIST_SIZE', index:'LIST_SIZE',align: 'center', width:70, editable: true 
					,formatter:'integer', formatoptions:{thousandsSeparator:","}, sorttype:"int"
					,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'REG_ID', index:'REG_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_ID', index:'UDT_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'REG_DT', index:'REG_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
				,{name:'UDT_DT', index:'UDT_DT',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doNoticeList.do"/>',
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
	
	<div class="ad_tit">게시판 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>게시판 명</label>
		<input type="text" id="srcTitle01">
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