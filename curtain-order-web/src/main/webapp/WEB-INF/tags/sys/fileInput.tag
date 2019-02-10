<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/fileinput.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="控件名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="文件Url"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="图片类型"%>
<%@ attribute name="thumbSize" type="java.lang.String" required="false" description="缩略图尺寸(300X200)"%>
<%@ attribute name="auto" type="java.lang.Boolean" required="false" description="默认自动上传"%>
<%@ attribute name="classS" type="java.lang.String" required="false" description="样式"%>

<input type="hidden" id="${path}" name="${path}" value="${value}" class="${classS }"/>
<input id="imgUpload-${path}" name="fileupload" type="file" >

<script type="text/javascript">
var img = null;
if ('${value}') {
	img = "<img src='${value}' class='file-preview-image' style='width:auto;height:160px;'>";
}
$('#imgUpload-${path}').fileinput({
	uploadUrl : '${ctx}/image/curtainupload/imageUpload',
	allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
	uploadExtraData : {
		uploadType : '${type}',
		thumbSize : '${thumbSize}' // 缩略图尺寸
	},
	maxFilesNum : 1,
	showClose : false,
	initialPreviewShowDelete : false,
	showUpload : true,
	dropZoneEnabled : false,
	append : false,
	initialPreview : [ img ],
	// initialPreviewConfig : [ {
		// caption : 'desert.jpg',
		// size : "1024",
		// width : '160px',
		// key : 100,
		// extra : {
		//	id : 100
		// }
	// } ],
	showCaption: false,
	fileActionSettings : {
		showUpload : false,
		showRemove : false,
		showDrag : false
	},
	language : 'zh'
}).on("fileselect", function(event, files) {
	<c:if test="${auto || empty auto}">
	 	$(this).fileinput("upload");
	</c:if>
})
.on('fileuploaded',function(event, data, previewId, index) {
	if (data.response) {
		$('#${path}').val(data.response.imageUrl);
	}
})
.on('filecleared', function(event) {
	$('#${path}').val('');
});

/* $('#imgUpload').on(
'fileuploaded',
function(event, data, previewId, index) {
	if (data.response) {
		$('#${path}').val(
				data.response.imageUrl);
	}
});

$('#imgUpload').on('filecleared', function(event) {
	$('#${path}').val('');
}); */

</script>
