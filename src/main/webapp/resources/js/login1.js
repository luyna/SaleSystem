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
	                    required: "�û�������Ϊ��."
	                },
	                userpassword: {
	                    required: "���벻��Ϊ��."
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
	                    required: "Email����Ϊ��."
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
	            // ���Ƽ��� ^ �c $ ��̖�����������ֶ�Ҫ����
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
	                    regex: "[A-Za-z0-9]+" // ����Ո���� Regex
	                },
	                realname: {
	                    required: true,
	                    maxlength:20
	                },
	                userpassword: {
	                    required: true,
	                    maxlength:20
	                },
	                rpassword: {
	                    equalTo: "#register_password"
	                },
	                email: {
	                    email: true
	                },
	                depart: {
	                    required: true,
	                    maxlength:15
	                }
	            },

	            messages: { // custom messages for radio buttons and checkboxes
	                username: {
	                    required: "�û�������Ϊ�գ�",
	                    maxlength: jQuery.validator.format("������һ�� ��������� {0} ���ַ���"),   
	                    regex:"�û���ֻ��Ϊ��ĸ������"
	                },
	                realname:{
	                	required:"��ʵ��������Ϊ�ա�",
	                	maxlength:"��ʵ�������Ȳ��ܴ���20"
	                },
	                userpassword:{
	                	required:"���벻��Ϊ��",
	                	maxlength:"���볤�ȱ���С��20"
	                },
	                rpassword:{
	                	equalTo:"�����������벻һ��"
	                },
	                email:{
	                	email:"Email��ʽ����ȷ"
	                },
	                depart:{
	                	required:"�������Ʋ���Ϊ��",
	                	maxlength:"�������Ʊ���С��15"
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