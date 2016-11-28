<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>테크플라워CMS</title>

<link href="<c:url value='/resources/css/common/admin.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/common/reset.css'/>" rel="stylesheet">

<link href="<c:url value='/resources/css/jqgrid/ui.jqgrid.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.min.css'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/jquery/jquery-ui.theme.min.css'/>" rel="stylesheet">

<script src="<c:url value='/resources/js/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery/jquery-1.11.0.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery/jquery-ui-1.11.2.custom.min.js'/>"></script>
<script src="<c:url value='/resources/bootstrap-3.3.4/dist/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" charset="UTF-8" src="<c:url value='/resources/js/jqgrid/jquery.jqGrid.min.js'/>"></script>

<script src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/common/nicEdit.js'/>"></script>

<link href="<c:url value="/resources/images/logo.jpg"/>" rel="shortcut icon">

<script type="text/javascript">
$(document).ready(function(){
	contextRoot = "${context_root}";
});
</script>
</head>
<div id="wrap">
<jsp:include page="../login/Login.jsp"></jsp:include>
</div>
</body>
</html>