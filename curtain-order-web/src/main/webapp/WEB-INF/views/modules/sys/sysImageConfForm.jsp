<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片配置管理</title>
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
		<li><a href="${ctx}/sys/sysImageConf/">图片配置列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysImageConf/form?id=${sysImageConf.id}">图片配置<shiro:hasPermission name="sys:sysImageConf:edit">${not empty sysImageConf.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysImageConf:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysImageConf" action="${ctx}/sys/sysImageConf/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				图片类型：
			</label>
			<div class="col-sm-3">
				<%--<form:input path="imageType" htmlEscape="false" maxlength="11" class="form-control required"/>--%>
					<form:select path="imageType" class="form-control">
						<form:option value="" label="请选择"/>
						<form:options items="${fns:getDictList('image_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				图片相对路径：
			</label>
			<div class="col-sm-3">
				<form:input path="imagePath" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
			<p class="col-sm-5 help-block">
				图片服务器：app/icon/
			</p>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				子目录格式：
			</label>
			<div class="col-sm-3">
				<%--<form:input path="subDirFormat" htmlEscape="false" maxlength="200" class="form-control "/>--%>
				<form:select path="subDirFormat" class="form-control">
					<form:option value="" label="请选择"/>
					<form:option value="yyyyMM" label="yyyyMM"/>
					<form:option value="yyyyMMdd" label="yyyyMMdd"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				原图是否需要压缩：
			</label>
			<div class="col-sm-3">
				<%--<form:input path="isOriginalCompress" htmlEscape="false" maxlength="1" class="form-control "/>--%>
				<form:select path="isOriginalCompress" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				原图尺寸：
			</label>
			<div class="col-sm-3">
				<form:input path="originalSize" htmlEscape="false" maxlength="30" class="form-control "/>
			</div>
			<p class="col-sm-5 help-block">
				例如1024X1024
			</p>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				是否需要缩略图：
			</label>
			<div class="col-sm-3">
				<%--<form:input path="isThumb" htmlEscape="false" maxlength="1" class="form-control "/>--%>
				<form:select path="isThumb" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				缩略图尺寸：
			</label>
			<div class="col-sm-3">
				<form:input path="thumbSize" htmlEscape="false" maxlength="30" class="form-control "/>
			</div>
			<p class="col-sm-5 help-block">
				例如230X230
			</p>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="sys:sysImageConf:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>