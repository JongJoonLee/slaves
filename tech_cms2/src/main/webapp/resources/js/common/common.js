//<![CDATA[
/**동기식아작스선언*/
jQuery.extend({
	syncPost: function(url, data, callback, type, async) {
		if (jQuery.isFunction(data)) {
			callback = data;
			data = {};
		}
		return jQuery.ajax({
			type: "POST",
			url: url,
			data: data,
			success: callback,
			dataType: type,
			async: async
		});
	}
});

$(document).ready(function($) {
	/**AES 256bit 암호화*/
	window.AESEncode = function(txt) {
		var key = "MOBIZPARKJONGWON";
		GibberishAES.size(128);	
		return GibberishAES.aesEncrypt(txt, key);
	};
	
	/**폼가져오기*/
	window.getForm = function() {
		return document.sform;
	};
	
	/**공백제거*/
	window.trim = function(txt) {
		return txt.replace(/(^[ \f\n\r\t]*)|([ \f\n\r\t]*$)/g, "");
	};
	
	/**페이지 서브밋*/
	window.Submit = function(action) {
		getForm().action = action;
		getForm().submit();
	};
	
	/**페이지변경*/
	window.fn_changePage = function(pageIndex) {
		getForm().pageIndex.value = pageIndex;
		Submit(getForm().action);
	};
	
	/**하위페이지변경*/
	window.fn_changeCPage = function(cpage) {
		getForm().cpage.value = cpage;
		Submit(getForm().action);
	};
	
	/**실행변경*/
	window.fn_changeCommand = function(command) {
		getForm().command.value = command;
		Submit(window.location.pathname);
	};
	
	/**메세지박스*/
//	window.Alert = function(title, msg, obj) {
//		$('<div title="'+title+'"><p>'+msg+'</p></div>').dialog({
//			autoOpen: true,
//			width: 500,
//			resizable: false,
//			modal: true,
//			closeOnEscape: false,
//			buttons: [{text: "확인", click: function() {
//					$(this).dialog("close");
//					if (obj) {
//						obj.focus();
//					}
//			}}]
//		});
//	};
	
	
	/**PRINT*/
	var oriBody;
	window.fn_printDocument = function() {
		var initBody = document.body.innerHTML;
        window.onbeforeprint = function(){
            document.body.innerHTML = document.getElementById('home_contents').innerHTML;
        }
        window.onafterprint = function(){
            document.body.innerHTML = initBody;
        }
        window.print(); 
	};
	
	/**PrintAdmin*/
	window.fn_printAdminContent = function() {
		var initBody = document.body.innerHTML;
        window.onbeforeprint = function(){
            document.body.innerHTML = $("body article section:first-child").html();
        }
        window.onafterprint = function(){
            document.body.innerHTML = initBody;
        }
        window.print(); 
	};
	/***Date Type 정의*/
	$('.DateYY-MM-DD').each(function() {
		$(this).datepicker({
			inline: true,
			dateFormat: "yy-mm-dd"
		});
	});
	
	/***Date Type 정의*/
	$('.DateYYMMDD').each(function() {
		$(this).datepicker({
			inline: true,
			dateFormat: "yymmdd"
		});
	});	
	
	/*** Layer Dialog 정의*/
//	$(".layer_viewer").dialog({
//		autoOpen: false,
//		show: {
//			effect: "blind",
//			duration: 1000
//		},
//		hide: {
//			effect: "blind",
//			duration: 1000
//		}
//	});
	
	/**** Button Event */
	/** Viewer ID, Viewer 가로 사이즈, Viewer 세로 사이즈 */
//	window.layer_viewer = function(viewer_id, viewer_w, viewer_h, title)
//	{
//	    $( "#" + viewer_id ).dialog({
//			height: viewer_h,
//			width: viewer_w,
//			title: title
//		});
// 
//		$( "#" + viewer_id ).dialog( "open" );
//
//	};
	
	/** 숫자만 추출하여 반환 */
	window.getNumberOnly = function(str)
	{
	    var val = str;
	    val = new String(val);
	    var regex = /[^0-9]/g;
	    val = val.replace(regex, '');
	    return val;
	};
	
	/** 날짜계산 */
	window.addDate = function(num) {
		var int_second = 1000 * 1;
		var int_minute = 60 * int_second;
		var int_hour = 60 * int_minute;
		var int_day = 24 * int_hour;
		var date = new Date();
		var date_milliseconds = date.valueOf();
		var add_milliseconds = num * int_day;
		var ret_date = new Date(date_milliseconds + add_milliseconds);
		return ret_date;
	};
	
	/**요일반환*/
	window.weekOfDay = function(num) {
		switch(num) {
			case 0 : return "일";
			case 1 : return "월";
			case 2 : return "화";
			case 3 : return "수";
			case 4 : return "목";
			case 5 : return "금";
			default : return "토";
		}
	};
	
	/**iframe사이즈조절*/
	window.fn_resizeIframe = function(height) {
		document.getElementById("contentFrame").style.height=(height+70)+"px";
	};
	
//	/**웹메일*/
//	window.fn_loginMail = function() {
//		$('<div title="Information"><p>로그인하셔야 접근하실수 있습니다.<br/>로그인하시겠습니까?</p></div>').dialog({
//			autoOpen: true,
//			width: 500,
//			resizable: false,
//			modal: true,
//			closeOnEscape: false,
//			buttons: [{text: "확인", click: function() {
//					$(this).dialog("close");
//					document.location.href="/Login.do";
//				}
//			}, {text: "취소", click: function() {
//					$(this).dialog("close");
//				}
//			}]
//		});
//	};
	
	/**통합검색*/
	window.fn_RSASearch = function(obj) {
		if (!obj.qt.value) {
			Alert("Warning!", "검색할 키워드를 입력해주세요.", obj.qt);
			return false;
		} else {
			obj.submit();	
		}
	};
	
	/*Ajax 통신에 대한 Spring Security 세션 처리*/
	$.ajaxSetup({
    	beforeSend: function(xhr) {
    		xhr.setRequestHeader("AJAX", true);
    	},
    	error: function(xhr, status, err) {
    		if (xhr.status == 401) {
    			window.location.href= getContext()+"/Login";
    		} else if (xhr.status == 403) {
    			window.location.href= getContext()+"/Login";
    		} else {
    			alert("예외가 발생했습니다. 관리자에게 문의하세요.스프링시큐리티js");
    		}
    	}
	});

});

