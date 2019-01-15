<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>订单管理</title>
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
        function showLogistics(id, no) {

            var callbackurl = 'javascript:void(0)';

            window.sgSpan = layer.open({
                type: 2,
                title: '物流轨迹',
                area: ['50%', '80%'],
                content: ['https://m.kuaidi100.com/index_all.html?type=' + id + '&postid=' + no + '&callbackurl=' + callbackurl, 'yes'],
                btns: 2,
                btnAlign: 'c',
                btn: ['确定', '取消'],
                success: function (layero, index) {
                    // console.log(layero.find("iframe")[0].contentWindow.$('.ui-btn-text'))
                    // layero.find("iframe")[0].contentWindow.$('.ui-btn-text').click(function(){
                    //     alert(11);
                    //     layero.close(index);
                    // });

                },
                yes: function (index, layero) {

                },
                no: function (index, layero) {
                }
            });
        }

        function getExpressCompany() {
            var logisticsNo = $('#logisticsNo').val();
            var result = '';
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderMain/getExpressCompany",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data) {
                        var html = [];
                        html.push('<select id="logisticsNo" style="width:200px;height:30px;margin: 10px;display: inline-block;" class="form-control">');
                        html.push('<option value="">--请选择物流公司--</option>');
                        $.each(data, function (i, _this) {
                            var txt = '';
                            if (logisticsNo == _this.code) {
                                txt = 'selected="true"';
                            }
                            html.push('<option data-id="' + _this.id + '" ' + txt + ' value="' + _this.code + '">' + _this.name + '</option>');
                        });
                        html.push('</select>');
                        result = html.join('').toString();
                    }
                }
            });
            return result;
        }

        function sendGoods(_this) {
            var id = $(_this).data('id');
            var expressCompany = getExpressCompany();
            var content = [];
            content.push('<ul style="margin-top: 20px;height: auto;text-align: center;">');
            content.push('<li>物流公司：' + expressCompany + '</li>');
            content.push('<li>物流单号：<input type="text" id="freightNumber" class="form-control" style="display: inline-block;width:200px;height:30px;margin: 10px;" placeholder="请输入运单号"></li>');
            content.push('</ul>');

            content = content.join('').toString();

            window.sgSpan = layer.open({
                type: 1,
                title: '订单发货',
                area: ['400px', '240px'],
                content: content,
                btns: 2,
                btnAlign: 'c',
                btn: ['确定', '取消'],
                success: function (layero, index) {
                },
                yes: function (index, layero) {
                    var freightNumber = $(layero).find('#freightNumber').val();
                    var logisticsNo = $(layero).find('#logisticsNo').val();
                    var logisticsName = $(layero).find('#logisticsNo option:selected').text();

                    if (!$.trim(logisticsNo)) {
                        layer.msg('请选择物流公司');
                        return;
                    }
                    if (!$.trim(freightNumber)) {
                        layer.msg('请输入物流单号');
                        return;
                    }
                    var reg = /^\w+$/;
                    if (!reg.test(freightNumber)) {
                        layer.msg('物流单号格式不正确');
                        return;
                    }
                    var data = {
                        id: id,
                        logisticsNo: logisticsNo,
                        freightNumber: freightNumber,
                        logisticsName: logisticsName
                    };

                    checkLogNoFun(data, function () {
                        sendGoodsFun(data, function () {
                            layer.close(index);
                            setTimeout(function () {
                                window.location.reload();
                            }, 1500)
                        });
                    });
                },
                no: function (index, layero) {
                }
            });
        }

        function sendGoodsFun(data, callback) {
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderMain/sendGoods",
                data: data,
                dataType: "json",
                success: function (data) {
                    if (data) {
                        layer.msg(data.errorMessage);
                    }
                    if (callback) callback();
                    return;
                }
            });
        }

        function checkLogNoIsUse(data, callback) {
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderMain/checkLogNo",
                data: data,
                dataType: "json",
                async: false,
                success: function (data) {
                    if (callback) callback(data.success);
                    return;
                }
            });
        }

        function checkLogNoFun(data, yes, no) {
            checkLogNoIsUse(data, function (flag) {
                if (flag) {
                    layer.confirm('该物流单号已使用，您要确定要继续使用吗？', {
                        btn: ['确定', '取消'] //按钮
                    }, function () {
                        if (yes) yes();
                    }, function () {
                        if (no) no();
                    });
                } else {
                    if (yes) yes();
                }
            });
        }

        function showLog1(obj) {
            var btn = $(obj);
            var node = $('.show-log');
            // 如果node是显示的则隐藏node元素，否则显示
            if (node.is(':visible')) {
                node.hide();
                btn.html('查看操作日志');
            } else {
                node.show();
                btn.html('隐藏操作日志');
            }
        }

        function updateStatus(status, id) {
            layer.confirm('您确定要执行该操作吗？', {
                btn: ['确定', '取消']
            }, function () {
                updateStatusFun(status, id);
            }, function () {

            });
        }

        function updateStatusFun(status, id, amount) {
            var oldStatus = $('#orderStatus').val();
            var data = {id: id, status: status, oldStatus: oldStatus, amount: amount};
            layer.load();
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderMain/updateStatus",
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

        function addRemarkFun(id, remark) {
            var data = {id: id, remark: remark};
            layer.load();
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderMain/addRemark",
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

        function addRemark(id) {
            var content = [];
            content.push('<ul style="margin-top: 20px;height: auto;text-align: center;padding: 0 10px;">');
            content.push('<li><textarea id="remark" class="form-control" rows="5" placeholder="请输入备注"></textarea></li>');
            content.push('</ul>');
            content = content.join('').toString();
            window.sgSpan = layer.open({
                type: 1,
                title: '添加备注',
                area: ['400px', '240px'],
                content: content,
                btns: 2,
                btnAlign: 'c',
                btn: ['确定', '取消'],
                success: function (layero, index) {
                },
                yes: function (index, layero) {
                    var remark = $(layero).find('#remark').val();
                    if (!$.trim(remark)) {
                        layer.msg('请输入备注');
                        return;
                    }
                    addRemarkFun(id, remark);
                },
                no: function (index, layero) {
                }
            });
        }

        function addAmount(status, id) {
            var content = [];
            content.push('<ul style="margin-top: 20px;height: auto;text-align: center;padding: 0 10px;">');
            content.push('<li><input id="amount" class="form-control" rows="5" placeholder="请输入报价"></input></li>');
            content.push('</ul>');
            content = content.join('').toString();
            window.sgSpan = layer.open({
                type: 1,
                title: '报价',
                area: ['300px', '160px'],
                content: content,
                btns: 2,
                btnAlign: 'c',
                btn: ['确定', '取消'],
                success: function (layero, index) {
                },
                yes: function (index, layero) {
                    var amount = $(layero).find('#amount').val();
                    if (!$.trim(amount)) {
                        layer.msg('请输入报价');
                        return;
                    }

                    var reg = /^[\-\+]?([0-9]\d*|0|[1-9]\d{0,2}(,\d{3})*)(\.\d+)?$/;
                    if (!reg.test(amount)) {
                        layer.msg('格式不正确');
                        return;
                    }
                    updateStatusFun(status, id, amount);
                },
                no: function (index, layero) {
                }
            });
        }

    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/order/orderMain/list?orderType=1">订单列表</a></li>
    <li class="active"><a href="${ctx}/order/orderMain/detail?id=${orderMain.id}">订单查看</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="orderMain" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="orderStatus"/>
    <form:hidden path="logisticsNo"/>

    <div class="alert alert-info width85" contenteditable="true">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h4>提示!</h4>
        订单状态流转为不可逆操作,请谨慎操作.
    </div>
    <div style="margin-bottom:15px;" class="width85">
        <!-- Standard button -->
            <%--<button id="button_refuse" type="button" ${orderMain.orderStatus != '1' ? 'disabled="true"' : ''}--%>
            <%--onclick="updateStatus('0', '${orderMain.id}');" class="btn btn-warning order-btn">退回--%>
            <%--</button>--%>

        <!-- Standard button -->
        <button id="button_saleafter" type="button" ${orderMain.orderStatus != '1' ? 'disabled="true"' : ''}
                onclick="updateStatus('2', '${orderMain.id}');" class="btn btn-primary order-btn">售后审核
        </button>

        <!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
        <button id="button_finance" type="button" ${orderMain.orderStatus != '2' ? 'disabled="true"' : ''}
                onclick="updateStatus('3', '${orderMain.id}');" class="btn btn-primary order-btn">财务审核
        </button>

        <!-- Indicates a successful or positive action -->
        <button id="button_baiting" type="button" ${orderMain.orderStatus != '3' ? 'disabled="true"' : ''}
                onclick="updateStatus('4', '${orderMain.id}');" class="btn btn-success order-btn">下料
        </button>

        <!-- Contextual button for informational alert messages -->
        <button id="button_price" type="button" ${orderMain.orderStatus != '4' ? 'disabled="true"' : ''}
                onclick="addAmount('5', '${orderMain.id}');" class="btn btn-info order-btn">报价
        </button>

        <!-- Indicates caution should be taken with this action -->
        <button id="button_shipments" type="button" ${orderMain.orderStatus != '5' ? 'disabled="true"' : ''}
                data-id="${orderMain.id}" onclick="sendGoods(this);" class="btn btn-warning order-btn">发货
        </button>

        <!-- Indicates a dangerous or potentially negative action -->
        <button id="button_off" type="button" ${orderMain.orderStatus != '6' ? 'disabled="true"' : ''}
                onclick="updateStatus('7', '${orderMain.id}');" class="btn btn-success order-btn">完成
        </button>

        <!-- Indicates a dangerous or potentially negative action -->
        <button id="button_delete" type="button" ${orderMain.orderStatus != '1' ? 'disabled="true"' : ''}
                onclick="updateStatus('8', '${orderMain.id}');" class="btn btn-danger order-btn">取消
        </button>

        <!-- Indicates a dangerous or potentially negative action -->
        <button id="button_remark" type="button" onclick="addRemark('${orderMain.id}');" class="btn btn-default">添加备注
        </button>
    </div>

    <table id="contentTable" class="table table-bordered table-condensed">
        <thead>
        <tr>
            <th style="width: 3%;">序号</th>
            <th>型号</th>
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
            <th>是否定型</th>
            <th>详细说明</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orderDtlList}" var="orderDtl" varStatus="od">
            <tr>
                <td>
                        ${od.index+1}
                </td>
                <td>
                        ${orderDtl.goods.goodsNo}
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
                        ${fns:getDictLabel(orderDtl.isFinalize, 'yes_no', '')}
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
            <th colspan="4">订单信息</th>
        </tr>
        <tr>
            <td width="15%">订单编码</td>
            <td width="35%">${orderMain.orderNo}</td>
            <td width="15%">订单状态</td>
            <td width="35%">${fns:getDictLabel(orderMain.orderStatus,'order_status','')}</td>
        </tr>
        <tr>
            <td width="15%">报价</td>
            <td width="35%">${orderMain.totalAmount}</td>
            <td width="15%">总米数</td>
            <td width="35%">${orderMain.totalQty}米</td>
        </tr>
        <tr>
            <td width="15%">创建时间</td>
            <td width="35%"><fmt:formatDate value="${orderMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td width="15%">下单用户</td>
            <td width="35%">${orderMain.createBy.name}</td>
        </tr>
        <tr>
            <th colspan="4">收货人信息</th>
        </tr>
        <tr>
            <td width="15%">收货人</td>
            <td width="35%">${orderMain.consigneeName}</td>
            <td width="15%">联系方式</td>
            <td width="35%">${orderMain.consigneePhone}</td>
        </tr>
        <tr>
            <td width="15%">收货地址</td>
            <td colspan="3">${orderMain.consigneeAddress}</td>
        </tr>
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}">
            <th colspan="4">物流信息</th>
        </tr>
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}">
            <td width="15%">运单号</td>
            <td width="35%"><a data-id="${orderMain.logisticsNo}" data-no="${orderMain.freightNumber}"
                               href="javascript:showLogistics('${orderMain.logisticsNo}','${orderMain.freightNumber}')">${orderMain.freightNumber}</a>
            </td>
            <td width="15%">物流公司</td>
            <td width="35%">${orderMain.logisticsName}</td>
        </tr>
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}">
            <td width="15%">发货时间</td>
            <td colspan="3"><fmt:formatDate value="${orderMain.deliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        <tr>
            <th colspan="4">备注</th>
        </tr>
        <tr>
            <td width="15%">备注</td>
            <td colspan="3">${not empty orderMain.remarks ? orderMain.remarks : '无'}</td>
        </tr>
    </table>

    <button type="button" id="showLog" class="button big" style="margin: auto 7.5%;" onclick="showLog1(this)">查看操作日志
    </button>

    <!-- 日志 -->
    <table id="contentTable" class="table table-bordered table-condensed show-log" style="display: none;">
        <thead>
        <tr>
            <th style="width: 3%;">序号</th>
            <th>操作内容</th>
            <th>操作时间</th>
            <th>操作人</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${logList}" var="log" varStatus="od">
            <tr>
                <td>
                        ${od.index+1}
                </td>
                <td>
                        ${log.content}
                </td>
                <td>
                    <fmt:formatDate value="${log.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                        ${log.createBy.name}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="form-group full">
        <div class="col-sm-offset-2 col-sm-3">
            <button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
        </div>
    </div>
</form:form>
</body>
</html>