<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关键字管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysKeywordSetting/">关键字列表</a></li>
		<shiro:hasPermission name="sys:sysKeywordSetting:edit"><li><a href="${ctx}/sys/sysKeywordSetting/form">关键字添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysKeywordSetting" action="${ctx}/sys/sysKeywordSetting/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>关键字类型</label>
				<form:select path="keywordType" class="form-control">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('keyword_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>关键字：</label>
				<form:input path="keyword" htmlEscape="false" maxlength="50" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>关键字类型</th>
				<th>关键字</th>
				<th>创建时间</th>
				<shiro:hasPermission name="sys:sysKeywordSetting:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysKeywordSetting" varStatus="vs">
			<tr>
				<td>
					${vs.index+1 }
				</td>
				<td>
					${fns:getDictLabel(sysKeywordSetting.keywordType, 'keyword_type', '')}
				</td>
				<td>
					${sysKeywordSetting.keyword}
				</td>
				<td>
					<fmt:formatDate value="${sysKeywordSetting.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sys:sysKeywordSetting:edit"><td>
    				<a href="${ctx}/sys/sysKeywordSetting/form?id=${sysKeywordSetting.id}">修改</a>
					<a href="${ctx}/sys/sysKeywordSetting/delete?id=${sysKeywordSetting.id}" onclick="return confirmx('确认要删除该关键字吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>