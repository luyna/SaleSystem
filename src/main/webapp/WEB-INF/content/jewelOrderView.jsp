<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="../resources/css/smartpaginator.css" rel="stylesheet"> 

 
<%@include file="header.jsp"%>
<style type="text/css">
.table > thead > tr > th, 
.table > tbody > tr > th, 
.table > thead > tr > td, 
.table > tbody > tr > td{
	word-wrap: break-word;
	word-break: break-all;
	text-align:center;
	vertical-align: baseline;
}
</style>
<div class="container">
	<div class="row">
		<h3><span class="label label-primary">我的订单</span></h3>
	</div>
	<div class="row">
		<div class=" col-lg-12 col-md-12">
	<table class="table table-bordered table-striped table-hover">
      <thead>
        <tr>
          <th>订单编号</th>
          <th>总件数</th>
          <th>总重量（克）</th>
          <th>配件价格（元）</th>
          <th>付款类型</th>
          <th>状态</th>
          <th>下单日期</th>
          <th style="width:15%;">备注</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody id="carttoorder">
      
      <c:forEach items="${orderlist}" var="item">
        <tr style="vertical-align: baseline;">
          <td>${item.orderid }</td>
          <td>${item.totalnum }</td>
          <td>${item.totalweight }</td>
          <td>${item.accessoryprice}</td>
          <td >${item.paytype }</td>
          <td>${item.status}</td>
          <td><fmt:formatDate value="${item.ordertime}" type="date" pattern="yyyy-MM-dd"/></td>  
          <td>${item.remark}</td>     
          <td><a href="${pageContext.request.contextPath}/jewel/orderDetail?&orderid=${item.orderid }&companyid=${item.companyid }"  class="btn btn-primary">
          <span class="glyphicon glyphicon-folder-open" aria-hidden="true">查看详情 </span></a>
          </td>
        </tr>
      </c:forEach>  
      </tbody>
    </table>
    </div>
    </div>
	<div id="black"></div>
	
</div>


<%@include file="footer.jsp"%>
<script src="../resources/js/smartpaginator.js" type="text/javascript"></script> 
<script type="text/javascript">

//翻页功能
 var len=${totalsize};
var pagenow= ${pagenow};
//alert(pagenow+1);
var pagesize=${pagesize};

$('#black').smartpaginator({ 
	totalrecords: len, 
    recordsperpage: pagesize, 
    next: '下一页', 
    prev: '上一页', 
    first: '首页', 
    last: '末页', 
    go: '前往',
    theme: 'black', 
    initval:pagenow+1, //翻页高亮显示的当前页码
    onchange: onPageChange
    
    });
    
function onPageChange(newPageValue) {
    current_page = newPageValue-1;
    //alert(newPageValue);
    window.location.href="${pageContext.request.contextPath}/jewel/jewelOrderView?pagenow="+current_page+"&pagesize="+pagesize;
} 



</script>

</body>
</html>
