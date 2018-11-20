<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>分公司管理</title>
<meta name="decorator" content="default"/>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/raty/lib/jquery.raty.min.js" type="text/javascript"></script>
<c:set var="imagePath" value="${fns:getUrlHeader()}"/>
<style type="text/css">
.smallDiv{
    width:70px;height:70px;
    overflow:hidden;
    position:relative;
    display:table-cell;
    text-align:center;
    vertical-align:middle;
    border:1px solid #d3d3d3;
}
.smallDiv span{
    position:static;
    *position:absolute; /*针对IE6/7的Hack*/
    top:50%; /*针对IE6/7的Hack*/
}
.smallDiv img {
	max-width:70px;
    position:static;
    *position:relative; /*针对IE6/7的Hack*/
    top:-50%;left:-50%; /*针对IE6/7的Hack*/
}
</style>
<script type="text/javascript">
	$(function() {
		$.fn.raty.defaults.path = ctxStatic + '/raty/lib/img';
		// alert($.fn.raty.defaults.path);
		$('uy').each(function(i){
			console.info($(this).attr('ss'));
			var i = $(this).attr('ss');
			$(this).raty({ readOnly: true, score: i });
		}); 
	});
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
       	return false;
       }
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/sysCompany/">分公司列表</a></li>
		<shiro:hasPermission name="sys:sysCompany:edit"><li><a href="${ctx}/sys/sysCompany/form">分公司添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysCompany" action="${ctx}/sys/sysCompany/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>公司名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="20" class="input-medium"/>
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
				<th style="width: 70px;">logo</th>
				<th>公司名称</th>
				<th>联系电话</th>
				<th>联系人</th>
				<!-- <th>经度</th>
				<th>纬度</th> -->
				<!-- <th>省</th>
				<th>市</th>
				<th>区</th> -->
				<th>公司地址</th>
				<th>创建日期</th>
				<th>更新时间</th>
				<th>评价</th>
				<shiro:hasPermission name="sys:sysCompany:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysCompany" varStatus="vs">
			<tr>
				<td>
					${vs.index+1}
				</td>
				<td>
					<div class="smallDiv">
						<span><img src="${imagePath }${sysCompany.logoUrl}" alt="" /></span>
					</div>
				</td>
				<td><a href="${ctx}/sys/sysCompany/form?id=${sysCompany.id}">
					${sysCompany.companyName}
				</a></td>
				<td>
					${sysCompany.contactPhone}
				</td>
				<td>
					${sysCompany.contacts}
				</td>
				<%-- <td>
					${sysCompany.lng}
				</td>
				<td>
					${sysCompany.lat}
				</td> --%>
				<%-- <td>
					${sysCompany.provice}
				</td>
				<td>
					${sysCompany.city}
				</td>
				<td>
					${sysCompany.county}
				</td> --%>
				<td>${sysCompany.provice}${sysCompany.city}${sysCompany.county}${sysCompany.detailAddress}</td>
				<td>
					<fmt:formatDate value="${sysCompany.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${sysCompany.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<%-- ${sysCompany.evalStar}    --%>
			        <uy ss="${sysCompany.evalStar}"></uy>
				</td>
				<shiro:hasPermission name="sys:sysCompany:edit"><td>
    				<a href="${ctx}/sys/sysCompany/form?id=${sysCompany.id}">修改</a>
					<a href="${ctx}/sys/sysCompany/delete?id=${sysCompany.id}" onclick="return confirmx('确认要删除该分公司吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>