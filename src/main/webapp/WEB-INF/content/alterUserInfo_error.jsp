<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link rel="stylesheet" href="../resources/css/ace.minadmin.css" />
<%@include file="header.jsp"%>

	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="main-content">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-8">
							<h4 class="lighter">
								<i class="icon-hand-right icon-animated-hand-pointer blue"></i>
								<a href="#modal-wizard" data-toggle="modal" class="pink">
									用户基本信息修改失败！</a>
							</h4>

							<div class="hr hr-18 hr-double dotted"></div>
							<a href="javascript:void(0);" onclick="window.history.back();">返回</a>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->

		</div>
		<!-- /.main-container-inner -->

	</div>
	<!-- /.main-container -->

<%@include file="footer.jsp"%>
</body>
</html>
