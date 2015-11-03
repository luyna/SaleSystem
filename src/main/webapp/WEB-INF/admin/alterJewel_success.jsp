<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link rel="stylesheet" href="../resources/css/ace.minadmin.css" />
<%@include file="header.jsp"%>
<section id="main" class="column" >
<h4 class="alert_info" style="margin-top:80px;">珠宝信息修改成功，
<a href="${pageContext.request.contextPath}/jewel/toAlterJewelSearch" style="color:#E91A1A">继续修改</a></h4>
</section>
<%@include file="footer.jsp"%>
</body>
</html>
