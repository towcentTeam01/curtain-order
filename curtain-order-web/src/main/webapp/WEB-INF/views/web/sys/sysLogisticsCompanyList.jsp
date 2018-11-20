<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统物流公司管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysLogisticsCompany/">系统物流公司列表</a></li>
		<shiro:hasPermission name="sys:sysLogisticsCompany:edit"><li><a href="${ctx}/sys/sysLogisticsCompany/form">系统物流公司添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysLogisticsCompany" action="${ctx}/sys/sysLogisticsCompany/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物流公司编码：</label>
				<form:input path="companyNo" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>物流公司名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="200" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>Id</th>
				<th>物流公司编码</th>
				<th>物流公司名称</th>
				<th>备注</th>
				<th>更新时间</th>
				<shiro:hasPermission name="sys:sysLogisticsCompany:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysLogisticsCompany">
			<tr>
				<td><a href="${ctx}/sys/sysLogisticsCompany/form?id=${sysLogisticsCompany.id}">
					${sysLogisticsCompany.id}
				</a></td>
				<td>
					${sysLogisticsCompany.companyNo}
				</td>
				<td>
					${sysLogisticsCompany.companyName}
				</td>
				<td>
					${sysLogisticsCompany.remarks}
				</td>
				<td>
					<fmt:formatDate value="${sysLogisticsCompany.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sys:sysLogisticsCompany:edit"><td>
    				<a href="${ctx}/sys/sysLogisticsCompany/form?id=${sysLogisticsCompany.id}">修改</a>
					<a href="${ctx}/sys/sysLogisticsCompany/delete?id=${sysLogisticsCompany.id}" onclick="return confirmx('确认要删除该系统物流公司吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>