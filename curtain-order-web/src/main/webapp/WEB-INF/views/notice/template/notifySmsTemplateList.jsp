<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>短信模版管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/template/notifySmsTemplate/">短信模版列表</a></li>
		<shiro:hasPermission name="template:notifySmsTemplate:edit"><li><a href="${ctx}/template/notifySmsTemplate/form">短信模版添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="notifySmsTemplate" action="${ctx}/template/notifySmsTemplate/" method="post" class="form-search navbar-form" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label for="content">内容：</label>	
				<form:input path="content" htmlEscape="false" class="form-control"/>				
			</li>
			<li>
				<label for="smsType">模板类型：</label>
				<form:select path="smsType" class="form-control">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('sms_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>				
			</li>
			<li class="btns">
				<button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button>
			</li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模板类型</th>
				<th>内容</th>
				<th>短信签名</th>
				<th>参数列表</th>
				<th>短信模板ID</th>
				<th>是否验证码</th>
				<th>验证码超时时长(s)</th>
				<th>创建时间</th>
				<th>创建人</th>
				<th>更新时间</th>
				<th>修改人</th>
				<shiro:hasPermission name="template:notifySmsTemplate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="notifySmsTemplate">
			<tr>
				<td><a href="${ctx}/template/notifySmsTemplate/form?id=${notifySmsTemplate.id}">
					${fns:getDictLabel(notifySmsTemplate.smsType, 'sms_type', '')}
				</a></td>
				<td>
					${notifySmsTemplate.content}
				</td>
				<td>${notifySmsTemplate.signature }</td>
				<td>${notifySmsTemplate.paramStr }</td>
				<td>${notifySmsTemplate.smsTemplateId }</td>
				<td>${fns:getDictLabel(notifySmsTemplate.isSecurityCode, 'yes_no', '')}</td>
				<td>${notifySmsTemplate.validTime}</td>
				<td>
					<fmt:formatDate value="${notifySmsTemplate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${notifySmsTemplate.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${notifySmsTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${notifySmsTemplate.updateBy.name}
				</td>
				<shiro:hasPermission name="template:notifySmsTemplate:edit"><td>
    				<a href="${ctx}/template/notifySmsTemplate/form?id=${notifySmsTemplate.id}">修改</a>
					<a href="${ctx}/template/notifySmsTemplate/delete?id=${notifySmsTemplate.id}" onclick="return confirmx('确认要删除该短信模版吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>