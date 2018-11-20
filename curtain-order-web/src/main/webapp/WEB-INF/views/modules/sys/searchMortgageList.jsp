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
					parent.$('#mortgageId').val(id);
					parent.$('#mortgageNo').val(val);
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${mortgage.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="carSaleMortgage" action="${ctx }/tag/tagSearch/searchMortgageList" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>按揭编号：</label>
				<form:input path="morgageNo" htmlEscape="false" maxlength="200" class="form-control"/>
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
				<th>按揭编号</th>
				<th>借款方</th>
				<th>放贷方</th>
				<th>贷款类型</th>
				<th>首付款单据号</th>
				<th>贷款总额</th>
				<th>贷款期数</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="mortgage" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${mortgage.id}" value="${mortgage.morgageNo}"/>${vs.index+1 }
				</td>
				<td>
					${mortgage.morgageNo }
				</td>
				<td>
					${mortgage.supplier1.supShortName }
				</td>
				<td>
					${mortgage.supplier2.supShortName }
				</td>
				<td>
					${fns:getDictLabel(mortgage.loanType, 'loan_type', '')}
				</td>
				<td>
					${mortgage.firstReceivedNo}
				</td>
				<td>
					${mortgage.totalAmount}
				</td>
				<td>
					${mortgage.periodsNumber}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>