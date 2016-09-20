<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>


<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/font-awesome.css" rel="stylesheet" />
<link href="resources/css/mystyle.css" rel="stylesheet" />
<link href="resources/css/footer-v6.css" rel="stylesheet" />
<link rel="stylesheet" href="resources/css/jquery-ui.css" />
<link rel='stylesheet' type='text/css'
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>
<script src="resources/js/jquery-1.12.3.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>

<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- 아작스 아이디중복확인 -->
<script type="text/javascript">
	function chkMbId() {
		$.ajax({
			url : "chkMbId.do",
			type : "post",
			data : {
				mbId : $("#mbId").val()
			},
			dataType : "json",
			success : function(data) {

				$(
						"<div align=\"center\" style='text-align:center;'>" + data.resultMsg
								+ "</div>").dialog({
					modal : true,
					resizable : false,
					buttons : [ {
						
						
						
						text : "확인",
						
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
				
				
				
				$(".ui-dialog-titlebar").hide();

				if (data.result == "success") {

				} else {
					var frm = document.frm;
					
					frm.mbId.value='';
				}
			}
		});
	}
</script>







</head>
<body>

	<div class="container">

		<div class="row" id="top-menu">
		<c:import url="topmenu.jsp" charEncoding="UTF-8"></c:import>
		</div>
		<div class="row" style="padding-left: 25px;">
			<div class="col-md-12">

				<h2>회원가입</h2>
				<hr />
				<br /> <br />

				<h4>개인정보 입력</h4>
				TEST사 회원가입 사항입니다<br /> 아래의 간단한 양식을 작성해 주시면 회원가입이 완료됩니다.<br /> </b> <i
					style="margin-top: 40px;" " class="fa fa-info-circle"
					aria-hidden="true"></i><b> &nbsp;회원가입양식</b><br />


				<form:form action="joinpagepost.do" method="post" name="frm">
					<table style="margin-top: 10px;" class="table table-condensed"
						width="500px">
						<tr>
							<td class="active">아이디</td>
							<td><form:input type="text" path="id" name="mbId" id="mbId" />
								<button type="button" class="btn btn-primary"
									style="margin-left: 10px;" onclick="chkMbId();">중복확인</button></td>

						</tr>
						<tr>
							<td class="active">비밀번호</td>
							<td><form:input type="password" path="password" id="_pw" /></td>
						</tr>
						<tr>
							<td class="active">비밀번호확인</td>
							<td><input type="password" id="_rpw" /></td>
						</tr>
						<tr>
							<td class="active">이름</td>
							<td><form:input type="text" path="name" /></td>
						</tr>
						<tr>
							<td class="active">성별</td>
							<td><label class="radio-inline"> <form:radiobutton
										path="sex" value="1" /> 남자
							</label> <label class="radio-inline"> <form:radiobutton
										path="sex" value="2" /> 여자
							</label></td>

						</tr>
						<tr>
							<td class="active">생년월일</td>
							<td><form:input type="text" path="birthday" /></td>
						</tr>
						<tr>
							<td class="active">e-mail</td>
							<td><form:input type="email" path="email" /></td>
						</tr>
						<tr>
							<td class="active">전화번호</td>
							<td><form:input type="text" path="tel" /></td>
						</tr>



						<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
						<tr>
							<td class="active">우편번호</td>
							<td><form:input path="postcode" type="text" name="postcode"
									class="postcodify_postcode5" />
								<button style="margin-left: 5px;" class="btn btn-primary"
									type="button" id="postcodify_search_button">검색</button></td>

						</tr>
						<tr>
							<td class="active">도로명주소</td>
							<td><form:input path="address1" type="text"
									class="postcodify_address" style="width:500px;" /></td>
						</tr>
						<tr>
							<td class="active">상세주소</td>
							<td><form:input path="address2" type="text"
									class="postcodify_details" style="width:500px;" /></td>
						</tr>



					</table>


					<button class="btn btn-success" type="submit">회원가입</button>
				</form:form>


			</div>
		</div>

	</div>

	<script>
		$(function() {
			$("#postcodify_search_button").postcodifyPopUp();
		});
	</script>



	<!-- 	<script type="text/javascript">
		function fsubmit() {

			if (document.form1.uid.value == ""
					|| document.form1.upwd.value == ""
					|| document.form1.uname.value == "") {
				alert("모든 항목을 작성해주세요.");
				return false;
			} else {
				return true;
			}
		}
	</script> -->











</body>
</html>