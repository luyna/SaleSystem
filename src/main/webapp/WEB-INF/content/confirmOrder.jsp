<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../resources/css/jquery.spinner.css"
	type="text/css" />
<!-- <link href="../resources/css/smartpaginator.css" rel="stylesheet"> -->


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
<div class="container">
	<div class="row">
		<h3>
			<span class="label label-primary">我的金店</span> <a href="${pageContext.request.contextPath}/user/toAddBranchCompany" style="font-size:16px">添加地址</a>
		</h3>
	    
	</div>

	<div role="tabpanel">
		<!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist" id="myTab">
			<li id="0" role="presentation" class="active"><a href="#home"
				aria-controls="home" role="tab" data-toggle="tab">总店</a></li>
			<c:forEach items="${companyList}" var="company">
				<li id="${company.companyid }" role="presentation"><a href="#address${company.companyid }"
					aria-controls="profile" role="tab" data-toggle="tab">${company.companyname }</a></li>
			</c:forEach>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="home">
				<h3>
					收货地址： <span class="label label-default">${user.companyname }&nbsp;&nbsp;&nbsp;&nbsp;
						${user.address }&nbsp;&nbsp;&nbsp;&nbsp;${user.userrelname }&nbsp;&nbsp;&nbsp;&nbsp;手机号：${user.phonenum }</span>
				</h3>
				<a href="${pageContext.request.contextPath}/user/toAlterUserInfo">修改地址</a>
			</div>
			
			<c:forEach items="${companyList}" var="company1">
				<div role="tabpanel" class="tab-pane fade " id="address${company1.companyid }">
					<h3>
						收货地址： <span class="label label-default">${company1.companyname }&nbsp;&nbsp;&nbsp;&nbsp;
							${company1.address }&nbsp;&nbsp;&nbsp;&nbsp;${company1.relationuser }&nbsp;&nbsp;&nbsp;&nbsp;手机号：${user.phonenum }</span>
					</h3>
					<a href="${pageContext.request.contextPath}/user/toAlterBranchCompany?companyid=${company1.companyid }">修改地址</a>
				</div>
			</c:forEach>
			
		</div>
	</div>
	<div class="row">
		<h3>
			<span class="label label-primary">支付方式：</span>
		</h3>
		<div class="radio">
			<label> <input type="radio" name="optionsRadios"
				id="来款结价" value="option1" checked>来款结价
			</label>
		</div>
		<div class="radio">
			<label> <input type="radio" name="optionsRadios"
				id="来料结算" value="option2">来料结算（ 1.为保证成色，以提纯料重为准，
				2.请按照订单总金重来料。（网站金重为大概重量，以业务员统计总金重为准））
			</label>
		</div>
	</div>

	<div class="row">
		<h3>
			<span class="label label-primary">订单备注：</span>
		</h3>
		<textarea id="remark" class="form-control" rows="3"></textarea>
	</div>

	<div class="row">
		<h3>
			<span class="label label-primary">订单清单</span>
		</h3>
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
						<th>重量</th>
						<th>数量</th>
						<th>总重（克）</th>
						<th>配件名称</th>
						<th>配件单价</th>
						<th>配件总价（元）</th>
					</tr>
				</thead>
				<tbody id="carttoorder">

					<c:forEach items="${shopCartList}" var="item">
						<tr style="vertical-align: baseline;">
							<td scope="row">
							<a  href="${pageContext.request.contextPath}/jewel/jewelDetail?styleno=${item.jewel.styleno }" 
							data-toggle="modal" data-target="#jewelDetailModal">
							<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno=${item.jewel.styleno }" 
							onError="this.src='../resources/image/nopic1.jpg'"
								alt="Generic placeholder thumbnail"
								style="width: 60px; height: 70px;"></a>
							</td>
							<td id="styleno" value="${item.jewel.styleno }">${item.jewel.styleno }</td>
							<td>${item.jewel.jewelname }</td>
							<td>${item.jewel.specification }</td>
							<td>${item.jewel.weight }克</td>
							<td id="cartNumOnly" value="${item.jewelnum }"><span
								class="label label-primary">${item.jewelnum }件</span><span
								class="label label-default">(库存${item.jewel.storage }件)</span></td>
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
	<span style="margin-left: 65%" class="label label-primary">总件数：${totalNum }件
		金重总计：${totalWeight }克 配件总金额：￥${totalprice }元 </span>
	<!-- <div id="black"></div> -->
	<div class="row">
		<a href="${pageContext.request.contextPath}/jewel/shopcartDetail"  class="btn btn-primary"
			style="margin-left: 40%;display:inline-block">
			<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true">返回购物车修改</span>
		</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="submitorder" class="btn btn-primary"
			style="display:inline-block">
			<span class="glyphicon  glyphicon-ok" aria-hidden="true">提交订单</span>
		</button>
	</div>


<!-- Modal -->
<div class="modal fade" id="jewelDetailModal" tabindex="-1" role="dialog" aria-labelledby="modelLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">   
    </div>
  </div>
</div>
</div>


<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.spinner.js" type="text/javascript"></script>
<!-- <script src="../resources/js/smartpaginator.js" type="text/javascript"></script>  -->
<script type="text/javascript">
	//提交订单事件
	$("#submitorder").click(
			function() {
				var companyid=$("#myTab").children("li[class=active]").attr("id");
				var pay=$('input[type="radio"][name="optionsRadios"]:checked').attr("id");
				var remark=$("#remark").val();
				/* $.post(
					"${pageContext.request.contextPath}/jewel/orderSubmit",				        
				     {     			        
				            companyid:companyid,
				            paytype:pay,
				            remark:remark,
				            totalnum:"${totalNum}",
				            totalweight:"${totalWeight}",
				            accessoryprice:"${totalprice}"				            				            
				     }
				     
				); */
				var param="companyid="+companyid+"&paytype="+encodeURI(encodeURI(pay))+"&remark="+encodeURI(encodeURI(remark))+"&totalnum=${totalNum}&totalweight=${totalWeight}&accessoryprice=${totalprice}";
				window.location.href="${pageContext.request.contextPath}/jewel/orderSubmit?"+param;
				
			});

	$('#myTab a').click(function(e) {
		e.preventDefault()
		$(this).tab('show')
	})
	
//解决模态框只加载一次数据的问题
$("#jewelDetailModal").on("hidden.bs.modal", function() {
    $(this).removeData("bs.modal");
});
</script>
</body>
</html>
