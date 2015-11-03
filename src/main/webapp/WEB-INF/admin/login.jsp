<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<!DOCTYPE HTML >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>欢迎登录福米珠宝后台管理系统</title>

<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="./resources/css/bootstrap.min1.css" rel="stylesheet" type="text/css" />
<link href="./resources/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="./resources/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="./resources/css/style.css" rel="stylesheet" type="text/css" />
<link href="./resources/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="./resources/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="./resources/css/login.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="./resources/image/logo.jpg">

<%-- <%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
        + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
System.out.println(basePath);
%> --%>

</head>

<body class="login">
		<h1 align="center" style="color:#fff;">福米珠宝后台管理系统</h1>
		<div class="content">
			<form action="user/adminLogin"  method="post" class="form-vertical login-form" >
				<h3 class="form-title">欢迎登录</h3>
				<div class="alert alert-error hide">
					<button class="close" data-dismiss="alert"></button>
					<span>请输入用户名和密码</span>
				</div>
				<div class="control-group">
					<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
					<label class="control-label visible-ie8 visible-ie9">用户名</label>
					<div class="controls">
						<div class="input-icon left">
							<i class="icon-user"></i> <input
								class="m-wrap placeholder-no-fix" type="text"
								placeholder="用户名" name="username"  />
						</div>
					</div>
				</div>
				<div class="control-group" >
					<label class="control-label visible-ie8 visible-ie9">密码</label>
					<div class="controls">
						<div class="input-icon left">
							<i class="icon-lock"></i> <input
								class="m-wrap placeholder-no-fix" type="password"
								placeholder="密码" name="userpassword" autocomplete="off" />
						</div>

					</div>

				</div>

				<div class="form-actions">
					<!-- <label class="checkbox"> <input type="checkbox"
						name="remember" value="1" /> 记住用户名和密码
					</label> -->
					<button type="reset" class="btn green pull-left" >
						<i class="m-icon-swapleft m-icon-white"></i>重置
					</button>
					<button type="submit" class="btn green pull-right" >
						登录<i class="m-icon-swapright m-icon-white"></i>
					</button>
				</div>
				<span>相关链接：<a href="adminIndex.jsp">福米珠宝下单系统</a></span>
			</form>
			
		</div>


	<div class="copyright">2015 &copy;深圳市福米珠宝有限公司</div>

	<script src="./resources/js/jquery-2.0.3.min.js" type="text/javascript"></script>
	<script src="./resources/js/login.js" type="text/javascript" charset="utf-8"></script>
	<script src="./resources/js/app.js" type="text/javascript" charset="utf-8"></script>
	<script src="./resources/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="./resources/js/excanvas.min.js"></script>
	<script src="./resources/js/respond.min.js"></script> 
	<script src="./resources/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery.uniform.min.js" type="text/javascript"></script>
	<script src="./resources/js/jquery.validate.min.js" type="text/javascript"></script>
	

<script type="text/javascript">
	jQuery(document).ready(function() {
		App.init();
		Login.init();
	});
//异步验证用户名是否已经在数据库中存在
/* $().ready(function() {  
	  $("#checkResult").html("");
	  $("#username").change(function() {  
		  $.ajax({
				url:'user/userNameExist',
				type : 'POST',
				data : {username:$("#username").val()},
				success : function(data) {
					if($("#username").val()==''){						
					}else{
						 if(data.versionIsUsed == true){ 							
                             $("#checkResult").html("<font color='red'>该型号已经存在，请重新输入！</font>");
                            
                   		 } else if(data.versionIsUsed==false){
                   	 		$("#checkResult").html("<font color='green'>该型号尚不存在，可以添加！</font>");
                   	 		
                    	 } 
					}
                    
				},
				error : function() {
					alert('发生错误');
				}
			});
	  });
       
});	
 */
 
</script>
</body>

<!-- END BODY -->

</html>