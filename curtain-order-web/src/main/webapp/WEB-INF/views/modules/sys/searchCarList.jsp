<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>车辆列表</title>
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
					parent.$('#carId').val(id);
					parent.$('#carIds').val(val);
					parent.checkBindingCar();
					parent.layer.close(index);
				});
			});
		
			$('input[name=completeCheck][value="${carInfo.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="carInfo" action="${ctx }/tag/tagSearch/searchCarList" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>车牌号：</label>
				<form:input path="carLicense" htmlEscape="false" maxlength="11" class="form-control"/>
			</li>
			<li><label>车辆类别：</label>
				<form:select path="carCategory" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('car_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>车辆类型：</label>
				<form:select path="carType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('car_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>车辆状态：</label>
				<form:select path="carStatus" class="form-control" >
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('car_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>车辆识别码</th>
				<th>车牌号</th>
				<th>车辆状态</th>
				<th>车辆类别</th>
				<th>车辆类型</th>
				<th>品牌型号</th>
				<th>是否有效 </th>
				<th>购车时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="carInfo" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${carInfo.id}" value="${carInfo.carLicense}"/>
				</td>
				<td>
					${carInfo.carIdentificationNo}
				</td>
				<td>
					${carInfo.carLicense}
				</td>
				<td>
					${fns:getDictLabel(carInfo.carStatus, 'car_status', '')}
				</td>
				<td>
					${fns:getDictLabel(carInfo.carCategory, 'car_category', '')}
				</td>
				<td>
					${fns:getDictLabel(carInfo.carType, 'car_type', '')}
				</td>
				<td>
					${carInfo.brand}
				</td>
				<td>
					${fns:getDictLabel(carInfo.isEnabled, 'is_enabled', '')}
				</td>
				<td>
					<fmt:formatDate value="${carInfo.purchaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>