function getCodeItem(type, category, callBack){
	var arr = {};
	if(type == "cd"){
		arr.key = "CAT_CD";
		arr.val = category;
	}else{
		arr.key = "CAT_NM";
		arr.val = category;
	}
	$.ajax({
		url:getContext()+"/items/CodeService/selectCodeList",
		type: "POST",
		data: {key:arr.key, val:arr.val},
		dataType: "json",
		success:function(data){
			//var jdata = JSON.parse(data);
			if(typeof(callBack) == "function"){
				callBack(data);
			}else{
				$.each(data, function(idx, item){
					var option = "";
					option += "<option value='"+item.CAT_DE_CD+"'>"+item.CAT_DE_NM+"</option>";
					$("#"+callBack).append($(option));
				});
			}
		}
	});
}

function fnSetCombo(jData, callBackFunc){
	$.ajax({
		url:getContext()+"items/CodeService/selectCategoryList",
		type: "POST",
		dataType: "json",
		//async: false,
		success:callBackFunc,
		error:function(e){
		}
	});
}

function setCombo(data, categoryCd, comboId, parentCd){
	var jdata = data[categoryCd];
	var option = "";
	if(parentCd == undefined || parentCd == null){
		for(var key in jdata){
			option += "<option class='"+jdata[key]["PARENT_CD"]+"' value='"+jdata[key]["CAT_DE_CD"]+"'>"+jdata[key]["CAT_DE_NM"]+"</option>";
		}
	}else{
		for(var key in jdata){
			if(jdata[key]["PARENT_CD"] == parentCd){
				option += "<option class='"+jdata[key]["PARENT_CD"]+"' value='"+jdata[key]["CAT_DE_CD"]+"'>"+jdata[key]["CAT_DE_NM"]+"</option>";
			}
		}
	}
	$("#"+comboId).append($(option));
}

