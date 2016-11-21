<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Insert title here</title>
		
<%-- 		<link href="<c:url value='/resources/bootstrap-3.3.4/dist/css/bootstrap.css'/>" rel="stylesheet"> --%>
		<link href="<c:url value='/resources/css/common/panel.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/fancytree/ui.fancytree.min.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/fancytree/ngel.fancytree.css'/>" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/jqgrid/ui.jqgrid.css'/>"/>
		
		<script type="text/javascript" src="<spring:url value='/resources/js/fancytree/jquery.fancytree.min.js'/>"></script>
		<script type="text/javascript" src="<spring:url value='/resources/js/fancytree/jquery.fancytree.filter.js'/>"></script>
		<script type="text/javascript" src="<spring:url value='/resources/js/ngel.tree.js'/>"></script>
<%-- 		<script type="text/javascript" src="<c:url value='/resources/js/common/bootstrap-dialog.min.js'/>"></script> --%>
		<style>
		#menuTree ul li {font-weight: normal;}
		</style>
		<script type="text/javascript">
		$(document).ready(function(){
			//메뉴 트리
			$("#menuTree").setTree({
				url: "<spring:url value='/CMS/MAIL/list.do'/>",
				key: "BOARD_CD",
				title: "TITLE",
				gubunField: "folder",
				autoheight: false,
				height: 400,
				beforeActivate: function(event, data) {
					if(!data.node.key) return false;
					return true;
				},
				activate: function(event, data) {
					document.getElementById("lblDetailTitle").innerHTML = "상세정보 - "+data.node.title;
					doSearchDetailGrid(data.node);
					//fnSearchGrdList(data.node);
				}
			});
			
			createGrid("gridList", 
					["수신여부","ID","사용자구분","이름","이메일","전화번호","휴대전화","게시판구분",""], 
					[
						{name:'MAIL_RECEIVE', index:'MAIL_RECEIVE',align: 'center', width:100, editable: true,edittype:'checkbox'
			    			,editoptions:{value:"1:0"
			    				,dataEvents: [{
									type : 'change',
									fn:fnSetCellChange	    							
								}]}, formatter:"checkbox"
			    			,width:50}
						,{name:'USER_ID', index:'USER_ID',align: 'center', width:100, editable: false}
						,{name:'TMPMEMBER_CLASS_ID', index:'TMPMEMBER_CLASS_ID',align: 'center', width:100, editable: false}
						,{name:'USER_NM', index:'USER_NM',align: 'center', width:100, editable: false}
						,{name:'USER_EMAIL', index:'USER_EMAIL',align: 'center', width:100, editable: false}
						,{name:'USER_PHONE', index:'USER_PHONE',align: 'center', width:100, editable: false}
						,{name:'USER_MOBILE', index:'USER_MOBILE',align: 'center', width:100, editable: false}
						,{name:'BOARD_CD', index:'BOARD_CD',align: 'center', width:100, hidden:true}
			    		,{name:'rowType', width:20, align: 'center', hidden:false}
					], {url:'EMPTY',
						multiselect:true, 
						width:'90%',
						height: 450,
						loadingModal:false,
						useColSpanStyle: true
					});
			
			$("#btn-reset").click(fnReset);
			$("#btn-save").click(fnSave);
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
		
		//초기화
		function fnReset(){
			$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
			jQuery("#jqGrid_gridList").setGridParam({
				url:'<c:url value="/CMS/MAIL/detailList.do"/>',
				postData : {									
					pageNo : "1"
				},
			    datatype : "json"}).trigger("reloadGrid");   
		}
		
		//저장
		function fnSave(){		
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
			console.log(data);
			if(data.length == 0){return;};
			
			for(var idx = (data.length-1); idx >= 0; idx--){
				if(data[idx].rowType == "C" || data[idx].rowType == "U" || data[idx].rowType == "D"){
					vnChangeCnt++;
					
					objGrid.jqGrid("saveRow", selRows[idx], false, 'clientArray');
					submitAction2("<c:url value='/CMS/MAIL/save.do'/>", 
							objGrid.getRowData(selRows[idx]), 
							function(data){vnSuccess++;},
							function(e){vnFail++;},
							"POST", false);
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
					url:'<c:url value="/CMS/MAIL/detailList.do"/>',
					postData : {									
						pageNo : "1"
					},
				    datatype : "json"}).trigger("reloadGrid");   
			};
		}
		
		function doSearchDetailGrid(node){
			var data = $.extend({}, {page:1}, node.data);
			moMenuNode = node;
			var grid = $("#gridList").find("table[id^=jqGrid]");
			grid.clearGridData();  // 이전 데이터 삭제
			grid.setGridParam({
				url:"<c:url value='/CMS/MAIL/detailList.do'/>",
				postData : data,
			    datatype : "json"}).trigger("reloadGrid");
		}
		</script>
	</head>
	<body>
		<div class="ad_tit">메일링 서비스</div>
		
		<div class="search" id="searchArea"></div>
		
		<div class="box">
			<div class="row">
				<div class="col-xs-3">
					<div id="divTree" class="panel panel-primary">
						<div class="panel-heading">목록</div>
						<div id="menuTree"></div>
					</div>
				</div>
				<div class="col-xs-9" style="width: 775px;">
					<div id="menuDetail" class="panel panel-primary panel-detail">
						<div class="panel-heading">
							<label id="lblDetailTitle">상세정보</label>
							<div class="btn-group pull-right">
								<span id="btn-reset" class="in-btn pull-right" >초기화</span>
								<span id="btn-save" class="in-btn pull-right">저장</span>
							</div>
						</div>
						<div id="gridList"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>