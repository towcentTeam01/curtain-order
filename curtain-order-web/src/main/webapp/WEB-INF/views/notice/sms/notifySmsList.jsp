<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>短信管理</title>
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
		<li class="active"><a href="${ctx}/sms/notifySms/">短信列表</a></li>
		<shiro:hasPermission name="sms:notifySms:edit"><li><a href="${ctx}/sms/notifySms/form">短信添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="notifySms" action="${ctx}/sms/notifySms/" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label for="phone" class="control-label">接收手机：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="form-control"/>		
			</li>
			<li>
				<label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
						value="<fmt:formatDate value="${notifySms.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
						value="<fmt:formatDate value="${notifySms.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li>
				<label>短信内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="256" class="form-control" />
			</li>
			<li>
				<label>短信类型：</label>
				<form:select path="smsType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sms_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>短信状态：</label>
				<form:select path="smsStatus" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sms_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns">
				<button type="submit" class="button big" id="btnSubmit"><span class="magnifier icon"></span>查询</button>
			</li>	
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>接收手机</th>
				<th>短信内容</th>
				<th>短信类型</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>消息Id</th>
				<shiro:hasPermission name="sms:notifySms:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="notifySms">
			<tr>
				<td><a href="${ctx}/sms/notifySms/form?id=${notifySms.id}">
					${notifySms.phone}
				</a></td>
				<td>
					${notifySms.content}
				</td>
				<td>
					${fns:getDictLabel(notifySms.smsType, 'sms_type', '')}
				</td>
				<td>
					${fns:getDictLabel(notifySms.smsStatus, 'sms_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${notifySms.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${notifySms.smsid}
				</td>
				<shiro:hasPermission name="sms:notifySms:edit"><td>
    				<a href="${ctx}/sms/notifySms/form?id=${notifySms.id}">修改</a>
					<a href="${ctx}/sms/notifySms/delete?id=${notifySms.id}" onclick="return confirmx('确认要删除该短信吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>