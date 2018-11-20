<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/fileinput.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="控件名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="文件Url"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="图片类型"%>
<%@ attribute name="thumbSize" type="java.lang.String" required="false" description="缩略图尺寸(300X200)"%>

<input type="hidden" id="${path}" name="${path}" value="${value}"/>
<input id="upload${path }" name="fileupload" type="file" >

<script type="text/javascript">
$('#upload${path}').fileinput({
	uploadUrl : '${ctx}/image/upload/imageUpload',
	allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
	uploadExtraData : {
		uploadType : '${type}',
		thumbSize : '${thumbSize}' // 缩略图尺寸
	},
	maxFilesNum : 1,
	showClose : false,
	initialPreviewShowDelete : false,
	dropZoneEnabled : false,
	append : false,
	showCaption: false,
	language : 'zh'
}).on("filebatchselected", function(event, files) {
 	$(this).fileinput("upload");
})
.on("fileuploaded", function(event, data) {
	if(data.response){
		var id = $('#${path}').val();
		saveReturnPic(id,data.response.imageUrl);
	}
});;

$('#upload${path}').on('filecleared', function(event) {
	$('#${path}').val('');
});

</script>
