<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<head>
<title>${TITLE}</title>

<script src="<c:url value='/resources/js/common/nicEditEditor.js'/>"></script>
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
</style>

<link href="<c:url value='/resources/css/jquery/jquery-ui.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.min.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/admin.css'/>"
	rel="stylesheet">
<link href="<c:url value='/resources/css/common/reset.css'/>"
	rel="stylesheet">

<script type="text/javascript" charset="UTF-8" src="<c:url value='/resources/js/jquery/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" charset="UTF-8" src="<c:url value='/resources/js/jquery/jquery-ui-1.11.2.custom.min.js'/>"></script>

<script src="<c:url value='/resources/js/jquery/jquery-migrate.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/jquery/jquery.easing.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/jquery/jquery.parallax.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/js/jquery/jquery.scrollTo.min.js'/>" type="text/javascript"></script>

<script type="text/javascript" charset="UTF-8" src="<c:url value='/resources/js/jquery/jquery.form.min.js'/>"></script>
<script src="<c:url value='/resources/bootstrap-3.3.4/dist/js/ie-emulation-modes-warning.js'/>" type="text/javascript"></script>
<script src="<c:url value='/resources/bootstrap-3.3.4/dist/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/bootstrap-3.3.4/dist/js/ie10-viewport-bug-workaround.js'/>"></script>
<script src="<c:url value='/resources/js/common/bootstrap-dialog.min.js'/>"></script>
<script src="<c:url value='/resources/js/common/common.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#btnSave").click(function(){
		$.ajax({
			url : '<c:url value="/doContentSave.do"/>',
			data : 	{
				DESIGN_PAGE_NM : "${DESIGN_PAGE_NM}",
				DESIGN_PAGE_ID : "${DESIGN_PAGE_ID}",
				DESIGN_LOCALE : "${DESIGN_LOCALE}",
				DESIGN_HTML : $('.nicEdit-main')[0].innerHTML
			},
			type : 'POST',
			async: false,
			success : function(data){						
				alert("완료");
				window.close();
				window.opener.$('#btnSearch').trigger("click");
			}
		});
	});
	
	$("#btnCancel").click(function(){
		window.close();
	});
});
</script>
</head>
<body>
<div class="gf">
    <div class="la_con">
        <p class="gr_tit">웹에디터관리 (${DESIGN_PAGE_NM})</p>
        <div class="re_list_view">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  					<tbody>
                        <tr>
      						<th colspan="4" class="in_tit">내용</th>
    					</tr>
                        <tr>
      						<td colspan="4" class="intext">
      						<div id="myNicPanel" style="width: 100%;"></div>
							<textarea id="myInstance1" style="overflow:auto; font-size: 16px; background-color: #ccc; width: 100%;">
								${DESIGN_HTML}
							</textarea>
							</td>
    					</tr>
				  </tbody>
				</table>                
            </div>
            <p class="btn save"><span class="cl" id="btnCancel">취소</span> <span id="btnSave">저장</span></p> 
     </div>
</div>
<script type="text/javascript">
	var myNicEditor; 

     bkLib.onDomLoaded(function() {
          myNicEditor = new nicEditor({maxHeight : 500, fullPanel : true});
          myNicEditor.setPanel('myNicPanel');
          myNicEditor.addInstance('myInstance1');
     });
</script>
</body>
</html>