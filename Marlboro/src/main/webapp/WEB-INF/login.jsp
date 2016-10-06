<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>동성 그룹웨어 로그인</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link href="resources/css/bootstrap.css" rel="stylesheet">
    <link href="resources/css/font-awesome.css" rel="stylesheet">
	<link href="resources/css/login.css" rel="stylesheet">
    <link href="resources/css/loginstyle.css" rel="stylesheet">
    
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- Favicon and touch icons -->
<!--<link rel="shortcut icon" href="resources/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="resources/ico/apple-touch-icon-57-precomposed.png">
     -->
    
  </head>
  <body>

<!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>(주)동성소프트</strong></h1>
                            <div class="description">
                            	<p>
                            		여러분들의 보다 나은 미래를 위해<br/> 
	                            	항상 노력하는 (주)동성소프트가 되겠습니다.
	                            	
                            	</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>그룹웨어</h3>
                            		<p>사번과 비밀번호를 입력해주세요</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="index.do" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">사번</label>
			                        	<input type="text" name="form-username" placeholder="사번" class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">비밀번호</label>
			                        	<input type="password" name="form-password" placeholder="비밀번호" class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn">로그인</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 social-login">
                        	<h4>비밀번호 문의는 전산실(9399)에 문의 바랍니다.</h4>
                        	<div class="social-login-buttons">
	                        	<a class="btn btn-link-2" href="#"
	                        	data-toggle="modal" data-target=".bs-example-modal-lg">
	                        		개인정보처리방침
	                        	</a><br/>
	                        	<a class="btn btn-link-2" href="login.do">
	                        		Korean
	                        	</a>
	                        	<a class="btn btn-link-2" href="login_En.do">
	                        		English
	                        	</a>
                        	</div>
                        </div>
                        
                       <!-- Large modal -->

	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">개인정보처리방침</h4>
      </div>
      <div class="modal-body" style="font-size: 14px;" align="left">
"동성소프트 주식회사" 는 (이하 '회사') 이용자의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보 보호"에 관한 법률을 준수하고 있습니다.
회사는 개인정보처리방침을 통하여 이용자가 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항을 통하여 공지할 것입니다.
<br/><br/>
1. 개인정보의 보유기간 및 이용기간<br/> 
이용자가 회사에서 제공하는 서비스를 이용하는 동안 회사는 이용자의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다.<br/> 
이용자가 직접 개인정보 삭제를 요청한 경우 추후 열람이나 이용이 불가능한 상태로 처리됩니다. <br/>
<br/>
2. 개인정보의 파기 절차 및 방법<br/> 
회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.<br/> 
- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다. <br/>
- 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다. <br/>
 <br/>
3. 개인정보의 제 3자 제공<br/> 
회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우는 예외로 합니다.<br/> 
- 이용자가 사전에 동의한 경우 <br/>
- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우<br/> 
 <br/>
4. 개인정보의 위탁<br/> 
회사는 서비스 이행을 위해 아래와 같이 외부 전문업체에 위탁하여 운영하고 있습니다.<br/> 
- 위탁 대상자 : (주)종준시큐리티 <br/>
- 위탁업무 내용 : 개인 정보 관리 <br/>
 <br/>
5. 개인정보 보호책임자 및 개인정보 보호담당자<br/> 
회사는 이용자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 개인정보 관리책임자를 지정하고 있습니다.<br/> 
<br/>
(1) 개인정보 보호책임자<br/> 
- 직책 : 대표<br/>
- 성명 : 김진수<br/>
 <br/>
(2) 개인정보 보호담당자<br/> 
- 소속 : 경영지원팀<br/>
- 직책 : 과장<br/>
- 성명 : 이종준<br/>
- 전화번호 : 010-1234-5678<br/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
      
    </div>
  </div>
</div>
                    </div>
                </div>
            </div>
            
        </div>

  

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="resources/js/bootstrap.js"></script>
    <script src="resources/js/jquery.backstretch.js"></script>
    <script src="resources/js/login.js"></script>
    
    <!--[if lt IE 10]>
          <script src="resources/js/placeholder.js"></script>
    <![endif]-->
    
  </body>
</html>