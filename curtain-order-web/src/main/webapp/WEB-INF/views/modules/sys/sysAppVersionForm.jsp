<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>版本管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
		<li><a href="${ctx}/sys/sysAppVersion/">版本管理列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysAppVersion/form?id=${sysAppVersion.id}">版本管理<shiro:hasPermission name="sys:sysAppVersion:edit">${not empty sysAppVersion.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysAppVersion:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysAppVersion" action="${ctx}/sys/sysAppVersion/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>当前版本号：</label>
			<div class="col-sm-3">
				<form:input path="currentVersion" htmlEscape="false" maxlength="10" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">兼容版本号：</label>
			<div class="col-sm-3">
				<form:input path="compatibleVersion" htmlEscape="false" maxlength="10" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>版本号名称：</label>
			<div class="col-sm-3">
				<form:input path="versionName" htmlEscape="false" maxlength="20" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">下载地址：</label>
			<div class="col-sm-3">
				<form:input path="url" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>App类型：</label>
			<div class="col-sm-3">
				<form:select path="appType" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>操作系统类型：</label>
			<div class="col-sm-3">
				<form:select path="sysType" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('feedback_app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">更新记录：</label>
			<div class="col-sm-3">
				<form:input path="updateContent" htmlEscape="false" maxlength="2000" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">唯一码：</label>
			<div class="col-sm-3">
				<form:input path="md5" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-3">
				<form:input path="remark" htmlEscape="false" maxlength="500" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="sys:sysAppVersion:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>