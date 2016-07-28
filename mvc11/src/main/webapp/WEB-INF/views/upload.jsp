<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>이미지업로드</title>
	<link href="resources/css/bootstrap.css" rel="stylesheet" />
</head>

<body>
	<div class="container">
		<form action="upload.do" enctype="multipart/form-data" method="post">
			<input type="file" name="file" />
			<input type="submit" value="업로드" />
		</form>
	</div>
</body>
</html>