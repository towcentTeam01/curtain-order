<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商家列表</title>
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
		
			$('input[name=completeCheck][value="${merchantInfo.merchantAccount}"]').attr("checked","chekced");
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
	<form id="searchForm" action="${ctx}/merchant/merchantAccount/selMerchantAccount" method="post">
		<div style="padding: 1px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<label>商家编码：</label>
			<input name="merchantNo" maxlength="20" class="input-medium" value="${merchantInfo.merchantNo }"/>
			<label>商家名称：</label>
			<input name="merchantName" maxlength="100" class="input-medium" value="${merchantInfo.merchantName }"/>
			<label>商家账号：</label>
			<input name="merchantAccount" maxlength="100" class="input-medium" value="${merchantInfo.merchantAccount }"/>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		</div>
	</form>
	<table id="mytable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="text-align:center;width:10%;">序号</th>
				<th style="width:20%;">商家编码</th>
				<th>商家账号</th>
				<th>商家名称</th>
				<th>商家昵称</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
			<c:forEach items="${page.list}" var="obj" varStatus="i">
			<tr style="cursor: pointer;">
				<td style="text-align:center;">${i.index + 1}
					<input type="radio" name="completeCheck" value="${obj.merchantAccount }">
				</td>
				<td>${obj.merchantNo}</td>
				<td>${obj.merchantAccount}
				<c:if test="${obj.isMaster == 0}">(主帐号)</c:if>
				<c:if test="${obj.isMaster == 1}">(子帐号)</c:if>
				</td>
				<td>${obj.merchantName}</td>
				<td>${obj.nickName}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>