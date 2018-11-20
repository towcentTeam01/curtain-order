<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品频道管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
                ignore:"",
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else if($(element)[0].tagName == 'SELECT' || element.is(".input-upload")){
                        error.insertAfter(element.next());
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
		<li><a href="${ctx}/goods/goodsChannel/">商品频道列表</a></li>
		<li class="active"><a href="${ctx}/goods/goodsChannel/form?id=${goodsChannel.id}">商品频道<shiro:hasPermission name="goods:goodsChannel:edit">${not empty goodsChannel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="goods:goodsChannel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="goodsChannel" action="${ctx}/goods/goodsChannel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>频道名称：
			</label>
			<div class="col-sm-3">
				<form:input path="channelName" htmlEscape="false" maxlength="30" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>频道类型：
			</label>
			<div class="col-sm-3">
				<form:select path="channelType" class="form-control required">
					<form:options items="${fns:getDictList('channel_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>频道别名：
			</label>
			<div class="col-sm-3">
				<form:input path="channelAlias" htmlEscape="false" maxlength="30" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>是否开启：
			</label>
			<div class="col-sm-3">
				<form:select path="channelStatus" class="form-control required">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>排序：
			</label>
			<div class="col-sm-3">
				<form:input path="sort" htmlEscape="false" maxlength="6" class="form-control required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				开始时间：
			</label>
			<div class="col-sm-3">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="form-control input-medium Wdate "
					value="<fmt:formatDate value="${goodsChannel.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				结束时间：
			</label>
			<div class="col-sm-3">
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="form-control input-medium Wdate "
					value="<fmt:formatDate value="${goodsChannel.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<span><font color="red">*</font></span>频道图片：
			</label>
			<div class="col-sm-3">
				<sys:fileInput path="channelImg" value="${goodsChannel.channelImg}" type="icon" thumbSize="80X80" classS="form-control required input-upload"></sys:fileInput>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				链接：
			</label>
			<div class="col-sm-3">
				<form:input path="channelUrl" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				注备：
			</label>
			<div class="col-sm-3">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="form-control input-xxlarge "/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-3">
			<shiro:hasPermission name="goods:goodsChannel:edit">
			   <button type="submit" id="btnSubmit" class="button big">保存</button>&nbsp;&nbsp;
			</shiro:hasPermission>
			<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返回</button>
			</div>
		</div>
	</form:form>
</body>
</html>