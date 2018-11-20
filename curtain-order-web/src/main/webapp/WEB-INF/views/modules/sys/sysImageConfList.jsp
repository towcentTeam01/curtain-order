<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片上传配置管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysImageConf/">图片配置列表</a></li>
		<shiro:hasPermission name="sys:sysImageConf:edit"><li><a href="${ctx}/sys/sysImageConf/form">图片配置添加</a></li></shiro:hasPermission>
	</ul>
	<%--<form:form id="searchForm" modelAttribute="sysImageConf" action="${ctx}/sys/sysImageConf/" method="post" class="navbar-form form-search" role="form">--%>
		<%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>--%>
		<%--<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
		<%--<ul class="ul-form">--%>
			<%--<li><label>图片类型(数据字典:image_type)：</label>--%>
				<%--<form:input path="imageType" htmlEscape="false" maxlength="11" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li><label>图片相对路径(图片服务器：app/icon/)：</label>--%>
				<%--<form:input path="imagePath" htmlEscape="false" maxlength="200" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li><label>子目录格式(yyyyMM|yyyyMMdd)：</label>--%>
				<%--<form:input path="subDirFormat" htmlEscape="false" maxlength="200" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li><label>原图是否需要压缩(1:是 0:否)：</label>--%>
				<%--<form:input path="isOriginalCompress" htmlEscape="false" maxlength="1" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li><label>是否需要缩略图(1:是 0:否)：</label>--%>
				<%--<form:input path="isThumb" htmlEscape="false" maxlength="1" class="form-control"/>--%>
			<%--</li>--%>
			<%--<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>--%>
			<%--<li class="clearfix"></li>--%>
		<%--</ul>--%>
	<%--</form:form>--%>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>图片类型</th>
				<th>图片相对路径</th>
				<th>子目录格式</th>
				<th>原图是否需要压缩</th>
				<th>原图尺寸</th>
				<th>是否需要缩略图</th>
				<th>缩略图尺寸</th>
				<th>更新时间</th>
				<shiro:hasPermission name="sys:sysImageConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysImageConf">
			<tr>
				<td>
					${fns:getDictLabel(sysImageConf.imageType, 'image_type', '')}
				</td>
				<td>
					${sysImageConf.imagePath}
				</td>
				<td>
					${sysImageConf.subDirFormat}
				</td>
				<td>
					${fns:getDictLabel(sysImageConf.isOriginalCompress, 'yes_no', '')}
				</td>
				<td>
					${sysImageConf.originalSize}
				</td>
				<td>
					${fns:getDictLabel(sysImageConf.isThumb, 'yes_no', '')}
				</td>
				<td>
					${sysImageConf.thumbSize}
				</td>
				<td>
					<fmt:formatDate value="${sysImageConf.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="sys:sysImageConf:edit"><td>
    				<a href="${ctx}/sys/sysImageConf/form?id=${sysImageConf.id}">修改</a>
					<a href="${ctx}/sys/sysImageConf/delete?id=${sysImageConf.id}" onclick="return confirmx('确认要删除该图片上传配置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>