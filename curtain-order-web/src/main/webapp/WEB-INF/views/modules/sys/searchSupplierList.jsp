<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>其它资料列表</title>
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
					debugger
					parent.$('#${myId}').val(id);
					parent.$('#${myName}').val(val);
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${baseSupplierInfo.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="baseSupplierInfo" action="${ctx }/tag/tagSearch/searchSupplierList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="supType" name="pageSize" type="hidden" value="${baseSupplierInfo.supType}"/>
		<ul class="ul-form">
			<li><label>简称：</label>
				<form:input path="supCnName" htmlEscape="false" maxlength="200" class="form-control"/>
			</li>
			<li><label>联系电话：</label>
				<form:input path="telephone" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>类型：</label>
				<form:select path="supType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('supplier_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
				<th>类型</th>
				<th>简称</th>
				<th>地址</th>
				<th>联系人</th>
				<th>联系电话</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="baseSupplierInfo" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${baseSupplierInfo.id}" value="${baseSupplierInfo.supShortName}"/>
				</td>
					<td>
					${fns:getDictLabel(baseSupplierInfo.supType, 'supplier_type', '')}
				</td>
				<td>
					${baseSupplierInfo.supShortName}
				</td>
				<td>
					${baseSupplierInfo.address}
				</td>
				<td>
					${baseSupplierInfo.contacts}
				</td>
				<td>
					${baseSupplierInfo.telephone}
				</td>
				<td>
					<fmt:formatDate value="${baseSupplierInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>