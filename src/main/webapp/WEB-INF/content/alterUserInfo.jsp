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
									修改用户基本信息 </a>
							</h4>

							<div class="hr hr-18 hr-double dotted"></div>
							<div class="row-fluid">
								<div class="span12">
									<div class="widget-box">
										<div
											class="widget-header widget-header-blue widget-header-flat">
											<h4 class="lighter">用户信息</h4>
										</div>

										<div class="widget-body">
											<div class="widget-main">

												<div class="step-content row-fluid position-relative"
													id="step-container">
													<div class="step-pane active" id="step1">
														<h3 class="lighter block green">${userInfo.username }</h3>
														<sf:form action="${pageContext.request.contextPath}/user/alterUserInfo" modelAttribute="userInfo"
															class="form-horizontal " id="validation-form"
															method="post">
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">真实姓名:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="userrelname" 
																			class="col-xs-12 col-sm-4" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">公司名称:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="companyname" 
																			class="col-xs-12 col-sm-4" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">地址:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="address" 
																			class="col-xs-12 col-sm-4" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">手机号:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="phonenum" 
																			class="col-xs-12 col-sm-4"  />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">邮箱:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="email" 
																			class="col-xs-12 col-sm-4"  />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">注册日期:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<fmt:formatDate value="${userInfo.regdate}" type="date" pattern="yyyy-MM-dd"/>
																	</div>
																</div>
															</div>

															<div class="hr hr-dotted"></div>

															<div style="margin-left:20%" class="row-fluid wizard-actions">

																<button style="margin-left:20%" class="btn btn-success btn-next" type="button" onclick="window.history.back();">
																	<i class="icon-arrow-left icon-on-left"></i>返回
																</button>
																<button id="submitUserInfo" class="btn btn-success btn-next" type="submit"
																	data-last="Finish ">
																	提交 <i class="icon-arrow-right icon-on-right"></i>
																</button>
															</div>
														</sf:form>
													</div>
												</div>
											</div>
											<!-- /widget-main -->
										</div>
										<!-- /widget-body -->
									</div>
								</div>
							</div>


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
<script src="../resources/js/jquery.validate.min.js"></script>
<script type="text/javascript">
/* $("#submitUserInfo").click(function(){
	$.ajax(function(){
		url:"",
	});
}) */
</script>
	<script type="text/javascript">
		jQuery(function($) {
			$('#validation-form')
					.validate(
							{
								errorElement : 'div',
								errorClass : 'help-block',
								focusInvalid : false,
								rules : {
									userrelname: {
					                    required: true,
					                    maxlength:20
					                },
					                companyname:{
					                	required: true,
					                	maxlength:50,
					                },
					                address:{
					                	maxlength:30,
					                },
					                email: {
					                    email: true,
					                	maxlength:30,
					                },
					                phonenum: {
					                    required: true,
					                    maxlength:20,
					                    digits:true
					                }
					                
								},

								messages : {
									  
						               userrelname:{
						                	required:"真实姓名不能为空。",
						                	maxlength:"真实姓名长度不能大于20"
						                },
						                companyname:{
						                	required:"公司名称不能为空",
						                	maxlength:"公司名称长度不能大于50"
						                },
						                email:{
						                	email:"Email格式不正确",
						                	maxlength:"email长度不能大于30"
						                },
						                phonenum:{
						                	required:"手机号不能为空",				                	
						                	maxlength:"手机号长度不能大于20",
						                	digits:"手机号只能为数字"
						                }

								},

								invalidHandler : function(event, validator) { //display error alert on form submit   
									$('.alert-danger', $('.login-form')).show();
								},

								highlight : function(e) {
									$(e).closest('.form-group').removeClass(
											'has-info').addClass('has-error');
								},

								success : function(e) {
									$(e).closest('.form-group').removeClass(
											'has-error').addClass('has-info');
									$(e).remove();
								},

								errorPlacement : function(error, element) {
									if (element.is(':checkbox')
											|| element.is(':radio')) {
										var controls = element
												.closest('div[class*="col-"]');
										if (controls.find(':checkbox,:radio').length > 1)
											controls.append(error);
										else
											error.insertAfter(element.nextAll(
													'.lbl:eq(0)').eq(0));
									} else if (element.is('.select2')) {
										error
												.insertAfter(element
														.siblings('[class*="select2-container"]:eq(0)'));
									} else if (element.is('.chosen-select')) {
										error
												.insertAfter(element
														.siblings('[class*="chosen-container"]:eq(0)'));
									} else
										error.insertAfter(element.parent());
								},

								invalidHandler : function(form) {
								}
							});

			/* $('#modal-wizard .modal-header').ace_wizard();
			$('#modal-wizard .wizard-actions .btn[data-dismiss=modal]')
					.removeAttr('disabled'); */
		})
	</script>
</body>
</html>
