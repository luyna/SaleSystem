<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<%@include file="header.jsp"%>

<div class="container">
	<div align="CENTER">  
        <div class="row">
			<h3><span class="label label-primary">下单成功！</span></h3>
		</div>  
        <hr>  
        <a href="${pageContext.request.contextPath}/jewel/jewelOrderView" >查看订单</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="${pageContext.request.contextPath}/jewel/homepage" >继续选购</a>  
    </div>  
</div>
<%@include file="footer.jsp"%>

<script type="text/javascript">


</script>

</body>
</html>
