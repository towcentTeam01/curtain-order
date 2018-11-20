<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>个人信息</title>
<meta name="decorator" content="default"/>
<script type="text/javascript">
$(document).ready(function() {
	$("#inputForm").validate({
		submitHandler: function(form){
			loading('正在提交，请稍等...');
			form.submit();
		},
		errorContainer: "#messageBox",
		errorPlacement: function(error, element) {
			$("#messageBox").text("输入有误，请先更正。");
			if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
				error.appendTo(element.parent().parent());
			} else {
				error.insertAfter(element);
			}
		}
	});
});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">头像:</label>
			<div class="col-sm-3">
				<sys:fileInput path="photo" value="${user.photo}" type="0" thumbSize="200X200"></sys:fileInput>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属公司:</label>
			<div class="col-sm-3">
				<label class="control-label">${user.company.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属部门:</label>
			<div class="col-sm-3">
				<label class="control-label">${user.office.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">职务:</label>
			<div class="col-sm-3">
				<label class="control-label">${user.job}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">入职时间:</label>
			<div class="col-sm-3">
				<label class="control-label"><fmt:formatDate value="${user.entryDate}" pattern="yyyy-MM-dd"/></label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">生日:</label>
			<div class="col-sm-3">
				<label class="control-label"><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/></label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">姓名:</label>
			<div class="col-sm-3">
				<form:input path="name" htmlEscape="false" maxlength="50" class="form-control required" readonly="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">性别:</label>
			<div class="col-sm-3">
				<form2:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="input-xlarge required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">邮箱:</label>
			<div class="col-sm-3">
				<form:input path="email" htmlEscape="false" maxlength="50" class="form-control email"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">电话:</label>
			<div class="col-sm-3">
				<form:input path="phone" htmlEscape="false" maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">手机:</label>
			<div class="col-sm-3">
				<form:input path="mobile" htmlEscape="false" maxlength="50" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-4">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户类型:</label>
			<div class="col-sm-3">
				<label class="control-label">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户角色:</label>
			<div class="col-sm-3">
				<label class="control-label">${user.roleNames}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">上次登录:</label>
			<div class="col-sm-4">
				<label class="control-label">IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-3 col-sm-offset-2">
				<button type="submit" class="button big" id="btnSubmit">保 存</button>				
			</div>
		</div>
	</form:form>
</body>
</html>