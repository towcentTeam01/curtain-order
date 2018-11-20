<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<div class="input-append imagetemp-div">
<input type="text" id="${id}" name="${name}" skuNos="${skuNos}" placeholder="尺码" value="${value}" class="${cssClass}" style="width:400px;" 
readonly="readonly" />
<a title="搜索" id="${id}Button" href="javascript:" class="btn" style="border-radius: 0px;">&nbsp;<i class="icon-search imagetemp-i"></i>&nbsp;</a>
<a title="清除" id="${id}Clear" href="javascript:" class="btn">&nbsp;<i class="icon-refresh imagetemp-i"></i>&nbsp;</a>
&nbsp;&nbsp;
</div>
<script type="text/javascript">
	$("#${id}Button").click(function(){
		var val = $('#${name}').val();
		var skuNos = $('#skuNos').val();
		top.$.jBox.open("iframe:${ctx}/goods/goodsInfo/selGoodsSku?skuName="+val+"&skuNos="+skuNos, "选择尺码", 800, $(top.document).height()-180, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                	var check = h.find("iframe")[0].contentWindow.$("input[name=attrName]:checked");
                	var checkNo = new Array();
                	var skuNo = new Array();
                	for(var i=0;i<check.length;i++){
                		checkNo[i]=check[i].value;
                		skuNo[i]=check[i].getAttribute('skuNo');
                	}
                	$('#${id}').val(checkNo.join(","));
                	$('#skuNos').val(skuNo.join(","));
                }else if (v=="clear"){
	                $('#${id}').val('');
	                $('#skuNos').val('');
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
	});
	
	$('#${id}Clear').click(function(){
		 $('#${id}').val('');
		 $('#skuNos').val('');
	})
</script>