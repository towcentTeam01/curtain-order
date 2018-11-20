<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>车主列表</title>
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
		
			$('input[name=completeCheck][value="${baseCarOwner.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="baseCarOwner" action="${ctx }/tag/tagSearch/searchCarOwnerList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>车主代码：</label>
				<form:input path="ownerNo" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>车主名称：</label>
				<form:input path="ownerCnName" htmlEscape="false" maxlength="200" class="form-control"/>
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
				<th>车主代码</th>
				<th>车主简称</th>
				<th>地址</th>
				<th>手机号码</th>
				<th>是否有效</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="baseCarOwner" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${baseCarOwner.id}" value="${baseCarOwner.ownerShortName}"/>
				</td>
				<td>
					${baseCarOwner.ownerNo}
				</td>
				<td>
					${baseCarOwner.ownerShortName}
				</td>
				<td>
					${baseCarOwner.address}
				</td>
				<td>
					${baseCarOwner.mobilePhone}
				</td>
				<td>
					${fns:getDictLabel(baseCarOwner.isEnabled, 'is_enabled', '')}
				</td>
				<td>
					<fmt:formatDate value="${baseCarOwner.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>