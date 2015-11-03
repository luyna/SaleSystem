<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>

<!DOCTYPE HTML >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>欢迎登录福米珠宝订单系统</title>
<link rel="shortcut icon" href="../resources/image/logo.jpg" />
<link href="../resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

</head>

<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
  		<h2>深圳市福米珠宝有限公司</h2>
        <!-- <img alt="Brand" src="../resources/image/brand.jpg" style="width:300px;height:70px">  -->     
    </div>
  </div>
</nav>
<div class="container">
<div class="jumbotron">
 <div class="row" >
 
  <div class="col-xs-4 col-md-4">
    <a href="${pageContext.request.contextPath}/jewel/mainpage?type=1" class="thumbnail">
      <img src="../resources/image/p1.jpg" alt="3D硬千足金" class="img-rounded" >
    </a>
  </div>
  <div class="col-xs-4 col-md-4">
    <a href="${pageContext.request.contextPath}/jewel/mainpage?type=2" class="thumbnail">
      <img src="../resources/image/p2.jpg" alt="珠宝类" class="img-rounded">
    </a>
  </div>
  <div class="col-xs-4 col-md-4">
    <a href="${pageContext.request.contextPath}/jewel/mainpage?type=3" class="thumbnail">
      <img src="../resources/image/p3.jpg" alt="闪沙系列" class="img-rounded">
    </a>
  </div>
  </div>
</div>
</div>

</body>
</html>
