<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>图片管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript" src="${ctxStatic}/jquery/plugin/lazyload/jquery.lazyload.js"></script>
<style type="text/css">
.imagetemp-div {
	position: relative;
	top: -5px;
}

.imagetemp-div input {
	width: 190px !important;
	height: 38px;
}

.imagetemp-div a {
	height: 38px;
}

.imagetemp-div a i {
	margin-top: 6px;
}

.ui.cards>.card {
	display: -webkit-box;
	display: -ms-flexbox;
	margin: .875em .5em;
	float: none;
}

.radio, .checkbox {
	padding-left: 0px;
}

div {
	word-wrap: break-word;
}

.imgdiv {
	display: table-cell;
	width: 170px;
	height: 170px;
	vertical-align: middle;
	text-align: center;
}

.imgdiv img {
	vertical-align: middle;
}

.pagination input {
	padding: 0px !important;
	width: 30px !important;
}
</style>
<script type="text/javascript">
	$(function() {
		loadImgPage(0);
	});

	function loadImgPage(type) {
		var params = "";
		if (type != null && type == 1) {
			params = $("#paramsForm").serialize();
		}
		
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		$('#loadImgList').load("${ctx}/image/imageTempSpace/loadList?" + params, {
					"pageNo" : pageNo,
					"pageSize" : pageSize
				}, function(data) {
					unCheckAll();
				});
		return false;
	}

	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		loadImgPage(1);
		return false;
	}
</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/image/imageTempSpace/">图片空间</a></li>
</ul>
			<form method="post" id="paramsForm" action="" class="navbar-form form-search">
				<input type="hidden" id="createBy" name="createBy" value="${fns:getUser().id}" />
				<input type="hidden" id="orderBy" name="orderBy" value="" />
				<ul class="ul-form">
					<%-- <li><label></label>
						<sys:tagSearchList name="merchantNo"
						value="${imageTempSpace.merchantNo}" id="merchantNo">选择</sys:tagSearchList>
					</li> --%>
					<li><label></label>
						<input name="picName" placeholder="图片名" autocomplete="off" value="${imageTempSpace.picName}"  class="form-control"/>
					</li>
					<li><label>分类：</label>
						<input type="hidden" value="${imageTempSpace.picType}" id="picTypeHe"> 
						<select class="ui dropdown notselect" name="picType" id="picTypeId"  class="form-control">
							<option value="-1">全部</option>
							<option value="0">商品主图图</option>
							<option value="1">商品详情图</option>
						</select>
					</li>
					<li class="btns">
						<button id="sendBtn" class="button big" type="button"onclick="queryTempSpace()">查询</button>
					</li>
					<li class="clearfix">
						
					</li>
				</ul>
				<div id="uploadImg">
					<sys:multfileInput path="photo" value="" type="tempPic" thumbSize="230X230" auto="true" browerIE="${isLessThanIE10 }"
					url="/image/imageTempSpace/uploadImage"></sys:multfileInput>
				</div>
			</form>
			<sys:message content="${message}" />
			<div id="loadImgList"></div>
<script type="text/javascript">
function photoCallBack(urls){
	alertx("上传成功!",function() {queryTempSpace();});
}
$(document).ready(function() {
	//全选
	//window.jsonData.merchantId = 2;
	$("#selectallId").click(function(){
		var checked = $(this).attr('class').indexOf('checked') > 0;
		if (checked) { //反选
			$('.imageCheckbox').each(function(){
				var checked = $(this).attr('class').indexOf('checked') > 0;
				if(checked){
					$(this).click();
				}
			});
		} else {
			$('.imageCheckbox').each(function(){
				var checked = $(this).attr('class').indexOf('checked') > 0;
				if(!checked){
					$(this).click();
				}
			});
		}
	});
	
	$('#orderById').change(function(){
		$('#orderBy').val($(this).val());
		loadImgPage(1);
	});
	
	$('#setTypeId').change(function(){
		if ($(this).val() >= 0) {
			var spIds = getCheckBoxIds();
			if (spIds) {
				$.ajax({
					type : "POST",
					url : ctx + "/image/imageTempSpace/setPicType",
					data : {"picType":$(this).val(), "spIds":spIds},
					async : false,
					success : function(data) {
				       	if("success"==data) {
				       		unCheckAll();
							alertx("设置图片分类成功");
					  	} else {
					  		alertx('设置图片分类失败');
					  	}
				   	}
				});			
			} else {
				alertx('请勾选要设置分类的图片');
			}
		}
	});
	
	//删除图片
	$('.del-pic').live('click',function(){
		var id = $(this).attr('_id');
		confirmx('确认要删除该图片吗？', function(){
			$.ajax({
				dataType : "json",
				url : ctx + "/image/imageTempSpace/delete",
				data : {'id':id},
				success : function(data) {
					unCheckAll();
					loadImgPage(1);
			   	}
			});	
		});
	});
});

function queryTempSpace() {
	loadImgPage(1);
}

function getCheckBoxIds() {
	var spIds = "";
	$('.imageCheckbox').each(function(){
		var checked = $(this).attr('class').indexOf('checked') > 0;
		if (checked) {
			spIds += $(this).attr('spaceId');
			spIds += ",";
		}
	});
	return spIds;
}

function deleteSelect() {
	var spIds = getCheckBoxIds();
	//var href = ctx + "/image/imageTempSpace/deleteSelect?jumpType="+type+"&merchantNo="+merchantNo+"&spIds=" + spIds;
	if (spIds) {
		confirmx('确认要删除该图片吗？', function(){
			$.ajax({
				dataType : "json",
				url : ctx + "/image/imageTempSpace/deleteSelect",
				data : {'spIds':spIds},
				success : function(data) {
					unCheckAll();
					loadImgPage(1);
			   	}
			});
		});				
	} else {
		alertx('请勾选要删除的图片');
	}
}

function unCheckAll(){
	var isCheck = $('#selectAll').attr("checked");
	if(isCheck == "checked"){
		$('#selectAll').removeAttr("checked");
	}
}
</script>
</body>
</html>