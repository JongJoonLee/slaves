<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- �� 3���� ��Ÿ �±״� *�ݵ��* head �±��� ó���� �;��մϴ�; � �ٸ� ���������� �ݵ�� �� �±׵� *������* �;� �մϴ� -->
    <title>���� �׷���� �α���</title>

    <!-- ��Ʈ��Ʈ�� -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link href="resources/css/bootstrap.css" rel="stylesheet">
    <link href="resources/css/font-awesome.css" rel="stylesheet">
	<link href="resources/css/login.css" rel="stylesheet">
    <link href="resources/css/loginstyle.css" rel="stylesheet">
    
    <!-- IE8 ���� HTML5 ��ҿ� �̵�� ������ ���� HTML5 shim �� Respond.js -->
    <!-- WARNING: Respond.js �� ����� file:// �� ���� �������� �� ���� �������� �ʽ��ϴ�. -->
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
                            <h1><strong>(��)��������Ʈ</strong></h1>
                            <div class="description">
                            	<p>
                            		�����е��� ���� ���� �̷��� ����<br/> 
	                            	�׻� ����ϴ� (��)��������Ʈ�� �ǰڽ��ϴ�.
	                            	
                            	</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>�׷����</h3>
                            		<p>����� ��й�ȣ�� �Է����ּ���</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="index.do" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">���</label>
			                        	<input type="text" name="form-username" placeholder="���" class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">��й�ȣ</label>
			                        	<input type="password" name="form-password" placeholder="��й�ȣ" class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn">�α���</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 social-login">
                        	<h4>��й�ȣ ���Ǵ� �����(9399)�� ���� �ٶ��ϴ�.</h4>
                        	<div class="social-login-buttons">
	                        	<a class="btn btn-link-2" href="#"
	                        	data-toggle="modal" data-target=".bs-example-modal-lg">
	                        		��������ó����ħ
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
        <h4 class="modal-title" id="myModalLabel">��������ó����ħ</h4>
      </div>
      <div class="modal-body" style="font-size: 14px;" align="left">
"��������Ʈ �ֽ�ȸ��" �� (���� 'ȸ��') �̿����� ���������� �߿���ϸ�, "������Ÿ� �̿����� �� ���� ��ȣ"�� ���� ������ �ؼ��ϰ� �ֽ��ϴ�.
ȸ��� ��������ó����ħ�� ���Ͽ� �̿��ڰ� �����ϴ� ���������� ��� �뵵�� ������� �̿�ǰ� ������, ����������ȣ�� ���� ��� ��ġ�� �������� �ִ��� �˷��帳�ϴ�.
ȸ��� ��������ó����ħ�� �����ϴ� ��� ������Ʈ ���������� ���Ͽ� ������ ���Դϴ�.
<br/><br/>
1. ���������� �����Ⱓ �� �̿�Ⱓ<br/> 
�̿��ڰ� ȸ�翡�� �����ϴ� ���񽺸� �̿��ϴ� ���� ȸ��� �̿����� ���������� ��������� �����ϸ� ���� ���� ���� ���� �̿��մϴ�.<br/> 
�̿��ڰ� ���� �������� ������ ��û�� ��� ���� �����̳� �̿��� �Ұ����� ���·� ó���˴ϴ�. <br/>
<br/>
2. ���������� �ı� ���� �� ���<br/> 
ȸ��� ��Ģ������ �������� ���� �� �̿������ �޼��� �Ŀ��� �ش� ������ ��ü ���� �ı��մϴ�. �ı����� �� ����� ������ �����ϴ�.<br/> 
- ������ �������·� ����� ���������� ����� ����� �� ���� ����� ����� ����Ͽ� �����մϴ�. <br/>
- ���̿� ��µ� ���������� �м��� �м��ϰų� �Ұ��� ���Ͽ� �ı��մϴ�. <br/>
 <br/>
3. ���������� �� 3�� ����<br/> 
ȸ��� �̿����� ���������� ��Ģ������ �ܺο� �������� �ʽ��ϴ�. �ٸ�, �Ʒ��� ���� ���ܷ� �մϴ�.<br/> 
- �̿��ڰ� ������ ������ ��� <br/>
- ������ ������ �ǰ��ϰų�, ���� �������� ���ɿ� ������ ������ ����� ���� �������� �䱸�� �ִ� ���<br/> 
 <br/>
4. ���������� ��Ź<br/> 
ȸ��� ���� ������ ���� �Ʒ��� ���� �ܺ� ������ü�� ��Ź�Ͽ� ��ϰ� �ֽ��ϴ�.<br/> 
- ��Ź ����� : (��)���ؽ�ť��Ƽ <br/>
- ��Ź���� ���� : ���� ���� ���� <br/>
 <br/>
5. �������� ��ȣå���� �� �������� ��ȣ�����<br/> 
ȸ��� �̿����� ���������� ��ȣ�ϰ� ���������� ������ �Ҹ��� ó���ϱ� ���Ͽ� �Ʒ��� ���� �������� ����å���ڸ� �����ϰ� �ֽ��ϴ�.<br/> 
<br/>
(1) �������� ��ȣå����<br/> 
- ��å : ��ǥ<br/>
- ���� : ������<br/>
 <br/>
(2) �������� ��ȣ�����<br/> 
- �Ҽ� : �濵������<br/>
- ��å : ����<br/>
- ���� : ������<br/>
- ��ȭ��ȣ : 010-1234-5678<br/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
      </div>
      
    </div>
  </div>
</div>
                    </div>
                </div>
            </div>
            
        </div>

  

    <!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
    <script src="resources/js/bootstrap.js"></script>
    <script src="resources/js/jquery.backstretch.js"></script>
    <script src="resources/js/login.js"></script>
    
    <!--[if lt IE 10]>
          <script src="resources/js/placeholder.js"></script>
    <![endif]-->
    
  </body>
</html>