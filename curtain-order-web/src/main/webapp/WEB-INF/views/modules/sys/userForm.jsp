<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default"/>

 
	<script type="text/javascript">
	/*手机格式  */
		$(document).ready(function() {
			function isMobile(value) {var rePhone = /^1\d{10}$/;return rePhone.test(value);}
			jQuery.validator.addMethod("mobile", 
				    function(value, element) {
					    var reg = /^1[3-9]\d{9}$/;
					    return this.optional(element) || (reg.test(value) && value > 0);
				    },
				"手机格式不正确");
			
			/*基础工资格式  */
			jQuery.validator.addMethod("money",function(value,elment){
				  var reg = /^[1-9]\d{0,10}$/;
				return this.optional(elment) || reg.test(value);
			},"请输入正确的格式！");
			jQuery.validator.addMethod("phone", 
				    function(value, element) {
					    var reg = /^1[3-9]\d{9}$/;
					    return this.optional(element) || (reg.test(value) && value > 0);
				    },
				"格式不正确");
			
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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

				$("#inputForm").validate({
					submitHandler: function(form){
						alert(11);
						if(!isMobile($("#moblie").val())){
							
							alert("手机号码格式不正确");
							return;
						}
						else{
							loading('正在提交，请稍等...');
							form.submit();
						}
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
		<li><a href="${ctx}/sys/user/list?userType=1">用户列表</a></li>
		<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="userType" name="userType" type="hidden" value="1" />
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">头像:</label>
			<div class="col-sm-3">
				<sys:fileInput path="photo" value="${user.photo}" type="0" thumbSize="200X200"></sys:fileInput>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属公司:</label>
			<div class="col-sm-3">
                <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
					title="公司" url="/sys/office/treeData?type=1" cssClass="form-control required" sysSelect="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属部门:</label>
			<div class="col-sm-3">
                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">工号:</label>
			<div class="col-sm-3">
				<form:input path="no" htmlEscape="false" maxlength="50" class="form-control required"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">姓名:</label>
			<div class="col-sm-3">
				<form:input path="name" htmlEscape="false" maxlength="50" class="form-control required"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">登录名:</label>
			<div class="col-sm-3">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="form-control required userName"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">密码:</label>
			<div class="col-sm-3">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="form-control ${empty user.id?'required':''}"/>
			</div>
			<c:if test="${empty user.id}"><span class="help-block"><font color="red">*</font> </span></c:if>
			<c:if test="${not empty user.id}"><span class="help-block">若不修改密码，请留空。</span></c:if>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">确认密码:</label>
			<div class="col-sm-3">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="form-control"/>
			</div>
			<c:if test="${empty user.id}"><span class="help-block"><font color="red">*</font> </span></c:if>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">性别:</label>
			<div class="col-sm-3">
				<%-- <form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass="radio-inline"/> --%>
                <form2:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">生日:</label>
			<div class="col-sm-3">
				<input name="birthday" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">邮箱:</label>
			<div class="col-sm-3">
				<form:input path="email" htmlEscape="false" maxlength="100" class="form-control email"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">电话:</label>
			<div class="col-sm-3">
				<form:input path="phone"  id="phone" htmlEscape="false" maxlength="100" class="form-control phone"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">手机:</label>
			<div class="col-sm-3">
				<form:input path="mobile" id="moblie" htmlEscape="true" maxlength="100" class="form-control mobile"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">职务:</label>
			<div class="col-sm-3">
				<form:input path="job" htmlEscape="false" maxlength="50" class="form-control"/>
			</div>
			<span class="help-block"></span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">入职日期:</label>
			<div class="col-sm-3">
				<input name="entryDate" type="text" readonly="readonly" maxlength="20" class="form-control  Wdate "
					value="<fmt:formatDate value="${user.entryDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否允许登录:</label>
			<div class="col-sm-3">
				<form2:radiobuttons path="loginFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" />
			</div>
			<span class="help-block"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
		</div>
		<%-- <div class="form-group">
			<label class="col-sm-2 control-label">用户类型:</label>
			<div class="col-sm-3">
				<form:select path="userType" class="form-control">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户角色:</label>
			<div class="col-sm-3" >
				<form2:radiobuttons path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
			</div>
			<span class="help-block"><font color="red">*</font> </span>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-4">
				<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="200" class="form-control"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="form-group">
				<label class="col-sm-2 control-label">创建时间:</label>
				<div class="col-sm-3">
					<label class="control-label"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">最后登陆:</label>
				<div class="col-sm-5">
					<label class="control-label">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<div class="form-group">
			<div class="col-sm-5 col-sm-offset-2">
				<shiro:hasPermission name="sys:user:edit">
					<button type="submit" id="btnSubmit" class="button big">保 存</button>&nbsp;&nbsp;
				</shiro:hasPermission>
				<button type="button" id="btnCancel" class="button big" onclick="history.go(-1)">返 回</button>
			</div>
		</div>
	</form:form>
</body>
</html>