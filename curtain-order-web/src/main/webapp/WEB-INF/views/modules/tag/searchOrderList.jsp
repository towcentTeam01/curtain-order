<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员列表</title>
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
					
					parent.$('[id="${myId}"]').val(id);
					parent.$('[id="${myName}"]').val(val);
					if(typeof parent.${fn:replace(myId,'.','')}CallBack == 'function'){
						parent.${fn:replace(myId,'.','')}CallBack(id,val);
					}
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${goods.id}"]').attr("checked","chekced");
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

    <form:form id="searchForm" modelAttribute="orderMain" action="${ctx }/tag/searchOrderList" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="myId" name="myId" type="hidden" value="${myId}"/>
		<input id="myName" name="myName" type="hidden" value="${myName}"/>
		<ul class="ul-form">
			<li><label>订单号：</label>
				<form:input path="orderNo" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>收货人：</label>
				<form:input path="consigneeName" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>联系电话：</label>
				<form:input path="mobilePhone" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>订单状态：</label>
				<form:select path="orderStatus" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>支付状态：</label>
				<form:select path="payStatus" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('pay_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
				<th>订单号</th>
				<th>实付金额</th>
				<th>商品数量</th>
				<th>订单状态</th>
				<th>支付状态</th>
				<th>交易方式</th>
				<th>付款方式</th>
				<th>收货人</th>
				<th>联系电话</th>
				<th>下单时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderMain">
			<tr>
			   <td>
					<input type="radio" name="completeCheck" id="${orderMain.id}" value="${orderMain.orderNo}"/>
				</td>
				<td>
					${orderMain.orderNo}
				</td>
				<td>
					${orderMain.payAmount}
				</td>
				<td>
					${orderMain.goodsQty}
				</td>
				<td>
					${fns:getDictLabel(orderMain.orderStatus, 'order_status', '')}
				</td>
				<td>
					${fns:getDictLabel(orderMain.payStatus, 'pay_status', '')}
				</td>
				<td>
					${fns:getDictLabel(orderMain.tradeWay, 'trade_way', '')}
				</td>
				<td>
					${fns:getDictLabel(orderMain.payWay, 'pay_way', '')}
				</td>
				<td>
					${orderMain.consigneeName}
				</td>
				<td>
					${orderMain.mobilePhone}
				</td>
				<td>
					<fmt:formatDate value="${orderMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>