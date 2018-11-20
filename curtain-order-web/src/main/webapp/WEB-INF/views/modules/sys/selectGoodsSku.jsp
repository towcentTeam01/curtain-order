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
	    

		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return false;
		}
		
		function selectAll(sizeTypeNo,obj){
			var attrName = document.getElementsByName('attrName');
			var flag = obj.getAttribute('flag');
			var bol = flag=='0';
			if(bol){
				obj.setAttribute('flag','1');
				obj.value="反选";
			}else{
				obj.setAttribute('flag','0');
				obj.value="全选";
			}
			for(var i=0;i<attrName.length;i++)
			{
				if(attrName[i].getAttribute('skuNo') ==sizeTypeNo ){
					attrName[i].checked = bol;
				}
			}
		}
	</script>
</head>
<body>
	<div style="margin-top: 10px;"></div>
	<table id="mytable" class="table table-striped table-bordered table-condensed">
		<tbody id="tbody_id">
			<c:forEach items="${goodsSizeList}" var="obj" varStatus="i">
			<tr style="cursor: pointer;">
				<td style="text-align:center;">
					<table class="table table-striped table-bordered table-condensed">
						<tr>
							<td>${obj.sizeTypeName} <input type="button" id="${obj.sizeTypeNo}" onclick="selectAll('${obj.sizeTypeNo}',this)" class="btn btn-primary" style="height: 25px;" flag="0" value="全选"/></td>
						</tr>
						<tr>
							<td>
								<c:forEach items="${obj.goodsSizeDtlList}" var="sizeDtl" varStatus="i">
									<input type="checkbox" skuNo="${sizeDtl.sizeTypeNo}" name="attrName" 
										<c:if test="${fn:contains(skuName, sizeDtl.attrName)}">
											<c:if test="${fn:contains(skuNos, sizeDtl.sizeTypeNo)}">
												checked="checked"
											</c:if>
										</c:if>
										
										value="${sizeDtl.attrName }">
									    ${sizeDtl.attrName }
								</c:forEach>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>