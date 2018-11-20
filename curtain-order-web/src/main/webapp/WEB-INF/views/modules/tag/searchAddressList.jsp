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
                    var address = $(this).find("input[name=completeCheck]:checked").attr('address');
                    var phone = $(this).find("input[name=completeCheck]:checked").attr('phone');

                    var str = "【"+val+"】"+"【"+phone+"】"+"【"+address+"】"
					
					parent.$('[id="${myId}"]').val(id);
					parent.$('[id="${myName}"]').val(str);
					if(typeof parent.${fn:replace(myId,'.','')}CallBack == 'function'){
						parent.${fn:replace(myId,'.','')}CallBack(id,str);
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
	<form:form id="searchForm" modelAttribute="consigneeAddr" action="${ctx }/tag/searchAddressList" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="myId" name="myId" type="hidden" value="${myId}"/>
		<input id="myName" name="myName" type="hidden" value="${myName}"/>
		<ul class="ul-form">
			<li><label>收货人姓名：</label>
				<form:input path="consigneeName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>联系方式：</label>
				<form:input path="mobilePhone" htmlEscape="false" maxlength="50" class="form-control"/>
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
				<th>收货人姓名</th>
				<th>收货地址</th>
				<th>手机号码</th>
				<th>电话号码</th>
				<th>是否默认地址</th>
				<th>标签</th>
				<th>会员名称</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="consigneeAddr">
			<tr>
			   <td>
					<input type="radio" name="completeCheck" id="${consigneeAddr.id}"
						   phone="${consigneeAddr.mobilePhone}" address="${consigneeAddr.address}"
						   value="${consigneeAddr.consigneeName}"/>
				</td>
				<td><a href="${ctx}/sys/consigneeAddr/form?id=${consigneeAddr.id}">
						${consigneeAddr.consigneeName}
				</a></td>
				<td>
						${consigneeAddr.address}
				</td>
				<td>
						${consigneeAddr.mobilePhone}
				</td>
				<td>
						${consigneeAddr.telephone}
				</td>
				<td>
						${fns:getDictLabel(consigneeAddr.defaultFlag, 'yes_no', '')}
				</td>
				<td>
						${consigneeAddr.remarks}
				</td>
				<td>
						${consigneeAddr.user.name}
				</td>
				<td>
					<fmt:formatDate value="${consigneeAddr.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>