<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<head>
<title>게시물 관리 상세</title>

<link href="<c:url value='/resources/css/jquery/jquery-ui.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.min.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/admin.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/reset.css'/>"
	rel="stylesheet">

<script src="<c:url value='/resources/js/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery/jquery-1.11.0.min.js'/>"></script>
<script
	src="<c:url value='/resources/js/jquery/jquery-ui-1.11.2.custom.min.js'/>"></script>
<script src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/common/nicEditBorder.js'/>"></script>

<style type="text/css">
#myInstance1 {
	border: 2px dashed #0000ff;
}

.nicEdit-selected {
	border: 2px solid #0000ff !important;
}

.nicEdit-panel {
	background-color: #fff !important;
}

.nicEdit-button {
	background-color: #fff !important;
}
.myfileupload-buttonbar input
        {
            position: absolute;
            top: 0;
            right: 0;
            margin: 0;
            border: solid transparent;
            border-width: 0 0 100px 200px;
            opacity: 0.0;
            filter: alpha(opacity=0);
            -o-transform: translate(250px, -50px) scale(1);
            -moz-transform: translate(-300px, 0) scale(4);
            direction: ltr;
            cursor: pointer;
        }
        .myui-button
        {
            position: relative;
            cursor: pointer;
            text-align: center;
            overflow: visible;
            overflow: hidden;
        }
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#btnDetail").click(function(){
		window.close();
		window.opener.$('#btnSearch').trigger("click");
		//window.parent.$("#contents").load("/goBoardPage.do?boardDiv=board"); 
	});
	
	//저장
	$("#btnSave").click(function(){
		if(!$("#ipbTitle").val()){
			alert("제목을 입력해 주십시요.");
			$("#ipbTitle").focus();
			return;
		}
		if(!$(".nicEdit-main").html()){
			alert("내용을 입력해 주십시요.");
			$(".nicEdit-main").focus();
			return;
		}
		if(confirm("저장하시겠습니까?")){
			var datas = new FormData();
            datas.append("files", document.getElementById("atch_file").files[0]);
            datas.append('BOARD_CD', $("#boardCd").val());
            datas.append('BOARD_SEQ', $("#boardSeq").val());
            datas.append('CONTENTS', $(".nicEdit-main").html());
            datas.append('SUMMARY', $("#ipbSummary").val());
            datas.append('HTML', '1');
            datas.append('SUBSCRIPTION_YN', '0');
            datas.append('STATE', '보임');
            datas.append('SEND_YN', '0');
            datas.append('NOTICE_YN', '0');
            datas.append('LANG', $("#ipbLangegue").val());
            datas.append('TITLE', $("#ipbTitle").val());
            datas.append('BIGO', '');
            datas.append('CONTENTS_BK', $("#myInstance1").val());
			
			$.ajax({
				url:'<c:url value="/doUpdateBoardList.do"/>',
				type: "POST",
				async: false,
				data: datas,
				processData : false,
				contentType : false,
				dataType: "json",
				success:function(result){
					alert("저장이 완료되었습니다.");
					window.close();
					window.opener.$('#btnSearch').trigger("click");
				},
				error:function(e){
					alert("error::"+JSON.stringify(e));
				}
			});
		}else{
			
		}
	});
	
	//취소
	$("#btnCancel").click(function(){
		window.close();
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
	
	//파일 다운로드
	$.fileDownLoad = function(psFileName, psSvrFileName){
		if(!!psFileName){
			$.download('<c:url value="/doFileDownLoad.do"/>','filename='+psFileName+'&svg_filename='+psSvrFileName+'&board_cd='+document.getElementById("boardCd").value,'post' );
		}
	};
	
	$.fileUpload = function(myFiles){
		if(!!myFiles){
			var fileName = myFiles[0].name;
			
			if(!!fileName){
				if(fileName.indexOf(".exe") > 0 || fileName.indexOf(".bat") > 0){
					alert("등록이 불가능한 파일입니다. (exe, bat, reg, 등 실행파일)");
					document.getElementById("atch_file").value = "";
					$('#ipbFiles').text();
					return;
				}	
			}
			$('#ipbFiles').text(fileName);
		}else{
			$('#ipbFiles').text();
		}
	};
	
});
</script>
</head>
<body>
	<div class="gf">
		<div class="la_con">
			<!-- <p class="close_btn">
				<img src="<c:url value='/resources/images/close_btn.jpg'/>"
					width="22" height="21" alt="" />
			</p> -->
			<p class="gr_tit">게시물 관리</p>
			<!-- ${SEQ}
		<button id="btnDetail" value="목록">목록 이동</button> -->
			<input type="hidden" id="boardCd" value="${dataList.BOARD_CD}">
			<input type="hidden" id="boardSeq" value="${dataList.BOARD_SEQ}">
			<div class="re_list_view">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<th>작성자(이메일)</th>
							<td>${dataList.REG_NM}(${dataList.REG_EMAIL})</td>
							<th>작성일</th>
							<td>${dataList.REG_DT}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input id="ipbTitle" name="ipbTitle" type="text"
								value="${dataList.TITLE}" /></td>
							<th>조회수</th>
							<td>${dataList.VW_CNT}</td>
						</tr>
						<tr>
							<th>언어</th>
							<td><input id="ipbLangegue" name="ipbLangegue" type="text"
								value="${dataList.LANG}" /></td>
							<th>IP</th>
							<td>${dataList.REG_IP}</td>
						</tr>
						<!-- <tr>
							<th>비밀번호</th>
							<td colspan="3"><input id="ipbPw" name="ipbPw" type="password"
								value="${dataList.PW}" /></td>
						</tr> -->
						<tr>
							<th colspan="4" class="in_tit">요약내용</th>
						</tr>
						<tr>
							<td colspan="4" class="intext"><input id="ipbSummary" name="ipbSummary"
								type="text" value="${dataList.SUMMARY}" /></td>
						</tr>
						<tr>
							<th colspan="4" class="in_tit">내용</th>
						</tr>
						<tr>
							<td colspan="4" class="intext">
								<div id="myNicPanel" style="width: 100%;"></div>
								<textarea id="myInstance1"
									style="font-size: 16px; background-color: #ccc; width: 100%;">
									${dataList.CONTENTS}
								</textarea>
							</td>
						</tr>
						<tr>
							<th class="file">첨부파일</th>
							<td colspan="3" class="intext s"><c:if
									test="${fn:length(dataFileList) > 0}">
									<c:forEach var="list" varStatus="status"
										items="${dataFileList}">
										<!-- <input id="down_${status.count}" name=" " type="text"
											value="${list.FILE_NM}" /> -->
										${list.FILE_NM}
										<span id="down_${status.count}" onclick="$.fileDownLoad('${list.FILE_NM}','${list.SVR_FILE_NM}')"><img
											src="<c:url value='/resources/images/i_down.png'/>" alt="" />&nbsp;
											다운로드</span><br>
									</c:forEach>
								</c:if></td>
						</tr>
						<tr>
							<th class="file">파일첨부</th>
							<td colspan="3" class="intext s">							
								<div id="fileupload" >
        							<div class="myfileupload-buttonbar ">
            							<label class="myui-button">
                							<span ><img src="<c:url value='/resources/images/i_upload.png'/>" alt="" /></span>
                							<input id="atch_file" type="file" name="atch_file" multiple="false"
                								onchange="$.fileUpload(this.files)"/>
            							</label>
            							<label id="ipbFiles"></label>
        							</div>
    							</div>		
							</td>			
						</tr>
					</tbody>
				</table>
			</div>
			<p class="btn save">
				<span class="cl" id="btnCancel">취소</span> <span id="btnSave">저장</span>
			</p>
		</div>
	</div>
	<script type="text/javascript">
			var myNicEditor; 

			bkLib.onDomLoaded(function() {
     			myNicEditor = new nicEditor();
     			myNicEditor.setPanel('myNicPanel');
     			myNicEditor.addInstance('myInstance1');
			});
</script>
</body>
</html>