<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.AnonymousFilter" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>${fns:getConfig('productName')} 注册</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10"/>
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-store">
    <link href="${ctxStatic}/login/css/login.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxStatic}/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxStatic}/bootstrap/3.3.0/awesome/font-awesome.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/login/css/uniform.default.min.css" rel="stylesheet"/>
    <link href="${ctxStatic}/common/jeesite.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/login/css/components.css" rel="stylesheet" type="text/css"/>
    <link id="style_color" href="${ctxStatic}/login/css/darkblue.min.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .header {
            height: 80px;
            padding-top: 20px;
        }

        .alert {
            position: relative;
            width: 300px;
            margin: 0 auto;
            *padding-bottom: 0px;
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
    <script src="${ctxStatic}/jquery/plugin/jquery-layui-1.0.2/layui.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery/plugin/jquery-layui-1.0.2/lay/dest/layui.all.js" type="text/javascript"></script>
    <script type="text/javascript">
        ;!function(){
            var from = layui.form(),layer = layui.layer;
        }();
        if (window.parent != window) {
            window.parent.location = window.location;
        }
    </script>
</head>
<body>
<div class="login">
    <!-- BEGIN LOGO -->
    <div class="logo">
        <h1 class="form-signin-heading">${merchantInfo.merchantName}${fns:getConfig('productName')}</h1>
    </div>
    <!-- END LOGO -->
    <!-- BEGIN 登录框 -->
    <div class="content">
        <!-- BEGIN 登录表单 -->
        <form id="loginForm" class="login-form"  method="post">
            <h3 class="form-title">会员注册</h3>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie8 visible-ie9">用户名</label>
                <div class="input-icon">
                    <i class="icon-user"></i>
                    <input class="form-control placeholder-no-fix required username" type="text" autocomplete="off"
                           placeholder="用户名" name="loginName" id="loginName"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">密码</label>
                <div class="input-icon">
                    <i class="icon-lock"></i>
                    <input class="form-control placeholder-no-fix required password equalTo" type="password"
                           autocomplete="off" placeholder="密码" name="password" id="password"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">确认密码</label>
                <div class="input-icon">
                    <i class="icon-lock"></i>
                    <input class="form-control placeholder-no-fix required password equalTo" type="password"
                           autocomplete="off" placeholder="确认密码" name="confirmPassword" id="confirmPassword"/>
                </div>
            </div>
            <c:if test="${isValidateCodeLogin}">
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">验证码</label>
                    <div class="input-icon">
                        <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;height:30px;"
                                          imageCssStyle="width:90px;height:30px;margin-bottom:3px;"/>
                    </div>
                </div>
            </c:if>
            <div class="form-actions">
                <button type="submit" class="btn blue pull-right">
                    注册 <i class="m-icon-swapright m-icon-white"></i>
                </button>
            </div>
            <div class="form-group">
                <span style="color: #eee;">已有账号？<a href="${ctx}/login">请登录</a></span>
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
        <div style="color:#98a6ba; padding:10px" align="center">
            Copyright &copy; 2018
            版权所有 @@科技有限公司
        </div>
    </div>
</div>
<script>
    var ctxpath = '/static';
    $(function () {
        $('input[name="username"]').focus();
        Metronic.init(); // init metronic core components
        $.backstretch(
            [
                "${ctxStatic}/login/images/bg/1.jpg",
                "${ctxStatic}/login/images/bg/2.jpg",
                "${ctxStatic}/login/images/bg/3.jpg",
                "${ctxStatic}/login/images/bg/4.jpg"
            ], {
                fade: 1000,
                duration: 8000
            }
        );

        jQuery.validator.addMethod("password", function (value, element) {
            var length = value.length;
            return this.optional(element) || /^\w{6,20}$/.test(value);
        }, "请输入正确的密码");


        jQuery.validator.addMethod("equalTo", function (value, element) {
            var password = $('#password').val();
            return this.optional(element) || (password && value && password === value);
        }, "两次密码输入不一致");

        $("#loginForm").validate({
            errorElement: "span",
            errorClass: "help-block",
            highlight: function (e) {
                $(e).closest(".form-group").addClass("has-error")
            },
            rules: {
                username: {required: true}, password: {required: true},
                validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
            },
            messages: {
                loginName: {required: "请填写用户名!"}, password: {required: "请填写密码!"},
                confirmPassword: {required: "请填写确认密码!"},
                validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
            },
            errorPlacement: function (e, f) {
                e.insertAfter(f.closest(".input-icon"))
            },
            submitHandler: function (form) {
                register();
                return false;
            },
        });
    });

    //如果在框架或在对话框中，则弹出提示并跳转到首页
    if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0) {
        alert('未登录或登录超时。请重新登录，谢谢！');
        //top.location = "${ctx}";
        window.parent.location = window.location;
    }

    function register() {
        var data = {};
        var fields = $('#loginForm').serializeArray();
        jQuery.each(fields, function (i, field) {
            data[field.name] = field.value;
        });
        var loadTip = layui.layer.load();
        $.ajax({
            type: "POST",
            url: "${ctx}/register",
            data: data,
            dataType: "json",
            async: false,
            success: function (data) {
                console.log(data)
                layui.layer.msg(data.errorMessage);
                if (data.code == '000') {
                    setTimeout(function () {
                        location.href = "${ctx}/login";
                    }, 500);
                }else{
                    layer.close(loadTip);
                }
                return;
            }
        });
    }


</script>
<!-- END 本页面Js -->
</body>
</html>