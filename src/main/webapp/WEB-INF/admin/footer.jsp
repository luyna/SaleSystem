<%@ page contentType="text/html; charset=utf-8"%>

<script type="text/javascript" src="../resources/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="../resources/js/bootstrap.min.js" ></script>
<script src="../resources/js/hideshow.js" type="text/javascript"></script>
<script type="text/javascript">
//初始化购物车显示数量
$().ready(function(){
	 $.ajax({  
	        url:"${pageContext.request.contextPath}/jewel/shopcart",  
	        dataType:"json",
	        success:function(data) {
	        	var cartCount=data.cartCount;
	        	$("#cartCount").html('<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>购物车('+cartCount+")");
	        }
		});	
	 
});
</script>
 <footer>

<hr>
 <table width="780" border="0" cellspacing="0" align="center">
  <tr>
	<td height="68" ><p align="center" >
	  2015 &copy;深圳市福米珠宝有限公司<br/></p>
	</td>
  </tr>
</table>
</footer> 
