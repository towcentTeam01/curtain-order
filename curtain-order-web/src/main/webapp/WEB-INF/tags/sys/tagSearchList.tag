<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域的值"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="placeholder" type="java.lang.String" required="false" description="文本提示"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="跳转链接"%>
<div class="input-group" style="">
<c:set value="${fn:replace(id,'.','')}" var="btnId"></c:set>
<input id="${id}" name="${id}" class="${cssClass}" type="hidden" value="${value}"/>
<input type="text" id="${name}" name="${name}" placeholder="${placeholder }" value="${labelValue}" class="${cssClass}" style="${cssStyle}" 
readonly="readonly" onclick="$('#${id}Button').click()"/>
<span class="input-group-btn">
	<button type="button" class="btn btn-default ${disabled} ${hideBtn ? 'hide' : ''}" id="${btnId}Button" style="cursor: pointer;${smallBtn?'padding:4px 2px;':''}"><i class="icon-search"></i></a></button>
</span>
<!-- <a id="${id}Button" href="javascript:" class="btn">&nbsp;<i class="icon-search imagetemp-i"></i>&nbsp;</a>&nbsp;&nbsp;  -->
</div>
<script type="text/javascript">
	$("#${btnId}Button").click(function(){
		var url = '${url}';
		if(url.indexOf('?') > 0){
			url += '&';
		}else{
			url += '?'
		}
		url += 'myId=${id}&myName=${name}';
		//iframe层
		layer.open({
		  type: 2,
		  title: "${placeholder }",
		  //shadeClose: true,
		  //shade: 0.8,
		  area: ['800px', '90%'],
		  btn: ['确定', '清除', '关闭'],
		  content: url, //iframe的url
			yes: function(index, layero){
            	var val = layero.find("iframe")[0].contentWindow.$("input[name=completeCheck]:checked").val();
            	var id = layero.find("iframe")[0].contentWindow.$("input[name=completeCheck]:checked").attr('id');
            	$('[id="${name}"]').val(val);
            	$('[id="${id}"]').val(id);
            	if('${id}' == 'trayId'){
            		checkBindingTray();
            	}
            	if('${id}' == 'containerId'){
            		checkBindingContainer();
            	}
               	if('${id}' == 'carId'){
            		checkBindingCar();
            	}
               	if('${id}' == 'driverId'){
            		checkBindingDriver();
            	}
				layer.close(index);
			},
			btn2: function(index, layero){
				if(layero.find('.layui-layer-btn1').text() == '清除'){
					$('[id="${name}"]').val('');
                    $('[id="${id}"]').val('');
				}
				layer.close(index);
			},btn3: function(index, layero){
				layer.close(index);
			}
		}); 
	});
</script>