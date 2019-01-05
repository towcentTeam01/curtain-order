<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员管理</title>
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
		<li class="active"><a href="${ctx}/general/user/">会员列表</a></li>
		<!-- <shiro:hasPermission name="general:user:edit"><li><a href="${ctx}/general/user/form">会员添加</a></li></shiro:hasPermission> -->
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/general/user/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>会员名称：</label>
				<form:input path="loginName" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="mobile" htmlEscape="false" maxlength="64" class="form-control"/>
			</li>
			<li><label>账号状态：</label>
                <form:select path="job" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>帐号</th>
				<th>手机号</th>
				<th>邮箱</th>
				<th>状态</th>
				<th>创建时间</th>
				<shiro:hasPermission name="general:user:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysFrontAccount">
			<tr>
				<td>
				    ${sysFrontAccount.user.loginName}
				</td>
				<td>
					${sysFrontAccount.user.mobile}
				</td>
				<td>
					${sysFrontAccount.user.email}
				</td>
				<td>
				    ${fns:getDictLabel(sysFrontAccount.user.job, 'user_status', '')}
                </td>
				<td>
					<fmt:formatDate value="${sysFrontAccount.user.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="general:user:edit"><td>
    				<a href="${ctx}/general/user/form?id=${sysFrontAccount.user.id}">修改</a>
    				<a href="${ctx}/sys/consigneeAddr/list?user.id=${sysFrontAccount.user.id}">收货地址</a>
					<a href="${ctx}/general/user/delete?id=${sysFrontAccount.user.id}" onclick="return confirmx('确认要删除该会员吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>