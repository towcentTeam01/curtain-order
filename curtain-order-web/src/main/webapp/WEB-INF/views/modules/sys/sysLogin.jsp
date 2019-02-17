<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${fns:getConfig('productName')} 登录</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store">
<link href="${ctxStatic}/login/css/login.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/bootstrap/3.3.0/awesome/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/login/css/uniform.default.min.css" rel="stylesheet" />
<link href="${ctxStatic}/common/jeesite.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/login/css/components.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="${ctxStatic}/login/css/darkblue.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css" media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
<style type="text/css">
.header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
body
{
    background:url('${ctxStatic}/login/images/login.jpg');
    background-attachment:fixed;
    background-repeat:no-repeat;
    background-size:cover;
    -moz-background-size:cover;
    -webkit-background-size:cover;
    background-size：100% 100%;
    background-repead:no-repead;
}
</style>
<script src="${ctxStatic}/jquery/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/bootstrap/3.3.0/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/plugin/jquery-validation/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/login/js/jquery.backstretch.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/login/js/metronic.js" type="text/javascript"></script>
<script src="${ctxStatic}/login/js/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/login/js/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/login/js/jquery.cokie.min.js" type="text/javascript"></script>
<script type="text/javascript">
if(window.parent!=window){
	window.parent.location = window.location;
}
</script>
</head>
<body>
<div class="login">
<!-- BEGIN LOGO -->
<div class="logo">
	<!-- <h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>  -->
	<h1 class="form-signin-heading">订货系统</h1>
</div>
<!-- END LOGO -->
<!-- BEGIN 登录框 -->
<div class="content">
	<!-- BEGIN 登录表单 -->
	<form id="loginForm" class="login-form" action="${ctx}/login" method="post">
		<h3 class="form-title">登录您的帐号</h3>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
			<label class="control-label visible-ie8 visible-ie9">用户名</label>
			<div class="input-icon">
				<i class="icon-user"></i>
				<input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="用户名" name="username"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label visible-ie8 visible-ie9">密码</label>
			<div class="input-icon">
				<i class="icon-lock"></i>
				<input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="密码" name="password"/>
			</div>
		</div>
		<c:if test="${isValidateCodeLogin}">
			<div class="form-group">
				<label class="control-label visible-ie8 visible-ie9">密码</label>
				<div class="input-icon">
					<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;height:30px;" imageCssStyle="width:90px;height:30px;margin-bottom:3px;"/>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<label class="checkbox">
			<input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} value="1"/> 记住我（公共场所慎用） </label>
			<button type="submit" class="btn blue pull-right">
			登录 <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
		<div class="form-group">
			<span style="color: #eee;">还没有账号？<a href="${ctx}/toRegister">立即注册</a></span>
		</div>
		<div class="form-group">
			<c:if test="${not empty message }">
				<span id="loginError" style="color: #a94442;">${message}</span>
			</c:if>
		</div>
	</form>
	<!-- END 登录表单 -->
	</div>
	<!-- END 登录框 -->
	<div class="page-footer">
		<div style="color:#4e70a1; padding:10px" align="center" id="footerId">
			Copyright &copy; 2018 
			版权所有 @@科技有限公司
		</div>
	</div>
</div>
<script>
var ctxpath = '/static';
$(function() {
	$('input[name="username"]').focus();
	Metronic.init(); // init metronic core components
	// $.backstretch(
	//	[
	        // "${ctxStatic}/login/images/bg/1.jpg",
	        // "${ctxStatic}/login/images/bg/2.jpg",
	        // "${ctxStatic}/login/images/bg/3.jpg",
	        // "${ctxStatic}/login/images/bg/4.jpg"
	        // "${ctxStatic}/login/images/login5.jpg"
	//	], {
	//		fade: 1000,
	//		duration: 8000
	//	}
	//);
	
	$("#loginForm").validate({
		errorElement : "span",
		errorClass : "help-block",
		highlight : function(e) {
			$(e).closest(".form-group").addClass("has-error")
		},
		rules: {
			username:{required:true},password: {required:true},
			validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
		},
		messages: {
			username: {required: "请填写用户名!"},password: {required: "请填写密码!"},
			validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
		},
		errorPlacement : function(e, f) {
			e.insertAfter(f.closest(".input-icon"))
		}
	});
});

//如果在框架或在对话框中，则弹出提示并跳转到首页
if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
	alert('未登录或登录超时。请重新登录，谢谢！');
	//top.location = "${ctx}";
	window.parent.location = window.location;
}

function ajaxFun(url, params, callback) {
    $.ajax({
        type: "POST",
        url: url,
        data: params,
        dataType: "json",
        async: false,
        success: function (data) {
            if (callback) callback(data);
        }
    });
}

function getMerchantInfo() {
    ajaxFun("${ctx}/getMerchantInfo", {}, function (data) {
        if (data && data.data) {
            var title = $('.form-signin-heading').text();
            if(data.data.merchantName){
                $('.form-signin-heading').html(data.data.merchantName+title);
                $('#footerId').html(data.data.qq + "  © 2018 " + data.data.wxCode + "版权所有<br>地址:" + data.data.address);
			}
			if (data.data.id) {
			    $("body").css("background","url('${ctxStatic}/login/images/login" + data.data.id + ".jpg')");
			}
        }

    });
}

getMerchantInfo();
</script>
<!-- END 本页面Js -->
</body>
</html>