function createGrid(parentNodeId, arrColNames, arrColModel, jOptions, selectRowFunc, cellSelectFunc, loadCompleteFunc){
	var gridId = "jqGrid_"+parentNodeId;
	var lastSel = "";
	$("#"+parentNodeId).append($("<table id='"+gridId+"' class='jqgrid-list'></table>"));
	$("#"+parentNodeId).append($("<div id='"+gridId+"Pager'></div>"));	//하단 pager
	$("#"+gridId).jqGrid({
		caption:jOptions.caption,
		url: jOptions.url,
		datatype: 'json',
		mtype: 'POST',
		height: jOptions.height || 225,
		width:jOptions.width,
		shrinkToFit: jOptions.shrinkToFit,
		forceFit:true,
		hidegrid:false,
		pager: '#'+gridId+'Pager',	//하단 pager
//		toppager:true,
		postData: jOptions.postData,
		rownumbers: true,
		rownumWidth: 30,
		loadonce: true,
		multiselect: jOptions.multiselect || false,
		multiboxonly: jOptions.multiboxonly || true,
		recreateFilter: true,
		viewrecords: true,
		gridview: true,
		scroll:1,
		rowNum: 30,
		rowList: [10, 50, 100],
		colNames: arrColNames, 
		colModel: arrColModel,
		jsonReader: {root: 'rows',/*page: 'page>page', npage:1,total: 'page>total',records: 'max',*/repeatitems: false/*, id: 'rows>id'*/},
//		toolbar:[true, "top"],
//		grouping:true,
//		groupingView:{
//			groupField:['name'],
//			groupSummary:[true],
//			groupColumnShow:[true],
//			groupText:['<b>{0}</b>'],
//			groupCollapse:false,
//			groupOrder:['desc']
//		},
		useColSpanStyle: jOptions.useColSpanStyle, 
		groupHeaders: jOptions.groupHeaders,
		beforeSelectRow: function (rowid, e) {},
		onCellSelect:cellSelectFunc,
		onSelectRow: function(id){
			//TODO 로우 선택 이벤트를 여기서 먼저 발생시켜야 함.
			//현재 onCellSelect 에서만 발생하므로 로직 구현이 어려움.
			//수정 바람.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			var prevId = "0";
			var selArrRow = $("#"+gridId).getGridParam("selarrrow");
			if(selArrRow.length > 0){
				prevId = selArrRow[selArrRow.length - 1];
			}
			
			if(id && id!==lastSel && lastSel != ""){
				fnSelectedRowProc(gridId, id, lastSel, selectRowFunc);
			}else if(prevId != "0"){
				fnSelectedRowProc(gridId, prevId, lastSel, selectRowFunc);
			}else{
				if(typeof(selectRowFunc) == "function"){
					selectRowFunc(null, "onSelectCell");
				}
			}
		},
		beforeRequest:function(){if(jOptions.loadingModal){$("div#loadingbar").modal("show");}},
		//loadBeforeSend:function(){alert('2:loadBeforeSend');},
		//serializeGridData:function(){alert('3:serializeGridData');},
		//loadError:function(){alert('4:loadError');},
		//beforeProcessing:function(){alert('5:beforeProcessing');},
		gridComplete:function(){$("div#loadingbar").modal("hide");},
		loadComplete:function(data){
			/* 추가 렌더링시 이벤트 발생 */
			//alert('7:loadComplete');
			//console.log(this.p);
//			var cbs = $("tr.jqgrow > td > input.cbox", $("#"+gridId));
//	        cbs.on("click", function(){return false;});
			if(typeof(loadCompleteFunc) == "function"){loadCompleteFunc(data);}
		},
		afterInsertRow:function(rowId, data, xhr){}
	});
	jQuery("#"+gridId).jqGrid('navGrid','#'+gridId+'Pager',{edit:false,add:false,del:false});
}

function fnSelectedRowProc(gridId, id, lastSel, selectRowFunc){
	var rowData;
	var currentData;
	currentData = getGridRowData($("#"+gridId).getRowData(id));
	currentData["ROW_ID"] = id;
	
	$("#"+gridId).jqGrid('saveRow',lastSel, {url:"clientArray"}); 
	
	rowData = getGridRowData($("#"+gridId).getRowData(lastSel));
	$("#"+gridId).setRowData(lastSel, rowData);
	
	//editRow 파라미터
	//rowid : 로우 아이디
	//keys  : Enter or ESC 키 사용 여부
	//		  true 일 경우 Enter 는 Save,
	//		  		    ESC는 Cancel을 수행한다.
	$("#"+gridId).jqGrid('editRow',id, false); 
	lastSel=id; 

	if(typeof(selectRowFunc) == "function"){
		selectRowFunc(currentData, "onSelectCell");
	}
}

function getGridRowData(rowData){
	var jData = {};
	for(var key in rowData){
		if(rowData[key].indexOf("rowid") != -1){
			var cellVal = $("#"+$(rowData[key]).attr("id")).val();
//			var cellData = rowData[key];
//			sIdx = (cellData.indexOf("id=")+4);
//			eIdx = cellData.indexOf("\"", sIdx);
//			var cellVal = $("#"+cellData.substring(sIdx, eIdx)).val();
			jData[key] = cellVal == undefined || cellVal == null?"":cellVal;
		}else{
			jData[key] = rowData[key];
		}
	}
	return jData;
}

