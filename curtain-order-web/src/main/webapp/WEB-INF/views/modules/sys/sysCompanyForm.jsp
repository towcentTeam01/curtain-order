<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>分公司管理</title>
<meta name="decorator" content="default"/>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/uploadify/uploadify.css">
<script type="text/javascript" src="${ctxStatic}/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${ctxStatic}/uploadify/jquery.uploadify.3.2.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/areaSelect.js"></script>
<c:set var="imagePath" value="${fns:getUrlHeader()}"/>
<script type="text/javascript">
$(document).ready(function() {
	loadAndShowArea('${sysCompany.id}','${sysCompany.provinceNo}','${sysCompany.cityNo}','${sysCompany.countyNo}');
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
	<li><a href="${ctx}/sys/sysCompany/">分公司列表</a></li>
	<li class="active"><a href="${ctx}/sys/sysCompany/form?id=${sysCompany.id}">分公司<shiro:hasPermission name="sys:sysCompany:edit">${not empty sysCompany.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysCompany:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="sysCompany" action="${ctx}/sys/sysCompany/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>		
	<div class="control-group">
		<label class="control-label">公司名称：</label>
		<div class="controls">
			<form:input path="companyName" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">公司logo:</label>
		<div class="controls">
			<div style="display: none;margin: 0 0 10px 0" id="logoUrlPicDiv">
				<img src="${imagePath}${sysCompany.logoUrl}" width="100px"/>
			</div>
			<input type="hidden" id="logoUrl" name="logoUrl" value="${sysCompany.logoUrl}"/>
			<input type="file" name="fileupload" id="logoUrlPic"/> 
			<div id="logoUrlPicFile" style="display:inline-block;"></div>
			<!-- <span class="help-inline"><font color="red">*</font></span> -->
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">联系人：</label>
		<div class="controls">
			<form:input path="contacts" htmlEscape="false" maxlength="20" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">联系电话：</label>
		<div class="controls">
			<form:input path="contactPhone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">地址：</label>
		<div class="controls">
			<form:select path="provinceNo" class="input-small required" id="province_no">
				<form:option value="" label="请选择省份"/>
			</form:select>
			<span class="help-inline"></span>
			&nbsp;&nbsp;
			<form:select path="cityNo" class="input-small required" id="city_no">
				<form:option value="" label="请选择城市"/>
			</form:select>
			<span class="help-inline"></span>
			&nbsp;&nbsp;
			<form:select path="countyNo" class="input-small required"  id="county_no">
				<form:option value="" label="请选择区县"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">详细地址：</label>
		<div class="controls">
			<form:input path="detailAddress" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<%-- <div class="control-group">
		<label class="control-label">经度：</label>
		<div class="controls">
			<form:input path="lng" htmlEscape="false" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">纬度：</label>
		<div class="controls">
			<form:input path="lat" htmlEscape="false" class="input-xlarge "/>
		</div>
	</div> --%>
	<div class="control-group">
		<label class="control-label">公司描述：</label>
		<div class="controls">
			<form:textarea path="companyDesc" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
		</div>
	</div>
	<div class="form-actions">
		<shiro:hasPermission name="sys:sysCompany:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">
$(document).ready(function(){
	var brandNo = '${sysCompany.id}';
	if(brandNo != null && brandNo != ''){
		$('#logoUrlPicDiv').show();
	}
	
	function onUploadSuccess(data){
		if(data != null && data != ""){
			data = JSON.parse(data);
			$('#logoUrlPicDiv').show();
			$('#logoUrl').val(data.photo);
			$('#logoUrlPicDiv').find('img').attr('src',"${imagePath}"+data.photo);
			$('#logoUrlPic').next('label').remove();
		}
	}
	
	$('#logoUrlPic').ImgUpload('company',{},onUploadSuccess);
});
</script>
</body>
</html>