<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图库管理</title>
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
		<li><a href="${ctx}/image/imageTempSpace/">图库列表</a></li>
		<li class="active"><a href="${ctx}/image/imageTempSpace/form?id=${imageTempSpace.id}">图库<shiro:hasPermission name="image:imageTempSpace:edit">${not empty imageTempSpace.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="image:imageTempSpace:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="imageTempSpace" action="${ctx}/image/imageTempSpace/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">商家id：</label>
			<div class="col-sm-3">
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="form-control  digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">图片名称：</label>
			<div class="col-sm-3">
				<form:input path="picName" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">图片相对路径：</label>
			<div class="col-sm-3">
				<form:input path="picUrl" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">商品id：</label>
			<div class="col-sm-3">
				<form:input path="goodsId" htmlEscape="false" maxlength="11" class="form-control  digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">图片类型(0:窗口图 1:详情图)：</label>
			<div class="col-sm-3">
				<form:input path="picType" htmlEscape="false" maxlength="1" class="form-control "/>
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
			<shiro:hasPermission name="image:imageTempSpace:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>