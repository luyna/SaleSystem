<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link href="../resources/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<div class="page-content">
	<%-- <div class="page-header">
			<div class="alert alert-block alert-success">
				<i class="icon-ok green"></i> ${jewel.jewelname }
			</div>
	</div> --%>
	<!-- /.page-header -->
		
		 <div class="col-sm-6 col-md-6">
   				 <div class="thumbnail">
     				<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno=${jewel.styleno }" onError="this.src='../resources/image/nopic1.jpg'" 
     				alt="Generic placeholder thumbnail" style="width: 220px; 
     				height: 300px;">
     		      </div>
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<!-- PAGE CONTENT BEGINS -->
			<table class="table table-striped table-bordered table-hover">
			<caption class="text-center"><h3><span style="word-wrap: break-word;
				word-break: break-all;" class="label label-primary">
				${jewel.jewelname }</span></h3></caption> 
				<tbody data-link="row" class="rowlink">
					<tr>
						<td style="width=10%">类别</td>
						<td>${jewel.subtype.subtypename }</td>
					</tr>
					<tr>
						<td>款号</td>
						<td>${jewel.styleno }</td>
					</tr>
					<tr>
						<td>金重</td>
						<td>${jewel.weight }克</td>
					</tr>
					<tr>
						<td>成色</td>
						<td>${jewel.fineness }</td>
					</tr>
					<tr>
						<td>规格</td>
						<td>${jewel.specification }</td>
					</tr>
					<tr>
						<td>配件</td>
						<td>${jewel.accessory }</td>
					</tr>
					<tr>
						<td>配件价格</td>
						<td>${jewel.accessoryprice }元</td>
					</tr>
					<tr>
						<td>库存</td>
						<td>${jewel.storage }件</td>
					</tr>
					<tr>
						<td>日期</td>
						<td><fmt:formatDate value="${jewel.time }" type="date" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<td>套件</td>
						<td>${jewel.suite }</td>
					</tr>
					
					<tr>
						<td>说明</td>
						<td>${jewel.instruction }</td>
					</tr>
					<tr>
						<td>备注</td>
						<td>${jewel.remark }</td>
					</tr>

				</tbody>
			</table>
			<button type="button"  class="btn btn-primary" data-dismiss="modal" >关闭</button>        
		
		</div>

			<!-- /row -->
			 <div class="modal-footer" align="center" >
        		      <%-- <button id="shopcart" value="${collection.jewel.styleno }" class="btn btn-primary">
    	       	 			    	<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>加入购物车</button>&nbsp;&nbsp;&nbsp;
    	       	 			    	<button id="collection" value="${collection.jewel.styleno }" class="btn btn-primary" role="button">
    	       	 			    	<span class="glyphicon glyphicon-heart" aria-hidden="true">取消收藏</span></button> --%>
			
     		 </div> 
			<!-- PAGE CONTENT ENDS -->


</div>
<!-- /.page-content -->
<script type="text/javascript">
 	//$(".modal-content").html(" ");
</script>
</body>
</html>

