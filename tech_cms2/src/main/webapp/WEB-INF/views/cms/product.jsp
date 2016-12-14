<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">

<div class="ad_tit">PRODUCT 관리</div>



<div class="row">
	<div class="col-md-4">
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
													<button class="btn btn-info btn-xs" style="float: right;" data-toggle="modal" data-target="#AclassModal"> +</button>
											</h4>
											
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseOne" class="panel-collapse collapse">
											<c:forEach var="tmpsub" items="${listsub1}">
												<div class="list-group">
												
												
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">
														${tmpsub.tb_product_sub_title}
													</a>
													<div class="btn-group" role="group" aria-label="...">
														<form method="post" action="deleteSubMenu.do">
															<button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#Modal${tmpsub.tb_product_sub_no}">수정</button>
														
															<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
															<button class="btn btn-danger btn-xs" type="submit">삭제</button>
														</form>
													
													</div>
												</div>
												
												
												
												<!-- 하위메뉴 수정 Modal -->
												<div class="modal fade" id="Modal${tmpsub.tb_product_sub_no}" tabindex="-1" role="dialog" aria-labelledby="Modal${tmpsub.tb_product_sub_no}Label" aria-hidden="true">
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <div class="modal-header">
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
												        <h4 class="modal-title" id="myModalLabel">${tmpsub.tb_product_sub_title} 수정</h4>
												      </div>
												       <form method="post" action="updateSubMenu.do">
													      <div class="modal-body">
														    	
														    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control" value="${tmpsub.tb_product_sub_title}"/>
															   	<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
														      
													      </div>
													      <div class="modal-footer">
														     	
														     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
														     	<button type="submit" class="btn btn-primary">저장</button>
													     </div>
												      </form>
												    </div>
												  </div>
												</div>
												<!--하위메뉴 수정 Modal 끝 -->
												
												
												
												
												
												
												
											</c:forEach>
										</div>
										




										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseTwo" aria-expanded="true"
													aria-controls="#collapseTwo">MARINE EQUIPMENT</a>
													<button style="float: right;" class="btn btn-info btn-xs" data-toggle="modal" data-target="#BclassModal"> +</button>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseTwo" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub2}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
													
													<div class="btn-group" role="group" aria-label="...">
														<form method="post" action="deleteSubMenu.do">
															<button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#Modal${tmpsub.tb_product_sub_no}">수정</button>
														
															<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
															<button class="btn btn-danger btn-xs" type="submit">삭제</button>
														</form>
													
													</div>
												
												
												</div>
												
												
												
												<!-- 하위메뉴 수정 Modal -->
												<div class="modal fade" id="Modal${tmpsub.tb_product_sub_no}" tabindex="-1" role="dialog" aria-labelledby="Modal${tmpsub.tb_product_sub_no}Label" aria-hidden="true">
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <div class="modal-header">
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
												        <h4 class="modal-title" id="myModalLabel">${tmpsub.tb_product_sub_title} 수정</h4>
												      </div>
												       <form method="post" action="updateSubMenu.do">
													      <div class="modal-body">
														    	
														    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control" value="${tmpsub.tb_product_sub_title}"/>
															   	<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
														      
													      </div>
													      <div class="modal-footer">
														     	
														     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
														     	<button type="submit" class="btn btn-primary">저장</button>
													     </div>
												      </form>
												    </div>
												  </div>
												</div>
												<!--하위메뉴 수정 Modal 끝 -->
												
												
												
												
												
											</c:forEach>
										</div>
										
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseThree" aria-expanded="true"
													aria-controls="#collapseThree">OFFSHORE EQUIPMENT</a>
													<button style="float: right;" class="btn btn-info btn-xs" data-toggle="modal" data-target="#CclassModal"> +</button>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseThree" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub3}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												
												<div class="btn-group" role="group" aria-label="...">
														<form method="post" action="deleteSubMenu.do">
															<button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#Modal${tmpsub.tb_product_sub_no}">수정</button>
														
															<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
															<button class="btn btn-danger btn-xs" type="submit">삭제</button>
														</form>
													
													</div>
												
												
												</div>
												
												<!-- 하위메뉴 수정 Modal -->
												<div class="modal fade" id="Modal${tmpsub.tb_product_sub_no}" tabindex="-1" role="dialog" aria-labelledby="Modal${tmpsub.tb_product_sub_no}Label" aria-hidden="true">
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <div class="modal-header">
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
												        <h4 class="modal-title" id="myModalLabel">${tmpsub.tb_product_sub_title} 수정</h4>
												      </div>
												       <form method="post" action="updateSubMenu.do">
													      <div class="modal-body">
														    	
														    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control" value="${tmpsub.tb_product_sub_title}"/>
															   	<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
														      
													      </div>
													      <div class="modal-footer">
														     	
														     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
														     	<button type="submit" class="btn btn-primary">저장</button>
													     </div>
												      </form>
												    </div>
												  </div>
												</div>
												<!--하위메뉴 수정 Modal 끝 -->
											
											
											
											</c:forEach>
										</div>
										
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#collapseFour" aria-expanded="true"
													aria-controls="#collapseFour">ON/OFFSHORE PLANT</a>
													<button style="float: right;" class="btn btn-info btn-xs" data-toggle="modal" data-target="#DclassModal"> +</button>
											</h4>
										</div>
										<!-- div id인 collapse*는 위의 데이터토글을 위해 DB값에서 받아옴 -->
										<div id="collapseFour" class="panel-collapse collapse">


											<c:forEach var="tmpsub" items="${listsub4}">
												<div class="list-group">
													<a href="#" class="list-group-item"
														onclick="sendAjax('productDetail.do?tb_product_sub_no=${tmpsub.tb_product_sub_no}')">${tmpsub.tb_product_sub_title}</a>
												<div class="btn-group" role="group" aria-label="...">
														<form method="post" action="deleteSubMenu.do">
															<button type="button" class="btn btn-success btn-xs" data-toggle="modal" data-target="#Modal${tmpsub.tb_product_sub_no}">수정</button>
														
															<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
															<button class="btn btn-danger btn-xs" type="submit">삭제</button>
														</form>
													
													</div>
												
												
												
												</div>
												
												
												
												<!-- 하위메뉴 수정 Modal -->
												<div class="modal fade" id="Modal${tmpsub.tb_product_sub_no}" tabindex="-1" role="dialog" aria-labelledby="Modal${tmpsub.tb_product_sub_no}Label" aria-hidden="true">
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <div class="modal-header">
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
												        <h4 class="modal-title" id="myModalLabel">${tmpsub.tb_product_sub_title} 수정</h4>
												      </div>
												       <form method="post" action="updateSubMenu.do">
													      <div class="modal-body">
														    	
														    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control" value="${tmpsub.tb_product_sub_title}"/>
															   	<input type="hidden" name="tb_product_sub_no" value="${tmpsub.tb_product_sub_no}">
														      
													      </div>
													      <div class="modal-footer">
														     	
														     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
														     	<button type="submit" class="btn btn-primary">저장</button>
													     </div>
												      </form>
												    </div>
												  </div>
												</div>
												<!--하위메뉴 수정 Modal 끝 -->
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




	<div class="col-md-8">

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




	<!--DEFENCE EQUIPMENT 하위메뉴 추가 Modal -->
	<div class="modal fade" id="AclassModal" tabindex="-1" role="dialog" aria-labelledby="AclassModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">DEFENCE EQUIPMENT 하위메뉴 추가</h4>
	      </div>
	       <form method="post" action="insertSubMenu.do">
		      <div class="modal-body">
			    	
			    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control"/>
				   	<input type="hidden" name="tb_product_no" value="1">
			      
		      </div>
		      <div class="modal-footer">
			     	
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!--DEFENCE EQUIPMENT 하위메뉴 추가 Modal 끝 -->	

	<!--MARINE EQUIPMENT 하위메뉴 추가 Modal -->
	<div class="modal fade" id="BclassModal" tabindex="-1" role="dialog" aria-labelledby="BclassModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">MARINE EQUIPMENT 하위메뉴 추가</h4>
	      </div>
	       <form method="post" action="insertSubMenu.do">
		      <div class="modal-body">
			    	
			    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control"/>
				   	<input type="hidden" name="tb_product_no" value="2">
			      
		      </div>
		      <div class="modal-footer">
			     	
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!--MARINE EQUIPMENT 하위메뉴 추가 Modal 끝 -->	
	
	
	<!--OFFSHORE EQUIPMENT 하위메뉴 추가 Modal -->
	<div class="modal fade" id="CclassModal" tabindex="-1" role="dialog" aria-labelledby="CclassModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">OFFSHORE EQUIPMENT 하위메뉴 추가</h4>
	      </div>
	       <form method="post" action="insertSubMenu.do">
		      <div class="modal-body">
			    	
			    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control"/>
				   	<input type="hidden" name="tb_product_no" value="3">
			      
		      </div>
		      <div class="modal-footer">
			     	
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!--OFFSHORE EQUIPMENT 하위메뉴 추가 Modal 끝 -->	
	
	
	<!--ON/OFFSHORE PLANT 하위메뉴 추가 Modal -->
	<div class="modal fade" id="DclassModal" tabindex="-1" role="dialog" aria-labelledby="DclassModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">ON/OFFSHORE PLANT 하위메뉴 추가</h4>
	      </div>
	       <form method="post" action="insertSubMenu.do">
		      <div class="modal-body">
			    	
			    	<input name="tb_product_sub_title" id="tb_product_sub_title" type="text" class="form-control"/>
				   	<input type="hidden" name="tb_product_no" value="4">
			      
		      </div>
		      <div class="modal-footer">
			     	
			     	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			     	<button type="submit" class="btn btn-primary">저장</button>
		     </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!--ON/OFFSHORE PLANT 하위메뉴 추가 Modal 끝 -->	
	
	










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