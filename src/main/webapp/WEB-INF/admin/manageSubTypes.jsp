<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link rel="stylesheet" href="../resources/css/ace.minadmin.css" />
<link rel="stylesheet" href="../resources/css/jasny-bootstrap.css" />
<!-- 日期选择插件 -->
<!-- <link href="../resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet"> -->
<%@include file="header.jsp"%>
<section id="main" class="column" >
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="main-content" style="margin-left:4%;margin-top:6%">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box">
								<div class="widget-header widget-header-small">
									<h5 class="lighter">二级类型增加、修改、删除。</h5>
								</div>

								<div class="widget-body">
									<div class="widget-main">
										<div class="row">
											<label></label> <span>
											<select id="jewelKind" class="form-horizontal" style="width: 200px;">
													<option id="1" value="1">3D硬千足金</option>
													<option id="2" value="2">珠宝类</option>
													<option id="3" value="3">闪沙系列</option>											
											</select>
											</span><span>
											<select id="jewelType" class="form-horizontal" style="width: 200px;">
												<c:forEach items="${jewelTypes}" var="type">
													<option id="${type.typeid }" value="${type.typeid }">${type.typename }</option>
												</c:forEach>
																							
											</select>
											</span><span>新类型名称： </span> <span> <label></label>
												<input type="text" id="newType" name="newType"
												maxlength="50" style="width: 100;" />

											</span> <span>
												<button id="addButton" type="button"
													class="btn btn-purple btn-sm">
													新增<i class="icon-plus icon-on-right bigger-110"></i>
												</button>
											</span>
										</div>
									</div>
								</div>
							</div>


							<div id="resultlist" class="row">
								
									<div class="col-xs-12">
										<div class="tableshow">
											<table id="sample-table-1"
												class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th>编码</th>
														<th>二级类型名称</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody id="subtypelist">
												<c:forEach items="${jewelSubTypes }" var="types">
													<tr>
														<td id="typeid" value="${types.subtypeid }">${types.subtypeid }</td>
														<td id="typename"><input value="${types.subtypename }"/></td>
														
														<td><div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
														<button  id="alterbutton" type="button" class="btn btn-xs btn-success">
														修改<i class="icon-ok bigger-120"></i></button>
														<button  id="deletebutton" type="button" class="btn btn-xs btn-danger" >
														删除<i class="icon-trash bigger-120"></i></button></div></td>
													</tr>
												</c:forEach>
												</tbody>
											</table>
										</div>
								
								<div class="hr hr-18 dotted hr-double"></div>
							</div>
						</div>
					</div>

				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->


		</div>
		<!-- /.main-container-inner -->

	</div>
	<!-- /.main-container -->
</section>

