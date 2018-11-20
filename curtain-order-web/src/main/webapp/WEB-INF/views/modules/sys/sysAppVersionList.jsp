<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>版本管理管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysAppVersion/">版本管理列表</a></li>
		<shiro:hasPermission name="sys:sysAppVersion:edit"><li><a href="${ctx}/sys/sysAppVersion/form">版本管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysAppVersion" action="${ctx}/sys/sysAppVersion/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>当前版本号：</label>
				<form:input path="currentVersion" htmlEscape="false" maxlength="10" class="form-control"/>
			</li>
			<li><label>App类型：</label>
				<form:select path="appType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>操作系统类型：</label>
				<form:select path="sysType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('feedback_app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>当前版本号</th>
				<th>兼容版本号</th>
				<th>版本号名称</th>
				<th>下载地址</th>
				<th>App类型</th>
				<th>操作系统类型</th>
				<th>更新记录</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>更新人</th>
				<th>更新时间</th>
				<th>唯一码</th>
				<th>备注</th>
				<shiro:hasPermission name="sys:sysAppVersion:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysAppVersion">
			<tr>
				<td><a href="${ctx}/sys/sysAppVersion/form?id=${sysAppVersion.id}">
					${sysAppVersion.currentVersion}
				</a></td>
				<td>
					${sysAppVersion.compatibleVersion}
				</td>
				<td>
					${sysAppVersion.versionName}
				</td>
				<td>
					${sysAppVersion.url}
				</td>
				<td>
					${fns:getDictLabel(sysAppVersion.appType, 'app_type', '')}
				</td>
				<td>
					${fns:getDictLabel(sysAppVersion.sysType, 'feedback_app_type', '')}
				</td>
				<td>
					${sysAppVersion.updateContent}
				</td>
				<td>
					${sysAppVersion.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysAppVersion.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysAppVersion.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysAppVersion.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysAppVersion.md5}
				</td>
				<td>
					${sysAppVersion.remark}
				</td>
				<shiro:hasPermission name="sys:sysAppVersion:edit"><td>
    				<a href="${ctx}/sys/sysAppVersion/form?id=${sysAppVersion.id}">修改</a>
					<a href="${ctx}/sys/sysAppVersion/delete?id=${sysAppVersion.id}" onclick="return confirmx('确认要删除该版本管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>