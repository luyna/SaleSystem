<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../resources/css/jquery.spinner.css"
	type="text/css" media="screen" />
<link href="../resources/css/smartpaginator.css" rel="stylesheet">

<%@include file="header.jsp"%>
<div class="container" >
	<div class="row">
		<h3>
			<span class="label label-primary">我的收藏夹</span>
		</h3>
	</div>
	
		<!-- 结果显示 -->
		<div id="resultlist">
			<div class="row">
				<c:if test="${empty collectionList}">
					<h2>
						<span style="margin-left: 10%;" class="label label-danger">您还未添加任何收藏！</span>
					</h2>
				</c:if>

				<c:forEach items="${collectionList}" var="collection">
					<div class="col-sm-3 col-md-3">
						<div class="thumbnail">
							<a  href="${pageContext.request.contextPath}/jewel/jewelDetail?styleno=${collection.jewel.styleno }" data-toggle="modal" data-target="#jewelDetailModal">
							<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno=${collection.jewel.styleno }" onError="this.src='../resources/image/nopic1.jpg'"
								alt="Generic placeholder thumbnail"
								style="width: 220px; height: 150px;"></a>
							<div class="caption">
								<p style="width: 240px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
									款号：${collection.jewel.styleno } <br />
									名称：${collection.jewel.jewelname } <br />
									金重：${collection.jewel.weight }g<br /> 
									件数：<input type="text" class="spinner" />
									库存(${collection.jewel.storage }件)</br>

								</p>
								<p>
									<button id="shopcart" value="${collection.jewel.styleno }" class="btn btn-primary">
    	       	 			    	<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>加入购物车</button>&nbsp;&nbsp;&nbsp;
    	       	 			    	<button id="collection" value="${collection.jewel.styleno }" class="btn btn-primary" role="button">
    	       	 			    	<span class="glyphicon glyphicon-heart" aria-hidden="true">取消收藏</span></button>
									
								</p>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>


		</div>
		<!-- 翻页插件的显示 -->
		<div id="black"></div>
		<div class="row">
			<a href="${pageContext.request.contextPath}/jewel/homepage" class="btn btn-primary"
				style="margin-left: 40%; display: inline-block"> <span
				class="glyphicon  glyphicon-hand-left" aria-hidden="true">再去逛一逛</span>
			</a>
		</div>
		
		<!-- Modal -->
	<div class="modal fade" id="jewelDetailModal" tabindex="-1" role="dialog" aria-labelledby="modelLabel" aria-hidden="true">
 		 <div class="modal-dialog">
    		<div class="modal-content"> </div>
  		</div>
	</div>
	
</div>



<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.spinner.js" type="text/javascript"></script>
<script src="../resources/js/smartpaginator.js" type="text/javascript"></script>
<script type="text/javascript">
	//数字加减插件
	$('.spinner').spinner();
	//加入购物车
	$("button[id=shopcart]").click(
					function() {
						var styleno = $(this).attr("value");
						var count = $(this).parent().prev().children("div")
								.children("input").val();
						$.ajax({
								url : "${pageContext.request.contextPath}/jewel/shopcart",
								dataType : "json",
								data : {
									styleno : styleno,
									count : count
								},
								success : function(data) {
									var result = data.result;
										var cartCount = data.cartCount;
										if (result == "success") {
											$("#cartCount").html(
											'<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>购物车('
											+ cartCount+ ")");
											alert("添加购物车成功！");

										} else
											alert("购物车添加失败！");
									},
									error:function(){
										alert("购物车添加失败！");
									}
								});

					});
	//取消收藏事件
	$("button[id=collection]").click(function() {
		var styleno = $(this).attr("value");
		$.ajax({
			url : "${pageContext.request.contextPath}/jewel/collectionCancel",
			dataType : "json",
			data : {
				styleno : styleno,
			},
			success : function(data) {
				alert("从收藏夹中删除成功！");
				window.location.href = "${pageContext.request.contextPath}/jewel/collectionView";
			},
			error:function(){
				alert("从收藏夹中删除失败！");
			}
		});

	});
	//翻页功能
	var len = ${totalsize};
	var pagenow = ${pagenow};
	//alert(pagenow+1);
	var pagesize = ${pagesize};

	$('#black').smartpaginator({
		totalrecords : len,
		recordsperpage : pagesize,
		next : '下一页',
		prev : '上一页',
		first : '首页',
		last : '末页',
		go : '前往',
		theme : 'black',
		initval : pagenow + 1, //翻页高亮显示的当前页码
		onchange : onPageChange

	});

	function onPageChange(newPageValue) {
		current_page = newPageValue - 1;
		//alert(newPageValue);
		window.location.href = "${pageContext.request.contextPath}/jewel/collectionView?pagenow="
				+ current_page + "&pagesize=" + pagesize;
	}
	
	//解决模态框只加载一次数据的问题
	 $("#jewelDetailModal").on("hidden.bs.modal", function() {
	    $(this).removeData("bs.modal");
	}); 

</script>
</body>
</html>
