<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>频道商品分配</title>
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
    <li><a href="${ctx}/goods/goodsChannel">频道商品列表</a></li>
    <shiro:hasPermission name="goods:goodsChannel:edit">
        <li><a href="${ctx}/goods/goodsChannel/form">商品频道添加</a></li>
    </shiro:hasPermission>
    <li class="active"><a href="${ctx}/goods/goodsChannelDtl?channelId=${channel.id}&assigned=${channelGoods.assigned}">频道商品分配</a></li>
</ul>

<div class="form-search" style=" padding: 15px 15px 0;">
    <ul class="ul-form">
        <li><label>频道名称：</label>${channel.channelName }</li>
        <li><label>频道别名：</label>${channel.channelAlias }</li>
        <li><label>频道商品数：</label>${channel.goodsQty }</li>
        <li><label>状态：</label>${fns:getDictLabel(channel.channelStatus, 'yes_no', '')}</li>
    </ul>
</div>
<form:form id="searchForm" modelAttribute="channelGoods" action="${ctx}/goods/goodsChannelDtl" method="post"
           class="navbar-form form-search" role="form">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="id" name="channelId" type="hidden" value="${channel.id}">
    <ul class="ul-form">
        <%-- <li>
            <label>商品分类：</label> 
            <sys:treeselect id="goodsCategory" name="goodsCategoryId"
                 value="${channelGoods.goodsCategoryId}" labelName="goodCategoryName"
                 labelValue="${channelGoods.goodCategoryName}" title="商品分类"
                 url="/goods/goodsCategory/treeData/${channel.merchantId}"
                 cssClass="form-control"/>
        </li> --%>
        <li><label>商品名称：</label> <form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control"/>
        </li>
        <li><label>商品编码：</label> <form:input path="goodsNo" htmlEscape="false" maxlength="50" class="form-control"/>
        </li>
        <li><label>是否分配：</label>
            <select name="assigned" class="form-control">
                <option value="0"
                        <c:if test="${channelGoods.assigned == 0 }">selected="selected"</c:if> >请选择
                </option>
                <option value="1"
                        <c:if test="${channelGoods.assigned == 1 }">selected="selected"</c:if> >是
                </option>
                <option value="2"
                        <c:if test="${channelGoods.assigned == 2 }">selected="selected"</c:if> >否
                </option>
            </select></li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<div class="form-search" style=" padding: 0;">
    <ul class="ul-form">
        <li class="btns">
            <form action="${ctx}/goods/goodsChannelDtl/assign" method="post" onsubmit="return doAssign();">
                <input id="txt_goodsIds" type="hidden" name="goodsIds">
                <input type="hidden" name="channelId" value="${channel.id}">
                <input class="btn btn-primary" type="submit" value="确定分配"/>
            </form>
        </li>
    </ul>
</div>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th><input id="cb_all" type="checkbox"></th>
        <th>商品名称</th>
        <th>商品编码</th>
        <th>商品分类</th>
        <th>商品状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="channelGoods">
        <tr>
            <td><input class="cb-goosChannel-${channelGoods.assigned}" value="${channelGoods.goodsId}" type="checkbox"
                       <c:if test="${channelGoods.assigned==1}">disabled="disabled"</c:if>></td>
            <td>${channelGoods.goodsName}</td>
            <td>${channelGoods.goodsNo}</td>
            <td>${channelGoods.structureName}</td>
            <td>${fns:getDictLabel(channelGoods.goodsStatus, 'goods_status', '')}</td>
            <td>
                <c:if test="${channelGoods.assigned==1 }">
                    <a href="${ctx}/goods/goodsChannelDtl/cancle?goodsIds=${channelGoods.goodsId }&channelId=${channelGoods.channelId }">取消分配</a>
                </c:if>
                <c:if test="${channelGoods.assigned==2 }">
                    <a href="${ctx}/goods/goodsChannelDtl/assign?goodsIds=${channelGoods.goodsId }&channelId=${channelGoods.channelId }">分配</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
${page}
<script type="text/javascript">
    $(function () {
        $("#cb_all").change(function () {
            $(".cb-goosChannel-2").prop("checked", $(this).prop("checked"));
        });
    });

    function doAssign() {
        var goodsIds = "";
        $(".cb-goosChannel-2:checked").each(function () {
            goodsIds += $(this).val();
            goodsIds += ",";
        });
        if (goodsIds == "") {
            alert("至少选择一种商品进行分配");
            return false;
        } else {
            $("#txt_goodsIds").attr("value", goodsIds);
            return true;
        }
    }
</script>
</body>
</html>
