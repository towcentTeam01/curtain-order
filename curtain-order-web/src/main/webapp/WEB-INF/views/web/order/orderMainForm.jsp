<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/order/orderMain/">订单列表</a></li>
		<li class="active"><a href="${ctx}/order/orderMain/form?id=${orderMain.id}">订单<shiro:hasPermission name="order:orderMain:edit">${not empty orderMain.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="order:orderMain:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="orderMain" action="${ctx}/order/orderMain/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				订单类型(0:普通订单)：
			</label>
			<div class="col-sm-3">
				<form:input path="orderType" htmlEscape="false" maxlength="2" class="form-control required"/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				订单号：
			</label>
			<div class="col-sm-3">
				<form:input path="orderNo" htmlEscape="false" maxlength="20" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				订单状态：
			</label>
			<div class="col-sm-3">
				<form:select path="orderStatus" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				报价：
			</label>
			<div class="col-sm-3">
				<form:input path="totalAmount" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				收货人姓名：
			</label>
			<div class="col-sm-3">
				<form:input path="consigneeName" htmlEscape="false" maxlength="20" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				收货人联系方式：
			</label>
			<div class="col-sm-3">
				<form:input path="consigneePhone" htmlEscape="false" maxlength="20" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				收货详细地址：
			</label>
			<div class="col-sm-3">
				<form:input path="consigneeAddress" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				总米数/米：
			</label>
			<div class="col-sm-3">
				<form:input path="totalQty" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				运单号：
			</label>
			<div class="col-sm-3">
				<form:input path="freightNumber" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				物流公司编码：
			</label>
			<div class="col-sm-3">
				<form:input path="logisticsNo" htmlEscape="false" maxlength="20" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				物流公司名称：
			</label>
			<div class="col-sm-3">
				<form:input path="logisticsName" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div> --%>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				售后备注：
			</label>
			<div class="col-sm-3">
				<form:input path="saleAfterRemarks" htmlEscape="false" maxlength="2000" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				售后申请时间：
			</label>
			<div class="col-sm-3">
				<input name="saleAfterDate" type="text" readonly="readonly" maxlength="20" class="form-control input-medium Wdate "
					value="<fmt:formatDate value="${orderMain.saleAfterDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				注备：
			</label>
			<div class="col-sm-3">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="600" class="form-control input-xxlarge "/>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				支付时间(暂时未使用)：
			</label>
			<div class="col-sm-3">
				<input name="payDate" type="text" readonly="readonly" maxlength="20" class="form-control input-medium Wdate "
					value="<fmt:formatDate value="${orderMain.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div> --%>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				发货时间：
			</label>
			<div class="col-sm-3">
				<input name="deliveryTime" type="text" readonly="readonly" maxlength="20" class="form-control input-medium Wdate "
					value="<fmt:formatDate value="${orderMain.deliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div> --%>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				是否导出(0:未导出 1:已导出)：
			</label>
			<div class="col-sm-3">
				<form:select path="isExport" class="form-control ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('is_export')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				商户id：
			</label>
			<div class="col-sm-3">
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="order:orderMain:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>