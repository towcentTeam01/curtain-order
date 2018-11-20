<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品频道详情管理</title>
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
		<li><a href="${ctx}/goods/goodsChannel/">商品频道列表</a></li>
		<shiro:hasPermission name="goods:goodsChannel:edit">
			<li><a href="${ctx}/goods/goodsChannel/form">商品频道添加</a></li>
		</shiro:hasPermission>
		<li class="active"><a href="${ctx}/goods/goodsChannelDtl/">商品频道详情列表</a></li>
		<shiro:hasPermission name="goods:goodsChannelDtl:edit"><li><a href="${ctx}/goods/goodsChannelDtl/form">商品频道详情添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="goodsChannelDtl" action="${ctx}/goods/goodsChannelDtl/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品id：</label>
				<form:input path="goods.id" htmlEscape="false" maxlength="11" class="form-control"/>
			</li>
			<li><label>频道id：</label>
				<form:input path="channel.id" htmlEscape="false" maxlength="11" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width: 30%">商品名称</th>
				<th>商品编码</th>
				<th>所属频道</th>
				<th>排序号</th>
				<th>频道商品图片</th>
				<th>创建时间</th>
				<shiro:hasPermission name="goods:goodsChannelDtl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goodsChannelDtl">
			<tr>
				<td><a href="${ctx}/goods/goods/form?id=${goodsChannelDtl.goods.id}">
					${goodsChannelDtl.goods.goodsName}
				</a></td>
				<td><a href="${ctx}/goods/goods/form?id=${goodsChannelDtl.goods.id}">
						${goodsChannelDtl.goods.goodsNo}
				</a></td>
				<td>
					<a href="${ctx}/goods/goodsChannel/form?id=${goodsChannelDtl.channel.id}">${goodsChannelDtl.channel.channelName}</a>
				</td>
				<td>
					${goodsChannelDtl.sort}
				</td>
				<td>
					${goodsChannelDtl.img}
				</td>
				<td>
					<fmt:formatDate value="${goodsChannelDtl.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="goods:goodsChannelDtl:edit"><td>
    				<a href="${ctx}/goods/goodsChannelDtl/form?id=${goodsChannelDtl.id}">修改</a>
					<a href="${ctx}/goods/goodsChannelDtl/delete?id=${goodsChannelDtl.id}" onclick="return confirmx('确认要删除该商品频道详情吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>