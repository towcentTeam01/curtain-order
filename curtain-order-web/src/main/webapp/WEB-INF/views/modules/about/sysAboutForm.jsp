<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>关于管理</title>
<meta name="decorator" content="default"/>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/lang/zh-cn/zh-cn.js"></script>
<c:set var="imagePath" value="${fns:getUrlHeader()}"/>
<script type="text/javascript">
var validate;
	$(document).ready(function() {
		validate = $("#inputForm").submit(function(){
			UE.getEditor('content').sync();
		}).validate({
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
	
	var data = [[
	             'fullscreen', 'source', '|', 'undo', 'redo', '|',
	             'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
	             'fontfamily', 'fontsize', '|',
	             'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
	             'horizontal', 'date', 'time', 'spechars', 'preview'
	         ]];
	UE.getEditor('serviceAgreement',{toolbars:data,initialContent: '${sysAbout.serviceAgreement}'});
	UE.getEditor('privacyPolicy',{toolbars:data,initialContent: '${sysAbout.privacyPolicy}'});
	UE.getEditor('userNotes',{toolbars:data,initialContent: '${sysAbout.userNotes}'});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/about/sysAbout/">关于列表</a></li>
		<li class="active"><a href="${ctx}/about/sysAbout/form?id=${sysAbout.id}">关于<shiro:hasPermission name="about:sysAbout:edit">${not empty sysAbout.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="about:sysAbout:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysAbout" action="${ctx}/about/sysAbout/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label"><span class="help-inline"><font color="red">*</font></span>app类别：</label>
			<div class="col-sm-3">
				<form:select path="appType" class="input-xlarge required" cssStyle="width:200px;">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('app_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">LOGO：</label>
			<div class="col-sm-4">
				<sys:fileInput path="logo" value="${sysAbout.logo}" type="icon" thumbSize="200X200"></sys:fileInput>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><span class="help-inline"><font color="red">*</font></span>APP名称：</label>
			<div class="col-sm-3">
				<form:input path="appName" htmlEscape="false" maxlength="200" class="form-control required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">版权：</label>
			<div class="col-sm-3">
				<form:input path="copyright" htmlEscape="false" maxlength="200" class="form-control "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">软件服务协议：</label>
			<div class="col-sm-6">
				<!-- 加载编辑器的容器 -->
		        <script id="serviceAgreement" name="serviceAgreement" type="text/plain" style="width:780px;height:300px;">${sysAbout.serviceAgreement}</script>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">隐私政策：</label>
			<div class="col-sm-6">
				<!-- 加载编辑器的容器 -->
		        <script id="privacyPolicy" name="privacyPolicy" type="text/plain" style="width:780px;height:300px;"></script>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户须知：</label>
			<div class="col-sm-6">
				<!-- 加载编辑器的容器 -->
		        <script id="userNotes" name="userNotes" type="text/plain" style="width:780px;height:300px;"></script>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">关于我们内容：</label>
			<div class="col-sm-6">
				<form:textarea path="about" htmlEscape="false" rows="15"  maxlength="1000" class="form-control" style="width:780px;height:300px;"/>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-5 col-sm-offset-2">
				<shiro:hasPermission name="about:sysAbout:edit">
					<button type="submit" id="btnSubmit" class="button big">保 存</button>&nbsp;&nbsp;
				</shiro:hasPermission>
				<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返 回</button>
			</div>
		</div>
	</form:form>
<script type="text/javascript">
$(document).ready(function(){
	var brandNo = '${sysAbout.id}';
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
	
	$('#logoUrlPic').ImgUpload('sysAbout',{},onUploadSuccess);
});
</script>
</body>
</html>