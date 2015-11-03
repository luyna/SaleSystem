<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE HTML >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>欢迎登录福米珠宝后台管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link href="../resources/css/navbar-fixed-top.css" rel="stylesheet">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/layout.css" type="text/css" media="screen" />
<link rel="shortcut icon" href="../resources/image/logo.jpg">

<style type="text/css">
.dropdown-submenu {
	position: relative;
}

.dropdown-submenu>.dropdown-menu {
	top: 0;
	left: 100%;
	margin-top: -6px;
	margin-left: -1px;
	-webkit-border-radius: 0 6px 6px 6px;
	-moz-border-radius: 0 6px 6px;
	border-radius: 0 6px 6px 6px;
}

.dropdown-submenu:hover>.dropdown-menu {
	display: block;
}

.dropdown-submenu>a:after {
	display: block;
	content: " ";
	float: right;
	width: 0;
	height: 0;
	border-color: transparent;
	border-style: solid;
	border-width: 5px 0 5px 5px;
	border-left-color: #ccc;
	margin-top: 5px;
	margin-right: -10px;
}

.dropdown-submenu:hover>a:after {
	border-left-color: #fff;
}

.dropdown-submenu.pull-left {
	float: none;
}

.dropdown-submenu.pull-left>.dropdown-menu {
	left: -100%;
	margin-left: 10px;
	-webkit-border-radius: 6px 0 6px 6px;
	-moz-border-radius: 6px 0 6px 6px;
	border-radius: 6px 0 6px 6px;
}
</style>

<style type="text/css">
td{
	word-wrap: break-word;
	word-break: break-all;
}
</style>

<%-- <%
	//String path = request.getContextPath();
	Object username = session.getAttribute("adminname");
	if (username == null) {
		request.getRequestDispatcher("/login_first.jsp").forward(
				request, response);
	}  
%> --%>

</head>
<body>
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-collapse collapse ">
				<ul id="navbarList" class="nav navbar-nav">
					<li class="active"><a href="#">福米珠宝后台管理系统</a></li>
					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li ><a href="${pageContext.request.contextPath}/"><span class="glyphicon  glyphicon-home" aria-hidden="true">福米珠宝前台下单系统登录</span></a></li>
					
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	
	
