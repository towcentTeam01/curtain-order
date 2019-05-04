<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>确认订单</title>
    <meta name="decorator" content="default"/>

    <style>
        .form-group.full {
            width: 100%;
            text-align: center;
        }

        .form-group {
            width: 45%;
            float: left;
        }

        .form-group .col-sm-3 {
            width: 50%;
            padding-top: 7px;
            margin-bottom: 0;
        }

        .form-group label {
            width: 50%;
        }

        .form-group.full label {
            width: 25%;
        }

        #contentTable {
            width: 85%;
            margin: 10px auto;
            text-align: center;
        }

        #contentTable tr td, #contentTable tr th {
            text-align: center;
            vertical-align: middle;
            height: 40px;
        }

        #contentTable_1 {
            width: 85%;
            margin: 20px auto;
        }

        #contentTable_1 tr th {
            height: 40px;
            line-height: 40px;
            font-weight: bold;
            font-size: 14px;
            padding: 0 10px;
        }

        #contentTable_1 tr td, #contentTable_1 tr th {
            height: 40px;
            line-height: 40px;
            padding: 0 10px;
        }

        .width85 {
            width: 85%;
            margin: 10px auto;
        }
    </style>

    <script>
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    createOrder();
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

        function createOrder() {
            $('#logisticsName').val($('#logisticsNo').find("option:selected").text());
            var data = {};
            var fields = $('#inputForm').serializeArray();
            jQuery.each(fields, function (i, field) {
                data[field.name] = field.value;
            });
            layer.load();
            $.ajax({
                type: "POST",
                url: "${ctx}/mall/order/crate",
                data: data,
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.code == '000') {
                        layer.msg('下单成功页面跳转中...');
                        setTimeout(function () {
                            location.href = "${ctx}/mall/order/detail?id=" + data.data.id;
                        }, 500)
                    } else {
                        layer.msg(data.errorMessage);
                        setTimeout(function () {
                            window.location.reload();
                        }, 500)
                    }
                    return;
                }
            });
        }


        function goToBack() {
            window.location.href = '${ctx}/mall/shoppingCart';
        }

    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/mall/shoppingCart/">购物车列表</a></li>
    <li class="active"><a href="${ctx}/mall/shoppingCart/toConfirm?ids=${orderMain.ids}">确认订单</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="orderMain" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="ids"/>
    <form:hidden path="logisticsName"/>

    <table id="contentTable" class="table table-bordered table-condensed">
        <thead>
        <tr>
            <th style="width: 3%;">序号</th>
            <th>商品名称</th>
            <th>数量</th>
            <th>成品宽/米</th>
            <th>成品高/米</th>
            <th>褶数/倍</th>
            <th>总米数/米</th>
            <th>辅料铅线、铅块、<br>底边花边</th>
            <th>里衬/帘头<br>返曼/侧拼</th>
            <th>对/单开</th>
            <th>打孔/捏褶<br>(对花)</th>
            <th>环、S钩</th>
            <th>工艺</th>
            <th>详细说明</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orderMain.orderDtls}" var="orderDtl" varStatus="od">
            <tr>
                <td>
                        ${od.index+1}
                </td>
                <td>
                        ${orderDtl.goods.goodsName}
                </td>
                <td>
                        ${orderDtl.num}
                </td>
                <td>
                        ${orderDtl.length}
                </td>
                <td>
                        ${orderDtl.high}
                </td>
                <td>
                        ${orderDtl.multiple}
                </td>
                <td>
                        ${orderDtl.qty}
                </td>
                <td>
                        ${orderDtl.param1}
                </td>
                <td>
                        ${orderDtl.param2}
                </td>
                <td>
                        ${orderDtl.param3}
                </td>
                <td>
                        ${orderDtl.param4}
                </td>
                <td>
                        ${orderDtl.param5}
                </td>
                <td>
                        ${fns:getDictLabel(orderDtl.isFinalize, 'technology', '')}
                </td>
                <td>
                        ${orderDtl.remarks}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <table id="contentTable_1" class="table  table-bordered table-condensed">
        <tr>
            <th colspan="2">订单信息</th>
        </tr>
        <tr>
            <td width="20%">收获地址</td>
            <td width="80%">
                <div class="col-sm-6" style="padding: 10px;">
                    <sys:tagSearchList
                            id="consigneeId"
                            value=""
                            name="consigneeAddress"
                            labelValue=""
                            url="${ctx}/sys/tag/searchAddressList"
                            placeholder="选择收获地址"
                            cssClass="form-control required">
                    </sys:tagSearchList>
                </div>
            </td>
        </tr>
        <tr>
            <td width="20%">物流公司</td>
            <td width="80%">
                <div class="col-sm-6" style="padding: 10px;">
                    <form:select path="logisticsNo" class="form-control required">
                        <form:option value="" label="请选择"/>
                        <c:forEach items="${mapList}" var="item">
                            <form:option value="${item.code}" label="${item.name}"/>
                        </c:forEach>
                    </form:select>
                </div>
            </td>
        </tr>
        <tr>
            <th colspan="2" style="text-align: center;">
                <button type="submit" id="btnSubmit" class="btn btn-success big">确认订单</button>&nbsp;&nbsp;
                <button type="button" id="btnCancel" class="btn btn-info big" onclick="goToBack()">返回</button>
            </th>
        </tr>
    </table>

</form:form>
</body>
</html>