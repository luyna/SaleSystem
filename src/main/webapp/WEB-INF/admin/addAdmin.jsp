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
<section id="main" class="column" style="margin-top:80px">
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="main-content">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-8">
							<div class="row-fluid">
								<div class="span12">
									<div class="widget-box">
										<div
											class="widget-header widget-header-blue widget-header-flat">
											<h4 class="lighter">添加管理员</h4>
										</div>

										<div class="widget-body">
											<div class="widget-main">

												<div class="step-content row-fluid position-relative"
													id="step-container">
													<div class="step-pane active" id="step1">
														<%-- <h3 class="lighter block green">${branchCompany.relationuser }</h3> --%>
														<sf:form action="${pageContext.request.contextPath}/jewel/addJewel" modelAttribute="manage"
															class="form-horizontal " id="validation-form" 
															method="post" enctype="multipart/form-data">												
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">用户名:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="managename" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">密码:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:password path="password" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															

															<div class="hr hr-dotted"></div>

															<div style="margin-left:20%" class="row-fluid wizard-actions">

																<button style="margin-left:20%" class="btn btn-success btn-next" type="reset">
																	<i class="icon-arrow-left icon-on-left"></i>重置
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
</section>

<%@include file="footer.jsp"%>
<script src="../resources/js/jquery.validate.min.js"></script>
<script src="../resources/js/jasny-bootstrap.js"></script>
<!-- <script type="text/javascript" src="../resources/js/bootstrap-datetimepicker.min.js"></script> -->
<script type="text/javascript">
/**
 * 判断用户名是否已经在数据库中存在
 */
$("#styleno").change(function(){
	var styleno=$(this).val();
	//alert(styleno);
	$.ajax({ 
        url:"${pageContext.request.contextPath}/jewel/stylenoExist",  
        dataType:"json",
        data:{     			        
            styleno:styleno,
        },
        success:function(data) {
        	var result=data.result;
        	if(result=="notExist"){
        		$("#stylenoExist").html('<h3><span class="label label-success">该款号尚不存在，可以添加！</span></h3>');
        		
        	}else{
        		$("#stylenoExist").html('<h3><span class="label label-danger">该款号已经存在！</span></h3>');       		
        	}     	
        },
        error:function(){
        	alert("错误！");
        }
	});
});

$().ready(function(){
	//主分类改变后，修改相应的一级和二级分类下拉列表
	$("#kind").change(function(){
		var styleno=$(this).children(":selected").attr("value");
		$.ajax({ 
	        url:"${pageContext.request.contextPath}/jewel/selectTypes",  
	        dataType:"json",
	        data:{     			        
	            styleno:styleno,
	        },
	        success:function(data) {
	        	var list=data.typelist;
	        	$("#type").children().remove();
	        	$("#typeno").children().remove();
	        	for(var i=0;i<list.length;i++){
	        		$("#type").append('<option value='+list[i].jewelType.typeid+'>'
	        				+list[i].jewelType.typename+'</option>');      		
	        	}
	        	for(var j=0;j<list[0].subTypeList.length;j++){
        			$("#typeno").append('<option value='+list[0].subTypeList[j].subtypeid+'>'
        					+list[0].subTypeList[j].subtypename+'</option>');
        		}
	        	    	
	        },
	        error:function(){
	        	alert("错误！");
	        }
		});		
	});
	
	$("#type").change(function(){
		var styleno=$(this).children(":selected").attr("value");
		$.ajax({ 
	        url:"${pageContext.request.contextPath}/jewel/selectTypes",  
	        dataType:"json",
	        data:{     			        
	            styleno:styleno,
	        },
	        success:function(data) {
	        	var list=data.typelist;
	        	$("#typeno").children().remove();
	        	for(var j=0;j<list.length;j++){
        			$("#typeno").append('<option value='+list[j].subtypeid+'>'
        					+list[j].subtypename+'</option>');
        		}
	        	    	
	        },
	        error:function(){
	        	alert("错误！");
	        }
		});		
	});
	//时间控件显示
	/* $('input[id=time]').datetimepicker({
	    format: 'yyyy-mm-dd',
	    todayBtn:true,
	    startView:4,
	    minView:2,
	    maxView:4,
	    startView:4,
	    todayHighlight:true,
	    //initialDate:'2013-09-08',
	    autoclose:true, 
	    inputMask: true 
	});		 */
});
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
									styleno: {
					                    required: true,
					                    maxlength:20
					                },
					                typeno:{
					                	required: true,
					                },
					                jewelname:{
					                	required: true,
					                	maxlength:30,
					                },
					                weight: {
					                    number:true,
					                },
					                fineness: {
					                
					                    maxlength:50,
					                },
					                specification: {
			
					                    maxlength:100,
					                },
					                accessory: {
					                    maxlength:50,
					                },
					                accessoryprice: {
					                    number:true,
					                },
					                suite: {
					                    maxlength:100,
					                },
					                storage: {
					                    digits:true,
					                },
					                time: {
					                    required: true,
					                },
					                instruction: {
			
					                    maxlength:200,
					                },
					                remark: {
			
					                    maxlength:200,
					                }
					                
								},

								messages : {
									styleno: {
					                    required: "款号不能为空",
					                    maxlength:"款号长度不能超过20"
					                },
					                typeno:{
					                	required:"类型不能为空"
					                },
					                jewelname:{
					                	required: "品名不能为空",
					                	maxlength:"品名长度不能超过30",
					                },
					                weight: {
					                    number:"重量必须为有效数值",
					                },
					                fineness: {
					                
					                    maxlength:"成色最大长度为50",
					                },
					                specification: {
			
					                    maxlength:"规格长度不能超过100",
					                },
					                accessory: {
					                    maxlength:"附件长度不能超过50",
					                },
					                accessoryprice: {
					                    number:"附件价格必须为有效数值",
					                },
					                suite: {
					                    maxlength:"套件长度不能超过100",
					                },
					                storage: {
					                    digits:"库存只能为数字",
					                },
					                time: {
					                    required:"时间不能为空",
					                },
					                instruction: {
			
					                    maxlength:"说明长度不能超过200",
					                },
					                remark: {
			
					                    maxlength:"备注长度不能超过200",
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
