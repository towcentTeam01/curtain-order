<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="imagePath" value="${fns:getUrlHeader()}" />
	<c:forEach items="${page.list}" var="image">
	  <div class="col-sm-3 col-md-2">
    	<div class="thumbnail" style="height: 200px;width:172px;: 0;">
	    	<a href="javscript:" class="imgdiv">
	      		<img class="lazy" style="max-height: 170px;vertical-align: middle;text-align: center;" data-original="${image.picUrl.substring(0,fn:indexOf(image.picUrl,'.jpg'))}_s.jpg" alt="${image.picName}">
	      	</a>
	      	<div class="caption" style="padding: 6px;">
		        <p class="form-control-static" style="padding: 0;">
		        	<div style="float: left">
		        		<span title="${image.picName}">
		        		<c:if test="${fn:length(image.picName) > 10}">
						${image.picName.substring(0,10)}
						</c:if>
						<c:if test="${fn:length(image.picName) <= 10}">
							${image.picName}
						</c:if>
						</span>
					</div>
		        	<div style="float: right;position: relative;">
		        		<input _src="${image.picUrl}" id="smart" type="checkbox" _id="${image.id }" name="mycheckBox" style="width: 16px;height: 16px;top: 3px;position: absolute;left: -23px;">
		        		<a class="del-pic" href="javascript:"  _id="${image.id }" style="height: 16px;">删除</a>
		        	</div>
		       	</p>
	     	</div>
	    </div>
	  </div>
	 </c:forEach>
<div class="col-sm-12 col-md-12 pagination" >${page}</div>
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
<script type="text/javascript">
$(function() {
	$("img.lazy").lazyload({
		effect : "fadeIn",
		threshold : 200,
		placeholder : "${ctxStatic}/images/logo.jpg"
	});
	
	
	$("#CheckAll").removeAttr('checked');
	
	
	$('select.dropdown').dropdown();
	//$('a.popup').popup();
	//$('.ui.checkbox').checkbox();

	$('#orderById').val("${page.orderBy}");
	
	$('.imgdiv').click(
			function() {
				var _this = $(this).next('div').find(
						'input[type=checkbox]');
				var check = _this.attr("checked");
				if (check == "checked") {
					$(this).next('div').find('.imageCheckbox')
							.removeClass('checked');
					_this.removeAttr("checked");
				} else {
					$(this).next('div').find('.imageCheckbox')
							.addClass('checked');
					_this.attr("checked", "checked");
				}
			});
});
</script>