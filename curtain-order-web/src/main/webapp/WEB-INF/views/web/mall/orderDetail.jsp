<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>订单详情</title>
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
            vertical-align:middle;
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
        function showLogistics(id,no){

            var callbackurl = 'javascript:void(0)';

            window.sgSpan = layer.open({
                type : 2,
                title : '物流轨迹',
                area : [ '50%', '80%' ],
                content : ['https://m.kuaidi100.com/index_all.html?type='+id+'&postid='+no+'&callbackurl='+callbackurl,'yes'],
                btns:2,
                btnAlign:'c',
                btn: ['确定', '取消'],
                success: function(layero,index){
                    // console.log(layero.find("iframe")[0].contentWindow.$('.ui-btn-text'))
                    // layero.find("iframe")[0].contentWindow.$('.ui-btn-text').click(function(){
                    //     alert(11);
                    //     layero.close(index);
                    // });

                },
                yes: function(index,layero){

                },
                no: function(index,layero){}
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

        function goToBack() {
            window.location.href = '${ctx}/mall/order/list?orderType=1';
        }
        
    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/mall/order/list?orderType=1">订单列表</a></li>
    <li class="active"><a href="${ctx}/mall/order/detail?id=${orderMain.id}">订单详情</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="orderMain" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    

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
            <th>里衬/反幔/<br>侧拼/帘头</th>
            <th>对/单开</th>
            <th>打孔/捏褶<br>(对花)</th>
            <th>环、S钩</th>
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
                    <a href="${ctx}/mall/goods/detail?goodsId=${orderDtl.goods.id}">${orderDtl.goods.goodsNo}</a>
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
                    ${orderDtl.remarks}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


    <table id="contentTable_1" class="table  table-bordered table-condensed">
        <tr><th colspan="4">订单信息</th></tr>
        <tr>
            <td width="15%">订单编码</td>
            <td width="35%">${orderMain.orderNo}</td>
            <td width="15%">订单状态</td>
            <td width="35%">${fns:getDictLabel(orderMain.orderStatus,'order_status','')}</td>
        </tr>
        <tr>
            <td width="15%">报价</td>
            <td width="35%" style="color:red;">${orderMain.totalAmount}</td>
            <td width="15%">总米数</td>
            <td width="35%">${orderMain.totalQty}米</td>
        </tr>
        <tr>
            <td width="15%">创建时间</td>
            <td width="35%"><fmt:formatDate value="${orderMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td width="15%">下单用户</td>
            <td width="35%">${orderMain.createBy.name}</td>
        </tr>
        <tr><th colspan="4">收货人信息</th></tr>
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
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}"><th colspan="4">物流信息</th></tr>
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}">
            <td width="15%">运单号</td>
            <td width="35%"><a data-id="${orderMain.logisticsNo}" data-no="${orderMain.freightNumber}" href="javascript:showLogistics('${orderMain.logisticsNo}','${orderMain.freightNumber}')">${orderMain.freightNumber}</a></td>
            <td width="15%">物流公司</td>
            <td width="35%">${orderMain.logisticsName}</td>
        </tr>
        <tr style="display: ${not empty orderMain.logisticsNo ? '' : 'none'}">
            <td width="15%">发货时间</td>
            <td colspan="3"><fmt:formatDate value="${orderMain.deliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        <tr><th colspan="4">备注</th></tr>
        <tr>
            <td width="15%">备注</td>
            <td colspan="3">${not empty orderMain.remarks ? orderMain.remarks : '无'}</td>
        </tr>
    </table>
    
    <button type="button" id="showLog" class="button big" style="margin: auto 7.5%;" onclick="showLog1(this)">查看操作日志</button>
    
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
            <button type="button" id="btnCancel" class="button big" onclick="goToBack()">返回</button>
        </div>
    </div>
</form:form>
</body>
</html>