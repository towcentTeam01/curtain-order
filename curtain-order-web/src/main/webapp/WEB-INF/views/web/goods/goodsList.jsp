<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
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
		<li class="active"><a href="${ctx}/goods/goods/">商品列表</a></li>
		<shiro:hasPermission name="goods:goods:edit"><li><a href="${ctx}/goods/goods/form">商品添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="goods" action="${ctx}/goods/goods/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品编码：</label>
				<form:input path="goodsNo" htmlEscape="false" maxlength="50" class="form-control"/>
			</li>
			<li><label>商品名称：</label>
				<form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<%-- <li><label>商品品牌：</label>
				<form:input path="brandName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li> --%>

			<li><label>风格：</label>
                <form:select path="style" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_style')}" itemLabel="label" itemValue="label"
                                  htmlEscape="false"/>
                </form:select>
                <!-- <form:input path="style" htmlEscape="false" maxlength="100" class="form-control"/> -->
            </li>
            <li><label>材质：</label>
                <form:select path="material" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_material')}" itemLabel="label" itemValue="label"
                                  htmlEscape="false"/>
                </form:select>
                <!-- <form:input path="material" htmlEscape="false" maxlength="100" class="form-control"/> -->
            </li>
			<li><label>分类：</label>
                <form:select path="cateNo" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </li>
			<li><label>标签类别：</label>
				<form:select path="labelType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('label_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${goods.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${goods.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
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
				<th>商品编码</th>
				<th>商品名称</th>
				<th>品牌</th>
				<th>门幅</th>
				<th>风格</th>
				<th>材质</th>
				<th>规格</th>
				<th>商品单价</th>
				<th>库存(/米)</th>
				<th>销量</th>
				<th>销售米数(/米)</th>
				<th>分类名称</th>
				<th>标签类别</th>
				<th>注备</th>
				<th>更新时间</th>
				<shiro:hasPermission name="goods:goods:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goods">
			<tr>
				<td>
				    <a href="${ctx}/goods/goods/form?id=${goods.id}">
					${goods.goodsNo}
					</a>
				</td>
				<td>
					${goods.goodsName}
				</td>
				<td>
					${goods.brandName}
				</td>
				<td>
					${goods.larghezza}
				</td>
				<td>
					${goods.style}
				</td>
				<td>
					${goods.material}
				</td>
				<td>
					${goods.specification}
				</td>
				<td>
					${goods.price}
				</td>
				<td>
					${goods.qty}
				</td>
				<td>
					${goods.saleNum}
				</td>
				<td>
					${goods.saleLength}
				</td>
				<td>
                    ${fns:getDictLabel(goods.cateNo, 'goods_category', '')}
                </td>
				<td>
					${fns:getDictLabel(goods.labelType, 'label_type', '')}
				</td>
				<td>
					${goods.remarks}
				</td>
				<td>
					<fmt:formatDate value="${goods.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="goods:goods:edit"><td>
    				<a href="${ctx}/goods/goods/form?id=${goods.id}">修改</a>
					<a href="${ctx}/goods/goods/delete?id=${goods.id}" onclick="return confirmx('确认要删除该商品吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>