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
				"<spring:url value='/doSearchBoardComboList.do'/>",
				null,
				function(data) {
					$.each(data, function(i, d) {
						combo[d.COM_CD] = d.COM_NM;
						var crtElem = document.createElement("option");
						crtElem.text = d.COM_NM;
						crtElem.value = d.COM_CD;
						document.all.selBoardDiv.options.add(crtElem);
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
			url:'<c:url value="/doSearchBoardList.do"/>',
			postData : {									
				boardCd : $("#selBoardDiv option:selected").val(),
				regStrDt : "",
				regEndDt : "",
				title : $("#srcTitle01").val()
			},
		    datatype : "json"}).trigger("reloadGrid");   	    
	});
	
	//신규
	$('#btnInsert').click(function(){	
		var data = {
				REG_NM : "ADMIN",
				REG_IP : ""
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
			if(data[idx].rowType == "D" || data[idx].rowType == "U"){
				vnChangeCnt++;
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doSaveBoardList.do"/>',
						 extraparam : {
							 BOARD_CD:data[idx].BOARD_CD,
							 BOARD_SEQ:data[idx].BOARD_SEQ,
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
					alert("게시물종류는 필수항목 입니다.");
					return;
				}
				
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/doSaveBoardList.do"/>',
						 extraparam : {
							 BOARD_CD:document.getElementById(vsRowId+"_BOARD_CD").value,
							 rowType:data[idx].rowType
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
				url:'<c:url value="/doSearchBoardList.do"/>',
				postData : {									
					boardCd : $("#selBoardDiv option:selected").val(),
					regStrDt : "",
					regEndDt : "",
					title : $("#srcTitle01").val()
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
	
	function viewLineBtn(cellvalue, options, rowObject) {
        return "<button id=\""+options.rowId+"\" class=\"viewLineItem\" onclick=\"javascript:viewGotoDetail("+rowObject.BOARD_SEQ+");\">상세내용</button>"
    };
				
	createGrid("gridList", 
			[" * 게시물종류","BOARD_SEQ","등록자","제목","상세내용","요약","이메일","IP","공지여부"," "], 
			[
				{name:'BOARD_CD', index:'BOARD_CD',align: 'center', width:60, frozen : true, editable: false
	    			,edittype:'select'
	    			,editoptions:{value:moCombo
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"select"
	    			,width:220}
				,{name:'BOARD_SEQ', hidden:true}
	    		,{name:'REG_NM', index:'REG_NM',align: 'center', width:100, editable: false, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'TITLE', index:'TITLE',align: 'center', width:300, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'CONTENTS', align: 'center', width:100, formatter: viewLineBtn}
	    		,{name:'SUMMARY', index:'SUMMARY',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'REG_EMAIL', index:'REG_EMAIL',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'REG_IP', index:'REG_IP',align: 'center', width:100, editable: false,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'NOTICE_YN', index:'NOTICE_YN',align: 'center', width:60, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/doSearchBoardList.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				},
			fnSelectRow
	);
});

function viewGotoDetail(psPopupId, pbflag){
	if(!psPopupId){
		alert("데이터를 먼저 저장하신 이 후, 내용등록, 보기가 가능합니다.");
		return false;
	}else{
		var left = parseInt((screen.availWidth/2) - (window.innerWidth/2));
   		var top = parseInt((screen.availHeight/2) - (window.innerHeight/2));
   		var windowFeatures = "width=" + window.innerWidth/*((window.innerWidth*2)/3)-10*/ + "px ,height=" + window.innerHeight + "px" + ",status,resizable,left=" + 0 + ",top=" + 0 + ",scrollbars = yes";
   		var title  = "newwindow";
   		
   		var form = document.createElement("form")
   	    $(form).attr("id", "reg-form").attr("name", "reg-form").attr("action", '<c:url value="/goBoardPage.do"/>').attr("method", "post").attr("target", title);

   	    //$(this).siblings("input:text").each(function() {
   	    $(form).append($("<input type='hidden' name='boardDiv'>").val("boardDetail"));
   	 	$(form).append($("<input type='hidden' name='boardSeq'>").val(psPopupId));
   	    //});
   	    var temp = window.open('about:blank', title, windowFeatures);
   	    
   	    document.body.appendChild(form);
   	    form.submit();
   	    document.body.removeChild(form);
		
		//window.parent.$("#contents").load("/goBoardPage.do?boardDiv=boardDetail&boardSeq="+psPopupId); 
	}
};
</script>

</head>
<body>

	<div class="ad_tit">게시물 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>게시물 명 </label>
		<input type="text" id="srcTitle01">
		&bull;<label>게시물종류</label>
		<select id="selBoardDiv" name="selBoardDiv" style="width:160;" size="1">
			<option selected value="">- 전체 -</option>
		</select>
		<span id="btnSearch">조회</span>
		<span id="btnInsert">신규</span>
		<span id="btnSave" class="save">저장</span>
		<span id="btnDelete" class="cl">삭제</span>
	</div>
	
	<div class="box">
		<div id="mainList" style="margin: 0 auto;">
			<div id="gridList"></div>
		</div>
	</div>
</body>
</html>