<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据字典管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysDictDtl/">数据字典列表</a></li>
		<shiro:hasPermission name="sys:sysDictMain:edit"><li><a href="${ctx}/sys/sysDictDtl/form">数据字典添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysDictDtl" action="${ctx}/sys/sysDictDtl/" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="orderBy" name="orderBy" type="hidden" value="a.sort"/>
		<input id="dictId" name="dictId" type="hidden" value="${sysDictDtl.dictId}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="form-control"  style="width:200px;"/>
			</li>
			<li><label>分类名：</label>
				<form:input path="main.name" htmlEscape="false" maxlength="20" class="form-control"  style="width:200px;"/>
			</li>
			<li><label>分类代码：</label>
				<form:input path="main.code" htmlEscape="false" maxlength="100" class="form-control"  style="width:200px;"/>
			</li>
			<li><label>字典类型：</label>
				<form:select path="main.systemFlag" class="form-control">
					<form:option value="">--请选择--</form:option>
					<form:option value="0">系统</form:option>
					<form:option value="1">业务</form:option>
				</form:select>
			</li>
			<li class="btns"><button id="btnSubmit" class="button big" type="submit">查询</button></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>分类名</th>
				<th>代码</th>
				<th>是否有效</th>
				<th>字典类型</th>
				<shiro:hasPermission name="sys:sysDictMain:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysDictDtl">
			<tr>
				<td>
					<a href="${ctx}/sys/sysDictDtl/form?id=${sysDictDtl.id}">
						${sysDictDtl.name}
					</a>
				</td>
				<td>${sysDictDtl.dictName}</td>
				<td>${sysDictDtl.code}</td>
				<td>
					<c:if test="${sysDictDtl.isValid==0}">有效</c:if><c:if test="${sysDictDtl.isValid==1}">无效</c:if>
				</td>
				<td>
					${sysDictDtl.main.systemFlag == 0 ? '系统' : '业务' }
				</td>
				<shiro:hasPermission name="sys:sysDictMain:edit"><td>
					<c:if test="${fns:getUser().id == 1 || (sysDictDtl.main.systemFlag == 1)}">
    				<a href="${ctx}/sys/sysDictDtl/form?id=${sysDictDtl.id}">修改</a>
					<a href="${ctx}/sys/sysDictDtl/delete?id=${sysDictDtl.id}&dictId=${sysDictDtl.dictId}" onclick="return confirmx('确认要删除该数据字典明细吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>