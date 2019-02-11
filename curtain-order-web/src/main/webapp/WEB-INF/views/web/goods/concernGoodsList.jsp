<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关注商品管理</title>
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

        function detail(id) {
                if (!id) return;
                window.location.href = "${ctx}/mall/goods/detail?goodsId=" + id;
            }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/goods/concernGoods/">商品收藏列表</a></li>
		<%-- <shiro:hasPermission name="goods:concernGoods:edit"><li><a href="${ctx}/goods/concernGoods/form">关注商品添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="concernGoods" action="${ctx}/goods/concernGoods/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品名称：</label>
				<form:input path="goods.goodsName" htmlEscape="false" maxlength="11" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width: 50px;text-align: center;">商品图片</th>
				<th>商品型号</th>
				<th>商品名称</th>
				<th>关注时间</th>
				<shiro:hasPermission name="goods:concernGoods:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="concernGoods">
			<tr>
			    <td>
			        <img style="width: 50px;height: 50px; object-fit: contain;" src="${concernGoods.picUrl}"/>
			    </td>
				<td>
				    <a href="#" onclick="detail('${concernGoods.goods.id}')">
					${concernGoods.goods.goodsNo}
					</a>
				</td>
				<td>${concernGoods.goods.goodsName}</td>
				<td>
					<fmt:formatDate value="${concernGoods.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="goods:concernGoods:edit"><td>
    				<%-- <a href="${ctx}/goods/concernGoods/form?id=${concernGoods.id}">修改</a> --%>
					<a href="${ctx}/goods/concernGoods/delete?id=${concernGoods.id}" onclick="return confirmx('确认要删除该关注商品吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>