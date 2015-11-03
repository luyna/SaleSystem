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
<section id="main" class="column" >
<div class="container" style="margin-left:1%;margin-top:6%;width:100%">
	<div class="row">
		<h2><span class="label label-primary">未审核订单</span></h2>
	</div>
	<div class="row">
		<div class=" col-lg-12 col-md-12">
	<table class="table table-bordered table-striped table-hover">
      <thead>
        <tr>
          <th style="width:15%;">订单编号</th>
          <th>总件数</th>
          <th>总重量（克）</th>
          <th>配件价格（元）</th>
          <th>付款类型</th>         
          <th>下单日期</th>
          <th style="width:10%;">备注</th>
          <th>订单详情</th>
          <th>状态</th>
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
          <td><fmt:formatDate value="${item.ordertime}" type="date" pattern="yyyy-MM-dd"/></td>  
          <td>${item.remark}</td>     
          <td><a href="${pageContext.request.contextPath}/jewel/adminOrderDetail?&orderid=${item.orderid }&companyid=${item.companyid }&username=${item.username}" target="_blank" class="btn btn-primary">
          <span class="glyphicon glyphicon-folder-open" aria-hidden="true">查看详情 </span></a>
          </td>
           <td><select id="status" class="form-control">
 				<option value="待审核" >待审核</option>
  				<option  value="审核通过">审核通过</option>
  				<option  value="已取消">已取消</option>
		 </select></td>
          <td><button id="checkOrderButton" value="${item.orderid }"  class="btn btn-primary">
          <span class="glyphicon glyphicon-ok" aria-hidden="true">确认</span></button>
          </td>
        </tr>
      </c:forEach>  
      </tbody>
    </table>
    </div>
    </div>
	<div id="black"></div>
	
</div>
</section>


<%@include file="footer.jsp"%>
<script src="../resources/js/smartpaginator.js" type="text/javascript"></script> 
<script type="text/javascript">
$("button[id=checkOrderButton]").click(function(){
	var status=$(this).parent().prev().children("#status").children(":selected").val();
	var orderid=$(this).attr("value");
	/* alert($(this).parent().parent().parent().attr("id"));
	alert($(this).parent().parent().attr("style")); */
	var $wholeNode=$(this).parent().parent();
	//alert(orderid);
	$.ajax({
		url:"${pageContext.request.contextPath}/jewel/checkOrder",
		type:"post",
		dataType:"json",
		data:{
			orderid:orderid,
			status:status
		},
		success:function(data){
			var result=data.result;			
			if(result=="1") {
				alert("状态修改成功！");
				if(status!="待审核") {
					/* alert(status);
					alert($(this).parent().parent().parent().attr("id")); */
					$wholeNode.remove();
				}
			}
			else alert("状态修改失败！");
		},
		error:function(){
			alert("状态修改失败!");
		}
	}); 
});


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
    window.location.href="${pageContext.request.contextPath}/jewel/toCheckOrder?pagenow="+current_page+"&pagesize="+pagesize;
} 



</script>

</body>
</html>
