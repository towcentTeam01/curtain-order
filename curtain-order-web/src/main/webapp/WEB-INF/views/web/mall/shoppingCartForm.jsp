<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>购物车管理</title>
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
		<li><a href="${ctx}/mall/shoppingCart/">购物车列表</a></li>
		<li class="active"><a href="${ctx}/mall/shoppingCart/form?id=${shoppingCart.id}">购物车<shiro:hasPermission name="mall:shoppingCart:edit">${not empty shoppingCart.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="mall:shoppingCart:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="shoppingCart" action="${ctx}/mall/shoppingCart/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group" style="display: none;">
			<label class="col-sm-2 control-label">
				商品id：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsId" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品名称：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsName" readonly="true" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品图片：
			</label>
			<div class="col-sm-3">
				<img src="${shoppingCart.goodsPicUrl}" style="width: 300px;height: 200px;"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				成品宽(单位/米)：
			</label>
			<div class="col-sm-3">
				<form:input path="length" htmlEscape="false" maxlength="10" class="form-control required money" max="100"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				成品高(单位/米)：
			</label>
			<div class="col-sm-3">
				<form:input path="high" htmlEscape="false" maxlength="10" class="form-control money" max="100"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				褶数(倍)：
			</label>
			<div class="col-sm-3">
				<form:input path="multiple" htmlEscape="false" maxlength="10" min="1" class="form-control required money" max="100"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				辅料铅线、铅块、底边花边：
			</label>
			<div class="col-sm-3">
				<form:input path="param1" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				里衬/帘头/返曼/侧拼：
			</label>
			<div class="col-sm-3">
				<form:input path="param2" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				对/单开：
			</label>
			<div class="col-sm-3">
				<form:input path="param3" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				打孔/捏褶(对花)：
			</label>
			<div class="col-sm-3">
				<form:input path="param4" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				环、S钩(不要可不填)：
			</label>
			<div class="col-sm-3">
				<form:input path="param5" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				详情说明：
			</label>
			<div class="col-sm-3">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control input-xxlarge "/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="mall:shoppingCart:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>