function percentFormat(cellvalue, options, rowObject){
	return cellvalue+"%";
}

function showConfirm(msg, callback) {
	BootstrapDialog.confirm(msg, callback);
}

function showInfomation(msg, result, callback){
	createDialog("#FCFDFD", "Info", msg, result, callback);
}

function showWarning(msg, result, callback){
	createDialog("#FCFDFD", "Warning", msg, result, callback);
}

function showError(msg, result, callback){
	createDialog("#FCFDFD", "Error", msg, result, callback);
}

function createDialog(type, title, msg, result, callback){
	var imageUrl = getContext() + "resources/images/clo.png";
	
	var popup = $("<div class='popup'></div>");
	//var close = $("<p class='close'><span><img src='"+imageUrl+"' width='25' height='25' alt=''/></span></p>");
	var content = $("<p class='info_tx'>"+msg+"</p>");
	var button = $("<p class='ok_btn'><span>확인</span></p>");
	/*$("> span", close).on("click", function(e){
		popup.dialog("close");
	})*/
	$("> span", button).on("click", function(e){
		popup.dialog("close");
	})
	//popup.append(close);
	popup.append(content);
	popup.append(button);
	popup.dialog({title:title, modal:true}).prev(".ui-dialog-titlebar").css({"display":"none"});
}

/**
 * Ajax Form Submit
 * @param target - 대상 Form
 * @param action - action
 * @param success - success callback
 * @param error - error callback
 */
function submitFormAction(target, action, success, error) {
	$(target).attr({
		'action': action,
		'method': 'post'
	});
	$(target).ajaxForm({
		success: success,
		error: error || function() {
			showError("시스템 오류가 발생하였습니다.");
		}
	});
	
	$(target).submit();
}

function toJson(target) {
	var fields = $(target).find("input[type!=button][type!=submit], select, textarea");
	var data = {};
	
	for(var i = 0 ; i < fields.length ; i++) {
		data[$(fields[i]).attr("name")] = $(fields[i]).val();
	}
	
	return data;
}

function searchDeptOrUser(targetId, deptNm, userNm, arrType, callbackFunc){
	if(deptNm == "" && userNm == ""){
		showWarning("검색하실 부서 또는 담당자를 입력해주세요.");
		return;
	}
	var urlVal = "";
	if($.inArray("BIZ_USER_NM", arrType) != -1){
		urlVal = getContext()+"items/CodeService/selectBizDeptAndUser";
	}else{
		urlVal = getContext()+"items/CodeService/selectBizDept";
	}
	
	$.ajax({
//		url:'<c:url value="/items/CodeService/selectBizDept"/>',
		url:urlVal,
		type:'POST',
		data:{DEPT_NM:deptNm,USER_NM:userNm},
		dataType:'json',
		success:function(result){
			if(result == "undefined" || result.length == 0){
				showWarning("입력하신 사업부서/담당자를 찾을 수 없습니다.");
				return;
			}
			if(result.length > 0){
				var $table = $("#"+targetId+" table#deptModal");
				$table.empty();
				
				var $thead = $("<thead></thead>");
				var $r = $("<tr></tr>");
				if($.inArray("BIZ_USER_NM", arrType) != -1){
					$r.append("<th>부서명</th><th>담당자</th>");
				}else{
					$r.append("<th>부서명</th><th>부서코드</th>");
				}
				$thead.append($r);
				
				var $tbody = $("<tbody></tbody>");
				for(var idx in result){
					var $tr = $("<tr></tr>");
					for(var i in arrType){
						var curData = result[idx][arrType[i]] == undefined?"":result[idx][arrType[i]];
						var $td = $("<td>"+curData+"</td>").bind("click", 
								function(e){
							if(typeof(callbackFunc) == "function"){callbackFunc(this, result);}
							$('div.modal').modal("hide");
							$thead.remove();
							$tbody.remove();
						});
						$tr.append($td);
					}
	
					$tbody.append($tr);
				}
				$table.append($thead);
				$table.append($tbody);
				
				$('#'+targetId).modal();
			}
			/* else{
				for(var idx in result){
					for(var key in result[idx]){
						$("*[name="+key+"]").val(result[idx][key]);
						$("*[name="+key+"]").trigger("change");
					}
				}
			} */
		}
	});
}

