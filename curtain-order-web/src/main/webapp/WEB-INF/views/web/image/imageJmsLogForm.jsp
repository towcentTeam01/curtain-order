<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片日志管理</title>
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
		<li><a href="${ctx}/image/imageJmsLog/">图片日志列表</a></li>
		<li class="active"><a href="${ctx}/image/imageJmsLog/form?id=${imageJmsLog.id}">图片日志<shiro:hasPermission name="image:imageJmsLog:edit">${not empty imageJmsLog.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="image:imageJmsLog:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="imageJmsLog" action="${ctx}/image/imageJmsLog/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">商品id：</label>
			<div class="col-sm-3">
				<form:input path="goodsId" htmlEscape="false" maxlength="11" class="form-control  digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">消息体：</label>
			<div class="col-sm-3">
				<form:input path="message" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">状态(0:未处理 1:已处理)：</label>
			<div class="col-sm-3">
				<form:input path="status" htmlEscape="false" maxlength="2" class="form-control  digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">执行次数：</label>
			<div class="col-sm-3">
				<form:input path="actionnum" htmlEscape="false" maxlength="11" class="form-control  digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">注备：</label>
			<div class="col-sm-3">
				<form:input path="remark" htmlEscape="false" maxlength="500" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="image:imageJmsLog:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>