<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function getExpressCompany(){
            var result = '';
            $.ajax( {
                type : "POST",
                url : "${ctx}/order/orderMain/getExpressCompany",
                dataType : "json",
                async:false,
                success : function(data) {
                    if(data){
                        var html = [];
                        html.push('<select id="logisticsNo" style="width:200px;height:30px;margin: 10px;display: inline-block;" class="form-control">');
                        html.push('<option value="">--请选择物流公司--</option>');
                        $.each(data,function(i,_this){
                            html.push('<option data-id="'+_this.id+'" value="'+_this.code+'">'+_this.name+'</option>');
                        });
                        html.push('</select>');
                        result = html.join('').toString();
                    }
                }
            });
            return result;
        }
		
		function sendGoods(_this){
            var id = $(_this).data('id');
            var expressCompany = getExpressCompany();
            var content = [];
            content.push('<ul style="margin-top: 20px;height: auto;text-align: center;">');
            content.push('<li>物流公司：'+expressCompany+'</li>');
            content.push('<li>物流单号：<input type="text" id="freightNumber" class="form-control" style="display: inline-block;width:200px;height:30px;margin: 10px;" placeholder="请输入运单号"></li>');
            content.push('</ul>');

            content = content.join('').toString();

            window.sgSpan = layer.open({
                type : 1,
                title : '订单发货',
                area : [ '400px', '240px' ],
                content : content,
                btns:2,
                btnAlign:'c',
                btn: ['确定', '取消'],
                success: function(layero,index){
                },
                yes: function(index,layero){
                    var freightNumber = $(layero).find('#freightNumber').val();
                    var logisticsNo = $(layero).find('#logisticsNo').val();
                    var logisticsName = $(layero).find('#logisticsNo option:selected').text();

                    if(!$.trim(logisticsNo)){
                        layer.msg('请选择物流公司');
                        return;
                    }
                    if(!$.trim(freightNumber)){
                        layer.msg('请输入物流单号');
                        return;
                    }
                    var reg = /^\w+$/;
                    if(!reg.test(freightNumber)){
                        layer.msg('物流单号格式不正确');
                        return;
                    }
                    var data = {id:id,logisticsNo:logisticsNo,freightNumber:freightNumber,logisticsName:logisticsName};

                    checkLogNoFun(data,function(){
                        sendGoodsFun(data,function(){
                            layer.close(index);
                            setTimeout(function(){
                                window.location.reload();
                            },1500)
                        });
                    });
                },
                no: function(index,layero){}
            });
        }

        function sendGoodsFun(data,callback){
            $.ajax( {
                type : "POST",
                url : "${ctx}/order/orderMain/sendGoods",
                data : data,
                dataType : "json",
                success : function(data) {
                    if(data){
                        layer.msg(data.errorMessage);
                    }
                    if(callback)callback();
                    return;
                }
            });
        }

        function checkLogNoIsUse(data,callback){
            $.ajax( {
                type : "POST",
                url : "${ctx}/order/orderMain/checkLogNo",
                data : data,
                dataType : "json",
                async:false,
                success : function(data) {
                    if(callback)callback(data.success);
                    return;
                }
            });
        }

        function checkLogNoFun(data,yes,no){
            checkLogNoIsUse(data,function(flag){
                if(flag){
                    layer.confirm('该物流单号已使用，您要确定要继续使用吗？', {
                        btn: ['确定','取消'] //按钮
                    }, function(){
                        if(yes)yes();
                    }, function(){
                        if(no)no();
                    });
                }else{
                    if(yes)yes();
                }
            });
        }
        
        function showLogistics(_this){
            var id = $(_this).data('id');
            var no = $(_this).data('no');
            var name = $(_this).data('name');
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/order/orderMain/">订单列表</a></li>
		<%-- <shiro:hasPermission name="order:orderMain:edit"><li><a href="${ctx}/order/orderMain/form">订单添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="orderMain" action="${ctx}/order/orderMain/" method="post" class="navbar-form form-search" role="form">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>订单号：</label>
				<form:input path="orderNo" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>订单状态：</label>
				<form:select path="orderStatus" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>收货人姓名：</label>
				<form:input path="consigneeName" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>收货人联系方式：</label>
				<form:input path="consigneePhone" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li><label>运单号：</label>
				<form:input path="freightNumber" htmlEscape="false" maxlength="50" class="form-control"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${orderMain.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${orderMain.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>是否导出：</label>
				<form:select path="isExport" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('is_export')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><button type="submit" id="btnSubmit" class="button big"><span class="magnifier icon"></span>查询</button> </li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单号</th>
				<th>订单状态</th>
				<th>报价</th>
				<th>收货人姓名</th>
				<th>收货人联系方式</th>
				<th>收货地址</th>
				<th>总米数/米</th>
				<th>运单号</th>
				<th>物流公司名称</th>
				<!-- <th>售后备注</th>
				<th>售后申请时间</th> -->
				<th>创建时间</th>
				<th>发货时间</th>
				<th>是否导出</th>
				<shiro:hasPermission name="order:orderMain:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderMain">
			<tr>
				<td><a href="${ctx}/order/orderMain/detail?id=${orderMain.id}">
					${orderMain.orderNo}
				</a></td>
				<td>
					${fns:getDictLabel(orderMain.orderStatus, 'order_status', '')}
				</td>
				<td>
					${orderMain.totalAmount}
				</td>
				<td>
					${orderMain.consigneeName}
				</td>
				<td>
					${orderMain.consigneePhone}
				</td>
				<td>
					${orderMain.consigneeAddress}
				</td>
				<td>
					${orderMain.totalQty}
				</td>
				<td>
					${orderMain.freightNumber}
				</td>
				<td>
					${orderMain.logisticsName}
				</td>
				<%-- <td>
					${orderMain.saleAfterRemarks}
				</td>
				<td>
					<fmt:formatDate value="${orderMain.saleAfterDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<td>
					<fmt:formatDate value="${orderMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${orderMain.deliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				    ${fns:getDictLabel(orderMain.isExport, 'is_export', '')}
				</td>
				<shiro:hasPermission name="order:orderMain:edit">
				    <td>
					    <a href="${ctx}/order/orderMain/detail?id=${orderMain.id}">查看</a>
	    				<%-- <a href="${ctx}/order/orderMain/form?id=${orderMain.id}">修改</a> --%>
	    				<c:if test="${orderMain.orderStatus == '0' || orderMain.orderStatus == '1'}">
						   <a href="${ctx}/order/orderMain/delete?id=${orderMain.id}" onclick="return confirmx('确认要取消该订单吗？', this.href)">取消</a>
						</c:if>
						<c:if test="${orderMain.orderStatus == '5'}">
	                        <a data-id="${orderMain.id}" onclick="sendGoods(this);" href="javascript:void(0);">发货</a>
	                    </c:if>
	                    <c:if test="${orderMain.orderStatus == '6'}">
	                        <a data-id="${orderMain.logisticsNo}" data-no="${orderMain.freightNumber}" data-name="${orderMain.logisticsName}" onclick="showLogistics(this);" href="javascript:void(0);">查看物流</a>
	                    </c:if>
	                    
	                    <!-- 需要区分是否导出 -->
	                    <a href="${ctx}/order/orderMain/export?id=${orderMain.id}" <c:if test="${orderMain.isExport == '1'}">style="color:green;"</c:if>>导出</a>
				    </td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	${page}
</body>
</html>