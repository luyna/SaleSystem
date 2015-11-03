<%@page contentType="text/html; charset=utf-8" language="java"
	errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="../resources/css/smartpaginator.css" rel="stylesheet"> 

 
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
		<h3><span class="label label-primary">我的分店</span>&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/user/toAddBranchCompany" style="font-size:16px">添加地址</a></h3>
	</div>
	<div class="row">
		<div class=" col-lg-12 col-md-12">
	<table class="table table-bordered table-striped table-hover">
      <thead>
        <tr>
          <th>分店编号</th>
          <th>联系人</th>
          <th>分店名</th>
          <th>地址</th>
          <th>手机号</th>
          <th>邮箱</th>         
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
      
      <c:forEach items="${companylist}" var="item">
        <tr style="vertical-align: baseline;">
          <td id="companyid" value="${item.companyid }">${item.companyid }</td>
          <td>${item.relationuser }</td>
          <td>${item.companyname }</td>
          <td>${item.address}</td>
          <td >${item.phonenum }</td>
          <td>${item.email}</td>
            
          <td><a href="${pageContext.request.contextPath}/user/toAlterBranchCompany?companyid=${item.companyid }"  class="btn btn-primary">
          <span class="glyphicon  glyphicon-pencil" aria-hidden="true">修改 </span></a>&nbsp;&nbsp;
          <button id="delBranchCompany" value="${item.companyid }"  class="btn btn-primary">
          <span class="glyphicon  glyphicon-trash" aria-hidden="true">删除</span></button>
          </td>
        </tr>
      </c:forEach>  
      </tbody>
    </table>
    </div>
    </div>
	<div id="black"></div>
	
</div>


<%@include file="footer.jsp"%>
<script src="../resources/js/smartpaginator.js" type="text/javascript"></script> 
<script type="text/javascript">

//翻页功能
 var len=${totalsize};
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
    window.location.href="${pageContext.request.contextPath}/user/branchCompany?pagenow="+current_page+"&pagesize="+pagesize;
} 

$("button[id=delBranchCompany]").click(function(){
	alert("test");
	if(confirm("确定删除该分店信息？")==true){
		var companyid=$(this).attr("value");
		//href="${pageContext.request.contextPath}/user/toAlterBranchCompany?companyid=${item.companyid }"
		$.ajax({ 
	        url:"${pageContext.request.contextPath}/user/delBranchCompany",  
	        dataType:"json",
	        data:{     			        
	        	companyid:companyid,
	        },
	        success:function(data) {
	        	//if(da)
	        	alert("删除成功!");        	
	        	window.location.href="${pageContext.request.contextPath}/user/branchCompany";
	        },error:function(){
	        	alert("删除失败，请稍后再试！");
	        }
		});
	}
})

</script>

</body>
</html>
