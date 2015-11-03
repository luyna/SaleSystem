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
						<div class="col-xs-8">
							<div class="row-fluid">
								<div class="span12">
									<div class="widget-box">
										<div
											class="widget-header widget-header-blue widget-header-flat">
											<h4 class="lighter">珠宝基本信息</h4>
										</div>

										<div class="widget-body">
											<div class="widget-main">

												<div class="step-content row-fluid position-relative"
													id="step-container">
													<div class="step-pane active" id="step1">
														
														<sf:form action="${pageContext.request.contextPath}/jewel/alterJewel" modelAttribute="jewel"
															class="form-horizontal " id="validation-form" 
															method="post" enctype="multipart/form-data">
														<div style="display:inline-block" class="thumbnail" style="width: 220px; height: 150px;">
															<img src="${pageContext.request.contextPath}/jewel/jewelPicture?styleno=${jewel.styleno }" 
															onError="this.src='../resources/image/nopic1.jpg'"
															alt="Generic placeholder thumbnail" style="width: 200px; height: 150px;"
															></a>
															<div class="caption">
																原图片
															</div>
														 </div>	
														<div style="display:inline-block" class="fileinput fileinput-new" data-provides="fileinput">
 														  	<div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
  									  							
  									  							 <img data-src="holder.js/100%x100%" alt="图片">
 								 						 	</div>
  								 							<div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
  								 							<div>
   								 								<span class="btn btn-default btn-file"><span class="fileinput-new">选择新图片</span><span class="fileinput-exists">更改</span>
   								 								<input type="file" name="jewelimage"></span>
    							 								<a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">移除</a>
  								 							</div>
														</div>
				
														<div class="hr hr-18 hr-double dotted"></div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">款号:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="styleno" readonly="true"
																			class="col-xs-12 col-sm-6" /><span id="stylenoExist"></span>
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">品名:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="jewelname" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">类型:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<select id="kind" class="form-control" style="width:30%;display:inline-block">
 																			<option id="1" value="1" >3D硬千足金</option>
  																			<option id="2" value="2">珠宝类</option>
																			<option id="3" value="3">闪沙系列</option>
																		</select>
																		<select id="type" class="form-control" style="width:30%;display:inline-block">
																			<c:forEach items="${typelist}" var="types">
																				<option id="${types.jewelType.typeid }" value="${types.jewelType.typeid }">${types.jewelType.typename }</option>
																			</c:forEach>
																		</select>
																		<sf:select path="typeno" style="width:30%;display:inline-block" class="form-control">
 																			<c:forEach items="${typelist}" begin="${prefix3 }" end="${prefix3 }" step="1" var="types">
																				<c:forEach items="${types.subTypeList }" var="subtype">
																					<option id="${subtype.subtypeid }" value="${subtype.subtypeid }">${subtype.subtypename }</option>
																				</c:forEach>
																			</c:forEach>
																		</sf:select>
																		
																	</div>
																</div>
															</div>
															
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">重量:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="weight" 
																			class="col-xs-12 col-sm-6" />（克）
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">成色:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="fineness" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">规格:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="specification" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">库存:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="storage" 
																			class="col-xs-12 col-sm-6"  />（件）
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">配件名称:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="accessory" 
																			class="col-xs-12 col-sm-6"  />
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">配件价格:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="accessoryprice" 
																			class="col-xs-12 col-sm-6"  />（元）
																	</div>
																</div>
															</div>
															
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">套件:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="suite" 
																			class="col-xs-12 col-sm-6" />
																	</div>
																</div>
															</div>
															<%-- <div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">录入日期:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:input path="time" 
																			class="col-xs-12 col-sm-6" />
																	</div>（格式：2015-06-20）
																</div><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
															</div> --%>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">说明:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																		<sf:textarea path="instruction" 
																		class="col-xs-12 col-sm-6 form-control" rows="3" />	
																	</div>
																</div>
															</div>
															<div class="space-2"></div>
															<div class="form-group">
																<label
																	class="control-label col-xs-12 col-sm-3 no-padding-right">备注:</label>
																<div class="col-xs-12 col-sm-9">
																	<div class="clearfix">
																	<sf:textarea path="remark" 
																	class="col-xs-12 col-sm-6 form-control" rows="3"></sf:textarea>						
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
 * 判断款号是否已经在数据库中存在
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
	$("#kind").children("#${prefix1}").attr("selected","selected");
	$("#type").children("#${prefix2}").attr("selected","selected");
	//alert(${jewel.typeno});
	$("#typeno").children("#${jewel.typeno}").attr("selected","selected");
	//alert($("#kind").children("#${prefix1}").attr("value"));
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
