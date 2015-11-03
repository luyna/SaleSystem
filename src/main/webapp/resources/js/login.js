var Login = function () {
    
    return {
        //main function to initiate the module
        init: function () {
        	
           $('.login-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            rules: {
	                username: {
	                    required: true
	                },
	                userpassword: {
	                    required: true
	                },
	                remember: {
	                    required: false
	                }
	            },

	            messages: {
	                username: {
	                    required: "用户名不能为空."
	                },
	                userpassword: {
	                    required: "密码不能为空."
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   
	                $('.alert-error', $('.login-form')).show();
	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	           
	        });

	        

	        $('.forget-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                email: {
	                    required: true,
	                    email: true
	                }
	            },

	            messages: {
	                email: {
	                    required: "Email不能为空."
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	            submitHandler: function (form) {
	                window.location.href = "index.jsp";
	            }
	        });

	        $('.forget-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('.forget-form').validate().form()) {
	                    window.location.href = "index.jsp";
	                }
	                return false;
	            }
	        });

	        jQuery('#forget-password').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.forget-form').show();
	        });

	        jQuery('#back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.forget-form').hide();
	        });
	        
	        
	        $.validator.addMethod("regex", function(value, element, param) {
	            // 強制加上 ^ 與 $ 符號限制整串文字都要符合
	            return value.match(new RegExp("^" + param + "$"));
	        });

	        $('.register-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                username: {
	                    required: true,
	                    maxlength:20,
	                    regex: "[A-Za-z0-9]+" // 寫法請參考 Regex
	                },
	                realname: {
	                    required: true,
	                    maxlength:20
	                },
	                userpassword: {
	                    required: true,
	                    //maxlength:20,
	                    minlength:5
	                },
	                rpassword: {
	                    equalTo: "#register_password"
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
	                    regex: "[0-9]+"
	                }
	            },

	            messages: { // custom messages for radio buttons and checkboxes
	                username: {
	                    required: "用户名不能为空，",
	                    maxlength: jQuery.validator.format("请输入一个 长度最多是 {0} 的字符串"),   
	                    regex:"用户名只能为字母和数字"
	                },
	                realname:{
	                	required:"真实姓名不能为空。",
	                	maxlength:"真实姓名长度不能大于20"
	                },
	                userpassword:{
	                	required:"密码不能为空",
	                	//maxlength:"密码长度不能大于20",
	                	minlength:"密码长度不能小于5"
	                },
	                rpassword:{
	                	equalTo:"两次密码输入不一致"
	                },
	                companyname:{
	                	required:"公司名称不能为空",
	                	maxlength:"公司名称长度不能大于50"
	                },
	                address:{
	                	maxlength:"地址长度不能大于30"
	                },
	                email:{
	                	email:"Email格式不正确",
	                	maxlength:"email长度不能大于30"
	                },
	                phonenum:{
	                	required:"手机号不能为空",
	                	regex:"手机号只能为数字",
	                	maxlength:"手机号长度不能大于20"
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
	                    error.addClass('help-small no-left-padding').insertAfter($('#register_tnc_error'));
	                } else {
	                    error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	                }
	            },

	           
	        });
	        
	 
	        jQuery('#register-btn').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.register-form').show();
	        });

	        jQuery('#register-back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.register-form').hide();
	        });
        }

    };

}();