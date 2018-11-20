<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>短信模版管理</title>
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
		<li><a href="${ctx}/template/notifySmsTemplate/">短信模版列表</a></li>
		<li class="active"><a href="${ctx}/template/notifySmsTemplate/form?id=${notifySmsTemplate.id}">短信模版<shiro:hasPermission name="template:notifySmsTemplate:edit">${not empty notifySmsTemplate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="template:notifySmsTemplate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="notifySmsTemplate" action="${ctx}/template/notifySmsTemplate/save" method="post" class="form-horizontal" role="form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">模板类型:</label>
			<div class="col-sm-3">
				<form:select path="smsType" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sms_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<span class="help-block"><font color="red">*</font></span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">短信内容:</label>
			<div class="col-sm-4">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="256" class="form-control required"/>
			</div>
			<span class="help-block"><font color="red">*</font></span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">短信模板ID:</label>
			<div class="col-sm-4">
				<form:input path="smsTemplateId" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">短信签名:</label>
			<div class="col-sm-4">
				<form:input path="signature" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">参数列表:</label>
			<div class="col-sm-4">
				<form:input path="paramStr" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否需要验证码:</label>
			<div class="col-sm-4">
				<form2:radiobuttons path="isSecurityCode" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">验证码超时时长:</label>
			<div class="col-sm-4">
				<form:input path="validTime" class="form-control number"/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
				<shiro:hasPermission name="template:notifySmsTemplate:edit">
					<button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
				</shiro:hasPermission>
				<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>