<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.validate.min.js"></script>
<script src="../resources/js/jasny-bootstrap.js"></script>
<!-- <script type="text/javascript" src="../resources/js/bootstrap-datetimepicker.min.js"></script> -->
<script type="text/javascript">
	$().ready(function() {
		//主分类改变后，修改相应的一级和二级分类下拉列表
		$("#jewelKind").change(function(){
			var styleno=$(this).children(":selected").attr("value");
			$.ajax({ 
		        url:"${pageContext.request.contextPath}/jewel/selectTypes",  
		        dataType:"json",
		        data:{     			        
		            styleno:styleno,
		        },
		        success:function(data) {
		        	var list=data.typelist;
		        	$("#jewelType").children().remove();
		        	$("#subtypelist").children().remove();
		        	for(var i=0;i<list.length;i++){
		        		$("#jewelType").append('<option value='+list[i].jewelType.typeid+'>'
		        				+list[i].jewelType.typename+'</option>');      		
		        	}
		        	for(var j=0;j<list[0].subTypeList.length;j++){
	        			$("#subtypelist").append('<tr><td id="typeid" value="'+list[0].subTypeList[j].subtypeid+'">'
	        			+list[0].subTypeList[j].subtypeid+'</td>'
						+'<td id="typename"><input value="'+list[0].subTypeList[j].subtypename+'"/></td>'
						+'<td><div class="visible-md visible-lg hidden-sm hidden-xs btn-group">'
						+'<button  id="alterbutton" type="button" class="btn btn-xs btn-success">'
						+'修改<i class="icon-ok bigger-120"></i></button>'
						+'<button  id="deletebutton" type="button" class="btn btn-xs btn-danger" >'
						+'删除<i class="icon-trash bigger-120"></i></button></div></td></tr>');
	        		}
		        	    	
		        },
		        error:function(){
		        	alert("错误！");
		        }
			});		
		});
		$("#jewelType").change(function(){
			var styleno=$(this).children(":selected").attr("value");
			$.ajax({ 
		        url:"${pageContext.request.contextPath}/jewel/selectTypes",  
		        dataType:"json",
		        data:{     			        
		            styleno:styleno,
		        },
		        success:function(data) {
		        	var list=data.typelist;
		        	$("#subtypelist").children().remove();
		        	for(var j=0;j<list.length;j++){
	        			$("#subtypelist").append('<tr><td id="typeid" value="'+list[j].subtypeid+'">'
	    	        			+list[j].subtypeid+'</td>'
	    						+'<td id="typename"><input value="'+list[j].subtypename+'"/></td>'
	    						+'<td><div class="visible-md visible-lg hidden-sm hidden-xs btn-group">'
	    						+'<button  id="alterbutton" type="button" class="btn btn-xs btn-success">'
	    						+'修改<i class="icon-ok bigger-120"></i></button>'
	    						+'<button  id="deletebutton" type="button" class="btn btn-xs btn-danger" >'
	    						+'删除<i class="icon-trash bigger-120"></i></button></div></td></tr>');      			
	        		}
		        	    	
		        },
		        error:function(){
		        	alert("错误！");
		        }
			});		
		});
		
		
		$("#addButton").click(function(){
			var jewelType=$("#jewelType").children(":selected").val();
			//alert(jewelKind);
			var newSubType=$("#newType").val();
			//alert(jewelType);
			$.ajax({ 
		        url:"${pageContext.request.contextPath}/jewel/addJewelSubType",  
		        type:"post",
		        dataType:"json",
		        data:{     			        
		        	newSubType:newSubType,
		        	jewelType:jewelType
		        },
		        success:function(data) {
		        	alert("添加成功！");
		        	var newtype=data.newType;
		        	$("#subtypelist").append('<tr><td id="typeid" value="'+newtype.subtypeid+'">'+newtype.subtypeid+'</td>'
							+'<td id="typename"><input value="'+newtype.subtypename+'"/></td>'
							+'<td><div class="visible-md visible-lg hidden-sm hidden-xs btn-group">'
							+'<button  id="alterbutton" type="button" class="btn btn-xs btn-success">'
							+'修改<i class="icon-ok bigger-120"></i></button>'
							+'<button  id="deletebutton" type="button" class="btn btn-xs btn-danger" >'
							+'删除<i class="icon-trash bigger-120"></i></button></div></td></tr>');
		        	    	
		        	alterAndDelButton();
		        },
		        error:function(){
		        	alert("出现错误！");
		        }
			});		
		});
		
		
		alterAndDelButton();
		function alterAndDelButton(){
			$("button[id=alterbutton]").click(function(){
				var $target=$(this).parent().parent().parent();
				var typename=$target.children("#typename").children("input").val();
				var typeid=$target.children("#typeid").attr("value");
				//alert(typename+","+typeid);
				$.ajax({ 
			        url:"${pageContext.request.contextPath}/jewel/updateJewelSubType",  
			        type:"post",
			        dataType:"json",
			        data:{     			        
			        	typeid:typeid,
			        	typename:typename
			        },
			        success:function(data) {
			        	alert("修改成功！");
			        	
			        },
			        error:function(){
			        	alert("出现错误！");
			        }
				});					
			});
			
			$("button[id=deletebutton]").click(function(){
				var $target=$(this).parent().parent().parent();
				var typeid=$target.children("#typeid").attr("value");
				alert(","+typeid);
				$.ajax({ 
			        url:"${pageContext.request.contextPath}/jewel/deleteJewelSubType",  
			        type:"post",
			        dataType:"json",
			        data:{     			        
			        	typeid:typeid,
			        },
			        success:function(data) {
			        	alert("删除成功！");
			        	$target.remove();
			        },
			        error:function(){
			        	alert("出现错误！");
			        }
				});					
			});			
		}				
	});

</script>
</body>
</html>
