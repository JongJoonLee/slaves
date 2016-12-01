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
									
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													onclick="sendAjax('productDetail.do?no=1')"
													href="#collapseFour" aria-expanded="true"
													aria-controls="#collapseFour"> <span
													class="glyphicon glyphicon-file"> </span>회장
												</a>
											</h4>
										</div>
										
										
										<div id="collapseFour" class="panel-collapse collapse in">
											<div class="list-group">
												<a href="#" class="list-group-item active">회장님</a> 
												<a href="#" class="list-group-item">회장님첫째</a> 
												<a href="#" class="list-group-item">회장님둘째</a> 
												<a href="#" class="list-group-item">회장님셋째</a> 
												<a href="#" class="list-group-item">회장님넷째</a>
											</div>
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