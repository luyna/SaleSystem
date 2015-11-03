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
	<div class="main-container" id="main-container" >
		<div class="main-container-inner">
			<div class="main-content" style="margin-left:3%;margin-top:8%">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box">
								<div class="widget-header widget-header-small">
									<h5 class="lighter">注册待审核用户</h5>
								</div>
							</div>
							<div id="resultlist" class="row">
								
									<div class="col-xs-12">
										<div class="tableshow">
											<table id="sample-table-1"
												class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<!-- <th>编号</th> -->
														<th>用户名</th>
														<th>用户真实姓名</th>
														<th>公司名</th>
														<th>地址</th>
														<th>手机号</th>
														<th>邮箱</th>
														<th>注册日期</th>
														<!-- <th>状态</th> -->
														<th>操作</th>
													</tr>
												</thead>
												<tbody id="userlist">
												<c:forEach items="${userlist }" var="user">
													<tr>
														<%-- <td>${user.userid }</td> --%>
														<td id="username" value="${user.username}">${user.username }</td>
														<td>${user.userrelname}</td>
														<td>${user.companyname }</td>
														<td>${user.address}</td>
														<td>${user.phonenum }</td>
														<td>${user.email}</td>
														<td><fmt:formatDate value="${user.regdate }" type="date" pattern="yyyy-MM-dd"/></td>
														<%-- <td>${user.status}</td> --%>
														<td><div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
														<button  id="checkbutton" type="button" class="btn btn-xs btn-success">
														审核通过<i class="icon-ok bigger-120"></i></button>
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
			$("button[id=checkbutton]").click(function(){
				var $target=$(this).parent().parent().parent();
				var username=$target.children("#username").attr("value");
				//alert(typename+","+typeid);
				$.ajax({ 
			        url:"${pageContext.request.contextPath}/user/checkUser",  
			        type:"post",
			        dataType:"json",
			        data:{     			        
			        	username:username
			        },
			        success:function(data) {
			        	alert("用户审核通过！");
			        	$target.remove();			        	
			        },
			        error:function(){
			        	alert("出现错误！");
			        }
				});					
			});
			
			$("button[id=deletebutton]").click(function(){
				var $target=$(this).parent().parent().parent();
				var username=$target.children("#username").attr("value");
				//alert(username);
				$.ajax({ 
			        url:"${pageContext.request.contextPath}/user/delUser",  
			        type:"post",
			        dataType:"json",
			        data:{     			        
			        	username:username,
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
	});

</script>
</body>
</html>
