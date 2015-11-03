<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link rel="stylesheet" href="../resources/css/ace.minadmin.css" />
<%@include file="header.jsp"%>
<section id="main" class="column" style="margin-top:80px">
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="main-content">
				<div class="page-content">
					
					<div class="row">
						<div class="col-xs-8">
							<h4 class="lighter">
								<i class="icon-hand-right icon-animated-hand-pointer blue"></i>
								<a href="#modal-wizard" data-toggle="modal" class="pink">
									修改密码 </a>
							</h4>

							<div class="hr hr-18 hr-double dotted"></div>
							<div class="row-fluid">
								<div class="span12">
									<div class="widget-box">
										<div
											class="widget-header widget-header-blue widget-header-flat">
											<h4 class="lighter">填写密码信息</h4>
										</div>

										<div class="widget-body">
											<div class="widget-main">

												<div class="step-content row-fluid position-relative"
													id="step-container">
													<div class="step-pane active" id="step1">
														<h3 class="lighter block green">输入以下信息</h3>
														<sf:form action="${pageContext.request.contextPath}/user/alterPassword" modelAttribute="passwordContent"
															class="form-horizontal " id="validation-form"
															method="post">


															<div class="space-2"></div>

															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right"
																	for="oldps">初始密码:</label>

																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="oldps" type="password" name="oldps" id="oldps"
																			class="col-xs-12 col-sm-4" autocomplete="off"/>
																	</div>
																</div>
															</div>

															<div class="space-2"></div>

															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right"
																	for="userpassword">新密码:</label>

																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="newps" type="password" name="newps"
																			id="newps" class="col-xs-12 col-sm-4" autocomplete="off"/>
																	</div>
																</div>
															</div>

															<div class="space-2"></div>

															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right"
																	for="rpassword">确认密码:</label>

																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<input type="password" name="rpassword" id="rpassword"
																			class="col-xs-12 col-sm-4" autocomplete="off" />
																	</div>
																</div>
															</div>

															<div class="hr hr-dotted"></div>

															<div class="row-fluid wizard-actions">

																<button class="btn btn-success btn-next" type="button" onclick="window.history.back();">
																	<i class="icon-arrow-left icon-on-left"></i>返回
																</button>
																<button class="btn btn-success btn-next" type="submit"
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
</section>
<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.validate.min.js"></script>

	<script type="text/javascript">
		jQuery(function($) {
			$('#validation-form')
					.validate(
							{
								errorElement : 'div',
								errorClass : 'help-block',
								focusInvalid : false,
								rules : {
									oldps : {
										required : true

									},
									newps : {
										required : true,
										minlength : 5
									},
									rpassword : {
										equalTo : "#newps"
									}
								},

								messages : {
									oldps : {
										required : "初始密码不能为空."
									},
									newps : {
										required : "新密码不能为空.",
										minlength:"新密码长度不能小于5"
									},
									rpassword : {
										equalTo : "确认密码必须与新密码一致."
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
