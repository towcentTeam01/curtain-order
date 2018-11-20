<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统公告管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysNotice/">系统公告列表</a></li>
		<shiro:hasPermission name="sys:sysNotice:edit"><li><a href="${ctx}/sys/sysNotice/form">系统公告添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysNotice" action="${ctx}/sys/sysNotice/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="500" class="form-control"/>
			</li>
			<li><label>类型：</label>
				<form:select path="noticeType" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('notice_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>App类别：</label>
				<form:select path="appType" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>标题</th>
				<th>内容</th>
				<th>类型</th>
				<th>App类别</th>
				<th>创建时间</th>
				<th>创建人</th>
				<shiro:hasPermission name="sys:sysNotice:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysNotice">
			<tr>
				<td>
					${sysNotice.title}
				</td>
				<td>
					${sysNotice.content}
				</td>
				<td>
					${fns:getDictLabel(sysNotice.noticeType, 'notice_type', '')}
				</td>
				<td>
						${fns:getDictLabel(sysNotice.appType, 'app_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${sysNotice.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysNotice.createBy.id}
				</td>
				<shiro:hasPermission name="sys:sysNotice:edit"><td>
    				<a href="${ctx}/sys/sysNotice/form?id=${sysNotice.id}">修改</a>
					<a href="${ctx}/sys/sysNotice/delete?id=${sysNotice.id}" onclick="return confirmx('确认要删除该系统公告吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>