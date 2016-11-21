<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Banner</title>
<script type="text/javascript">
$(document).ready(function(){
	
	function getComboList() {
		var combo = {"":""};
		combo["1"] = "사용";
		combo["0"] = "사용 안함";
		return combo;
	};
	var moCombo = getComboList();
	var contextRoot = "${context_root}";
	
	//조회
	$('#btnSearch').click(function(vsParam){
   	 	$("#jqGrid_gridList").clearGridData();
		jQuery("#jqGrid_gridList").setGridParam({
			url:'<c:url value="/doBannerSearch.do"/>',
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
			if(data[idx].rowType == "D" || data[idx].rowType == "U" || data[idx].rowType == "C"){
				vnChangeCnt++;
				var vsRowId = selRows[idx];
				var formData = new FormData();
				formData.append("files", document.getElementById(vsRowId+"_FILE_NM").files[0]);
				formData.append("BANNER_ID", data[idx].BANNER_ID);
				formData.append("MENU_CD", data[idx].MENU_CD);
				formData.append("TITLE", document.getElementById(vsRowId+"_TITLE").value);
				formData.append("CONTENTS", data[idx].CONTENTS);
				formData.append("STARTDAY", document.getElementById(vsRowId+"_STARTDAY").value);
				formData.append("ENDDAY", document.getElementById(vsRowId+"_ENDDAY").value);
				formData.append("URL", document.getElementById(vsRowId+"_URL").value);
				formData.append("USEYN", document.getElementById(vsRowId+"_USEYN").value);
				formData.append("BANNERIMAGE", data[idx].BANNERIMAGE);
				formData.append("FILE_SEQ", data[idx].FILE_SEQ);
				formData.append("TBL_NM", data[idx].TBL_NM);
				formData.append("TBL_PK", data[idx].TBL_PK);
				formData.append("rowType", data[idx].rowType);
				$.ajax({
					url : '<c:url value="/doBannerSave.do"/>',
					data : 	formData,
					processData : false,
					contentType : false,
					type : 'POST',
					async: false,
					success : function(data){						
						vnSuccess++;
					}
				});
			}/*else if(data[idx].rowType == "C"){
				vnChangeCnt++;
				var vsRowId = selRows[idx];
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '/doBannerSave.do', 
						 extraparam : {
							 rowType:data[idx].rowType
							 },
						 aftersavefunc : function(psId, e){
							 vnSuccess++;
						 },
						 errorfunc : function(psId, e){
							 vnFail++;
						 }}
				);
			}*/
		};
		if(vnChangeCnt === 0){
			alert('수정된 데이터가 없습니다.');
		};
		if(vnFail === 0 && vnSuccess > 0){
			alert('저장이 완료되었습니다.');
			$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
			jQuery("#jqGrid_gridList").setGridParam({
				url:'<c:url value="/doBannerSearch.do"/>',
				postData : {									
					pageNo : "1",
					title : $('#srcUser01').val()
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
	
	//파일셀렉터 수정 시 확인
	function fnSetCellFileChange(e){
		var target = e.target.id;
		var rowId = target.split("_")[0];	//수정된 cell의 아이디를 통해 수정된 row정보를 가져옴
		
		var grid = $("#gridList").find("table[id^=jqGrid]");
		var rowData = grid.getRowData(rowId);
		var fileTagObj = document.getElementById(rowId+"_FILE_NM");
		var fileName = fileTagObj.files[0];
		
		if(!!fileName){
			if(fileName.name.indexOf(".jpg") < 0 && fileName.name.indexOf(".bmp") < 0 
					&& fileName.name.indexOf(".png") < 0 && fileName.name.indexOf(".gif") < 0){
				alert("이미지파일만 선택이 가능합니다.");
				fileTagObj.value = "";
				return;
			}	
		}		
		if(rowData.rowType != "C" && rowData.rowType != "U" && rowData.rowType != "D"){
			//수정한 row가 신규추가 또는 삭제예정이 아닐 경우 update로 상태값 변경
			grid.setRowData(rowId, {rowType:"U"});
		}
	};
	
	function pickdates(id){
		jQuery("#"+id+"_STARTDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+id+"_ENDDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	};
	
	function fnRowSelector(poData, psFncId){
		jQuery("#"+poData["ROW_ID"]+"_STARTDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
		jQuery("#"+poData["ROW_ID"]+"_ENDDAY","#jqGrid_gridList").datepicker({dateFormat:"yymmdd"});
	}
	
	function playerPicFormatter(cellvalue, options, rowObject){
      	var html = '<img src="'+contextRoot+'/resources/uploadFiles/banner/'+cellvalue+'" height="25" onclick="gridFileDownload(\''+cellvalue+'\')" style="cursor:pointer;"/>';
      	return html;
    }
	
	createGrid("gridList", 
			["베너ID","메뉴코드"," * 제목"," * 시작일"," * 종료일"," * URL","사용유무"," * 파일 명","CONTENTS","BANNERIMAGE","FILE_SEQ","FILE_SIZE","TBL_NM","TBL_PK","베너 이미지", " "], 
			[
				{name:'BANNER_ID', hidden:true, index:'BANNER_ID'}
				,{name:'MENU_CD', hidden:true, index:'MENU_CD'}
	    		,{name:'TITLE', index:'TITLE',align: 'center', width:400, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'STARTDAY', index:'TITLE',align: 'center', width:70, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'ENDDAY', index:'TITLE',align: 'center', width:70, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'URL', index:'TITLE',align: 'center', width:200, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USEYN', index:'TITLE',align: 'center', width:60, frozen : true, editable: true
	    			,edittype:'select'
		    		,editoptions:{value:moCombo
		    			,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"select"
		    		,width:220}
	    		,{
	    		    name: 'FILE_NM',
	    		    index: 'FILE_SEQ',
	    		    align: 'left',
	    		    editable: true,
	    		    edittype: 'file',
	    		    editoptions: {
	    		        enctype: "multipart/form-data",
	    		        accept : "image/*",
	    		        dataEvents:[{type:'change', fn:fnSetCellFileChange}]
	    		    },
	    		    width: 210,
	    		    align: 'center',
	    		    /*formatter: jgImageFormatter,*/
	    		    search: false
	    		}
	    		,{name:'CONTENTS', hidden:true}
	    		,{name:'BANNERIMAGE', hidden:true}
	    		,{name:'FILE_SEQ', hidden:true}
	    		,{name:'FILE_SIZE', hidden:true}
	    		,{name:'TBL_NM', hidden:true}
	    		,{name:'TBL_PK', hidden:true}
	    		,{name: 'SVR_FILE_NM', width: 50, fixed: true, formatter: playerPicFormatter
	            }
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url: '<c:url value="/doBannerSearch.do"/>',//'EMPTY',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				}
		,fnRowSelector);
	
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
	
});
function gridFileDownload(poRowObj){
	if(!!poRowObj){
		$.download('<c:url value="/doBannerFileDownload.do"/>','filename='+poRowObj+'&svg_filename='+poRowObj,'post' );
	}else{
		alert('등록된 베너 이미지가 없습니다.');
		return;
	}
};
</script>
</head>
<body>

	<div class="ad_tit">베너관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>베너 명  </label>
		<input type="text" id="srcUser01">
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