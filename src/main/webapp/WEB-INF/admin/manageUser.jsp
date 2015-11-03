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
<link href="../resources/css/smartpaginator.css" rel="stylesheet"> 
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
									<h5 class="lighter">审核通过的用户</h5>
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
														<button  id="branchbutton" type="button" class="btn btn-xs btn-success">
														分店信息<i class="icon-ok bigger-120"></i></button>
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
				<div id="black"></div>
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
<script src="../resources/js/smartpaginator.js" type="text/javascript"></script> 
<!-- <script type="text/javascript" src="../resources/js/bootstrap-datetimepicker.min.js"></script> -->
<script type="text/javascript">
	$().ready(function() {
			$("button[id=branchbutton]").click(function(){
				var $target=$(this).parent().parent().parent();
				var username=$target.children("#username").attr("value");
				//alert(typename+","+typeid);
				window.location.href="${pageContext.request.contextPath}/user/toManageBranchCompany?username="+username;			
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

<script type="text/javascript">
//翻页功能
var len=${totalsize};
var pagenow= ${pagenow};
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
   window.location.href="${pageContext.request.contextPath}/user/toManageUser?pagenow="+current_page+"&pagesize="+pagesize;
} 
</script>
</body>
</html>
