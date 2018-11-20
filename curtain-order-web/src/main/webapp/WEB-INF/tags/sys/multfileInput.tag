<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/fileinput.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="控件名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="文件Url"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="图片类型"%>
<%@ attribute name="auto" type="java.lang.Boolean" required="false" description="默认自动上传"%>
<%@ attribute name="viewdel" type="java.lang.Boolean" required="false" description="预览是否可以删除"%>
<%@ attribute name="thumbSize" type="java.lang.String" required="false" description="缩略图尺寸(300X200)"%>
<input type="hidden" id="${path}" name="${path}" value="${value }"/>
<input id="upload${path }" name="fileupload" type="file" multiple>
<style>
.file-input{width: 800px;}
.file-preview-frame img{width:auto!important;height: 100px!important;}
</style>
<script type="text/javascript">
var img = [];
var viewconfig = [];
if ('${value}') {
	//var list = JSON.parse('${value}');
	var tempPic = '${value}';
	if(tempPic.indexOf(",")!=-1){
		tempPic = tempPic.replace(/,/g,';');
	}
	var list = tempPic.split(";");
	for(var i=0;i<list.length;i++){
		if(list[i] == null || list[i] == '')continue;
		img.push("<img src='"+list[i]+"' class='file-preview-image' style='width:100%;height:100%;' value='"+list[i]+"'/>");
		viewconfig.push({width:"100px",key:list[i],
			showZoom:true,showDelete:${empty viewdel ? true : viewdel}
		});
	}
}
$('#upload${path }').fileinput({
	uploadUrl : '${ctx}/image/upload/imageUpload',
	allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
	uploadExtraData : {
		uploadType : '${type}',
		thumbSize : '${thumbSize}' // 缩略图尺寸
	},
	showClose : false,
	initialPreviewShowDelete : true,
	/* showUpload : true, */
	dropZoneEnabled : false,
	initialPreviewShowDelete:true,
	overwriteInitial: false,
	uploadAsync: true,
	initialPreview : img,
	initialPreviewConfig:viewconfig,
	deleteUrl:'${ctx}/image/upload/delete',  //需要配置删除才起作用
	showCaption: false,
	append:true,
	showPreview:true,
	fileActionSettings : {
		showUpload : false,
		showRemove : true,
		showDrag : false,
		showZoom:false
	},
	language : 'zh'
}).on("filebatchselected", function(event, files) {
	<c:if test="${auto || empty auto}">
	 	$(this).fileinput("upload");
	</c:if>
})
.on("fileuploaded", function(event, data) {
	if(data.response && data.response.code != -1){
		var url = $('#${path}').val();
		if(url.length > 0 && url.indexOf(';') < 0){
			url += ';';
		}
		url += data.response.imageUrl + ';';
		 $('#${path}').val(url);
		
		//img赋值
	 	var imgs = $(event.currentTarget).parents('.file-input').find('.file-preview-frame').find('img');
		for(var i=0;i<imgs.length;i++){
			var value = $(imgs[i]).attr("value");
			if(value == null || value == ""){
				$(imgs[i]).attr('value',data.response.imageUrl);
				break;
			}
		}
		
		if(typeof saveReturnPic == 'function'){
			var id = $('#${path}').attr('id').split('-')[1];
			saveReturnPic(id);
		}
	}
}).on('filesuccessremove', function(event, id) {
	//移除后，值的变化
	var key = $('#'+id).find('img').attr('value')+";";
	var val = $('#${path}').val();
   	if(val != null && val != ''){
   		val = val.replace(key,'');
   		$('#${path}').val(val);
   	}
}).on('filepredelete', function(event, key) {
	//删除后，值的变化
	key = key+",";
	var val = $('#${path}').val();
   	if(val != null && val != ''){
   		val = val.replace(key,'');
   		$('#${path}').val(val);
   	}
});

$('#upload${path }').on('filecleared', function(event) {
	//清空后，值的变化
	$('#${path}').val('');
});

</script>
