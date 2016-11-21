<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>

<!-- <link href="<c:url value='/resources/bootstrap-3.3.4/dist/css/bootstrap.css'/>" rel="stylesheet"> -->
<link href="<c:url value='/resources/css/common/panel.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/fancytree/ui.fancytree.min.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/fancytree/ngel.fancytree.css'/>" rel="stylesheet">

<script type="text/javascript"
	src="<spring:url value='/resources/js/fancytree/jquery.fancytree.min.js'/>"></script>
<script type="text/javascript"
	src="<spring:url value='/resources/js/fancytree/jquery.fancytree.filter.js'/>"></script>
<script type="text/javascript"
	src="<spring:url value='/resources/js/ngel.tree.js'/>"></script>
<style>
#menuTree ul li {font-weight: normal;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var moMenuNode;
	
	function getComboList() {
		var combo = {};
		submitActionSync(
				"<spring:url value='/doAuthComboList.do'/>",
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
	
	//메뉴 트리
	$("#menuTree").setTree({
		url: "<spring:url value='/doMenuList.do'/>",
		rootkey: "M01",
		key: "ID",
		parent: "PARENT",
		title: "DESCRIPTION",
		gubunField: "URL",
		autoheight: false,
		height: 400,
		beforeActivate: function(event, data) {
			if(!data.node.key) return false;
			return true;
		},
		activate: function(event, data) {
			document.getElementById("lblDetailTitle").innerHTML = "상세정보 - "+data.node.title;
			$.doSearchDetailGrid(data.node);
			//fnSearchGrdList(data.node);
		}
	});
	
	createGrid("gridList", 
			["회원구분","회원구분","읽기","수정","쓰기","삭제", "메뉴코드","멤버CD","BOARD_CD"," "], 
			[
			 	{name:'MEMBER_CLASS_CD', index:'MEMBER_CLASS_CD',align: 'center', width:60, frozen : true, editable: true
	    			,edittype:'select'
	    			,editoptions:{value:moCombo
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"select"
	    			,width:220},
				{name:'CD_NM', index:'CD_NM', hidden:true, align: 'center', width:100}				
	    		,{name:'VW_AUTH', index:'VW_AUTH',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:75}
	    		,{name:'UDT_AUTH', index:'UDT_AUTH',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:75}
	    		,{name:'REG_AUTH', index:'REG_AUTH',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:75}
	    		,{name:'DEL_AUTH', index:'DEL_AUTH',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange
						}]}, formatter:"checkbox"
	    			,width:75}
	    		,{name:'MENU_CD', hidden:true, align: 'center'}
	    		,{name:'MEMBER_CLASS_CD', hidden:true, align: 'center'}  
	    		,{name:'BOARD_CD', hidden:true, align: 'center'}
	    		,{name:'rowType', width:20, align: 'center'}
			], {url:'EMPTY',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				});
	
	//그리드 데이터 수정 시 이벤트 처리
	function fnSetCellChange(e){
		var target = e.target.id;
		var rowId = target.split("_")[0];	//수정된 cell의 아이디를 통해 수정된 row정보를 가져옴
		
		var grid = $("#gridList").find("table[id^=jqGrid]");
		var rowData = grid.getRowData(rowId);
		if(rowData.rowType != "C" && rowData.rowType != "U"){
			//수정한 row가 신규추가 또는 삭제예정이 아닐 경우 update로 상태값 변경
			grid.setRowData(rowId, {rowType:"U"});
		}		
	};
	
	//조회
	$('#btnSearch').click(function(vsParam){
		var menuNm = $("#srcMenu01").val();
		$("#menuTree").searchByTitle(menuNm);
		
   	 	$("#jqGrid_gridList").clearGridData();  	    
	});
	
	//신규
	$('#btnInsert').click(function(vsParam){
		
		if(!moMenuNode || moMenuNode.key == "M01"){
			alert("목록에서 메뉴를 선택하신 이 후, 해당 메뉴에 대한 권한을 부여할 수 있습니다.");
			return;
		}
		var data = {
			MEMBER_CLASS_CD : "*",
			MENU_CD : moMenuNode.key
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
	    var cm = grid.jqGrid('getColProp','CD_NM');
	    cm.editable = true;
	      
		grid.jqGrid("editRow", rowId);
		cm.editable = false;
		
		return rowId;
	});
	
	//삭제
	$('#btnDelete').click(function(vsParam){
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
	
	//초기화
	$('#btnReset').click(function(vsParam){
		var grid = $("#gridList").find("table[id^=jqGrid]");
		grid.clearGridData();  // 이전 데이터 삭제
		grid.setGridParam({
			url:"<c:url value='/doMenuInAuthList.do'/>",
			postData : {									
				ID : moMenuNode.key
			},
		    datatype : "json"}).trigger("reloadGrid");
	});
	
	//저장
	$('#btnSave').click(function(vsParam){
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
			if(data[idx].rowType == "U" || data[idx].rowType == "D"){
				vnChangeCnt++;				
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doAuthSave.do"/>', 
						 extraparam : {
							 MENU_CD:data[idx].MENU_CD,
							 MEMBER_CLASS_CD:data[idx].MEMBER_CLASS_CD,
							 rowType : data[idx].rowType
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
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doAuthSave.do"/>', 
						 extraparam : {
							 MENU_CD:data[idx].MENU_CD,
							 MEMBER_CLASS_CD:document.getElementById(selRows[idx]+"_MEMBER_CLASS_CD").value,
							 rowType : data[idx].rowType
						 },
						 aftersavefunc : function(psId, e){
							 debugger;
							 if(e.responseJSON.result == "true"){
								 vnSuccess++;	 
							 }else{
								alert(e.responseJSON.resultVal); 
								var cm = objGrid.jqGrid('getColProp','MEMBER_CLASS_CD');
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
			/*for(var i=0; i< arrJSON.length; i++){
				$("#jqGrid_gridList").jqGrid('restoreRow',arrJSON[i]);
			}*/
		};
		if(vnFail === 0 && vnSuccess > 0){
			alert('저장이 완료되었습니다.');
			var grid = $("#gridList").find("table[id^=jqGrid]");
			grid.clearGridData();  // 이전 데이터 삭제
			grid.setGridParam({
				url:"<c:url value='/doMenuInAuthList.do'/>",
				postData : {									
					ID : moMenuNode.key
				},
			    datatype : "json"}).trigger("reloadGrid");
		};  	    
	});
	
	
	//메뉴명 inputbox keydown event
	$("#srcMenu01").on("keydown", function(event) {
		if(event.which === 13) {
			var menuNm = $(this).val();
			$("#menuTree").searchByTitle(menuNm);
		}
	});
	
	$.doSearchDetailGrid = function(node){
		moMenuNode = node;
		var grid = $("#gridList").find("table[id^=jqGrid]");
		grid.clearGridData();  // 이전 데이터 삭제
		grid.setGridParam({
			url:"<c:url value='/doMenuInAuthList.do'/>",
			postData : {									
				ID : node.key
			},
		    datatype : "json"}).trigger("reloadGrid");
	};
	
});
</script>
</head>
<body>
	
	<div class="ad_tit">권한관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>메뉴명 </label>
		<input type="text" id="srcMenu01">
		<span id="btnSearch">조회</span>
	</div>
	
	<div class="box">
		<div class="row">
			<div class="col-xs-3">
				<div id="divTree" class="panel panel-primary">
					<div class="panel-heading">목록</div>
					<div id="menuTree"></div>
				</div>
			</div>
			<div class="col-xs-9" style="width: 700px;">
				<div id="menuDetail" class="panel panel-primary panel-detail">
					<div class="panel-heading">
						<label id="lblDetailTitle">상세정보</label>
						<span id="btnReset" class="in-btn pull-right">초기화</span>
						<span id="btnInsert" class="in-btn pull-right">신규</span>
						<span id="btnSave" class="in-btn pull-right">저장</span>
						<span id="btnDelete" class="in-btn pull-right">삭제</span>
					</div>
					<div id="gridList"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>