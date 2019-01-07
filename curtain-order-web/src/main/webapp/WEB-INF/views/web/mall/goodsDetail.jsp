<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>${goods.goodsName}</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css" media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    return false;
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function addToCart() {
            if ($("#inputForm").valid()) {
                addToCartFun();
            }
        }

        function toBuy() {
            if ($("#inputForm").valid()) {
                addToCartFun(true);
            }
        }

        function addToCartFun(flag) {
            var data = {};
            var fields = $('#inputForm').serializeArray();
            jQuery.each(fields, function (i, field) {
                data[field.name] = field.value;
            });
            layer.load();
            $.ajax({
                type: "POST",
                url: "${ctx}/mall/shoppingCart/addToCart",
                data: data,
                dataType: "json",
                async: false,
                success: function (data) {
                    if (flag) {
                        location.href = "${ctx}/mall/shoppingCart/toConfirm?ids=" + data.data.id;
                    } else {
                        layer.msg(data.errorMessage);
                        setTimeout(function () {
                            window.location.reload();
                        }, 500);
                        return;
                    }
                }
            });
        }


        function collectFun(goodsId) {
            if (!goodsId) return;
            var data = {goodsId: goodsId};
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
                    }, 500);
                    return;
                }
            });
        }

    </script>

    <style type="text/css">
        .cate {

        }

        .cate > li > a {
            margin-right: 2px;
            line-height: 1.42857143;
            border: 1px solid transparent;
            border-radius: 4px 4px 0 0;
        }

        .cate > li > a {
            position: relative;
            display: inline-block;
            padding: 10px 5px;
        }

        .goods-panel, .goods-spec-panel, .desc-box {
            padding: 0 2% 1% 2%;
            width: 96%;
        }

        .goods-img {
            float: left;
            width: 40%;
            border: 1px solid #ccc;
            height: 300px;
            display: table-cell;
            vertical-align: middle;
            text-align: center;
        }

        .goods-img img {
            height: 300px;
        }

        .goods-info {
            float: left;
            width: 55%;
            border: 1px solid #ccc;
            min-height: 300px;
            margin-left: 3%;
        }

        .info-item {
            padding: 10px;
        }

        .info-item li {
            padding: 5px;
        }

        .item-name {
            font-size: 18px;
            font-weight: bold;
        }

        .btn-box {
            padding: 10px;
        }

        #contentTable {
            width: 98%;
            margin: 40px 0;
            text-align: left;
        }

        #contentTable tr td, #contentTable tr th {
            text-align: center;
            height: 40px;
        }

        #contentTable th span {
            color: red;
        }

        .form-horizontal {
            margin: 0;
        }

    </style>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active">
        <a href="${ctx}/mall/goods/detail?goodsId=${goods.id}">商品详情</a>
    </li>
