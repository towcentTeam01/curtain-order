<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>司机列表</title>
	<meta name="decorator" content="blank"/>
    <style type="text/css">
    	.page-header {clear:both;margin:0 20px;padding-top:20px;}
		table {width: 90%;}
		.tron  {background-color:#000}
		
    </style>
    <script type="text/javascript">
	    $(document).ready(function(){
			$('tbody tr').each(function() {
				$(this).click(function () { 
					var obj = $(this).children().children();
					if (obj.attr('checked') != 'checked') {
						obj.attr('checked', 'checked');					
					}
				});
				$(this).dblclick(function(){
					var obj = $(this).children().children();
					obj.attr('checked', 'checked');
					var index = parent.layer.getFrameIndex(window.name);
					var val = $(this).find("input[name=completeCheck]:checked").val();
					var id = $(this).find("input[name=completeCheck]:checked").attr('id');
					parent.$('#driverId').val(id);
					parent.$('#driverIds').val(val);
					parent.checkBindingDriver();
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${carDriverInfo.id}"]').attr("checked","chekced");
		});

		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
	<div style="margin-top: 10px;"></div>
	<form:form id="searchForm" modelAttribute="carDriverInfo" action="${ctx }/tag/tagSearch/searchDriverList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>司机姓名：</label>
				<form:input path="driverName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>司机注册账户：</label>
				<form:input path="account" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>身份证号：</label>
				<form:input path="identityCard" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<!-- <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>  -->
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>司机编号</th>
				<th>司机姓名</th>
				<th>性别</th>
				<th>身份证</th>
				<th>司机注册账户</th>
				<th>是否有效 </th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="carDriverInfo" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${carDriverInfo.id}" value="${carDriverInfo.driverName}"/>
				</td>
				<td>
					${carDriverInfo.driverNo}
				</td>
				<td>
					${carDriverInfo.driverName}
				</td>
				<td>
					${fns:getDictLabel(carDriverInfo.sex, 'sex', '')}
				</td>
				<td>
					${carDriverInfo.identityCard}
				</td>
				<td>
					${carDriverInfo.account}
				</td>
				<td>
					${fns:getDictLabel(carDriverInfo.isEnabled, 'is_enabled', '')}
				</td>
				<td>
					<fmt:formatDate value="${carDriverInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>