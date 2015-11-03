<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="../resources/css/smartpaginator.css" rel="stylesheet"> 
<!-- 日期选择插件 -->
<link href="../resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
 
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
<div class="container"  style="margin-left:1%;margin-top:6%;width:100%">
	<div class="row">
		<h2><span class="label label-primary">历史订单</span></h2>
	</div>
	<div class="jumbotron">
			<form name="con">
				<div class="row" align="center">
					<div class="col-lg-3">
						<div class="input-group input-group-sm">
							<span class="input-group-addon">用户ID：</span> <input type="text"
								name="username" id="username" class="form-control"
								placeholder="例如：xiaohong123">
						</div>
					</div>
					<div class="col-lg-3">
						<div class="input-group input-group-sm">
							<span class="input-group-addon">订单状态：</span> 
							<select id="orderStatus" class="form-control"> 						
 								<option id="审核通过" value="审核通过" >审核通过</option>
  								<option id="交易成功" value="交易成功">交易成功</option>
  								<option id="已取消" value="已取消">已取消</option>
		 					</select>
							<!-- <input type="text"
								name="orderStatus" id="orderStatus" class="form-control"
								placeholder="例如：交易成功"> -->
						</div><!-- （审核通过，交易成功，已取消）	 -->				
						
					</div>
					<div class="col-lg-4">
						<div class="input-group input-group-sm" >
							<span class="input-group-addon">下单时间</span> <input type="text"
								name="minDate" id="minDate" class="form-control"
								placeholder="最小日期"><span class="input-group-addon">-</span><input type="text"
								name="maxDate" id="maxDate" class="form-control"
								placeholder="最大日期">
						</div>（格式：2015-03-24）
					</div>
										
					<div class="col-lg-2">
						<button id="orderSearchButton" type="button" class="btn btn-default">搜索</button>
					</div>
				</div>
			</form>
		</div>
		
	
	<div class="row">
		<div class=" col-lg-12 col-md-12">
	<table class="table table-bordered table-striped table-hover">
      <thead>
        <tr>
          <th style="width:15%;">订单编号</th>
          <th>用户名</th>
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
          <td>${item.username }</td>
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
 				<option selected="selected" value="${item.status }" >${item.status }</option>
 				<c:if test="${item.status!='审核通过'}"><option id="审核通过" value="审核通过" >审核通过</option></c:if>
  				<c:if test="${item.status!='交易成功'}"><option id="交易成功" value="交易成功">交易成功</option></c:if>
  				<c:if test="${item.status!='已取消'}"><option id="已取消" value="已取消">已取消</option></c:if>
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
<script type="text/javascript" src="../resources/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
//时间选择控件
$('input[id*=Date]').datetimepicker({
    format: 'yyyy-mm-dd',
    todayBtn:true,
    startView:4,
    minView:2,
    maxView:4,
    startView:4,
    todayHighlight:true,
    //initialDate:'2013-09-08',
    autoclose:true, 
    inputMask: true 
});	
</script>
<script type="text/javascript">
$().ready(function(){
	//var username=${username};
	//var orderStatus=${orderStatus};
	//将输入的参数重新设置在输入框中
	$("#username").attr("value","${username}");
	$("#orderStatus").children("#${orderStatus}").attr("selected","selected");
	$("#minDate").attr("value","${minDate}");
	$("#maxDate").attr("value","${maxDate}");
});
//订单搜索按钮
$("#orderSearchButton").click(function(){
	var username=$("#username").val();
	var orderStatus=$("#orderStatus").children(":selected").attr("value");
	var minDate=$("#minDate").val();
	var maxDate=$("#maxDate").val();
	//alert(username+","+orderStatus+","+minDate+","+maxDate);
	window.location.href="${pageContext.request.contextPath}/jewel/toManageOrder?username="
			+username+"&orderStatus="+encodeURI(encodeURI(orderStatus))+"&minDate="+minDate+"&maxDate="+maxDate;
});
//修改订单状态事件
$("button[id=checkOrderButton]").click(function(){
	var status=$(this).parent().prev().children("#status").children(":selected").val();
	var orderid=$(this).attr("value");
	//alert(status);
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
    var username=$("#username").val();
    var orderStatus=$("#orderStatus").val();
    var minDate=$("#minDate").val();
    var maxDate=$("#maxDate").val();
    //alert(newPageValue);
    window.location.href="${pageContext.request.contextPath}/jewel/toManageOrder?username="
		+username+"&orderStatus="+encodeURI(encodeURI(orderStatus))+"&minDate="+minDate
		+"&maxDate="+maxDate+"&pagenow="+current_page+"&pagesize="+pagesize;
} 



</script>

</body>
</html>
