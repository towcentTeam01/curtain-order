<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商家物流配置管理</title>
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
		<li class="active"><a href="${ctx}/config/sysLogisticsCompanyMerchant/">商家物流列表</a></li>
		<shiro:hasPermission name="config:sysLogisticsCompanyMerchant:edit"><li><a href="${ctx}/config/sysLogisticsCompanyMerchant/form">商家物流添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysLogisticsCompanyMerchant" action="${ctx}/config/sysLogisticsCompanyMerchant/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物流公司：</label>
				<sys:tagSearchList
                    id="company.id"
                    value="${sysLogisticsCompanyMerchant.company.id}"
                    name="company.companyName"
                    labelValue="${sysLogisticsCompanyMerchant.company.companyName}"
                    url="${ctx}/sys/sysLogisticsCompany/searchLogisticsCompanyList"
                    placeholder="选择物流公司"
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
				<th>Id</th>
				<th>物流公司编码</th>
				<th>物流公司名称</th>
				<th>创建时间</th>
				<shiro:hasPermission name="config:sysLogisticsCompanyMerchant:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysLogisticsCompanyMerchant">
			<tr>
				<td><a href="${ctx}/config/sysLogisticsCompanyMerchant/form?id=${sysLogisticsCompanyMerchant.id}">
					${sysLogisticsCompanyMerchant.id}
				</a></td>
				<td>${sysLogisticsCompanyMerchant.company.companyNo}</td>
				<td>${sysLogisticsCompanyMerchant.company.companyName}</td>
				<td>
					<fmt:formatDate value="${sysLogisticsCompanyMerchant.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="config:sysLogisticsCompanyMerchant:edit"><td>
    				<a href="${ctx}/config/sysLogisticsCompanyMerchant/form?id=${sysLogisticsCompanyMerchant.id}">修改</a>
					<a href="${ctx}/config/sysLogisticsCompanyMerchant/delete?id=${sysLogisticsCompanyMerchant.id}" onclick="return confirmx('确认要删除该商家物流配置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>