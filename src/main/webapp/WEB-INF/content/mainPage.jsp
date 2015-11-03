<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../resources/css/layout.css" type="text/css" media="screen" />
<link rel="stylesheet" href="../resources/css/jquery.spinner.css" type="text/css" media="screen" />
<link href="../resources/css/pagination.css" rel="stylesheet">
<!--[if lt IE 9]>
	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

<%@include file="header.jsp"%>

<aside id="sidebar" class="column">
	<c:forEach items="${groupList}" var="typeGroup" varStatus="status">
		<h2>
			<span class="label label-primary"
				style="font-size: 55%;margin-left: 5%;"><a style="color:#ffffff" href="${pageContext.request.contextPath}/jewel/mainpage?type=${typeGroup.jewelType.typeid}">${typeGroup.jewelType.typename}</a></span>
		</h2>
		<ul class="toggle">
			<c:forEach items="${typeGroup.subTypeList}" var="subtype">
				<li class="icn_tags" ><a href="${pageContext.request.contextPath}/jewel/mainpage?type=${subtype.subtypeid}">${subtype.subtypename }</a></li>
			</c:forEach>
		</ul>
	</c:forEach>

</aside>


<section id="main" class="column">
	
	<div class="container" style="width:100%;">
		<div class="jumbotron">
			<form name="con">
				<div class="row" align="center">
					<div class="col-lg-3">
						<div class="input-group input-group-sm">
							<span class="input-group-addon">款号</span> <input type="text"
								name="jewelname" id="jewelname" class="form-control"
								placeholder="例如：JD1085">
						</div>
					</div>
					<div class="col-lg-3">
						<div class="input-group input-group-sm">
							<span class="input-group-addon">金重(g)</span> <input type="text"
								name="minWeight" id="minWeight" class="form-control"
								placeholder="最小值"><span class="input-group-addon">-</span><input type="text"
								name="maxWeight" id="maxWeight" class="form-control"
								placeholder="最大值">
						</div>
					</div>
										
					<div class="col-lg-3">
						<button id="quickSearch" type="button" class="btn btn-default">搜索</button>
					</div>
				</div>
			</form>
		</div>

	<!-- 检索结果显示 -->
  <div id="resultlist">	
<%-- 	<div class="row">	
	<c:if test="${empty jewelList}"><h2><span style="margin-left:10%;" class="label label-danger">对不起，暂无数据！</span></h2></c:if>
		
		<c:forEach items="${jewelList}" var="jewel" >	
			<div class="col-sm-3 col-md-3">
   				 <div class="thumbnail">
     				<img  src='#' onError="this.src='../resources/image/nopic1.jpg'" alt="Generic placeholder thumbnail" style="width: 220px; height: 150px;">
     			 <div class="caption">
       	 			<p style="width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
       	 			名称：${jewel.jewelname }
       	 			<br/>金重：${jewel.weight }g<br/>
       	 			件数：<input type="text" class="spinner"/>库存(${jewel.storage }件)</br>
       	 			
       	 			</p>
       	 			<p><a href="#" target="_blank" class="btn btn-primary" role="button">
       	 			<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>加入购物车</a>&nbsp;&nbsp;&nbsp;
       	 			<a href="#" target="_blank" class="btn btn-primary" role="button">
       	 			<span class="glyphicon glyphicon-heart" aria-hidden="true">收藏</span></a>
       	 			</p>
     	 		</div>
    			</div>
  			</div>
  		</c:forEach>
  	
  	</div> --%>

	</div>
		<!-- 翻页插件的显示 -->
		<div class="col-lg-12" align="center">
			<hr>
			<div id="Pagination" class="pagination "></div>
		</div> 
	</div>
	
</section>

<!-- Modal -->
<div class="modal fade" id="jewelDetailModal" tabindex="-1" role="dialog" aria-labelledby="modelLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">   
    </div>
  </div>
</div>


</div>


<%@include file="footer.jsp"%>
<script src="../resources/js/hideshow.js" type="text/javascript"></script>
<script src="../resources/js/jquery.spinner.js" type="text/javascript"></script>
<script src="../resources/js/jquery.pagination.js" type="text/javascript"></script> 

<script type="text/javascript">  
//加入购物车数字加减插件
/* $().ready(function(){
	$('.spinner').spinner(); 
}); */
var jewelname;
var minWeight;
var maxWeight;
$("#quickSearch").click(function(){	
	getDataList(0);
});

var pagenow = 0;
var pagesize=16;
$(window).load(function(){
	getDataList(pagenow); 
});
 
