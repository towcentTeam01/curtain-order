<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>运输线路列表</title>
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
					parent.$('#lineId').val(id);
					parent.$('#lineIds').val(val);
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${baseTransportLine.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="baseTransportLine" action="${ctx }/tag/tagSearch/searchLineList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>线路名称：</label>
				<form:input path="lineName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>线路类型：</label>
				<form:select path="lineType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('transport_line_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>线路名称</th>
				<th>线路类型</th>
				<th>参考发运价(元)</th>
				<th>参考里程(公里)</th>
				<th>运行时效(小时)</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="ransportLine" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${ransportLine.id}" value="${ransportLine.lineName}"/>
				</td>
				<td>
					${ransportLine.lineName}
				</td>
				<td>
					${fns:getDictLabel(ransportLine.lineType, 'transport_line_type', '')}
				</td>
				<td>
					${ransportLine.reTransportPrice}
				</td>
				<td>
					${ransportLine.reMileage}
				</td>
				<td>
					${ransportLine.transportTime}
				</td>
				<td>
					<fmt:formatDate value="${ransportLine.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>