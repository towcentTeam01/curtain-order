<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>系统配置管理</title>
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
    <li class="active"><a href="${ctx}/property/sysProperty/">系统配置列表</a></li>
    <shiro:hasPermission name="property:sysProperty:edit">
        <li><a href="${ctx}/property/sysProperty/form">系统配置添加</a></li>
    </shiro:hasPermission>
</ul>
<%--<form:form id="searchForm" modelAttribute="sysProperty" action="${ctx}/property/sysProperty/" method="post" class="navbar-form form-search" role="form">--%>
<%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>--%>
<%--<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
<%--<ul class="ul-form">--%>
<%--<li><label>属性名：</label>--%>
<%--<form:input path="propertyName" htmlEscape="false" maxlength="150" class="form-control"/>--%>
<%--</li>--%>
<%--<li><label>备注：</label>--%>
<%--<form:input path="remark" htmlEscape="false" maxlength="500" class="form-control"/>--%>
<%--</li>--%>
<%--<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>--%>
<%--<li class="clearfix"></li>--%>
<%--</ul>--%>
<%--</form:form>--%>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>属性名</th>
        <th>属性值</th>
        <th>排序</th>
        <th>备注</th>
        <th>创建人</th>
        <th>创建时间</th>
        <th>更新人</th>
        <th>更新时间</th>
        <shiro:hasPermission name="property:sysProperty:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="sysProperty">
        <tr>
            <td>
                    ${sysProperty.propertyName}
            </td>
            <td>
                    ${sysProperty.propertyValue}
            </td>
            <td>
                <input type="text" name="sort" value="${sysProperty.sort}" size="3">
                <button class="btn-xs save-sort">保存</button>
            </td>
            <td>
                    ${sysProperty.remark}
            </td>
            <td>
                    ${sysProperty.createBy.name}
            </td>
            <td>
                <fmt:formatDate value="${sysProperty.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                    ${sysProperty.updateBy.name}
            </td>
            <td>
                <fmt:formatDate value="${sysProperty.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <shiro:hasPermission name="property:sysProperty:edit">
                <td>
                    <a id="modify" href="${ctx}/property/sysProperty/form?id=${sysProperty.id}">修改</a>
                    <a href="${ctx}/property/sysProperty/delete?id=${sysProperty.id}"
                       onclick="return confirmx('确认要删除该系统配置吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
${page}
<script>
    // 每行的排序按钮按下的事件
    $(".save-sort").click(function () {
        var thisTd = $(this).parent();
        var thisTr = thisTd.parent();
        var sortNum = thisTd.find("input").val();
        var id = getIdFromHref(thisTr.find("#modify").prop("href"));
        saveSort(id, sortNum);
    });
    // 通过后面修改的那个修改的链接获取id
    function getIdFromHref(href) {
        return href.match(/[=](\S*)/)[1];
    }
    // 保存更改
    function saveSort(id, sortNum) {
        $.ajax({
            'type': 'POST',
            'url': '${ctx}/property/sysProperty/changeSort',
            'data': {
                'id': id,
                'sort': sortNum
            },
            'dataType': 'json',
            'success': function (res) {
                layer.msg("保存成功，如果需要看到效果，请刷新！");
            },
            'error': function () {
                layer.msg("保存失败，请重试！");
            }
        });
    }
</script>
</body>
</html>