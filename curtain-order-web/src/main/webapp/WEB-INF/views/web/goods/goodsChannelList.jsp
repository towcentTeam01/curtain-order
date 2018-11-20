<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>商品频道管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

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
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/goods/goodsChannel/">商品频道列表</a></li>
    <shiro:hasPermission name="goods:goodsChannel:edit">
        <li><a href="${ctx}/goods/goodsChannel/form">商品频道添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="goodsChannel" action="${ctx}/goods/goodsChannel/" method="post"
           class="navbar-form form-search" role="form">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>频道名称：</label>
            <form:input path="channelName" htmlEscape="false" maxlength="30" class="form-control"/>
        </li>
        <li><label>频道类型：</label>
            <form:select path="channelType" class="form-control">
                <form:option value="" label="请选择"/>
                <form:options items="${fns:getDictList('channel_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>频道别名：</label>
            <form:input path="channelAlias" htmlEscape="false" maxlength="30" class="form-control"/>
        </li>
        <li><label>是否开启：</label>
            <form:select path="channelStatus" class="form-control">
                <form:option value="" label="请选择"/>
                <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li class="btns">
            <button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>频道名称</th>
        <th>频道类型</th>
        <th>频道别名</th>
        <th>频道商品数</th>
        <th>是否开启</th>
        <th>排序</th>
        <th>有效时间</th>
        <th>频道图片</th>
        <th>更新时间</th>
        <th>
            <shiro:hasPermission name="goods:goodsChannel:edit">操作</shiro:hasPermission>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="goodsChannel">
        <tr>
            <td><a href="${ctx}/goods/goodsChannel/form?id=${goodsChannel.id}">
                    ${goodsChannel.channelName}
            </a></td>
            <td>
                    ${fns:getDictLabel(goodsChannel.channelType, 'channel_type', '')}
            </td>
            <td>
                    ${goodsChannel.channelAlias}
            </td>
            <td>
                    ${goodsChannel.goodsQty}
            </td>
            <td>
                    ${fns:getDictLabel(goodsChannel.channelStatus, 'yes_no', '')}
            </td>
            <td>
                    ${goodsChannel.sort}
            </td>
            <td>
                <c:if test="${not empty goodsChannel.startTime && not empty goodsChannel.endTime}">
                <fmt:formatDate value="${goodsChannel.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/> ~ <fmt:formatDate
                    value="${goodsChannel.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </c:if>
            </td>
            <td>
                <img style="height: 60px;width: 60px" src="${goodsChannel.channelImg}"/>
            </td>
            <td>
                <fmt:formatDate value="${goodsChannel.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                <shiro:hasPermission name="goods:goodsChannel:edit">
                    <a href="${ctx}/goods/goodsChannel/form?id=${goodsChannel.id}">修改</a>
                    <a href="${ctx}/goods/goodsChannel/delete?id=${goodsChannel.id}"
                       onclick="return confirmx('确认要删除该商品频道吗？', this.href)">删除</a>
                </shiro:hasPermission>
                <a href="${ctx}/goods/goodsChannelDtl?channelId=${goodsChannel.id}&assigned=0">分配商品</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
${page}
</body>
</html>