function getDataList(index){  
	var jewelname=$("#jewelname").val();
	var minWeight=$("#minWeight").val();
	var maxWeight=$("#maxWeight").val();
	//alert(jewelname+minWeight+maxWeight);
	$.ajax({  
        type:"get",
        url:"${pageContext.request.contextPath}/jewel/conditionSearchResult",   
        dataType:"json",
        contentType: 'application/json',
        data:{  
            styleNo:jewelname,  
            minWeight:minWeight,
            maxWeight:maxWeight,
            type:'${type}',
            pagenow:index,
            pagesize:pagesize,
            
        },
        success:function(data) { 
				var jewelList=data.jewelList;
     			$("#resultlist").html(" ");
     			//alert("hello"+jewelList.length);
     			var str='<div class="row">';
    			$( 'html, body' ).animate( { scrollTop: 0 }, 0 );
    			if(jewelList.length==0) str +='<h2><span style="margin-left:10%;" class="label label-danger">对不起，暂无数据！</span></h2></div>';
    			else{
    				for(var i=0;i<jewelList.length;i++){
    					str+='<div class="col-sm-3 col-md-3"><div class="thumbnail">'
    	     				+'<a  value="'+jewelList[i].styleno +'" href="${pageContext.request.contextPath}/jewel/jewelDetail?styleno='+jewelList[i].styleno +'" data-toggle="modal" data-target="#jewelDetailModal"><img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno='+jewelList[i].styleno+'" onError="this.src=\'../resources/image/nopic1.jpg\'" alt="Generic placeholder thumbnail" style="width: 220px; height: 150px;"></a>'
    	     			 +'<div class="caption"><p style="width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">'
    	       	 			+'款号：'+jewelList[i].styleno +'<br/>名称：'+jewelList[i].jewelname +'<br/>金重：'+jewelList[i].weight+'g<br/>'
    	       	 			+'件数：<input type="text" class="spinner"/>库存('+jewelList[i].storage +'件)</br>'
    	       	 			+'</p><p><button id="shopcart" value="'+jewelList[i].styleno+'" class="btn btn-primary">'
    	       	 			+'<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>加入购物车</button>&nbsp;&nbsp;&nbsp;'
    	       	 			+'<button id="collection" value="'+jewelList[i].styleno+'" class="btn btn-primary" role="button">'
    	       	 			+'<span class="glyphicon glyphicon-heart" aria-hidden="true">收藏</span></button>'
    	       	 			+'</p></div></div></div>'
        			}
    			}
    			
    			$("#resultlist").html(str); 
    			//数字加减插件
    			$('.spinner').spinner();   
    			//加入购物车
    			$("button[id=shopcart]").click(function(){
    				var styleno=$(this).attr("value");    				
    				var count=$(this).parent().prev().children("div").children("input").val();
    				$.ajax({  
    			        url:"${pageContext.request.contextPath}/jewel/shopcart",  
    			        dataType:"json",
    			        data:{     			        
    			            styleno:styleno,
    			            count:count
    			        },
    			        success:function(data) {
    			        	var result=data.result;
    			        	var cartCount=data.cartCount;
    			        	if(result=="success"){
    			        		$("#cartCount").html('<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>购物车('+cartCount+")");
    			        		alert("添加购物车成功！");
    			        		
    			        	}else alert("购物车添加失败！");
    			        },
    			        error:function(){
							alert("购物车添加失败！");
						}
    				});
    				
    			});
    			//添加收藏事件
    			$("button[id=collection]").click(function(){
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
    			        	
    			        	
    			        },
    			        error:function(){
							alert("收藏夹添加失败！");
						}
    				});
    				
    			});
    			
    			var total=data.resultCount;
    			 //分页-只初始化一次  
    		    if($("#Pagination").html()==""){  
    		    	// 创建分页 
    		    	 if(total<=16){
    		    		$("#Pagination").html("<div></div>");
    		    	}else{ 
    		    		$("#Pagination").pagination(total, {
    			    		num_edge_entries: 2, //边缘页数
    			    		num_display_entries: 4, //主体页数				    		
    			    		callback: pageselectCallback,
    			    		items_per_page: pagesize, //每页显示1项
    			    		prev_text: "<前一页",
    			    		next_text: "后一页>"
    			    	});  
    		    	}			    	  			    
    		    }/* else{
    				str=str+'<div class="panel panel-default"> <div class="panel-body"> <span class="label label-danger"><strong>对不起，没有找到相应的记录！</strong></span> </div> </div>';
            		$("#resultlist").html(str);  
            	} */	
            
        }});          
        function pageselectCallback(page_index){ 
            getDataList(page_index);  
            return false;
        } 
    } 
//解决模态框只加载一次数据的问题
$("#jewelDetailModal").on("hidden.bs.modal", function() {
    $(this).removeData("bs.modal");
});


</script>
</body>
</html>
