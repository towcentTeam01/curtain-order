<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商户账号管理</title>
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
		<li><a href="${ctx}/sys/sysUserMerchantRel/">商户账号列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysUserMerchantRel/form?id=${sysUserMerchantRel.id}">商户账号<shiro:hasPermission name="sys:sysUserMerchantRel:edit">${not empty sysUserMerchantRel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysUserMerchantRel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysUserMerchantRel" action="${ctx}/sys/sysUserMerchantRel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				系统用户：
			</label>
			<div class="col-sm-3">
			    <sys:tagSearchList
                    id="user.id"
                    value="${sysUserMerchantRel.user.id}"
                    name="user.name"
                    labelValue="${sysUserMerchantRel.user.name}"
                    url="${ctx}/sys/tag/searchUserList"
                    placeholder="选择系统用户"
                    cssClass="form-control">
                </sys:tagSearchList>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				商户：
			</label>
			<div class="col-sm-3">
			    <sys:tagSearchList
                    id="merchant.id"
                    value="${sysUserMerchantRel.merchant.id}"
                    name="merchant.shopName"
                    labelValue="${sysUserMerchantRel.merchant.merchantName}"
                    url="${ctx}/sys/sysMerchantInfo/searchMerchantList"
                    placeholder="选择商户"
                    cssClass="form-control">
                </sys:tagSearchList>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="sys:sysUserMerchantRel:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>