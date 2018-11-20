<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/semantic/semantic.min.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/uploadify/uploadify.css">
    <link rel="stylesheet" type="text/css" media="all" href="${ctxStatic}/semantic/daterangepicker/daterangepicker-bs3.css" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/common/admin.css?version=${version}">
    <script type="text/javascript" src="${ctxStatic}/semantic/semantic.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/semantic/daterangepicker/moment.js"></script>
    <script type="text/javascript" src="${ctxStatic}/semantic/daterangepicker/daterangepicker.js"></script>
    <script type="text/javascript" src="${ctxStatic}/commerce/image/imageTempSpace.js?version=${version}"></script>
    <script type="text/javascript" src="${ctxStatic}/uploadify/swfobject.js"></script>
    <script type="text/javascript" src="${ctxStatic}/uploadify/jquery.uploadify.3.2.min.js"></script>
	<c:set var="imagePath" value="${fns:getUrlHeader()}"/>
	<style type="text/css">
	.ui.cards>.card {
		  display: -webkit-box;
		  display: -ms-flexbox;
		  margin: .875em .5em;
		  float: none;
  			}
  		.radio, .checkbox{padding-left: 0px;}
		div{word-wrap: break-word;}
		.imgdiv{
			display: table-cell; 
			width:230px;
			height:230px;
			vertical-align:middle;
			text-align:center; 
		}
		.imgdiv img{vertical-align:middle;}
		.pagination input {
	padding: 0px !important;
	width: 30px !important;
}
	</style>
</head>
<body>
	<div class="mainBox">
		<div class="ui top attached tabular menu" id="tab">
			<a class="active item" data-tab="first">店铺临时图片空间</a> 
		</div>
		<div class="ui bottom attached active tab segment" data-tab="first">
			<div class="ui remote search" id="username">
				<form action="" method="post" id="paramsForm">
					<input id="merchantNo" name="merchantNo" type="hidden" value="${imageTempSpace.merchantNo}" />
					<input type="hidden" id="createBy" name="createBy" value="${fns:getUser().id}"/>
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
					<%-- <div class="ui icon input" style="width: 250px;">
						<sys:tagSearchList name="merchantNo" value="${imageTempSpace.merchantNo}" id="merchantNo">选择</sys:tagSearchList>
					</div> --%>
					<div class="ui icon input">
						<input name="picName" placeholder="图片名" autocomplete="off" value="${imageTempSpace.picName}">
					</div>
					<div class="ui dropdown">
						<label>上传时间：</label>
						<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
							value="<fmt:formatDate value="${imageTempSpace.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" style="height: 38px;margin-top: 6px;"/> 至 
						<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
							value="<fmt:formatDate value="${imageTempSpace.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({minDate:'#F{$dp.$D(\'startDate\',{H:1})}',dateFmt:'yyyy-MM-dd HH:mm:ss'});" style="height: 38px;margin-top: 6px;"/>
					</div>
					&nbsp;
					<label>分类：</label>
					<input type="hidden" value="${imageTempSpace.picType}" id="picTypeHe">
					<select class="ui dropdown notselect" name="picType" id="picTypeId">
						<option value="-1">全部</option>
						<option value="0">商品窗口图</option>
						<option value="1">商品客观图</option>
						<option value="2">商品参考图</option>
					</select>
					<div class="ui primary icon button" id="sendBtn" onclick="queryTempSpace();">
						查  询  <i class="search icon"></i>
					</div>
					
					<!-- <div class="ui btn-info icon button" id="uploadBtn" style="float:right;" onclick="upload();">
						上传图片  <i class="upload icon"></i>
					</div> -->
					<div id="uploadImg" style="margin-top:10px;">
						<input type="hidden" id="adminPhoto" name="adminPhoto" />
						<input type="file" name="fileupload" id="adminPic"/> 
						<div id="adminPicFile" style="display:inline-block;"></div>
						<script type="text/javascript">
							$(document).ready(function(){
									var imgCount = 0;
									var currNum = 0;
									$('#adminPic').uploadify({
									    'swf'       : '${ctxStatic}/swf/uploadify.swf',  //上传所用的flash 必须
									    'fileObjName'   : 'fileupload',  //file的name,
									    'method'		: 'post',
									    'auto'			: true,
									    'width'          : '107',
									    'height'         : '36',
									    'preventCaching'  : true,
									    'removeCompleted'  : true,
									    'buttonImage'      : '${ctxStatic}/images/button_Groupupload.png',
									    'cancelImage'      : '${ctxStatic}/images/upload_cancel.png',  //删除的图片*/
									    'multi'          : true,  //设置为true时可以上传多个文件
									    'fileDesc'       : '*.jpg;*.jpeg;*.png',  //用来设置选择文件对话框中的提示文本
									    'fileExt'        : '*.jpg;*.jpeg;*.png',  //设置可以选择的文件的类型，格式如：'*.doc;*.pdf;*.rar'
									    'formData'   : {merchantNo:'default'},
									    'uploader' : '${ctx}/image/imageTempSpace/uploadImage?;jsessionid=<%=request.getSession().getId()%>',
									    onDialogClose : function(queueData){
									    	imgCount = queueData.filesQueued;
									    },
									    onUploadStart:function(file){
									    	$('#adminPic').uploadify('settings','formData',{merchantNo:$('#merchantNo').val(),createBy:$('#createBy').val()});
									    },
									    onUploadSuccess:function(file, data, response){
									    	currNum++;
									    	if(currNum == imgCount){
									    		currNum = 0;
									    		alertx("上传成功!",function(){
									    			queryTempSpace();
									    		});
									    	}
									    }
								});
							});
						</script>
					</div>
				</form>
			</div>
			<sys:message content="${message}"/>
			<div class="ui form segment">
				<div class="inline field">
					<div class="ui checkbox" id="selectallId">
						<input type="checkbox"><label>全选</label>
					</div>
					将勾选的图片
					<select class="ui dropdown notselect" id="setTypeId">
						<option value="-1">设置分类</option>
						<option value="0">窗口图</option>
						<option value="1">客观图</option>
						<option value="2">参考图</option>
					</select>
					<div class="ui black button icon" onclick="deleteSelect();">
						删除<i class="trash icon"></i>
					</div>
					<select class="ui dropdown notselect" id="orderById">
						<option value="">排序</option>
						<option value="create_date desc">最新上传在前</option>
						<option value="create_date">最早上传在前</option>
						<option value="pic_name asc">图片名称升序</option>
						<option value="pic_name desc">图片名称降序</option>
					</select>
					<h4 class="ui dividing header"></h4>
					<div id="loadImgList">
					
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	loadImgPage(1);
});

function loadImgPage(type) {
	var params = "";
	if (type != null && type == 1) {
		params = $("#paramsForm").serialize();
	}
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	$('#loadImgList').load("${ctx}/image/imageTempSpace/loadList?" + params,
			{"pageNo":pageNo,"pageSize":pageSize}, function(data) {
				unCheckAll();
			});
	return false;
}

function page(n,s){
	$("#pageNo").val(n);
	$("#pageSize").val(s);
	loadImgPage(1);
   	return false;
}
</script>
</body>
</html>