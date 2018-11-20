<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
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
		<li><a href="${ctx}/goods/goods/">商品列表</a></li>
		<li class="active"><a href="${ctx}/goods/goods/form?id=${goods.id}">商品<shiro:hasPermission name="goods:goods:edit">${not empty goods.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="goods:goods:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="goods" action="${ctx}/goods/goods/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				分类编码：
			</label>
			<div class="col-sm-3">
				<form:select path="cateNo" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('goods_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				分类名称：
			</label>
			<div class="col-sm-3">
				<form:input path="cateName" htmlEscape="false" maxlength="500" class="form-control required"/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				商品编码：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsNo" htmlEscape="false" maxlength="50" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				商品名称：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsName" htmlEscape="false" maxlength="100" class="form-control required"/>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				商品类型(0:普通商品)：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsType" htmlEscape="false" maxlength="2" class="form-control "/>
			</div>
		</div> 
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品条形码：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsBarcode" htmlEscape="false" maxlength="50" class="form-control "/>
			</div>
		</div>--%>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				商品状态：
			</label>
			<div class="col-sm-3">
				<form:input path="goodsStatus" htmlEscape="false" maxlength="1" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				品牌：
			</label>
			<div class="col-sm-3">
				<form:input path="brandName" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				门幅：
			</label>
			<div class="col-sm-3">
				<form:input path="larghezza" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				风格：
			</label>
			<div class="col-sm-3">
				<form:input path="style" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
			<span class="col-sm-4 help-block">简欧、中式、现代、田园等</span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				材质：
			</label>
			<div class="col-sm-3">
				<form:input path="material" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				规格：
			</label>
			<div class="col-sm-3">
				<form:input path="specification" htmlEscape="false" maxlength="100" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品单价：
			</label>
			<div class="col-sm-3">
				<form:input path="price" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品成本价：
			</label>
			<div class="col-sm-3">
				<form:input path="costPrice" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品图片：
			</label>
			<div class="col-sm-3">
			    <sys:multfileInput path="mainUrls" value="${goods.mainUrls}" type="2" thumbSize="400X400"></sys:multfileInput>
				<%-- <form:input path="mainUrls" htmlEscape="false" maxlength="1000" class="form-control "/> --%>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品简介：
			</label>
			<div class="col-sm-3">
				<form:input path="description" htmlEscape="false" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				商品描述图片：
			</label>
			<div class="col-sm-3">
			    <sys:multfileInput path="descPic" value="${goods.descPic}" type="2" thumbSize="400X400"></sys:multfileInput>
				<%-- <form:input path="descPic" htmlEscape="false" class="form-control "/> --%>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				图片版本：
			</label>
			<div class="col-sm-3">
				<form:input path="descPicV" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span class="help-inline"><font color="red" style="vertical-align:middle;">* </font></span>
				库存：
			</label>
			<div class="col-sm-3">
				<form:input path="qty" htmlEscape="false" class="form-control required"/>
			</div>
			<span class="col-sm-4 help-block">单位/米</span>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				销量：
			</label>
			<div class="col-sm-3">
				<form:input path="saleNum" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				销售米数(单位/米)：
			</label>
			<div class="col-sm-3">
				<form:input path="saleLength" htmlEscape="false" class="form-control "/>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				标签类别：
			</label>
			<div class="col-sm-3">
				<form:select path="labelType" class="form-control ">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('label_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">
				评价数量：
			</label>
			<div class="col-sm-3">
				<form:input path="evaNum" htmlEscape="false" maxlength="11" class="form-control "/>
			</div>
		</div> 
		<div class="form-group">
			<label class="col-sm-2 control-label">
				好评率：
			</label>
			<div class="col-sm-3">
				<form:input path="goodEvalRate" htmlEscape="false" class="form-control "/>
			</div>
		</div>--%>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				注备：
			</label>
			<div class="col-sm-3">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control input-xxlarge "/>
			</div>
		</div>
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
			<shiro:hasPermission name="goods:goods:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>