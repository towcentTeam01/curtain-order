<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>商品列表</title>
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

    <style>

        .dataTables_wrapper {
            border: 1px solid #ddd;
            margin: 10px 0px;
            border-radius: 5px;
            min-height: 50px;
            float: left;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            position: relative;
            display: block;
            width: 100%;
        }

        .dataTables_wrapper .closeup .panel-toggle {
            transform: rotate(-90deg);
            -webkit-transform: rotate(-90deg);
        }

        .panel-heading {
            padding: 10px 15px;
            border-bottom: 1px solid transparent;
            border-top-right-radius: 3px;
            border-top-left-radius: 3px;
        }

        .dataTables_wrapper > .panel-heading {
            color: #333;
            background-color: #f5f5f5;
            border-color: #ddd;
        }

        .panel-heading {
            padding-left: 10px;
        }

        .text-primary {
            color: #428bca;
        }

        .dish-number {
            margin-left: 20px;
        }

        .caret {
            display: inline-block;
            width: 0;
            height: 0;
            margin-left: 2px;
            vertical-align: middle;
            border-top: 4px solid;
            border-right: 4px solid transparent;
            border-left: 4px solid transparent;
        }

        .dataTables_wrapper .panel-toggle {
            position: absolute;
            left: 15px;
            top: 15px;
            border-top: 8px solid;
            border-right: 6px solid transparent;
            border-left: 6px solid transparent;
            transition: transform .2s;
            -webkit-transition: transform .2s;
            cursor: pointer;
        }

        .panel-body {
            padding: 10px;
            float: left;
        }

        .widget-dishmanagernew-dish-list-item {
            float: left;
            margin-right: 20px;
            /* margin-bottom: 20px; */
            background-color: #fafafa;
            position: relative;
            display: inline-block;
        }

        .widget-dishmanagernew-dish-list-item .combo-icon-wrap {
            width: 120px;
            height: 120px;
            display: block;
            float: left;
            position: relative;
            overflow: hidden;
        }

        .widget-dishmanagernew-dish-list-item .combo-icon {
            display: block;
            float: left;
            background-color: #e5e5e5;
        }

        img {
            border: 0;
        }

        img {
            vertical-align: middle;
        }

        .widget-dishmanagernew-dish-list-item .combo-icon-wrap .saleout-status {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30px;
            line-height: 30px;
            background: rgba(0, 0, 0, .4);
            text-align: center;
            color: #fff;
            font-size: 14px;
            display: none;
        }

        .widget-dishmanagernew-dish-list-item .combo-icon-wrap .saleout-status {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 30px;
            line-height: 30px;
            background: rgba(0, 0, 0, .4);
            text-align: center;
            color: #fff;
            font-size: 14px;
            display: none;
        }

        .widget-dishmanagernew-dish-list-item .ext-info {
            width: 300px !important;
            padding: 10px;
            max-height: 450px;
            overflow-y: auto;
            border: 0;
            z-index: 9999;
        }

        .widget-dishmanagernew-dish-list-item .ext-info .ext-progress {
            width: 50%;
            margin: auto;
        }

        .widget-dishmanagernew-dish-list-item .info {
            float: left;
            width: 180px;
            // height: 120px;
            padding: 5px 10px;
        }

        .widget-dishmanagernew-dish-list-item .dish-top-info {
            display: flex;
            display: -webkit-flex;
            height: 30px;
            margin-bottom: 10px;
            border-bottom: 1px dashed #e7e7e7;
            overflow: hidden;
        }

        .widget-dishmanagernew-dish-list-item .dish-top-info .dish-name {
            flex: 1;
            -webkit-flex: 1;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: bold;
            font-size: 16px;
        }

        .action button.btn {
            min-width: auto;
            margin: 10px 0 10px 10px;
        }

        .combo-icon-wrap img {
            width: 120px;
            height: 120px;
        }

        .panel-body .btn {
            font-weight: 400;
        }

        .box-content .closeup .panel-toggle {
            transform: rotate(-90deg);
            -webkit-transform: rotate(-90deg);
        }

    </style>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/mall/index">首页</a></li>
    <li class="active"><a href="${ctx}/mall/goods/list">商品列表</a></li>
</ul>

