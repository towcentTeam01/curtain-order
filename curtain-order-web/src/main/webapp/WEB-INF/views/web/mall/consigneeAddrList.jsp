<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收货地址管理</title>
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
		<li class="active"><a href="${ctx}/mall/consigneeAddr/">收货地址列表</a></li>
		<shiro:hasPermission name="mall:consigneeAddr:edit"><li><a href="${ctx}/mall/consigneeAddr/form">收货地址添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="consigneeAddr" action="${ctx}/mall/consigneeAddr/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>收货人姓名：</label>
				<form:input path="consigneeName" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>联系方式：</label>
				<form:input path="mobilePhone" htmlEscape="false" maxlength="200" class="form-control"/>
			</li>
			<%-- <li><label>商户id：</label>
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="form-control"/>
			</li> --%>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>收货人姓名</th>
				<th>收货地址</th>
				<th>手机号码</th>
				<th>电话号码</th>
				<th>是否默认地址</th>
				<th>标签</th>
				<th>会员名称</th>
				<th>更新时间</th>
				<shiro:hasPermission name="mall:consigneeAddr:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="consigneeAddr">
			<tr>
				<td><a href="${ctx}/mall/consigneeAddr/form?id=${consigneeAddr.id}">
					${consigneeAddr.consigneeName}
				</a></td>
				<td>
					${consigneeAddr.address}
				</td>
				<td>
					${consigneeAddr.mobilePhone}
				</td>
				<td>
					${consigneeAddr.telephone}
				</td>
				<td>
				    ${fns:getDictLabel(consigneeAddr.defaultFlag, 'yes_no', '')}
				</td>
				<td>
					${consigneeAddr.remarks}
				</td>
				<td>
					${consigneeAddr.user.name}
				</td>
				<td>
					<fmt:formatDate value="${consigneeAddr.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="mall:consigneeAddr:edit"><td>
    				<a href="${ctx}/mall/consigneeAddr/form?id=${consigneeAddr.id}">修改</a>
					<a href="${ctx}/mall/consigneeAddr/delete?id=${consigneeAddr.id}" onclick="return confirmx('确认要删除该收货地址吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>