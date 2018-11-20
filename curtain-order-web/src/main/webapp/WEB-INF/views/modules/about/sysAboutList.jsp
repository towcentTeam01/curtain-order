<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关于管理</title>
	<meta name="decorator" content="default"/>
	<c:set var="imagePath" value="${fns:getUrlHeader()}"/>
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
		<li class="active"><a href="${ctx}/about/sysAbout/">关于列表</a></li>
		<shiro:hasPermission name="about:sysAbout:edit"><li><a href="${ctx}/about/sysAbout/form">关于添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysAbout" action="${ctx}/about/sysAbout/" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label for="appName">名称：</label>
				<form:input path="appName" htmlEscape="false" maxlength="50" class="form-control" />
			</li>
			<li><label for=appType>类型：</label>
				<form:select path="appType" class="form-control">
					<form:option value="" label="请选择类型"/>
					<form:options items="${fns:getDictList('sysAbout_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><button id="btnSubmit" type="submit" class="button big" onclick="return page();">查询</button></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>LOGO</th>
				<th>app类别</th>
				<th>名称</th>
				<th>关于我们内容</th>
				<th>修改人</th>
				<th>修改日期</th>
				<shiro:hasPermission name="about:sysAbout:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysAbout">
			<tr>
				<td>
					<div class="smallDiv">
						<span><img src="${sysAbout.logo}" alt="" width="100px" height="100px"/></span>
					</div>
				</td>
				<td><a href="${ctx}/about/sysAbout/form?id=${sysAbout.id}">
					${fns:getDictLabel(sysAbout.appType, 'app_type', '')}
				</a></td>
				<td>
					${sysAbout.appName}
				</td>
				<td>
					${sysAbout.about}
				</td>
				<td>
					${sysAbout.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${sysAbout.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="about:sysAbout:edit"><td>
    				<a href="${ctx}/about/sysAbout/form?id=${sysAbout.id}">修改</a>
					<a href="${ctx}/about/sysAbout/delete?id=${sysAbout.id}" onclick="return confirmx('确认要删除该关于吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>