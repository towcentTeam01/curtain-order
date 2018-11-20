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
		
			$('input[name=completeCheck][value="${member.id}"]').attr("checked","chekced");
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
	<form:form id="searchForm" modelAttribute="member" action="${ctx }/tag/searchMemberList" method="post" class="navbar-form form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="myId" name="myId" type="hidden" value="${myId}"/>
		<input id="myName" name="myName" type="hidden" value="${myName}"/>
		<ul class="ul-form">
			<li><label>会员编码：</label>
				<form:input path="memberNo" htmlEscape="false"  class="form-control"/>
			</li>
			<li><label>会员帐号：</label>
				<form:input path="account" htmlEscape="false"  class="form-control"/>
			</li>
			<li><label>会员昵称：</label>
				<form:input path="nickName" htmlEscape="false"  class="form-control"/>
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
				<th>会员编码</th>
				<th>会员帐号</th>
				<th>会员昵称</th>
				<th>真实姓名</th>
				<th>联系电话</th>
				<th>性别</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody id="tbody_id">
		<c:forEach items="${page.list}" var="member" varStatus="vs">
			<tr>
				<td>
					<input type="radio" name="completeCheck" id="${member.id}" value="${member.account}"/>
				</td>
				<td>
					${member.memberNo}
				</td>
				<td>
					${member.account}
				</td>
				<td>
					${member.nickName}
				</td>
				<td>
					${member.realName}
				</td>
				<td>
					${member.phone}
				</td>
				<td>
					${fns:getDictLabel(member.sex, 'sex', '')}
				</td>
				<td>
					<fmt:formatDate value="${member.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>