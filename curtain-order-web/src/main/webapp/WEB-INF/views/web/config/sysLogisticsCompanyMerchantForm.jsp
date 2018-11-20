<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商家物流配置管理</title>
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
		<li><a href="${ctx}/config/sysLogisticsCompanyMerchant/">商家物流配置列表</a></li>
		<li class="active"><a href="${ctx}/config/sysLogisticsCompanyMerchant/form?id=${sysLogisticsCompanyMerchant.id}">商家物流配置<shiro:hasPermission name="config:sysLogisticsCompanyMerchant:edit">${not empty sysLogisticsCompanyMerchant.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="config:sysLogisticsCompanyMerchant:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysLogisticsCompanyMerchant" action="${ctx}/config/sysLogisticsCompanyMerchant/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				物流公司：
			</label>
			<div class="col-sm-3">
				<sys:tagSearchList
                    id="company.id"
                    value="${sysLogisticsCompanyMerchant.company.id}"
                    name="company.companyName"
                    labelValue="${sysLogisticsCompanyMerchant.company.companyName}"
                    url="${ctx}/sys/sysLogisticsCompany/searchLogisticsCompanyList"
                    placeholder="选择物流公司"
                    cssClass="form-control">
            	</sys:tagSearchList>
				<%-- <form:input path="companyId" htmlEscape="false" maxlength="11" class="form-control required"/> --%>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				商家Id：
			</label>
			<div class="col-sm-3">
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="form-control required"/>
			</div>
		</div> --%>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="config:sysLogisticsCompanyMerchant:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>