<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商户管理管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysMerchantInfo/">商户管理列表</a></li>
		<shiro:hasPermission name="sys:sysMerchantInfo:edit"><li><a href="${ctx}/sys/sysMerchantInfo/form">商户管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysMerchantInfo" action="${ctx}/sys/sysMerchantInfo/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商户编码：</label>
				<form:input path="merchantNo" htmlEscape="false" maxlength="64" class="form-control"/>
			</li>
			<li><label>商户名称：</label>
				<form:input path="merchantName" htmlEscape="false" maxlength="200" class="form-control"/>
			</li>
			<li><label>启用标识：</label>
				<form:select path="enabledFlag" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('enabled_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>商户编码</th>
				<th>商户名称</th>
				<th>联系电话</th>
				<th>客服电话</th>
				<th>详细地址</th>
				<th>启用标识</th>
				<th>注备</th>
				<th>更新时间</th>
				<shiro:hasPermission name="sys:sysMerchantInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysMerchantInfo">
			<tr>
				<td><a href="${ctx}/sys/sysMerchantInfo/form?id=${sysMerchantInfo.id}">
					${sysMerchantInfo.merchantNo}
				</a></td>
				<td>
					${sysMerchantInfo.merchantName}
				</td>
				<td>
					${sysMerchantInfo.contactPhone}
				</td>
				<td>
					${sysMerchantInfo.servicePhone}
				</td>
				<td>
					${sysMerchantInfo.address}
				</td>
				<td>
					${fns:getDictLabel(sysMerchantInfo.enabledFlag, 'enabled_flag', '')}
				</td>
				<td>
					${sysMerchantInfo.remarks}
				</td>
				<td>
					<fmt:formatDate value="${sysMerchantInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sys:sysMerchantInfo:edit"><td>
    				<a href="${ctx}/sys/sysMerchantInfo/form?id=${sysMerchantInfo.id}">修改</a>
					<a href="${ctx}/sys/sysMerchantInfo/delete?id=${sysMerchantInfo.id}" onclick="return confirmx('确认要删除该商户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>