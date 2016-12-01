<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">

<div class="ad_tit">PRODUCT 관리</div>



<div class="row">
	<div class="col-md-3">
		<div class="row">
			<div class="col-md-12">
				<div class="x_panel">
					<div class="x_title">

						<h4>
							메뉴구성
							<!--  <small>Sessions</small> -->
						</h4>
						<div class="clearfix"></div>

					</div>

					<!-- 메뉴구성 DIV -->
					<div class="x_content">
						<div class="row">
							<div class="col-sm-12">
								<div class="panel-group" id="accordion">
									<!-- 아코디언 -->

									<div class="panel panel-default">


										<%-- <c:forEach var="tmp" items="${list}">
											<tr>
												<td><c:out value="${tmp.partner_name}" /></td>
												<td><img style="height: 30px;"
													src="${pageContext.request.contextPath}/<c:out value="${tmp.partner_ci}"/>" /></td>
												<td><c:out value="${tmp.partner_url}" /></td>
												<td><button class="btn btn-danger">삭제</button></td>
											</tr>
										</c:forEach> --%>
										<c:forEach var="tmp" items="${list}">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapse${tmp.tb_product_no}" aria-expanded="true"
													aria-controls="#collapseFour"> 
													<c:out value="${tmp.tb_product_name}" />
												</a>
											</h4>
										</div>
										
										
										
										
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapse${tmp.tb_product_no}" class="panel-collapse collapse">
											
											
											<c:forEach var="tmpsub" items="${listsub}" begin="1">
												
													
												
												
													<div class="list-group">
														<a href="#" class="list-group-item"
															onclick="sendAjax('productDetail.do?tmpsub.tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a> 
													</div>
												
													 
												
											</c:forEach>
										</div>
										
										
										
										
										
										</c:forEach>
									
									</div>


									<!-- 아코디언 끝 -->
								</div>
							</div>
						</div>
					</div>
					<!-- 메뉴구성 DIV 끝-->



				</div>
			</div>
		</div>
	</div>




	<div class="col-md-9">

		<div class="row">
			<div class="col-md-12">
				<div class="x_panel">
					<div class="x_title">
						<h4>
							컨텐츠 내용
							<!--  <small>Sessions</small> -->
						</h4>
						<div class="clearfix"></div>

					</div>


					<div class="x_content" id="changeView"></div>
				</div>
			</div>
		</div>
	</div>








</div>

<script type="text/javascript">
	var sendAjax = function(url) {

		var postString = "";
		$.ajax({

			type : "GET",
			url : url,
			data : postString,

			success : function(msg) {

				document.getElementById("changeView").innerHTML = msg;
			}
		});
	};
</script>