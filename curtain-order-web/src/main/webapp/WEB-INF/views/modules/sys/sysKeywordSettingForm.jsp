<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关键字管理</title>
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
					}else if(element.parent().is(".input-group")){
						error.insertAfter(element.parent());
					}else if(element.is('select')){
						error.insertAfter(element.next());
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
		<li><a href="${ctx}/sys/sysKeywordSetting/">关键字列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysKeywordSetting/form?id=${sysKeywordSetting.id}">关键字<shiro:hasPermission name="sys:sysKeywordSetting:edit">${not empty sysKeywordSetting.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysKeywordSetting:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysKeywordSetting" action="${ctx}/sys/sysKeywordSetting/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>关键字类型：</label>
			<div class="col-sm-3">
				<form:select path="keywordType" class="form-control required">
					<form:options items="${fns:getDictList('keyword_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>关键字：</label>
			<div class="col-sm-3">
				<form:input path="keyword" htmlEscape="false" maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="sys:sysKeywordSetting:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>