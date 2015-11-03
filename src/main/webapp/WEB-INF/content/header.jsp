<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE HTML >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>欢迎登录福米珠宝订单系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/navbar-fixed-top.css" rel="stylesheet">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
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

<%
	//String path = request.getContextPath();
	Object username = session.getAttribute("username");
	if (username == null) {
		request.getRequestDispatcher("/login_first.jsp").forward(
				request, response);
	}  
%>

</head>
<body>
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-collapse collapse ">
				<ul id="navbarList" class="nav navbar-nav">
					<li class="active"><a href="#">福米珠宝下单系统</a></li>
					<li ><a href="${pageContext.request.contextPath}/jewel/homepage"><span class="glyphicon  glyphicon-home" aria-hidden="true">主页</span></a></li>

					<li ><a  href="${pageContext.request.contextPath}/jewel/mainpage?type=1" >3D硬千足金</a>
						<!-- <ul class="dropdown-menu">
							<li ><a tabindex="-1" href="${pageContext.request.contextPath}/jewel/mainpage?type=1">3D硬千足金</a></li>
							<li ><a tabindex="-1" href="${pageContext.request.contextPath}/jewel/mainpage?type=2">珠宝类</a></li>
							<li ><a tabindex="-1" href="${pageContext.request.contextPath}/jewel/mainpage?type=3">闪沙系列</a></li>
						</ul> -->
					</li>
					<li ><a  href="${pageContext.request.contextPath}/jewel/mainpage?type=2" >珠宝类</a></li>
					<li ><a  href="${pageContext.request.contextPath}/jewel/mainpage?type=3" >闪沙系列</a></li>
					

				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a id="cartCount" href="${pageContext.request.contextPath}/jewel/shopcartDetail"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>购物车</a></li>
					<li><a href="${pageContext.request.contextPath}/jewel/jewelOrderView"><span class="glyphicon glyphicon-time" aria-hidden="true"></span>我的订单</a></li>
					<li><a href="${pageContext.request.contextPath}/jewel/collectionView"><span class="glyphicon glyphicon-star" aria-hidden="true"></span>我的收藏</a></li>
					<li class="light-blue"><a data-toggle="dropdown" href="#"
						class="dropdown-toggle"> <span> <span class="glyphicon glyphicon-user" aria-hidden="true">欢迎您,<%--  <%=username%> --%>
						</span><b class="caret"></b>
					</a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/user/toAlterUserInfo" ><span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改信息</a></li>
							<li><a href="${pageContext.request.contextPath}/user/toAlterPassword"><span class="glyphicon glyphicon glyphicon-lock" aria-hidden="true"> </span>修改密码</a></li>
							<li><a href="${pageContext.request.contextPath}/user/branchCompany"><span class="glyphicon  glyphicon-leaf" aria-hidden="true"> </span>分店管理</a></li>
							<li class="divider"></li>
							<li><a href="${pageContext.request.contextPath}/user/logout"><span class="glyphicon glyphicon-log-out" aria-hidden="true"> </span>注销</a></li>
						</ul></li>

				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	
	
	
<!-- Modal -->
<!-- <div class="modal fade" id="selfInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">   
    </div>
  </div>
</div> -->