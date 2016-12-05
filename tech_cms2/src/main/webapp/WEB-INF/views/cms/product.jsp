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

									
									
									<div class="panel panel-primary">
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseOne" aria-expanded="true"
													aria-controls="#collapseOne">DEFENCE EQUIPMENT</a>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseOne" class="panel-collapse collapse">
											<c:forEach var="tmpsub" items="${listsub1}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												</div>
											</c:forEach>
										</div>
										




										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseTwo" aria-expanded="true"
													aria-controls="#collapseTwo">MARINE EQUIPMENT</a>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseTwo" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub2}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												</div>
											</c:forEach>
										</div>
										
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseThree" aria-expanded="true"
													aria-controls="#collapseThree">OFFSHORE EQUIPMENT</a>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseThree" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub3}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												</div>
											</c:forEach>
										</div>
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseFour" aria-expanded="true"
													aria-controls="#collapseFour">OFFSHORE EQUIPMENT</a>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseFour" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub4}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												</div>
											</c:forEach>
										</div>
									
									
									
									
									
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