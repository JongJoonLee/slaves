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
				"<spring:url value='/userComboBoxList.do'/>",
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
   	 	$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
		jQuery("#jqGrid_gridList").setGridParam({
			url:'<c:url value="/userSearch.do"/>',
			postData : {									
				pageNo : "1",
				userId : $("#srcUser01")[0].value,
				userDiv : $("#srcUserDiv01")[0].value,
				receive : $("input:checkbox[id='srcChkReceive01']").is(":checked")?0:null
			},
		    datatype : "json"}).trigger("reloadGrid");   	    
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
			if(data[idx].rowType == "U"){
				vnChangeCnt++;
				/*var tempNm = document.getElementsByName("USER_NM");
				var tempId = document.getElementById(selRows[idx]+"_"+"USER_NM");
				data[idx].USER_NM = tempId.value;
				arrJSON.push(data[idx]);*/
				
				jQuery("#jqGrid_gridList").jqGrid('saveRow', selRows[idx],
						{url : '<c:url value="/userSave.do"/>', 
						 extraparam : {USER_ID:data[idx].USER_ID},
						 aftersavefunc : function(psId, e){
							 vnSuccess++;
						 },
						 errorfunc : function(psId, e){
							 vnFail++;
						 }}
				);
			};
		};
		
		if(vnChangeCnt === 0){
			alert('수정된 데이터가 없습니다.');
			/*for(var i=0; i< arrJSON.length; i++){
				$("#jqGrid_gridList").jqGrid('restoreRow',arrJSON[i]);
			}*/
		};
		if(vnFail === 0 && vnSuccess > 0){
			alert('저장이 완료되었습니다.');
			$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
			jQuery("#jqGrid_gridList").setGridParam({
				url:'<c:url value="/userSearch.do"/>',
				postData : {									
					pageNo : "1",
					userId : $("#srcUser01")[0].value,
					userDiv : $("#srcUserDiv01")[0].value,
					receive : $("input:checkbox[id='srcChkReceive01']").is(":checked")?0:null
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
		if(rowData.rowType != "C" && rowData.rowType != "U"){
			//수정한 row가 신규추가 또는 삭제예정이 아닐 경우 update로 상태값 변경
			grid.setRowData(rowId, {rowType:"U"});
		}		
	};
	
	//엑셀 다운로드
	$('#btnExcelDownload').click(function(e){
		$.ajax({
    		url:'<c:url value="/doExcelDownloadUser.do"/>',
    		type: "POST",
    		async: false,
    		data: {
    			userId : $("#srcUser01").val(),
    			userDiv : $("#srcUserDiv01").val(),
    			receive : $("input:checkbox[id='srcChkReceive01']").is(":checked")?0:null
    		},
    		dataType: "json",
    		success:function(result){
    			if(result.result == "true"){
    				$.download('<c:url value="/doFileDownLoadUser.do"/>'
    						,'filename='+result.file+'&svg_filename='+result.filename
    						,'post' );	
    			}
    		},
    		error:function(e){
    			//alert("예약취소중 오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
    			alert("시스템 오류가 발생하였습니다. 관리자에게 문의 바랍니다.");
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
	/*jQuery("#gridList").jqGrid({
		url:'EMPTY',
		postData : {
			pageNo : "1"
		},
	    datatype : "json",
	    colNames : ["사용자 ID","패스워드","사용자 성명","MEMBER_CLASS_CD","LEAVE_DT","USER_PHONE","USER_MOBILE","USER_EMAIL","USER_EMAIL_RECEIVE","rowType"],
	    colModel : [{name:'USER_ID', index:'USER_ID',align: 'center', width:100}
	    			,{name:'PW', index:'PW',align: 'center', width:100}
	    			,{name:'USER_NM', index:'USER_NM',align: 'center', width:100, editable: true}
	    			,{name:'MEMBER_CLASS_CD', index:'MEMBER_CLASS_CD',align: 'center', width:100}
	    			,{name:'LEAVE_DT', index:'LEAVE_DT',align: 'center', width:100 }
	    			,{name:'USER_PHONE', index:'USER_PHONE',align: 'center', width:100, editable: true}
	    			,{name:'USER_MOBILE', index:'USER_MOBILE',align: 'center', width:100, editable: true}
	    			,{name:'USER_EMAIL', index:'USER_EMAIL',align: 'center', width:100, editable: true}
	    			,{name:'USER_EMAIL_RECEIVE', index:'USER_EMAIL_RECEIVE',align: 'center', width:100, editable: true}
	    			,{name:'rowType', hidden:true, width:20, align: 'center'}],
	    height:'450',    // 그리드 높이
	    width:'90%',
	    hidegrid:false,
	    sortable:true,
	    loadonce:true,
	    cellEdit:true,
	    editurl: 'clientArray',
	    //autowidth:true, //자동 width설정  width와 동시 사용 못함.
	    viewrecords: true,
	    multiselect: true,
	    shrinkToFit:false,
	    loadingModal:true,
	    sortorder:"desc",
	    caption: "사용자 리스트",
	    pager: '#gridPager',
	    jsonReader: {
	         repeatitems:false,
	         root:"dataList"
	    },
	    gridComplete : function() {
	    	
	    },
	    beforeSelectRow:function(rowid, e){
	    	
	    },
	    onSelectRow : function(rowid, e){
	    	var prevId = "0";
			var selArrRow = $("#gridList").getGridParam("selarrrow");
			if(selArrRow.length > 0){
				prevId = selArrRow[selArrRow.length - 1];
			}
			
			if(rowid && rowid!==lastSel && lastSel != ""){
				fnSelectedRowProc("gridList", rowid, lastSel, selectRowFunc);
			}else if(prevId != "0"){
				fnSelectedRowProc("gridList", prevId, lastSel, selectRowFunc);
			}else{
				if(typeof(selectRowFunc) == "function"){
					selectRowFunc(null, "onSelectCell");
				}
			}
	    }
	});*/
	/*jQuery("#gridList").jqGrid('navGrid','#gridPager',{edit:false,add:false,del:false});*/
	
	createGrid("gridList", 
			["사용자 ID",/*"패스워드",*/"사용자 성명","사용자 구분","집 번호","폰 번호","회사명","회사구분","회사전화","부서명","직위","메일","탈퇴여부","인증키","인증일시","메일 수신여부","가입일자","탈퇴사유","탈퇴일자","상태", " "], 
			[
				{name:'USER_ID', index:'USER_ID',align: 'center', width:100}
	    		/*,{name:'PW', index:'PW',align: 'center', width:100}*/
	    		,{name:'USER_NM', index:'USER_NM',align: 'center', width:100, editable: true ,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'MEMBER_CLASS_CD', index:'MEMBER_CLASS_CD',align: 'center', width:100, editable: true 
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
	    		,{name:'USER_PHONE', index:'USER_PHONE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_MOBILE', index:'USER_MOBILE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_NM', index:'COMP_NM',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_CLASS_CD', index:'COMP_CLASS_CD',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'COMP_PHONE', index:'COMP_PHONE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'PART_NM', index:'PART_NM',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'POSITION', index:'POSITION',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_EMAIL', index:'USER_EMAIL',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'DEL_YN', index:'DEL_YN',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'CERTIFY_KEY', index:'CERTIFY_KEY',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'CERTIFY_DT', index:'CERTIFY_DT',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'USER_EMAIL_RECEIVE', index:'USER_EMAIL_RECEIVE',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'REG_DT', index:'REG_DT',align: 'center', width:100, editable: false}
	    		,{name:'LEAVE_DESCRIPTION', index:'USER_EMAIL_RECEIVE',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'LEAVE_DT', index:'LEAVE_DT',align: 'center', width:100, editable: true,editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
	    		,{name:'STATUS', index:'STATUS',align: 'center', width:100, editable: true,edittype:'checkbox'
	    			,editoptions:{value:"1:0"
	    				,dataEvents: [{
							type : 'change',
							fn:fnSetCellChange	    							
						}]}, formatter:"checkbox"
	    			,width:80}
	    		,{name:'rowType', /*hidden:true,*/ width:20, align: 'center'}
			], {url:'<c:url value="/userSearch.do"/>',
				multiselect:true, 
				width:'90%',
				height: 450,
				loadingModal:false,
				useColSpanStyle: true
				});
		
});
</script>
</head>
<body>
	
	<div class="ad_tit">사용자 관리</div>
	
	<div class="search" id="searchArea">
		&bull;<label>사용자 명 </label>
		<input type="text" id="srcUser01">
		&bull;<label>사용자구분 </label>
		<select id="srcUserDiv01">
			<option value="">- 전체 -</option>
			<c:if test="${fn:length(checkboxList) > 0}">
				<c:forEach var="list" varStatus="status" items="${checkboxList}">
					<option value="${list.BASIC_CD}">${list.CD_NM}</option>
				</c:forEach>
			</c:if>
		</select>
		<input type="checkbox" id="srcChkReceive01"> 미승인
		<span id="btnSearch">조회</span>
		<span id="btnSave">저장</span>
		<span id="btnExcelDownload">엑셀다운로드</span>
	</div>
	
	<div class="box">
		<div id="mainList" style="margin: 0 auto; overflow-x:scroll;">
			<div id="gridList"></div>
			<!-- <table id="gridList"></table>
			<div id="gridPager"></div> -->
		</div>
	</div>
</body>
</html>