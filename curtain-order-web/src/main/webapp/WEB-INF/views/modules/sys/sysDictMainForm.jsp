<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>数据字典分类</title>
<meta name="decorator" content="default"/>
<style type="text/css">
.win-input {float: right;width: 210px;margin-top:3px;}
.box-inline .control-label{line-height: 40px;width: 85px;padding-right: 15px;text-align:right;}
.box-inline .win-input .input-medium{line-height: 40px;}
</style>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#checkbox_systemFlag').change( function() {
				if ($("#checkbox_systemFlag").attr("checked")=='checked') {
					$('#systemFlag').val('0');
				} else {
					$('#systemFlag').val('1');
				}
			});	
			
			if ($('#systemFlag').val() == '1') {
				$("#checkbox_systemFlag").removeAttr("checked");
			} else {
				$('#systemFlag').val('0');
			}
		});
	</script>
	
</head>
<body>
	<form id="inputForm" action="" class="form-horizontal">
		<sys:message content="${message}"/>
		<div class="box-inline" style="margin-top: 10px;">
			<label class="control-label">分类名称:</label>
			<div class="win-input">
				<input type="text" id="name" name="name" value="${mDict.name }" class="form-control"/>
			</div>
		</div>
		<div class="box-inline">
			<label class="control-label">分类简称:</label>
			<div class="win-input">
				<input type="text" id="shortName" name="shortName" value="${mDict.shortName }" class="form-control"/>
			</div>
		</div>
		<div class="box-inline">
			<label class="control-label">分类代码:</label>
			<div class="win-input">
				<input type="text" id="code" name="code" value="${mDict.code }" class="form-control"/>
			</div>
		</div>
		<div class="box-inline">
			<label class="control-label">描述:</label>
			<div class="win-input">
				<input type="text" id="description" name="description" value="${mDict.description }" class="form-control"/>
			</div>
		</div>
		<div class="box-inline">
			<label class="control-label">是否系统:</label>
			<div class="win-input">
				<input type="hidden" id="systemFlag" name="systemFlag" value="${mDict.systemFlag }" />
				<div class="checkbox abc-checkbox">
                    <input id="checkbox_systemFlag" name="checkbox_systemFlag" class="styled" type="checkbox" checked="checked">
                    <label for="checkbox_systemFlag">
                    </label>
                </div>
			</div>
		</div>
	</form>
</body>
</html>