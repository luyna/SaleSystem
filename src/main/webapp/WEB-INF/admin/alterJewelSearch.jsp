<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="../resources/css/pagination.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/jquery.spinner.css" type="text/css" media="screen" />
<link href="../resources/css/pagination.css" rel="stylesheet">
<!--[if lt IE 9]>
	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

<%@include file="header.jsp"%>

<section id="main" class="column">
	
	<div class="container" style="width:100%;margin-top:8%">
		<div class="jumbotron ">
			<form name="con">
				<div class="row" align="center">
					<div class="col-lg-3">
						<div class="input-group input-group-sm">
							<span class="input-group-addon">款号</span> <input type="text"
								name="" id="stylenoKeyword" class="form-control"
								placeholder="例如：JD1085">
						</div>
					</div>
										
					<div class="col-lg-3">
						<button id="alterJewelsearch" type="button" class="btn btn-default">搜索</button>
					</div>
				</div>
			</form>
		</div>
		<div id="resultlist"></div>
		<!-- 翻页插件的显示 -->
		<div class="col-lg-12" align="center">
			<hr>
			<div id="Pagination" class="pagination "></div>
		</div> 
	</div>
	
</section>

</div>


<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.pagination.js" type="text/javascript"></script> 
<script type="text/javascript">  

var styleno;

$("#alterJewelsearch").click(function(){	
	getDataList(0);
});

var pagenow =0;
var pagesize=20;

 
function getDataList(index){  
	var styleno=$("#stylenoKeyword").val();
	//alert(styleno);
	$.ajax({  
        type:"get",
        url:"${pageContext.request.contextPath}/jewel/fuzzySearchJewel",   
        dataType:"json",
        data:{  
            styleno:styleno,  
            pagenow:index,
            pagesize:pagesize,           
        },
        success:function(data) { 
				var jewelList=data.jewellist;
     			$("#resultlist").html(" ");
     			//alert("hello"+jewelList.length);
     			var str='<div class="row">';
    			$( 'html, body' ).animate( { scrollTop: 0 }, 0 );
    			if(jewelList.length==0) str +='<h2><span style="margin-left:10%;" class="label label-danger">对不起，暂无数据！</span></h2></div>';
    			else{
    				for(var i=0;i<jewelList.length;i++){
    					str+='<div id="'+jewelList[i].styleno+'" class="col-sm-3 col-md-3"><div class="thumbnail">'
    	     				+'<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno='+jewelList[i].styleno+'" onError="this.src=\'../resources/image/nopic1.jpg\'" alt="Generic placeholder thumbnail" style="width: 200px; height: 180px;">'
    	     			 	+'<div class="caption"><p style="width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">'
    	       	 			+'款号：'+jewelList[i].styleno +'<br/>名称：'+jewelList[i].jewelname +'<br/>金重：'+jewelList[i].weight+'g<br/>'
    	       	 			+'库存：'+jewelList[i].storage +'件</br>'
    	       	 			+'</p><p><a href="${pageContext.request.contextPath}/jewel/toAlterJewelPage?styleno='+jewelList[i].styleno +'" target="_blank" id="jewelEdit" value="'+jewelList[i].styleno+'" class="btn btn-primary">'
    	       	 			+'<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</a>&nbsp;&nbsp;&nbsp;'
    	       	 			+'<button id="jewelDel" value="'+jewelList[i].styleno+'" class="btn btn-primary" role="button">'
    	       	 			+'<span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span></button>'
    	       	 			+'</p></div></div></div>'
        			}
    			}
    			
    			$("#resultlist").html(str); 
    			//删除事件
    			$("button[id=jewelDel]").click(function(){
    				if(confirm("确定删除该珠宝信息？")==true){
    					var styleno=$(this).attr("value");
    					$.ajax({  
    				        type:"post",
    				        url:"${pageContext.request.contextPath}/jewel/delJewel",   
    				        dataType:"json",
    				        data:{  
    				            styleno:styleno,           
    				        },
    				        success:function(data) { 
    				        	var result=data.result;
    				        	if(result=="success"){
    				        		alert("删除成功！")
    				        	}//else alert("删除失败！");
    				        },error:function(){
    				        	alert("删除失败！");
    				        }
    					});
    					$("#resultlist").children(".row").children("#"+styleno).remove();
    				}
    			})
    			var total=data.totalsize;
    			 //分页-只初始化一次  
    		    if($("#Pagination").html()==""){  
    		    	// 创建分页 
    		    	 if(total<=20){
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

</script>
</body>
</html>
