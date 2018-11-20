<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商户账号管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysUserMerchantRel/">商户账号列表</a></li>
		<shiro:hasPermission name="sys:sysUserMerchantRel:edit"><li><a href="${ctx}/sys/sysUserMerchantRel/form">商户账号添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysUserMerchantRel" action="${ctx}/sys/sysUserMerchantRel/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>系统用户：</label>
			    <sys:tagSearchList
                    id="user.id"
                    value="${sysUserMerchantRel.user.id}"
                    name="user.name"
                    labelValue="${sysUserMerchantRel.user.name}"
                    url="${ctx}/sys/tag/searchUserList"
                    placeholder="选择系统用户"
                    cssClass="form-control">
                </sys:tagSearchList>
			</li>
			<li><label>商户：</label>
			    <sys:tagSearchList
                    id="merchant.id"
                    value="${sysUserMerchantRel.merchant.id}"
                    name="merchant.merchantName"
                    labelValue="${sysUserMerchantRel.merchant.merchantName}"
                    url="${ctx}/sys/sysMerchantInfo/searchMerchantList"
                    placeholder="选择商户"
                    cssClass="form-control">
                </sys:tagSearchList>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>系统登录名</th>
				<th>用户姓名</th>
				<th>商户编码</th>
				<th>商户名称</th>
				<shiro:hasPermission name="sys:sysUserMerchantRel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysUserMerchantRel">
			<tr>
				<td>
					${sysUserMerchantRel.user.loginName}
				</td>
				<td>
                    ${sysUserMerchantRel.user.name}
                </td>
				<td>
					${sysUserMerchantRel.merchant.merchantNo}
				</td>
				<td>
                    ${sysUserMerchantRel.merchant.merchantName}
                </td>
				<shiro:hasPermission name="sys:sysUserMerchantRel:edit"><td>
					<a href="${ctx}/sys/sysUserMerchantRel/delete?id=${sysUserMerchantRel.id}" onclick="return confirmx('确认要删除该关系吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>