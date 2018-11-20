<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>轮播图配置表管理</title>
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
		<li><a href="${ctx}/sys/sysCarouselConf/">轮播图配置表列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysCarouselConf/form?id=${sysCarouselConf.id}">轮播图配置表<shiro:hasPermission name="sys:sysCarouselConf:edit">${not empty sysCarouselConf.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysCarouselConf:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysCarouselConf" action="${ctx}/sys/sysCarouselConf/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				轮播图类型：
			</label>
			<div class="col-sm-3">
				<form:select path="carouselType" cssClass="input-sm required">
					<form:option value=""> --请选择-- </form:option>
					<form:options items="${fns:getDictList('carousel_type')}" itemLabel="label" itemValue="value"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				标题：
			</label>
			<div class="col-sm-3">
				<form:input path="title" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				图片(请勿上传多张图片)：
			</label>
			<div class="col-sm-3">
				<sys:fileInput path="url" value="${sysCarouselConf.url}" type="icon" thumbSize="200X200"></sys:fileInput>

			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				是否是链接：
			</label>
			<div class="col-sm-3">
				<form:select path="isHref" cssClass="input-small required">
					<form:option value="">--请选择--</form:option>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				目标链接：
			</label>
			<div class="col-sm-3">
				<form:input path="targetUrl" htmlEscape="false" maxlength="500" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				排序：
			</label>
			<div class="col-sm-3">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				备注：
			</label>
			<div class="col-sm-3">
				<form:input path="remark" htmlEscape="false" maxlength="255" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="sys:sysCarouselConf:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>