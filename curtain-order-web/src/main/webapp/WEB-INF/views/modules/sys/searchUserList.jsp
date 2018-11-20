<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		$('tbody tr').each(function() {
			$(this).click(function () { 
				var obj = $(this).children().children();
				if (obj.attr('checked') != 'checked') {
					obj.attr('checked', 'checked');					
				}
			});
			$(this).dblclick(function(){
				var obj = $(this).children().children();
				obj.attr('checked', 'checked');
				$('.jbox-button', parent.document).each(function(){
					if ($(this).val() == 'ok') {
						$(this).click();	
					}
				});
			});
		});
	});
	function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/tag/tagSearch/searchUserList");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="user"
		action="${ctx}/tag/tagSearch/searchUserList" method="post"
		class="breadcrumb form-search ">
		<input id="roleName" name="roleName" type="hidden" value="${user.roleName}" />
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
			callback="page();" />
		<ul class="ul-form">
			<li><label>归属公司：</label>
			<sys:treeselect id="company" name="company.id"
					value="${user.company.id}" labelName="company.name"
					labelValue="${user.company.name}" title="公司"
					url="/sys/office/treeData?type=1" cssClass="input-small"
					allowClear="true" sysSelect="true"/></li>
			<li><label>登录名：</label>
			<form:input path="loginName" htmlEscape="false" maxlength="50"
					class="input-medium" /></li>
			<li class="clearfix"></li>
			<li><label>归属部门：</label>
			<sys:treeselect id="office" name="office.id"
					value="${user.office.id}" labelName="office.name"
					labelValue="${user.office.name}" title="部门"
					url="/sys/office/treeData?type=2" cssClass="input-small"
					allowClear="true" notAllowSelectParent="true" /></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label>
			<form:input path="name" htmlEscape="false" maxlength="50"
					class="input-medium" /></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th class="sort-column login_name">登录名</th>
				<th class="sort-column name">姓名</th>
				<th>手机</th>
				<th>电话</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="user" varStatus="vs">
				<tr>
					<td>
						${vs.index+1}
						<input type="radio" name="completeCheck" value="${user.name }" id="${user.id }"/>	
					</td>
					<td>${user.loginName}</td>
					<td>${user.name}</td>
					<td>${user.mobile}</td>
					<td>${user.phone}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>