<div class="box-content">

    <form:form id="searchForm" modelAttribute="goods" action="${ctx}/mall/goods/list" method="post"
               class="navbar-form form-search" role="form">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="12"/>
        <ul class="ul-form">
            <li><label>商品编码：</label>
                <form:input path="goodsNo" htmlEscape="false" maxlength="50" class="form-control"/>
            </li>
            <li><label>商品名称：</label>
                <form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control"/>
            </li>
            <li><label>风格：</label>
                <form:select path="style" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_style')}" itemLabel="label" itemValue="label"
                                  htmlEscape="false"/>
                </form:select>
                <!-- <form:input path="style" htmlEscape="false" maxlength="100" class="form-control"/> -->
            </li>
            <li><label>材质：</label>
                <form:select path="material" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_material')}" itemLabel="label" itemValue="label"
                                  htmlEscape="false"/>
                </form:select>
                <!-- <form:input path="material" htmlEscape="false" maxlength="100" class="form-control"/> -->
            </li>
            <li><label>分类：</label>
                <form:select path="cateNo" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('goods_category')}" itemLabel="label" itemValue="value"
                                  htmlEscape="false"/>
                </form:select>
            </li>
            <form:hidden path="labelType" />
            <!--
            <li><label>标签类别：</label>
                <form:select path="labelType" class="form-control">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('label_type')}" itemLabel="label" itemValue="value"
                                  htmlEscape="false"/>
                </form:select>
            </li>-->
            <li><label>创建时间：</label>
                <input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                       value="<fmt:formatDate value="${goods.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> -
                <input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                       value="<fmt:formatDate value="${goods.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
            </li>
            <li class="btns">
                <button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button>
            </li>
            <li class="clearfix"></li>
        </ul>
    </form:form>


    <div style="clear:both;"></div>


    <div id="type_1" class="row-fluid dataTables_wrapper proList closeup">

        <div class="panel-heading">
           <span>
                <span class="text-primary" data-node="name_wrap">商品数量：${page.count}</span>
                <span class="dish-number" style="color:#368ee0;">当前页：${page.pageNo}</span>
                <span class="dish-number" style="color:#368ee0;">总页数：${page.last}</span>
                <span class="dish-number" style="color:red;"></span>
           </span>
        </div>

        <div class="panel-toggle caret hidden"></div>

        <c:forEach items="${page.list}" var="goods">
            <div class="panel-body ui-sortable dish" data-node="dish_list_wrap" id="spec_1" data-typeid='1'>
                <div class="widget-dishmanagernew-dish-list-item dropdown online ui-sortable-handle">
                    <div class="combo-icon-wrap dropdown-toggle">
                        <img class="combo-icon" width="120" height="120"
                             src="${goods.goodsPicUrl}">
                        <span class="saleout-status" style="display: none;"></span>
                        <span class="saleout-status" style="display: none;"></span>
                    </div>
                    <!--info-->
                    <div class="info">
                        <div class="dish-top-info">
                            <span class="dish-name" title="${goods.goodsName}">${goods.goodsName}</span><span
                                class="dish-editor" data-node="editor"></span>
                        </div>
                        <div class="dish-store-nums">
                            <span class="dish-counts">库存：${goods.qty}米</span>
                        </div>
                        <div class="info_nav price">单价：
                            <span>¥&nbsp;${goods.price}</span>
                        </div>
                        <div class="tag-wrap">
                            <div class="dropdown-parent dropdown">
                            </div>
                        </div>
                    </div>
                    <!--info-->
                    <!--action-->
                    <div class="action">
                        <button class="btn btn-default btn-xs" onclick="detail('${goods.id}')">详情</button>
                        <span class="blank"></span>
                        <button class="btn btn-default btn-xs" onclick="collectFun('${goods.id}');">收藏</button>
                        <%--<span class="blank"></span>--%>
                        <%--<button class="btn btn-default btn-xs">加入购物车</button>--%>
                        <%--<span class="blank"></span>--%>
                        <%--<button class="btn btn-default btn-xs">立即购买</button>--%>
                    </div>
                    <!--action-->
                </div>
            </div>
        </c:forEach>
    </div>
    <div style="clear:both;"></div>
    ${page}
</div>
</div>

</div>

<script type="text/javascript">
    function detail(id) {
        if (!id) return;
        window.location.href = "${ctx}/mall/goods/detail?goodsId=" + id;
    }

    function collectFun(goodsId) {
        if (!goodsId) return;
        var data = {goodsId:goodsId};
        layer.load();
        $.ajax({
            type: "POST",
            url: "${ctx}/mall/concernGoods/collect",
            data: data,
            dataType: "json",
            async: false,
            success: function (data) {
                layer.msg(data.errorMessage);
                setTimeout(function () {
                    window.location.reload();
                }, 500)
                return;
            }
        });
    }
</script>

</body>
</html>