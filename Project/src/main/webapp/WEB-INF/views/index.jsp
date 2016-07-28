<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>로그인</title>

<!-- 부트스트랩 -->
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/css/login.css" rel="stylesheet">

<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body style="margin-top: 170px;">


	<div class="container">
		<div class="row">	
			<div class="col-md-7">
			<img alt="" class="img-responsive img-thumbnail" src="resources/images/bg3.jpg" height="300" width="100%">
			</div>
			<div class="col-md-5">
			<section class="login-form">
        
        <form action="main.do" role="login">
          <img src="resources/images/logo.png" class="img-responsive" alt="" />
          <input type="text" name="id" id="id" placeholder="ID" required class="form-control input-lg"/>
          
          <input type="password" class="form-control input-lg" name="password" id="password" placeholder="PASSWORD" required="" />
          
          
          <button type="submit" name="go" class="btn btn-lg btn-primary btn-block">로그인</button>
          
   
          
          <div>
            <a href="#" data-toggle="modal" data-target=".bs-example-modal-sm">도움이 필요하세요?</a> <br/>
            
          </div>


						 <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									<h4 class="modal-title">※ Help</h4>
									</div>
									<div class="modal-body">
											아이디와 비밀번호가 생각이 안나시면<br/> 
      										051 - 1234 - 4567<br/>
      										전산팀에 문의 바랍니다.
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->


        </form>
        
        <hr/>
        
        
        
        <input type="button" name="go" class="btn btn-primary" value="DRM"/>
        <input type="button" name="go" class="btn btn-primary" value="MESSENGER"/>
        <input type="button" name="go" class="btn btn-primary" value="SW INSTALL"/>
        <input type="button" name="go" class="btn btn-primary" value="R-SUPPORT"/>
        
        
        <hr/>
        
         
        
        
        <div class="form-links">
        
           Copyright(c) 2016 KJS All rights reserved.
           
        </div>
      </section>  
			
			</div>
		</div>
	</div>

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script src="resources/js/jquery-1.12.3.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="resources/js/bootstrap.min.js"></script>
</body>
</html>