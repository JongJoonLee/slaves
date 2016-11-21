<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Insert title here</title>
		<link href="<c:url value='/resources/css/common/panel.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/bootstrap-3.3.4/dist/css/bootstrap.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/common/panel.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/fancytree/ui.fancytree.min.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/fancytree/ngel.fancytree.css'/>" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/jqgrid/ui.jqgrid.css'/>"/>
		
		<script type="text/javascript" src="<spring:url value='/resources/js/fancytree/jquery.fancytree.min.js'/>"></script>
		<script type="text/javascript" src="<spring:url value='/resources/js/fancytree/jquery.fancytree.filter.js'/>"></script>
		<script type="text/javascript" src="<spring:url value='/resources/js/ngel.tree.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/common/bootstrap-dialog.min.js'/>"></script>
		<style>
		* {box-sizing: unset;}
		#menuTree ul li {font-weight: normal;}
		</style>
		<script type="text/javascript">
		$(document).ready(function(){
			//메뉴 트리
			$("#menuTree").setTree({
				url: "<spring:url value='/CMS/MENU/list.do'/>",
				postData:{PARENTBOM:"/"},
				rootkey: "/",
				key: "BOM_TEXT",
				parent: "PARENTBOM",
				title: "MENU_NM",
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
					["메뉴코드","메뉴명","메뉴설명","링크옵션","구분","구분명","담당자","URL","부모계층","계층","계층레벨","계층텍스트","등록자","등록일","수정자","수정일","정렬번호"
					 	,"MENU URL","CONFIG URL","PAGE_PATH","PARENT","DESCRIPTION","TITLE","TP","게시판코드","BOARD_CD"
					 	,"DESIGN_PAGE_ID","IDX_MENU","HIDE","ROLE"
					 	,""], 
					[
						{name:'MENU_CD', index:'MENU_CD',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'MENU_NM', index:'MENU_NM',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'MENU_DESCRIPTION', index:'MENU_DESCRIPTION',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'LINK_OPTION', index:'LINK_OPTION',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'TMPCLASS', index:'TMPCLASS',align: 'center', width:100, editable: true, 
							edittype:"select", editoptions:{value:{"":"없음","URL":"URL","DESIGNPAGE":"디자인페이지","IDX":"지수","BOARD":"게시판"},dataEvents:[{type:'change', fn:fnSetCellChange}]}, formatter:"select"
						}
						,{name:'TMPCLASSNM', index:'TMPCLASSNM',align: 'center', width:100, editable: true, 
							edittype:"custom", editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}], custom_element:ronly_btn, custom_value:ronly_btnValue}
						}
						,{name:'MENU_CHARGE', index:'MENU_CHARGE',align: 'center', width:100, editable: true, 
							edittype:"custom", editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}], custom_element:ronly_btn, custom_value:ronly_btnValue}
						}
						,{name:'URL', index:'URL',align: 'center', width:100, hidden:true}
						,{name:'PARENTBOM', index:'PARENTBOM',align: 'center', width:100, hidden:true}
						,{name:'BOM_CD', index:'BOM_CD',align: 'center', width:100, hidden:true}
						,{name:'BOM_LEV', index:'BOM_LEV',align: 'center', width:100, hidden:true}
						,{name:'BOM_TEXT', index:'BOM_TEXT',align: 'center', width:100, hidden:true}
						,{name:'REG_ID', index:'REG_DT',align: 'center', width:100, hidden:true}
						,{name:'REG_DT', index:'REG_DT',align: 'center', width:100, hidden:true}
						,{name:'UDT_ID', index:'UDT_ID',align: 'center', width:100, hidden:true}
						,{name:'UDT_DT', index:'UDT_DT',align: 'center', width:100, hidden:true}
						,{name:'ORDER_IDX', index:'ORDER_IDX',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}, hidden:false}
						,{name:'URL', index:'URL',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'C_URL', index:'C_URL',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'PAGE_PATH', index:'PAGE_PATH',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'PARENT', index:'PARENT',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'DESCRIPTION', index:'DESCRIPTION',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'TITLE', index:'TITLE',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'TP', index:'TP',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'BOARD_CD', index:'BOARD_CD',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'C_BOARD_CD', index:'C_BOARD_CD',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'C_DESIGN_PAGE_ID', index:'C_DESIGN_PAGE_ID',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'C_IDX_MENU', index:'C_IDX_MENU',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'HIDE', index:'HIDE',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
						,{name:'ROLE', index:'ROLE',align: 'center', width:100, editable: true, editoptions:{dataEvents:[{type:'change', fn:fnSetCellChange}]}}
			    		,{name:'rowType', width:20, align: 'center', hidden:false}
					], {url:'EMPTY',
						multiselect:true, 
						width: 906,
						height: 450,
						loadingModal:false,
						useColSpanStyle: true
					});
			
			fnSetPopup("#gridList", "TMPCLASS");
			fnSetPopup("#gridList", "TMPCLASSNM");
			fnSetPopup("#gridList", "MENU_CHARGE");
			
			$("#btn-reset").click(fnReset);
			$("#btn-new").click(fnNew);
			$("#btn-save").click(fnSave);
			$("#btn-del").click(fnDelete);
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
		
		function fnCellClick(cellVal, rowId, pos){
			var grid = $("#gridList").find("table[id^=jqGrid]");
			var cm = grid.jqGrid("getGridParam", "colModel");
			var jData = {"colName":cm[pos].name};
			console.log(jData);
	        if(cm[pos].name == "TMPCLASS"){
	        	createDataDialog(cellVal, rowId, pos, jData);
	        }else if(cm[pos].name == "TMPCLASSNM"){
	        	console.log(grid.getCell(rowId, "TMPCLASS"));
	        	createDataDialog(cellVal, rowId, pos, jData);
	        }else if(cm[pos].name == "MENU_CHARGE"){
	        	createDataDialog(cellVal, rowId, pos, jData);
	        }
		}
		
		function fnSetPopup(obj, colname) {
			$(obj).on("click", "button#btn_" + colname, function() {
				var rowid = $(this).attr("rowid");
				var grid = $("#gridList").find("table[id^=jqGrid]");
				var rowData = grid.jqGrid("getRowData", rowid);
				
				var vTMPCLASS = colname == "MENU_CHARGE"?"MENU_CHARGE":$("select#"+rowid+"_TMPCLASS").val();
				var vCOL;
				
				if(vTMPCLASS == "DESIGNPAGE"){
					vCOL = {"HEAD":["디자인페이지 코드","디자인페이지 명"],"COL1":"DESIGN_PAGE_ID", "COL2":"DESIGN_PAGE_NM", "INPUT_VAL":"DESIGN_PAGE_ID"};
				}else if(vTMPCLASS == "IDX"){
					vCOL = {"HEAD":["지수메뉴 코드","지수페이지명","지수그룹명"],"COL1":"IDX_MENU", "COL2":"IDX_PAGE_NM", "COL3":"IDX_GRP_NM", "INPUT_VAL":"IDX_MENU"};
				}else if(vTMPCLASS == "BOARD"){
					vCOL = {"HEAD":["게시판 코드","게시판 명"],"COL1":"BOARD_CD", "COL2":"TITLE", "INPUT_VAL":"BOARD_CD"};
				}else if(vTMPCLASS == "MENU_CHARGE"){
					vCOL = {"HEAD":["사용자 ID","사용자명"],"COL1":"USER_ID", "COL2":"USER_NM", "INPUT_VAL":"USER_ID"};
				}else if(vTMPCLASS == "URL"){
					vCOL = {"HEAD":["URL 입력"],"INPUT_VAL":""};
				}else if(vTMPCLASS == ""){
					return false;
				}
				
				
				if(vTMPCLASS == ""){
					$("input#"+rowid+"_TMPCLASSNM").val("");
					return;
				}
				
				var jData = {
						"grid":grid,
						"rowId":rowid,
						"colName":colname,
						"TMPCLASS":vTMPCLASS,
						"TMPCLASSNM":$("input#"+rowid+"_TMPCLASSNM").val(),
						"MENU_CHARGE":$("input#"+rowid+"_MENU_CHARGE").val(),
						"colOption":vCOL
				}
				
			submitAction("<c:url value='/CMS/MENU/comboList.do'/>", 
					jData, 
					function(result){
// 						console.log(data);
						createDataDialog(jData, result);
					}, 
					"POST", false);
				
			});
		}
		
		var dialog;
		function createDataDialog(gridData, result){
// 			var colLength = gridData["colOption"].length();
			var table = $("<table class='table table-hover'></table>");
			var thead = $("<thead></thead>");
			var tbody = $("<tbody></tbody>");
			var tr;
			
			table.append(thead);
			tr = $("<tr></tr>");
			for(var index in gridData["colOption"]["HEAD"]){
				tr.append("<th>"+gridData["colOption"]["HEAD"][index]+"</th>");
			}
			thead.append(tr);
			
			table.append(tbody);
			if(gridData["TMPCLASS"] == "URL"){
				tr = $("<tr></tr>");
				var td = $("<td><label for='input-url'>URL</label><input type='text' id='input-url'/></td>");
				var btn = $("<button class='btn btn-default'>입력</button>").click(function(){
					getDialogData(gridData["rowId"],gridData["colName"],$("#input-url").val());
				});
				td.append(btn);
				tr.append(td);
				tbody.append(tr);
			}else{
				for(var index in result){
					tr = $("<tr onclick='getDialogData(\""+gridData["rowId"]+"\",\""+gridData["colName"]+"\",\""+result[index][gridData["colOption"]["INPUT_VAL"]]+"\");'></tr>");
					for(var key in result[index]){
						if(gridData["colName"] == "TMPCLASS"){
							if(gridData["colOption"]["COL1"] == key || gridData["colOption"]["COL2"] == key){
								tr.append("<td>"+result[index][key]+"</td>");
							}
						}else if(gridData["colName"] == "TMPCLASSNM"){
							if(gridData["colOption"]["COL1"] == key || gridData["colOption"]["COL2"] == key || gridData["colOption"]["COL3"] == key){
								tr.append("<td>"+result[index][key]+"</td>");
							}
						}else if(gridData["colName"] == "MENU_CHARGE"){
							if(gridData["colOption"]["COL1"] == key || gridData["colOption"]["COL2"] == key){
								tr.append("<td>"+result[index][key]+"</td>");
							}
						}
					}
					tbody.append(tr);
				}
			}
			
			dialog = new BootstrapDialog({
// 				title:"Dialog",
				message: table
			});
			dialog.open();
		}
		
		function getDialogData(rowid, colName, value){
// 			console.log(rowid);console.log(colName);console.log(value);
			var grid = $("#gridList").find("table[id^=jqGrid]");
			var rowData = grid.jqGrid("getRowData", rowid);
			if(rowData["rowType"] != "C"){
				grid.setRowData(rowid, {rowType:"U"});
			}
			
			$("#"+rowid+"_"+colName).find(":input").val(value);
			dialog.close();
		}
		
		//초기화
		function fnReset(){
			$("#jqGrid_gridList").clearGridData();  // 이전 데이터 삭제
			jQuery("#jqGrid_gridList").setGridParam({
				url:'<c:url value="/CMS/MENU/detailList.do"/>',
				postData : {									
					pageNo : "1"
				},
			    datatype : "json"}).trigger("reloadGrid");   
		}
		
		//신규
		function fnNew(){
			alert("데이터 수정 또는 삭제 시 저장을 하셔야지만 변경 또는 삭제된 내용이 적용됩니다.");
			if ($("#menuTree").getActiveKey() == "") {
				return false;
			}
			var data = {PARENTBOM:$("#menuTree").getActiveKey()};	
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
					submitAction2("<c:url value='/CMS/MENU/save.do'/>", 
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
					url:'<c:url value="/CMS/MENU/detailList.do"/>',
					postData : {									
						pageNo : "1"
					},
				    datatype : "json"}).trigger("reloadGrid");   
			};
		}
		
		function fnDelete(){
			alert("데이터 수정 또는 삭제 시 저장을 하셔야지만 변경 또는 삭제된 내용이 적용됩니다.");
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
				var rowData = objGrid.getRowData(selRows[idx]);
				var isChecked = objGrid.find('#'+selRows[idx]+' input[type=checkbox]').prop('checked');
				if(isChecked){
					if(rowData.rowType == "C"){
						//수정한 row가 신규추가 또는 삭제예정이 아닐 경우 update로 상태값 변경
						objGrid.setRowData(selRows[idx], {rowType:""});
					} else {
						objGrid.setRowData(selRows[idx], {rowType:"D"});
					}
					objGrid.find("#"+selRows[idx]).css("display", "none");
				}
			}
		}
		
		function doSearchDetailGrid(node){
			var data = $.extend({}, {page:1}, node.data);
			moMenuNode = node;
			var grid = $("#gridList").find("table[id^=jqGrid]");
			grid.clearGridData();  // 이전 데이터 삭제
			grid.setGridParam({
				url:"<c:url value='/CMS/MENU/detailList.do'/>",
				postData : data,
			    datatype : "json"}).trigger("reloadGrid");
		}
		
		function ronly_btn(value, options) {
			console.log(options);
			var el = $("<div>")
						.append($("<input>").attr({
												"type": "text",
												"id": options.id,
												"name": options.name,
												"readonly": "readonly"
											})
											.addClass("editable")
											.css("width", "70%")
											.val(value)
						)
						.append($("<button>").attr({
												"type": "button",
												"id": "btn_" + options.name,
												"rowid": options.rowId
											})
											.addClass("btn btn-default btn-xs")
											.append("검색")
// 											.append($("<i>").addClass("fa fa-search"))
						);
			return el;
		}
		 
		function ronly_btnValue(elem, operation, value) {
			if(operation === 'get') {
				return $('input', elem).val();
		    } else if(operation === 'set') {
				$('input',elem).val(value);
		    }
		}
		</script>
	</head>
	<body>
		<div class="ad_tit">메뉴 관리</div>
		
		<div class="search" id="searchArea"></div>
		
		<div class="box">
			<div class="row">
				<div class="col-xs-3">
					<div id="divTree" class="panel panel-primary">
						<div class="panel-heading">목록</div>
						<div id="menuTree"></div>
					</div>
				</div>
				<div class="col-xs-9" style="width: 910px;">
					<div id="menuDetail" class="panel panel-primary panel-detail">
						<div class="panel-heading">
							<label id="lblDetailTitle">상세정보</label>
							<div class="btn-group pull-right">
								<span id="btn-reset" class="in-btn pull-right" >초기화</span>
								<span id="btn-new" class="in-btn pull-right" >신규</span>
								<span id="btn-save" class="in-btn pull-right">저장</span>
								<span id="btn-del" class="in-btn pull-right">삭제</span>
							</div>
						</div>
						<div id="gridList"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>