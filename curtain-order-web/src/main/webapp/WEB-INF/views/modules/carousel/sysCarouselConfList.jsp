<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>轮播图配置表管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysCarouselConf/">轮播图配置表列表</a></li>
		<shiro:hasPermission name="sys:sysCarouselConf:edit"><li><a href="${ctx}/sys/sysCarouselConf/form">轮播图配置表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysCarouselConf" action="${ctx}/sys/sysCarouselConf/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>轮播图类型：</label>
				<form:select path="carouselType" cssClass="input-sm required">
					<form:option value="">--请选择--</form:option>
					<form:options items="${fns:getDictList('carousel_type')}" itemLabel="label" itemValue="value"/>
				</form:select>
				<%--<form:input path="carouselType" htmlEscape="false" maxlength="2" class="form-control"/>--%>
			</li>
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>是否是链接：</label>
				<form:select path="isHref" cssClass="input-small required">
					<form:option value="">--请选择--</form:option>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</form:select>
				<%--<form:input path="isHref" htmlEscape="false" maxlength="1" class="form-control"/>--%>
			</li>
			<%--<li><label>创建者：</label>--%>
				<%--<form:input path="createBy.id" htmlEscape="false" maxlength="11" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li><label>更新者：</label>--%>
				<%--<form:input path="updateBy.id" htmlEscape="false" maxlength="11" class="form-control"/>--%>
			<%--</li>--%>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>轮播图类型</th>
				<th>标题</th>
				<th>图片地址</th>
				<th>是否是链接</th>
				<th>目标链接</th>
				<th>排序</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="sys:sysCarouselConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysCarouselConf">
			<tr>
				<td>
					${fns:getDictLabel(sysCarouselConf.carouselType, 'carousel_type', '')}
				</td>
				<td>
					${sysCarouselConf.title}
				</td>
				<td>
					${sysCarouselConf.url}
				</td>
				<td>
					${fns:getDictLabel(sysCarouselConf.isHref, 'yes_no', '')}
				</td>
				<td>
					${sysCarouselConf.targetUrl}
				</td>
				<td>
					${sysCarouselConf.sort}
				</td>
				<td>
					${sysCarouselConf.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysCarouselConf.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysCarouselConf.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysCarouselConf.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysCarouselConf.remark}
				</td>
				<shiro:hasPermission name="sys:sysCarouselConf:edit"><td>
    				<a href="${ctx}/sys/sysCarouselConf/form?id=${sysCarouselConf.id}">修改</a>
					<a href="${ctx}/sys/sysCarouselConf/delete?id=${sysCarouselConf.id}" onclick="return confirmx('确认要删除该轮播图配置表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>