<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>意见反馈管理</title>
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
		<li class="active"><a href="${ctx}/feedback/sysAppFeedback/">意见反馈列表</a></li>
		<%-- <shiro:hasPermission name="feedback:sysAppFeedback:edit"><li><a href="${ctx}/feedback/sysAppFeedback/form">意见反馈添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="sysAppFeedback" action="${ctx}/feedback/sysAppFeedback/" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>反馈账号：</label>
				<form:input path="account" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li>
				<label>反馈内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="1000" class="form-control"/>
			</li>
			<li>
				<label style="width:100px;">手机操作系统：</label>
				<form:select path="sysType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('feedback_app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>App类别：</label>
				<form:input path="appType" htmlEscape="false" maxlength="4" class="form-control"/>
			</li>
			<li>
				<label>反馈时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${sysAppFeedback.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${sysAppFeedback.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns">
				<button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button>
			</li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>反馈账号</th>
				<th>反馈内容</th>
				<th>手机型号</th>
				<th>系统版本</th>
				<th>手机操作系统</th>
				<th>应用版本</th>
				<th>App类别</th>
				<th>反馈类别</th>
				<th>图片</th>
				<th>联系方式</th>
				<th>反馈时间</th>
				<shiro:hasPermission name="feedback:sysAppFeedback:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysAppFeedback">
			<tr>
				<td><a href="${ctx}/feedback/sysAppFeedback/form?id=${sysAppFeedback.id}">
					${sysAppFeedback.account}
				</a></td>
				<td>
					${sysAppFeedback.content}
				</td>
				<td>
					${sysAppFeedback.phoneModel}
				</td>
				<td>
					${sysAppFeedback.sysVersion}
				</td>
				<td>
					${fns:getDictLabel(sysAppFeedback.sysType, 'feedback_app_type', '')}
				</td>
				<td>
					${sysAppFeedback.appVersion}
				</td>
				<td>
					${fns:getDictLabel(sysAppFeedback.appType, 'app_type', '')}
				</td>
				<td>
					${fns:getDictLabel(sysAppFeedback.feedback_type, 'feedback_type', '')}
				</td>
				<td>
					<c:if test="${not empty sysAppFeedback.picUrl}">
						<c:forEach var="img" items="${sysAppFeedback.picUrl.split(';') }">
							<a href="${img }" target="_blank"><img alt="" src="${img }" width="100px;" height="100px;"></a>&nbsp;&nbsp;
						</c:forEach>
					</c:if>
				</td>
				<td>
					${sysAppFeedback.contact }
				</td>
				<td>
					<fmt:formatDate value="${sysAppFeedback.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="feedback:sysAppFeedback:edit"><td>
    				<a href="${ctx}/feedback/sysAppFeedback/form?id=${sysAppFeedback.id}">修改</a>
					<a href="${ctx}/feedback/sysAppFeedback/delete?id=${sysAppFeedback.id}" onclick="return confirmx('确认要删除该意见反馈吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>