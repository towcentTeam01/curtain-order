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
					parent.$('#loanId').val(id);
					parent.$('#loanNo').val(val);
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${loan.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="carPurchaseLoan" action="${ctx }/tag/tagSearch/searchSupplierList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>贷款编号：</label>
				<form:input path="loanNo" htmlEscape="false" maxlength="200" class="form-control"/>
			</li>
			<li><label>贷款人：</label>
				<form:input path="loanPerson" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>贷款合同号：</label>
				<form:input path="contractNo" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>贷款编号</th>
				<th>贷款人</th>
				<th>贷款合同号</th>
				<th>贷款公司</th>
				<th>联系人</th>
				<th>联系方式</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="loan" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${loan.id}" value="${loan.loanNo}"/>${vs.index+1 }
				</td>
				<td>
					${loan.loanNo }
				</td>
				<td>
					${loan.loanPerson }
				</td>
				<td>
					${loan.contractNo}
				</td>
				<td>
					${loan.supplier.supShortName}
				</td>
				<td>
					${loan.contacts}
				</td>
				<td>
					${loan.telephone}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>