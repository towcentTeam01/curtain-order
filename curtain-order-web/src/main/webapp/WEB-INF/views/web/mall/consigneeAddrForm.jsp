<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收货地址管理</title>
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
		<li><a href="${ctx}/mall/consigneeAddr/">收货地址列表</a></li>
		<li class="active"><a href="${ctx}/mall/consigneeAddr/form?id=${consigneeAddr.id}">收货地址<shiro:hasPermission name="mall:consigneeAddr:edit">${not empty consigneeAddr.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:consigneeAddr:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="consigneeAddr" action="${ctx}/mall/consigneeAddr/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
			<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				收货人姓名：
			</label>
			<div class="col-sm-3">
				<form:input path="consigneeName" htmlEscape="false" maxlength="20" class="form-control required"/>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				省：
			</label>
			<div class="col-sm-3">
				<form:input path="province" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				市：
			</label>
			<div class="col-sm-3">
				<form:input path="city" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				区：
			</label>
			<div class="col-sm-3">
				<form:input path="district" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				详细地址：
			</label>
			<div class="col-sm-3">
				<form:input path="detailAddr" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
			<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				收货地址：
			</label>
			<div class="col-sm-3">
				<form:input path="address" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
			<span class="col-sm-4 help-block">尽量填写完整省市区地址</span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
			<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				手机号码：
			</label>
			<div class="col-sm-3">
				<form:input path="mobilePhone" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
			<span class="col-sm-4 help-block">手机或者电话至少填一项</span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				电话号码：
			</label>
			<div class="col-sm-3">
				<form:input path="telephone" htmlEscape="false" maxlength="20" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
			<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				是否默认地址：
			</label>
			<div class="col-sm-3">
			    <form:select path="defaultFlag" class="form-control required">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				会员id：
			</label>
			<div class="col-sm-3">
				<sys:treeselect id="user" name="user.id" value="${consigneeAddr.user.id}" labelName="user.name" labelValue="${consigneeAddr.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				标签：
			</label>
			<div class="col-sm-3">
				<form:input path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
			</div>
			<span class="col-sm-4 help-block">如：家，公司</span>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				商户id：
			</label>
			<div class="col-sm-3">
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="mall:consigneeAddr:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>