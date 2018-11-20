<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<div class="input-append imagetemp-div">
<input type="text" id="${id}" name="${name}" placeholder="会员帐号" value="${value}" class="${cssClass}" style="width:150px;" 
readonly="readonly" onclick="$('#${id}Button').click()"/>
<a title="搜索" id="${id}Button" href="javascript:" class="btn" style="border-radius: 0px;">&nbsp;<i class="icon-search imagetemp-i"></i>&nbsp;</a>
<a title="清除" id="${id}Clear" href="javascript:" class="btn">&nbsp;<i class="icon-refresh imagetemp-i"></i>&nbsp;</a>
&nbsp;&nbsp;
</div>
<script type="text/javascript">
	$("#${id}Button").click(function(){
		var val = $('#${name}').val();
		top.$.jBox.open("iframe:${ctx}/member/memberInfo/selectMemberAccount?memberAccount="+val, "选择会员", 800, $(top.document).height()-180, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                	var check = h.find("iframe")[0].contentWindow.$("input[name=completeCheck]:checked").val();
                	$('#${id}').val(check);
                }else if (v=="clear"){
	                $('#${id}').val('');
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
	});
	
	$('#${id}Clear').click(function(){
		 $('#${id}').val('');
	})
</script>