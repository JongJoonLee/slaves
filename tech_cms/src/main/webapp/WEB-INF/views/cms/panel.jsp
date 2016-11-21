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
		
	function getComboList() {
		var combo = {"":""};
		submitActionSync(
				"<spring:url value='/panelComboBoxList.do'/>",
				null,
				function(data) {
					$.each(data, function(i, d) {
						combo[d.BASIC_CD] = d.CD_NM;
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
			url:'<c:url value="/panelSearch.do"/>',
			postData : {									
				pageNo : "1",
				panelId : $("#srcUser01")[0].value,
				userDiv : 30
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
        var cm = grid.jqGrid('getColProp','USER_ID');
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
						{url : '<c:url value="/panelSave.do"/>', 
						 extraparam : {
							 USER_ID:data[idx].USER_ID,
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
						{url : '<c:url value="/panelSave.do"/>', 
						 extraparam : {
							 USER_ID:document.getElementById(vsRowId+"_USER_ID").value,
							 rowType:data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultValue); 
								var cm = objGrid.jqGrid('getColProp','USER_ID');
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
				url:'<c:url value="/panelSearch.do"/>',
				postData : {									
					pageNo : "1",
					panelId : $("#srcUser01")[0].value,
					userDiv : 30
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
			[" * 패널 ID ",/*"패스워드",*/"패널 명","사용자 구분","집 번호","폰 번호","회사명","회사구분","회사전화","부서명","직위","메일","탈퇴여부","인증키","인증일시","메일 수신여부","탈퇴사유","탈퇴일자","상태", " "], 
			[
				{name:'USER_ID', index:'USER_ID',align: 'center', width:100, editable: false ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		/*,{name:'PW', index:'PW',align: 'center', width:100}*/
	    		,{name:'USER_NM', index:'USER_NM',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'MEMBER_CLASS_CD', index:'MEMBER_CLASS_CD',align: 'center', width:60, frozen : true, editable: false
	    			,edittype:'select'
	    			,editoptions:{value:moCombo
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"select"
	    			/*,editoptions:{dataUrl:'/userComboBoxList.do'
	    						 ,buildSelect: function (data) {
	    							 var data = JSON.parse(data);
	    				             var s = "<select>", i, l, item;
	    				             if (data != null && data.length) {
	    				                 for (i = 0, l = data.length; i < l; i++) {
	    				                     item = data[i];
	    				                     s += '<option value="' + item.BASIC_CD + '">' +
	    				                             item.CD_NM + '</option>';
	    				                 }
	    				             }
	    				             return s + "</select>";
	    				        }
	    						,dataEvents: [{
	    							type : 'change',
	    							fn:fnSetCellChange	    							
	    						}]
	    			}*/
	    			,width:220}
	    		,{name:'USER_PHONE', index:'USER_PHONE',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_MOBILE', index:'USER_MOBILE',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_NM', index:'COMP_NM',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_CLASS_CD', index:'COMP_CLASS_CD',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_PHONE', index:'COMP_PHONE',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'PART_NM', index:'PART_NM',align: 'center', width:60, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'POSITION', index:'POSITION',align: 'center', width:60, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_EMAIL', index:'USER_EMAIL',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'DEL_YN', index:'DEL_YN',align: 'center', width:60, editable: false,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'CERTIFY_KEY', index:'CERTIFY_KEY',align: 'center', width:60, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'CERTIFY_DT', index:'CERTIFY_DT',align: 'center', width:60, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_EMAIL_RECEIVE', index:'USER_EMAIL_RECEIVE',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'LEAVE_DESCRIPTION', index:'USER_EMAIL_RECEIVE',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'LEAVE_DT', index:'LEAVE_DT',align: 'center', width:60, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'STATUS', index:'STATUS',align: 'center', width:60, editable: false,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/panelSearch.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				},
			fnSelectRow
	);
	
});

</script>
</head>
<body>
	
	<div class="ad_tit">패널 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>패널 명 </label>
		<input type="text" id="srcUser01">
		<span id="btnSearch">조회</span>
		<span id="btnInsert">신규</span>
		<span id="btnSave" class="save" >저장</span>
		<span id="btnDelete" class="cl" >탈퇴처리</span>
	</div>
	
	<div class="box">
		<div id="mainList" style="margin: 0 auto; overflow-x:scroll;">
			<div id="gridList"></div>
		</div>
	</div>
</body>
</html>