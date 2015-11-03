<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../resources/css/jquery.spinner.css" type="text/css"  />
<!-- <link href="../resources/css/smartpaginator.css" rel="stylesheet"> -->

 
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
		<h3><span class="label label-primary">购物车商品</span></h3>
	</div>
	<div class="row">
		<div class=" col-lg-12 col-md-12">
	<table class="table table-bordered table-striped table-hover">
      <thead>
        <tr>
          <!-- <th><div class="checkbox">
        	<label>
          		<input type="checkbox" id="selectall">全选
        	</label>
     	 </div></th> -->
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
          <th>操作</th>
        </tr>
      </thead>
      <tbody id="carttoorder">
      
      <c:forEach items="${shopCartList}" var="item">
        <tr style="vertical-align: baseline;">
          <!-- <td>
          <div class="checkbox">
       		 <label>
          		<input type="checkbox">
        	 </label>
      	  </div></td> -->
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
          <td id="cartNumOnly" value="${item.jewelnum }"><input type="text" class="spinner"/><span id="storage" value="${item.jewel.storage }">库存(${item.jewel.storage }件)</span></td>
          <td><fmt:formatNumber value="${item.jewelnum*item.jewel.weight }" pattern="#.##"/>克</td>
          <td>${item.jewel.accessory }</td>
          <td>${item.jewel.accessoryprice }元</td>
          <td><fmt:formatNumber value="${item.jewel.accessoryprice *item.jewelnum }" pattern="#.##"/>元</td>          
          <td><button id="deletebutton" value="${item.jewel.styleno }" class="btn btn-primary"><span class="glyphicon glyphicon-trash" aria-hidden="true">删除 </span></button>
          <button id="collectionbutton" value="${item.jewel.styleno }" class="btn btn-primary" >
       	 			<span class="glyphicon glyphicon-heart" aria-hidden="true">收藏</span></button></td>
        </tr>
      </c:forEach>  
      </tbody>
    </table>
    </div>
    </div>
    <span style="margin-left:65%" class="label label-primary">总件数：${totalNum }件   金重总计：${totalWeight }克   配件总金额：￥${totalprice }元 </span>
	<!-- <div id="black"></div> -->
	<button id="confirmorder" class="btn btn-primary" style="margin-left:50%">
       	 			<span class="glyphicon  glyphicon-ok" aria-hidden="true">确认订单</span></button>

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
//购物数字加减组件
$().ready(function(){
	$('.spinner').spinner(); 
});
//解决模态框只加载一次数据的问题
$("#jewelDetailModal").on("hidden.bs.modal", function() {
    $(this).removeData("bs.modal");
});
//翻页功能
/* var len=${totalsize};
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
    //翻页时将修改的数据保存到数据库中
    var $lines=$("tbody").children();
    for(var i=0;i<$lines.length();i++){
    	var styleno=$lines.eq(i).children("#styleno").val();
    	var cartNumOnly=$lines.eq(i).children("#cartNumOnly").attr("value");
    	alert(styleno+","+cartNumOnly);
    }
    
    //alert(newPageValue);
    window.location.href="${pageContext.request.contextPath}/jewel/shopcartDetail?pagenow="+current_page+"&pagesize="+pagesize;
} */

//删除按钮功能
$("button[id=deletebutton]").click(function(){
	if(confirm("确定从购物车中删除该商品？")==true){
		var styleno=$(this).attr("value");
		window.location.href="${pageContext.request.contextPath}/jewel/shopcartDelete?styleno="+styleno;
	}
});

//收藏按钮功能
$("button[id=collectionbutton]").click(function(){
	var styleno=$(this).attr("value");
	$.ajax({ 
        url:"${pageContext.request.contextPath}/jewel/collection",  
        dataType:"json",
        data:{     			        
            styleno:styleno,
        },
        success:function(data) {
        	var notExist=data.result;
        	if(notExist=="notExist"){
        		alert("添加收藏夹成功！");
        	}else{
        		alert("已经在收藏夹！");
        	}
        	
        	
        }
	});
});
//确认订单事件
$("#confirmorder").click(function(){
	var $lines=$("tbody[id=carttoorder]").children("tr");
	var param="";
	var storageNum=true;
    for(var i=0;i<$lines.length;i++){
    	var styleno=$lines.eq(i).children("#styleno").attr("value");
    	var cartNumOnly=$lines.eq(i).children("#cartNumOnly").attr("value");
    	var storage=$lines.eq(i).children("#cartNumOnly").children("#storage").attr("value");
    	//alert(styleno+","+cartNumOnly+","+storage);
    	if(parseInt(storage)<parseInt(cartNumOnly)) storageNum=false;
    	param += styleno+","+cartNumOnly+"]";
    }
    
    if(storageNum==false){
    	if(confirm("购物车中有商品库存不够，超出库存商品将会作为期货处理！是否确定订单？")==false){
    		return;
    		//window.location.href="${pageContext.request.contextPath}/jewel/orderConfirm?param="+param;
    	}
    }
	window.location.href="${pageContext.request.contextPath}/jewel/orderConfirm?param="+param;
    
});

//全选复选框事件
/* function selectAll(){
    $("INPUT[type='checkbox']").each( function() {
        $(this).attr('checked', true);
        $(this).parent().addClass('checked');
    });
}
 
function invertSelect(){
    $("INPUT[type='checkbox']").each( function() {
    if($(this).attr('checked')) {
        $(this).attr('checked', false);
        $(this).parent().removeClass('checked');
    } else {
        $(this).attr('checked', true);
            $(this).parents().addClass('checked');
    }
    });
}

$("#selectall").click(function(){
	invertSelect();
});
$("#selectall").unchecked(function(){
	invertSelect();
}); */


</script>

</body>
</html>
