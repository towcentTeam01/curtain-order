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
	<form:form id="searchForm" modelAttribute="goods" action="${ctx }/tag/searchGoodsList" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="myId" name="myId" type="hidden" value="${myId}"/>
		<input id="myName" name="myName" type="hidden" value="${myName}"/>
		<ul class="ul-form">
			<li><label>商品名称：</label>
				<form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control"/>
			</li>
			<li><label>商品编码：</label>
				<form:input path="goodsNo" htmlEscape="false" maxlength="50" class="form-control"/>
			</li>
			<li><label>商品状态：</label>
				<form:select path="goodsStatus" class="form-control">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('goods_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>商品名称</th>
				<th>商品编码</th>
				<th>商品分类</th>
				<th>商品价格</th>
				<th>商品标签</th>
				<th>兑换积分</th>
				<th>是否礼品</th>
				<th>商品状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goods">
			<tr>
			   <td>
					<input type="radio" name="completeCheck" id="${goods.id}" value="${goods.goodsName}"/>
				</td>
				<td>
					${goods.goodsName}
				</td>
				<td>
					${goods.goodsNo}
				</td>
				<td>
					${goods.goodsCategory.categoryName}
				</td>
				<td>
					${goods.price}
				</td>
				<td>
					${fns:getDictLabel(goods.goodsTag, 'goods_tag', '')}
				</td>
				<td>
					${goods.cnvInter}
				</td>
				<td>
					${fns:getDictLabel(goods.giftFlag, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(goods.goodsStatus, 'goods_status', '')}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>