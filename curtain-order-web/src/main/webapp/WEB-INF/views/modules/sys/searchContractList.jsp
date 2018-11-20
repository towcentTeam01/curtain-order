<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>店铺列表</title>
	<meta name="decorator" content="blank"/>
    <style type="text/css">
    	.page-header {clear:both;margin:0 20px;padding-top:20px;}
		table {width: 90%;}
		.tron  {background-color:#000}
		
    </style>
    <script type="text/javascript">
	    $(document).ready(function(){
			$('#tbody_id tr').each(function() {
				$(this).click(function () { 
					var obj = $(this).children().children();
					if (obj.attr('checked') != 'checked') {
						obj.attr('checked', 'checked');					
					}
				});
				$(this).dblclick(function(){
					var obj = $(this).children().children();
					obj.attr('checked', 'checked');
					$('.jbox-button', parent.document).each(function(){
						if ($(this).val() == 'ok') {
							$(this).click();	
						}
					});
				});
			});
		
			$('input[name=completeCheck][value="${contract.contractNo}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="contract" action="${ctx }/tag/tagSearch/searchContractList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>合同编码：</label>
				<form:input path="contractNo" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>所属分公司：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>客户公司：</label>
				<form:input path="csrCompanyName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>工程名：</label>
				<form:input path="projectName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>合同编码</th>
				<th>所属分公司</th>
				<th>客户公司</th>
				<th>联系人</th>
				<th>电话号码</th>
				<th>工程名</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="contract" varStatus="vs">
			<tr>
				<td>
					${vs.index+1 }
					<input type="radio" name="completeCheck" value="${contract.contractNo }"/>
				</td>
				<td>
					${contract.contractNo}
				</td>
				<td>
					${contract.company.name}
				</td>
				<td>
					${contract.csrCompanyName}
				<td>
					${contract.linkMan}
				</td>
				<td>
					${contract.linkPhone}
				</td>
				<td>
					${contract.projectName}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>