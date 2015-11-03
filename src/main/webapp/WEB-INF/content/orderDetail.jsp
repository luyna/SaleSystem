<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">


<!-- <link href="../resources/css/smartpaginator.css" rel="stylesheet">  -->
<%@include file="header.jsp"%>
<style type="text/css">
.table>thead>tr>th, .table>tbody>tr>th, .table>thead>tr>td, .table>tbody>tr>td
	{
	word-wrap: break-word;
	word-break: break-all;
	text-align: center;
	vertical-align: baseline;
}
</style>
<div id="print" class="container" style="margin-top:1%">
<div class="container">
	<div class="row">
		<h3>
			订单编号：<span class="label label-default">${orderid }</span>
		</h3>
	</div>
	<div class="row">
		<h3>
			收货地址： <span class="label label-default">${receiveAddress.companyName }&nbsp;&nbsp;&nbsp;&nbsp;
			${receiveAddress.companyAddress }&nbsp;&nbsp;&nbsp;&nbsp;${receiveAddress.userName }&nbsp;&nbsp;&nbsp;&nbsp;手机号：${receiveAddress.userPhone }</span>
		</h3>
	</div>
	

	<div class="row">
		<h3>
			<span class="label label-primary">订购清单</span>
		</h3>
		
		<div class="col-lg-3" >
				<div class="input-group input-group-sm">
					<span class="input-group-addon">类别：</span> 
					<select id="mainkind" class="form-control"> 		
								<option id="0" value="0" >全部</option>				
 								<option id="1" value="1" >3D硬千足金</option>
  								<option id="2" value="2">珠宝类</option>
  								<option id="3" value="3">闪沙系列</option>
		 			</select>
				</div>		
						
		</div>
		<br/><br/>
	</div>
	<div class="row">
		<div class=" col-lg-12 col-md-12">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th>图片预览</th>
						<th>款号</th>
						<th>品名</th>
						<th>规格</th>
						<th>重量（克）</th>
						<th>订购数量</th>
						<th>期货数量</th>
						<th>总重（克）</th>
						<th>配件名称</th>
						<th>配件单价（元）</th>
						<th>配件总价（元）</th>
					</tr>
				</thead>
				<tbody id="orderlist">

					<c:forEach items="${orderDetailList}" var="item">
						<tr style="vertical-align: baseline;">
							<td scope="row">
								<a  href="${pageContext.request.contextPath}/jewel/jewelDetail?styleno=${item.styleno }" 
									data-toggle="modal" data-target="#jewelDetailModal">
								<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno=${item.styleno }" 
									onError="this.src='../resources/image/nopic1.jpg'"
									alt="Generic placeholder thumbnail"
									style="width: 60px; height: 70px;"></a>
							</td>
							<td id="styleno" value="${item.styleno }">${item.styleno }</td>
							<td>${item.jewel.jewelname }</td>
							<td>${item.jewel.specification }</td>
							<td>${item.jewel.weight }克</td>
							<td ><span
								class="label label-primary">${item.jewelnum }件</span>
								（库存：${item.jewel.storage}件）
							</td>
							<td ><span
								class="label label-primary">${item.expectnum }件</span></td>
							<td><fmt:formatNumber value="${item.jewelnum*item.jewel.weight }" pattern="#.##"/>克</td>
							<td>${item.jewel.accessory }</td>
							<td>${item.jewel.accessoryprice }元</td>
							<td><fmt:formatNumber value="${item.jewel.accessoryprice *item.jewelnum }" pattern="#.##"/>元</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- <div id="black"></div> -->
	<div class="row">
		<input type="button"  onclick=" a()" value="打印" class="btn btn-primary" style="margin-left: 30%"/>
		<a href="${pageContext.request.contextPath}/jewel/jewelOrderView"  class="btn btn-primary"
			style="display:inline-block">
			<span class="glyphicon  glyphicon-hand-left" aria-hidden="true">返回查看历史订单</span>
		</a>
	</div>

<!-- Modal -->
<div class="modal fade" id="jewelDetailModal" tabindex="-1" role="dialog" aria-labelledby="modelLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">   
    </div>
  </div>
</div>



</div>
</div>

<%@include file="footer.jsp"%>

<!-- <script src="../resources/js/smartpaginator.js" type="text/javascript"></script>  -->
<script src="http://code.jquery.com/jquery-migrate-1.1.0.js"></script>
<script language="javascript" src="../resources/js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript">
//解决模态框只加载一次数据的问题
$("#jewelDetailModal").on("hidden.bs.modal", function() {
    $(this).removeData("bs.modal");
});
$().ready(function(){
	var kindid="${kindid}";
	if(kindid!=null && kindid!=""){
		$("#mainkind").children("#"+kindid).attr("selected","selected");
	}
	$("#mainkind").change(function(){
		//alert("test");
		var kindid=$(this).children(":selected").attr("value");
		var orderid="${orderid}";
		//alert(kindid+","+orderid);
		window.location.href="${pageContext.request.contextPath}/jewel/orderDetail?&orderid=${orderid }&companyid=${companyid }&kindid="+kindid;	
	});
});

//翻页功能
/*  var len=${totalsize};
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
    window.location.href="${pageContext.request.contextPath}/jewel/orderDetail?orderid=${orderid}&companyid=${companyid}&pagenow="+current_page+"&pagesize="+pagesize;
}  */

</script>

<!-- 打印 -->
<script language="javascript">
	function a(){
        $("#print").jqprint({       
                debug: false,//如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false  
                importCSS: false, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）  
                printContainer: true,//表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。  
                operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true  

        });
    }
</script>
</body>
</html>
