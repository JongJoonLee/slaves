<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>Insert title here</title>

<script type="text/javascript">
$(document).ready(function(){
	
	$.fileUpload = function(myFiles){
		if(!!myFiles){
			var fileName = myFiles[0].name;
			
			if(!!fileName){
				if(fileName.indexOf(".exe") > 0 || fileName.indexOf(".bat") > 0){
					alert("등록이 불가능한 파일입니다. (exe, bat, reg, 등 실행파일)");
					document.getElementById("atch_file").value = "";
					$('#srcUser01').val("");
					//$('#srcUser01').text();
					return;
				}	
			}
			$('#srcUser01').val(fileName);
			//$('#srcUser01').text(fileName);
		}else{
			$('#srcUser01').val("");
			//$('#srcUser01').text();
		}
	};
	
	$("#btnUpload").click(function(){
		if(!$('#srcUser01').val()){
			alert("선택된 엑셀 파일이 없습니다. 파일을 선택해 주세요.");
			return false;
		};
		if(confirm("업로드 하시겠습니까?")){
			var datas = new FormData();
            datas.append("files", document.getElementById("atch_file").files[0]);
			
			$.ajax({
				url:'<c:url value="/doExcelUpload.do"/>',
				type: "POST",
				async: false,
				data: datas,
				processData : false,
				contentType : false,
				dataType: "json",
				success:function(result){
					alert("저장이 완료되었습니다.");
					$('#srcUser01').val("");
				},
				error:function(e){
					alert("error::"+JSON.stringify(e));
				}
			});
		}else{
			
		}
	});
	
});
</script>

</head>
<body>

	<div class="ad_tit">엑셀 업로드</div>
	
	<div class="search" id="searchArea">
		&bull;<label>엑셀 파일명  </label>
		<input type="text" id="srcUser01" disabled="disabled">		
		<span id="btnSearch" onclick="$('input[type=file]').click()">파일찾기</span>
		<span id="btnCheck">데이터확인</span> 
		<span id="btnUpload" class="save">업로드</span>
		<input id="atch_file" type="file" name="atch_file" multiple="false" onchange="$.fileUpload(this.files)" style="visibility: hidden;"/>
	</div>

</body>
</html>