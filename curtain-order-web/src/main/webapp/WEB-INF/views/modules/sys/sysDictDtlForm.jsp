<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据字典明细管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					if ($("#checkbox_isValid").attr("checked")=='checked') {
						$('#isValid').val('0');
					} else {
						$('#isValid').val('1');
					}
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
			
			if ($('#isValid').val() == '1') {
				$("#checkbox_isValid").removeAttr("checked");
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/sysDictDtl/">数据字典列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysDictDtl/form?id=${sysDictDtl.id}">数据字典<shiro:hasPermission name="sys:sysDictMain:edit">${not empty sysDictDtl.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysDictMain:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysDictDtl" action="${ctx}/sys/sysDictDtl/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">字典类型:</label>
			<div class="col-sm-3">
                <sys:treeselect id="dictId" name="dictId" value="${sysDictDtl.dictId}" labelName="sysDictDtl.dictName" labelValue="${sysDictDtl.dictName}"
					title="公司" url="/sys/sysDictMain/treeData" cssClass="form-control required" sysSelect="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">名称:</label>
			<div class="col-sm-3">
				<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
			</div>
			<span class="help-block"><font color="red">*</font></span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">代码:</label>
			<div class="col-sm-3">
				<form:input path="code" htmlEscape="false" maxlength="100" class="form-control required abc"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">计算值:</label>
			<div class="col-sm-3">
				<form:input path="calculateVal" htmlEscape="false" maxlength="100" class="form-control number"/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">排序号:</label>
			<div class="col-sm-3">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="form-control input-small required digits"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">描述:</label>
			<div class="col-sm-3">
				<form:input path="description" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否有效:</label>
			<div class="col-sm-3">
				<input type="hidden" id="isValid" name="isValid" value="${sysDictDtl.isValid}">
				<div class="checkbox abc-checkbox abc-checkbox-primary">
					<input type="checkbox" id="checkbox_isValid" checked="checked">
					<label for="checkbox_isValid"></label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-3 col-sm-offset-2">
				<shiro:hasPermission name="sys:sysDictMain:edit">
				<button id="btnSubmit" class="button big" type="submit">保 存</button>&nbsp;
				</shiro:hasPermission>
				<button id="btnCancel" class="button big" type="button" onclick="history.go(-1)">返 回</button>
			</div>
		</div>
	</form:form>
</body>
</html>