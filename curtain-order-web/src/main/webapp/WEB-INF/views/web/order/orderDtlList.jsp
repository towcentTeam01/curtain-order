<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单明细管理</title>
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
		<li class="active"><a href="${ctx}/order/orderDtl/">订单明细列表</a></li>
		<shiro:hasPermission name="order:orderDtl:edit"><li><a href="${ctx}/order/orderDtl/form">订单明细添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="orderDtl" action="${ctx}/order/orderDtl/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>订单id：</label>
				<form:input path="orderId" htmlEscape="false" maxlength="11" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>详情说明</th>
				<shiro:hasPermission name="order:orderDtl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderDtl">
			<tr>
				<td><a href="${ctx}/order/orderDtl/form?id=${orderDtl.id}">
					${orderDtl.remarks}
				</a></td>
				<shiro:hasPermission name="order:orderDtl:edit"><td>
    				<a href="${ctx}/order/orderDtl/form?id=${orderDtl.id}">修改</a>
					<a href="${ctx}/order/orderDtl/delete?id=${orderDtl.id}" onclick="return confirmx('确认要删除该订单明细吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>