/**
 * Ajax Submit
 * @param url
 * @param data
 * @param callback
 */
function submitAction(url, data, callback, method, async) {
	$.ajax({
		type: method || "POST",
		url: url,
		contentType:"application/json",
		dataType:"json",
		data: JSON.stringify(data),
		async: (async == undefined || async == null || async) ? true : false,
		success: function(result) {
			if(callback != undefined && $.isFunction(callback))
				callback(result);
		},
		error:function(e) {
			if(e.responseJSON)
				showError(e.responseJSON.errorMessage);
			else
				showError("시스템 오류가 발생하였습니다.");
		}
	});
}

/**
 * Ajax Submit
 * @param url
 * @param data
 * @param successFunc
 * @param errorFunc
 */
function submitAction2(url, data, successFunc, errorFunc, method, async) {
	$.ajax({
		type: method || "POST",
		url: url,
		contentType:"application/json",
		dataType:"json",
		data: JSON.stringify(data),
		async: (async == undefined || async == null || async) ? true : false,
		success: function(result) {
			if(successFunc != undefined && $.isFunction(successFunc))
				successFunc(result);
		},
		error:function(e) {
			if(errorFunc != undefined && $.isFunction(errorFunc))
				errorFunc(result);
		}
	});
}

/**
 * Action submit - sync
 * 
 * @param url
 * @param data(json)
 * @param callback
 */
function submitActionSync(url, data, callback, method) {
	var mtd = method || "POST";
	submitAction(url, data, callback, mtd, false);
}

/**
 * 첨부파일 추가
 */
function addAttachFile() {
	var file = $(this).clone(true);
	file.attr("id", "");
	$(this).before(file);
	$(this).hide();
	
	var filename = $(this).val().split("\\");
	var p = $("<p>").addClass("form-control-static");
	p.html(filename[filename.length - 1] + " <a href='#' class='delete'>삭제</a>");
	p.on("click", "a", function(){$(this).parent().empty().remove();});
	p.append($(this));
	$("#attachFiles").append(p);
}

/**
 * 게시판 파일 다운로드
 * @param url - 파일 다운 URL (파라미터를 포함한 URL)
 */
function fileDownload(url) {
	if($("#downFrame").attr("id") == undefined) {
		$("<iframe>").css({"width":"0",	"height":"0"})
					 .attr("id", "downFrame")
					 .appendTo("body");
	}
	
	$("#downFrame").attr("src", url);
}

function isEmpty(str) {
	return (!str || $.trim(str) === "");
//	if(str == undefined || str == null || $.trim(str) === "")
//		return true;
//	else
//		return false;
}

function isEmptyObject(obj) {
	return $.isEmptyObject(obj);
}

/**
 * Dataset 생성
 * - Dataset 은 {key:value} 형태로 저장한다.
 */
function makeDataset(target, name, data) {
	$(target).data(name, data == undefined ? {} : data);
	return $(target).data(name);
}

/**
 * Dataset 생성
 * - 해당 값이 없을 경우 빈 데이터셋을 생성하여 리턴
 */
function getDataset(target, name) {
	return $(target).data(name) == undefined ? makeDataset(target, name, {}) : $(target).data(name);
}

/**
 * 코드 콤보 조회
 * @param comCd
 * @returns combo object
 */
function getCodeCombo(comCd) {
	var combo = {};
	
	if(comCd === "USE_YN" || comCd === "DEL_YN") {
		combo["Y"] = "Yes";
		combo["N"] = "No";
	}
	else {
		//TODO 코드 콤보 구현 기능 필요
//		submitActionSync(
//				getContextPath() + "/common/combo",
//				{COM_CD:comCd},
//				function(data) {
//					$.each(data, function(i, d) {
//						combo[d.CODE] = d.NAME;
//					});
//				}
//		);
	}
	
	return combo;
}

/**
 * 코드 콤보 셋팃
 * - select 를 대상으로 함.
 * @param target
 * @param combo
 * @param addOpt
 */
function setCodeCombo(target, combo, addOpt) {
	$(target).empty();

	if(addOpt != undefined && $.trim(addOpt) !== "") {
		$("<option>").attr("value", "").text(addOpt).appendTo($(target));
	}
	
	$.each(combo, function(code, name) {
		$("<option>").attr("value", code).text(name).appendTo($(target));
	});
}

