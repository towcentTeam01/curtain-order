<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>站内信管理</title>
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
		<li class="active"><a href="${ctx}/mail/notifyMail/">站内信列表</a></li>
		<shiro:hasPermission name="mail:notifyMail:edit"><li><a href="${ctx}/mail/notifyMail/form">站内信添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="notifyMail" action="${ctx}/mail/notifyMail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="500" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="noticeType" class="input-medium" >
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('notice_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>App类别：</label>
				<form:select path="appType" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>是否已读：</label>
				<form:select path="isRead" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('is_read')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>业务编码：</label>
				<form:input path="bizNo" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
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
				<th>账号</th>
				<th>App类别</th>
				<th>创建时间</th>
				<th>业务编码</th>
				<th>是否已读</th>
				<shiro:hasPermission name="mail:notifyMail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="notifyMail">
			<tr>
				<td><a href="${ctx}/mail/notifyMail/form?id=${notifyMail.id}">
					${notifyMail.title}
				</a></td>
				<td>
					${notifyMail.content}
				</td>
				<td>
					${fns:getDictLabel(notifyMail.noticeType, 'notice_type', '')}
				</td>
				<td>
					<c:if test="${notifyMail.appType == '2'}">
						${notifyMail.user.name}			
					</c:if>
					<c:if test="${notifyMail.appType == '1'}">
						${notifyMail.user.phone}		
					</c:if>
				</td>
				<td>
					${fns:getDictLabel(notifyMail.appType, 'app_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${notifyMail.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${notifyMail.bizNo}
				</td>
				<td>
					${fns:getDictLabel(notifyMail.isRead, 'is_read', '')}
				</td>
				<shiro:hasPermission name="mail:notifyMail:edit"><td>
    				<a href="${ctx}/mail/notifyMail/form?id=${notifyMail.id}">修改</a>
					<a href="${ctx}/mail/notifyMail/delete?id=${notifyMail.id}" onclick="return confirmx('确认要删除该站内信吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>