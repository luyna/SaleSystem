<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录失败</title>
<link rel="shortcut icon" href="./image/home.png" />
<%
session.removeAttribute("username");
session.removeAttribute("password");
session.removeAttribute("userinforlevel");

%>
</head>
<body>  
    <div align="CENTER">  
        <h2>注销成功！</h2>  
        <hr>  
        <a href="index.jsp" >登录军事装备查询系统></a>  
        <a href="adminIndex.jsp" >登录军事装备后台管理系统></a>  
    </div>  
</body>  
</html>