function ajax_download(url, data) {
	var $form;

	if($('#download_iframe').length === 0) {
		$("<iframe id='download_iframe' name='download_iframe' style='display: none'></iframe>").appendTo("body");
	}

	if(($form = $('#fileDownFrm')).length === 0) {
		$form = $("<form id='fileDownFrm' method='POST' style='display:none;'></form>").appendTo("body");
		$form.attr("action", url);
		$form.attr("target", "download_iframe");
	}
	
	for( var key in data) {
		if($form.find("input[name="+key+"]").length === 0){
			$form.append("<input type='hidden' name='" + key + "' value='"+ data[key] + "'>");
		}else{
			$form.find("input[name="+key+"]").val(data[key]);
		}
	}

	$form.submit();
}

function createFileUploadDialog(fileForm, title, callback){
	var dialog = new BootstrapDialog({
		type: BootstrapDialog.TYPE_INFOMATION,
		title: "엑셀업로드",
		message: function(dialogRef){
			//메시지 필드
			var $msgField = $("<div></div>");
			var $message = $("<div></div>").append(fileForm);
			var $btnGroup = $("<div class='modal-footer' style='margin-top:20px; margin-bottom:-20px;'></div>");
			
			//업로드버튼
			var $uploadBtn = $("<button class='btn btn-default btn-sm'>업로드</button>");
			$uploadBtn.one("click", {dialogRef: dialogRef}, function(event){
				fileForm.submit();
				setInterval(function(){ event.data.dialogRef.close(); }, 1000);
//				e.data.dialogRef.close();
			});
			$btnGroup.append($uploadBtn);
			
			//닫기버튼
			var $closeBtn = $("<button class='btn btn-default btn-sm'>닫기</button>");
			$closeBtn.on("click", {dialogRef: dialogRef}, function(e){
				e.data.dialogRef.close();
			});
			$btnGroup.append($closeBtn);

			$msgField.append($message);
			$msgField.append($btnGroup);
			return $msgField;
		},
		closable: true,
		onhidden: $.isFunction(callback) ? callback : null
	});
	
	dialog.realize();
	dialog.open();
}

function startLoading(title, msg, modalId){
	var v_id = modalId == undefined? "defaultLoadingLayer":modalId;
	
	if(($("#"+v_id).length) === 0){
		var $modal = $('<div class="modal fade" id="'+v_id+'"></div>');
		var $dialog = $('<div class="modal-dialog"></div>');
		var $content = $('<div class="modal-content panel-primary"></div>');
		var $header = $('<div class="modal-header panel-heading"><h4 class="modal-title"><strong><i class="fa fa-spinner fa-spin"></i> '+title+'</strong></h4></div>');
		var $body = $('<div class="modal-body panel-body">'+msg+'</div>');
		
		$content.append($header);
		$content.append($body);
		$dialog.append($content);
		$modal.append($dialog);
		$modal.appendTo("body");
	}
	
	$("#"+v_id).modal({backdrop:false, show:true});
}

function stopLoading(modalId){
	var v_id = modalId == undefined? "defaultLoadingLayer":modalId;
	if(($("#"+v_id).length) > 0){
		$("#"+v_id).modal("hide");
	}
}

function LPAD(s, c, n) {   
    if (! s || ! c || s.length >= n) {
        return s;
    }
 
    var max = (n - s.length)/c.length;
    for (var i = 0; i < max; i++) {
        s = c + s;
    }
 
    return s;
}

function RPAD(s, c, n) { 
    if (! s || ! c || s.length >= n) {
        return s;
    }
 
    var max = (n - s.length)/c.length;
    for (var i = 0; i < max; i++) {
        s += c;
    }
 
    return s;
}

function logout(url){
	localStorage.clear();
	window.location.href = url;
}

function siteLangValSet(language){
	var browser_Lang;
	if (navigator.appName == "Netscape") {
	 	browser_Lang = navigator.language;
	} else {
	 	browser_Lang = navigator.browserLanguage;
	}

	if(isEmpty(language)){
		if(isEmpty(localStorage.getItem("siteLang"))){
			return browser_Lang.split("-")[0];
		}else{
			return localStorage.getItem("siteLang");
		}
	}else{
		return language;
	}
}

function setLanguage(siteLang){
	if(!siteLang){
		siteLang = 'ko';
	}
	if(localStorage.getItem("isAuto") == "true"){
		localStorage.setItem("siteLang", siteLang);
	}
	window.location.href = "?language="+siteLang;
}
//]]>