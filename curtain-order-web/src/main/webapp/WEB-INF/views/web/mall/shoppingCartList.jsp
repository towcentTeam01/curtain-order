<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>购物车管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $('tbody tr').each(function () {
                $(this).click(function (e) {
                    if ($(e.target).attr('name') != 'completeCheck') {
                        var obj = $(this).children().children();
                        if (obj.is(':checked')) {
                            obj.removeAttr('checked');
                        } else {
                            obj.attr('checked', 'checked');
                        }
                    }
                });
            });

            $('#allbox').click(function () {
                if ($(this).is(':checked')) {
                    $('[name=completeCheck]').attr('checked', 'checked');
                } else {
                    $('[name=completeCheck]').removeAttr('checked');
                }
            });
        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function toConfirm() {
            var ids = [];
            $('[name=completeCheck]:checked').each(function () {
                if ($(this).val()) {
                    ids.push($(this).val())
                }
            });

            if (ids.length <= 0) {
                layer.msg("请选择下单商品");
                return;
            }
            ids = ids.join(';').toString();
            location.href="${ctx}/mall/shoppingCart/toConfirm?ids="+ids;
            <%--layer.load();--%>
            <%--$.ajax({--%>
                <%--type: "POST",--%>
                <%--url: "${ctx}/mall/shoppingCart/toConfirm",--%>
                <%--data: {ids: ids.join(';')},--%>
                <%--dataType: "json",--%>
                <%--async: false,--%>
                <%--success: function (data) {--%>
                    <%--if (data.code == '000') {--%>
                        <%--layer.msg('下单成功页面跳转中...');--%>
                        <%--setTimeout(function () {--%>
                            <%--location.href = "${ctx}/mall/order/detail?id=" + data.id;--%>
                        <%--}, 500)--%>
                    <%--} else {--%>
                        <%--layer.msg(data.errorMessage);--%>
                        <%--setTimeout(function () {--%>
                            <%--window.location.reload();--%>
                        <%--}, 500)--%>
                    <%--}--%>
                    <%--return;--%>
                <%--}--%>
            <%--});--%>
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/mall/shoppingCart/">购物车列表</a></li>
    <%--<shiro:hasPermission name="mall:shoppingCart:edit"><li><a href="${ctx}/mall/shoppingCart/form">购物车添加</a></li></shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="shoppingCart" action="${ctx}/mall/shoppingCart/" method="post"
           class="navbar-form form-search" role="form">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>商品名称：</label>
            <form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control"/>
        </li>
        <li class="btns">
            <button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button>
        </li>
        <li style="float: right;">
            <button type="button" id="buy_button"
                    class="btn btn-success big" onclick="toConfirm();" style="">下单
            </button>
        </li>

        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th><input type="checkbox" id="allbox"/></th>
        <th>商品名称</th>
        <th>商品图片</th>
        <th>成品宽(单位/米)</th>
        <th>成品高(单位/米)</th>
        <th>褶数(倍)</th>
        <th>辅料铅线、铅块、底边花边</th>
        <th>里衬/造型(返幔、帘头)</th>
        <th>对/单开</th>
        <th>打孔/捏褶(对花)</th>
        <th>环、S钩</th>
        <th>详情说明</th>
        <shiro:hasPermission name="mall:shoppingCart:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="shoppingCart">
        <tr>
            <td>
                <input type="checkbox" name="completeCheck" id="${shoppingCart.id}" value="${shoppingCart.id}"/>
            </td>
            <td><a href="${ctx}/mall/shoppingCart/form?id=${shoppingCart.id}">
                    ${shoppingCart.goodsName}
            </a></td>
            <td>
                <img src="${shoppingCart.goodsPicUrl}" style="height: 100px;height: 100px"/>
            </td>
            <td>
                    ${shoppingCart.length}
            </td>
            <td>
                    ${shoppingCart.high}
            </td>
            <td>
                    ${shoppingCart.multiple}
            </td>
            <td>
                    ${shoppingCart.param1}
            </td>
            <td>
                    ${shoppingCart.param2}
            </td>
            <td>
                    ${shoppingCart.param3}
            </td>
            <td>
                    ${shoppingCart.param4}
            </td>
            <td>
                    ${shoppingCart.param5}
            </td>
            <td>
                    ${shoppingCart.remarks}
            </td>
            <shiro:hasPermission name="mall:shoppingCart:edit">
                <td>
                    <a href="${ctx}/mall/shoppingCart/form?id=${shoppingCart.id}">修改</a>
                    <a href="${ctx}/mall/shoppingCart/delete?id=${shoppingCart.id}"
                       onclick="return confirmx('确认要删除该购物车吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
${page}
</body>
</html>