</ul>
<div class="box-content">

    <div class="goods-panel">
        <ul class="cate">
            <li>
                <a href="${ctx}/mall/goods/list">首页</a>>
                <a href="${ctx}/mall/goods/list?cateNo=${goods.cateNo}">${goods.cateName}</a>>
                <a style="color: #428bca;" href="${ctx}/mall/goods/detail?goodsId=${goods.id}">${goods.goodsName}</a>
            </li>
        </ul>
        <div class="goods-img">
            <div id="layer-photos-demo" class="layer-photos-demo">
                <div class="layui-carousel" id="test1" lay-filter="test1">
                    <div carousel-item="">
                        <c:forEach items="${goods.goodsImgList}" var="item" varStatus="va">
                            <div><img layer-pid="${va.index}" layer-src="${item}" src="${item}" alt="图片${va.index}">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="goods-info">
            <ul class="info-item">
                <li class="item-name">${goods.goodsName}
                    <span style="float: right;${isCollect == '1' ? 'color:red;' : 'color:#ccc;'}"
                          onclick="collectFun('${goods.id}')"><i class="icon-heart icon-white"></i></span>
                </li>
                <li>分类：${goods.cateName}</li>
                <li>品牌：${goods.brandName}</li>
                <li>价格：${goods.price}</li>
                <li>库存：${goods.qty}</li>
                <li>销量：${goods.saleNum}</li>
                <li>销售米数：${goods.saleLength}</li>
            </ul>
            <div class="btn-box">
                <button type="button" id="buy_car_button"
                        class="btn btn-primary btn-lg" onclick="addToCart();" style="">加入购物车
                </button>
                <button type="button" id="buy_button"
                        class="btn btn-success btn-lg" onclick="toBuy();" style="">立即购买
                </button>
            </div>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div class="goods-spec-panel">
        <form:form id="inputForm" modelAttribute="shoppingCart" action="" method="post" class="form-horizontal">
            <form:hidden path="goodsId" value="${goods.id}"/>
            <form:hidden path="goodsName" value="${goods.goodsName}"/>
            <table id="contentTable" class="table  table-bordered table-condensed">
                <thead>
                <tr>
                    <th><span>*</span>成品宽（单位M）</th>
                    <th>成品高（单位M）</th>
                    <th><span>*</span>褶数（倍）</th>
                    <th>辅料铅线、铅块、底边花边</th>
                    <th>里衬/反幔/侧拼/帘头</th>
                    <th>对/单开</th>
                    <th>打孔/捏褶（对花）</th>
                    <th>环、S钩（不要可不填）</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <form:input path="length" htmlEscape="false" maxlength="10" max="100"
                                    class="form-control required money"/>
                    </td>
                    <td>
                        <form:input path="high" htmlEscape="false" maxlength="10" max="100" class="form-control money"/>
                    </td>
                    <td>
                        <form:input path="multiple" htmlEscape="false" maxlength="10" min="1" class="form-control required"/>
                    </td>
                    <td>
                        <form:input path="param1" htmlEscape="false" maxlength="20" class="form-control"/>
                    </td>
                    <td>
                        <form:input path="param2" htmlEscape="false" maxlength="20" class="form-control"/>
                    </td>
                    <td>
                        <form:input path="param3" htmlEscape="false" maxlength="20" class="form-control"/>
                    </td>
                    <td>
                        <form:input path="param4" htmlEscape="false" maxlength="20" class="form-control"/>
                    </td>
                    <td>
                        <form:input path="param5" htmlEscape="false" maxlength="20" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>详细说明</td>
                    <td colspan="7">
                        <form:textarea path="remarks" rows="3" maxlength="200" htmlEscape="false" class="form-control"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </form:form>
    </div>

    <div class="desc-box">
        <div class="layui-tab">
            <ul class="layui-tab-title">
                <li class="layui-this">产品概述</li>
                <li>规格参数</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <div>${goods.description}</div>
                    <br>
                    <div>
                        <c:forEach items="${goods.goodsImgList}" var="item" varStatus="va">
                            <div style="padding: 10px;">
                                <img src="${item}" alt="图片${va.index}">
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <table class="table  table-bordered table-condensed">
                        <thead>
                        <tr>
                            <th>品牌</th>
                            <th>门幅</th>
                            <th>材质</th>
                            <th>风格</th>
                            <th>规格</th>
                            <th>上架时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                ${goods.brandName}
                            </td>
                            <td>${goods.larghezza}
                            </td>
                            <td>${goods.style}
                            </td>
                            <td>${goods.material}
                            </td>
                            <td>${goods.specification}
                            </td>
                            <td>
                                <fmt:formatDate value="${goods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript">
    layui.use(['carousel', 'form', 'element'], function () {
        var carousel = layui.carousel;

        //常规轮播
        carousel.render({
            elem: '#test1'
            , arrow: 'none'
            , width: '100%'
            , height: '300px'
            , interval: 5000
        });
    });
</script>

</body>
</html>