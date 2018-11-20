<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="图片类型Id"%>
<%@ attribute name="maxlimit" type="java.lang.String" required="true" description="最多选择多少图片"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="最多选择多少图片"%>
<%@ attribute name="notShowBtn" type="java.lang.String" required="false" description="不显示选择图片按钮"%>
<style type="text/css">

</style>
<div id="${id }List" style="overflow: inherit;" class="show-div">
	<input type="hidden" id="${id }SelImgs" value=""/>
	<input type="hidden" id="${id }Action" value=""/>
	<input type="hidden" id="${id }Postion" value=""/>
	<div class="show-list" id="show-${id }" style="display: none">
		<!-- <div class="col-sm-3 col-md-2">
	    	<div class="thumbnail">
		    	<a href="javscript:" class="imgdiv">
		      		<img src="">
		      	</a>
		      	<div class="caption">
			        
		     	</div>
		    </div>
	  </div> -->
	</div>
</div>
<div style="margin:10px 0 10px -15px;" class="col-sm-12">
	<button type="button" id="${id}Button" class="button big" style="<c:if test='${notShowBtn }'>display:none;</c:if>">选择图片</button>
	<%-- <a id="${id}Button" href="javascript:" class="buttong big btn" style="<c:if test='${notShowBtn }'>display:none;</c:if>">选择图片</a> --%>
	<c:if test="${required }">
		<span class="help-inline"><font color="red">*<c:if test="${not empty maxlimit}">最多上传${maxlimit }张</c:if></font></span>
	</c:if>
</div>
<a id="${id}BtnHide" href="javascript:" style="display: none;">选择图片</a>
<script type="text/template" id="template1">
<li class="fl" style="text-align:center;">
	<div onclick="window.open('{{tImgSrc}}')" class="imgdiv">
		<img alt="" src="{{imgSrc}}" style="width:150px;height:150px;">
	</div>
	<span>
		<a href="javascript:" onclick="insertTo(this)">插入</a>|
		<a href="javascript:" onclick="replaceTo(this,'right')">替换</a>
		<a href="javascript:" onclick="delImg(this)">删除</a>
	</span>
	<input type="hidden" name="${id}" value="'+imgSrc+'"/>
</li>
</script>
<script type="text/javascript">
	$("#${id}Button").click(function(){
		document.getElementById('${id }Action').value = '';
    	document.getElementById('${id }Postion').value = '';
		$("#${id}BtnHide").click();
	});
	
	$("#${id}BtnHide").click(function(){
		var merchantId = $('#merchantId').val();
		if(merchantId == null || merchantId == ''){
			alertx('请先选择店铺!');
			return false;
		}
		layer.open({
			  type: 2,
			  title: "${placeholder }",
			  //shadeClose: true,
			  //shade: 0.8,
			  area: ['835px', '90%'],
			  btn: ['确定', '清除', '关闭'],
			  content: "${ctx}/goods/goods/searchpiclist?merchantId="+merchantId, //iframe的url
				yes: function(index, layero){
	            	var action = document.getElementById('${id }Action').value;
                	var postion = document.getElementById('${id }Postion').value;
                	var picUl = $('#show-${id }');
                	var maxNum = "${maxlimit}";
                	var checkboxs = layero.find("iframe")[0].contentWindow.$("input[type=checkbox][name=mycheckBox]:checked");
                	var checkLenths = checkboxs.length;
                	if(checkLenths > 0){
                		picmove = true;
                	}else{
                		return false;
                	}
                	
                	var currNum = checkboxs.length;
                	var seledNum = $(picUl).find('li').length;
                	/**1.校验**/
					switch(action){
						case 'replace':
							if(currNum > 1){
								alertx("只能选择一张图片替换");
								return false;
							}
							break;
						default:
							if((seledNum+currNum) > maxNum){
		                		alertx("该类型图最多只能有"+maxNum+"张图片");
		                		return false;
		                	}
							break;
					}
					var html = "";
                	var imgs = [];
                	/**2.插入li**/
					for(var i=0;i<checkLenths;i++){
                		var currBox = checkboxs[i];
                		var img = $(currBox).parents(".caption").prev().find('img');
                		var imgSrc = $(img).attr("data-original");
                		imgs.push(imgSrc);
                		var tImgSrc = imgSrc.replace('_s.jpg','.jpg');
                		html += '<div class="col-sm-3 col-md-2"><div class="thumbnail" style="padding:0;"><a href="javscript:" class="imgdiv" onclick="window.open(\''+tImgSrc+'\')"><img alt="" src="'+imgSrc+'"></a><input type="hidden" name="${id}" value="'+imgSrc+'"/><div class="caption"></div></div></div>';
                	}
					
					if($(picUl).find('.col-sm-3').length > 0){
                		var lastLi = '';
                		if(action == 'insert'){
                			lastLi = $(picUl).find('.col-sm-3')[postion];
                			$(lastLi).before(html);
                		}else if(action == 'replace'){
                			var replaceLi = $(picUl).find('.col-sm-3')[postion];
							$(replaceLi).before(html);
							$(replaceLi).remove();
                		}else{
                			lastLi = $(picUl).find('.col-sm-3').last();
                    		$(lastLi).after(html);
                		}
                	}else{
                		$('#show-${id }').html(html).show();
                	}
					$('#${id}SelImgs').val(imgs.join(','));
                	
               		/**3.设置按钮**/
                   	$(picUl).find('.caption').each(function(i,e){
                   		var liLen = $(picUl).find('div').length;
                   		if(i == 0){
   	                		if(liLen == 1){
   	                			$(this).css('text-align','center');
   	                        	$(this).html(insertE+'|'+replaceE+'|'+deleteE);
   	                        	//$(this).html(deleteE);
   	                		}else{
   	                			$(this).css('text-align','right');
   	                        	$(this).html(insertE+'|'+replaceE+'|'+deleteE+'|'+rightE);
   	                        	//$(this).html(deleteE+'|'+rightE);
   	                		}
                   		}else if(i == (liLen - 1)){
                   			$(this).css('text-align','left');
                           	$(this).html(leftE+'|'+insertE+'|'+replaceE+'|'+deleteE);
                           	//$(this).html(leftE+'|'+deleteE);
                   		}else{
                   			$(this).css('text-align','center');
                           	$(this).html(leftE+'|'+insertE+'|'+replaceE+'|'+deleteE+'|'+rightE);
                           	//$(this).html(leftE+'|'+deleteE+'|'+rightE);
                   		}
                   	});
                   	layer.close(index);
				},
				btn2: function(index, layero){
					if(layero.find('.layui-layer-btn1').text() == '清除'){
						$("#${id}").val("");
						$("#${name}").val("");
					}
					layer.close(index);
				},btn3: function(index, layero){
					layer.close(index);
				}
			}); 
	});
</script>