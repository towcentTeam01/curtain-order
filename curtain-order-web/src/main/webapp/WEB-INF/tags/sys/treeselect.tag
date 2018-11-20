<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="checked" type="java.lang.Boolean" required="false" description="是否显示复选框，如果不需要返回父节点，请设置notAllowSelectParent为true"%>
<%@ attribute name="extId" type="java.lang.String" required="false" description="排除掉的编号（不能选择的编号）"%>
<%@ attribute name="isAll" type="java.lang.Boolean" required="false" description="是否列出全部数据，设置true则不进行数据权限过滤（目前仅对Office有效）"%>
<%@ attribute name="notAllowSelectRoot" type="java.lang.Boolean" required="false" description="不允许选择根节点"%>
<%@ attribute name="notAllowSelectParent" type="java.lang.Boolean" required="false" description="不允许选择父节点"%>
<%@ attribute name="allowClear" type="java.lang.Boolean" required="false" description="是否允许清除"%>
<%@ attribute name="allowInput" type="java.lang.Boolean" required="false" description="文本框可填写"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="smallBtn" type="java.lang.Boolean" required="false" description="缩小按钮显示"%>
<%@ attribute name="hideBtn" type="java.lang.Boolean" required="false" description="是否显示按钮"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否限制选择，如果限制，设置为disabled"%>
<%@ attribute name="dataMsgRequired" type="java.lang.String" required="false" description=""%>
<%@ attribute name="callBack" type="java.lang.String" required="false" description="回调方法"%>
<%@ attribute name="sysSelect" type="java.lang.Boolean" required="false" description="回调方法"%>
<input id="${id}Id" name="${name}" class="${cssClass.replace('required','')}" type="hidden" value="${value}"/>
<div class="input-group">
	<input id="${id}Name" name="${labelName}" ${allowInput?'':'readonly="readonly"'} type="text" value="${labelValue}" data-msg-required="${dataMsgRequired}"
		class="${cssClass}" style="${cssStyle}"/>
	<span class="input-group-btn">
		<button type="button" class="btn btn-default ${disabled} ${hideBtn ? 'hide' : ''}" id="${id}Button" style="cursor: pointer;${smallBtn?'padding:4px 2px;':''}"><i class="icon-search"></i></a></button>
	</span>
	<%-- <div id="${id}Button" class="input-group-addon ${disabled} ${hideBtn ? 'hide' : ''}" style="cursor: pointer;${smallBtn?'padding:4px 2px;':''}"><i class="icon-search"></i></div>	 --%>
</div>
<script type="text/javascript">
	$("#${id}Button, #${id}Name").click(function(){
		// 是否限制选择，如果限制，设置为disabled
		if ($("#${id}Button").hasClass("disabled")){
			return true;
		}
		var ${id}left = (pageX(document.getElementById('${id}Name')) - $(document).scrollLeft()) + 'px';
		var ${id}tops = (pageY(document.getElementById('${id}Name')) + 34 - $(document).scrollTop()) + 'px';
		var btns = ['确定'];
		if('${allowClear}'){
			btns.push('清除');
		}
		btns.push('关闭');
		layer.open({
			title: "选择${title}",
			type: 2, 
			area:['309px','420px'],
			offset: [${id}tops, ${id}left],
			btn: btns,
			content: "${ctx}/tag/treeselect?url="+encodeURIComponent("${url}")+"&module=${module}&checked=${checked}&extId=${extId}&isAll=${isAll}&id=${id}",
			yes: function(index, layero){
				var tree = layero.find('iframe')[0].contentWindow.tree;
				${id}okEvent(tree);
				layer.close(index);
			},
			btn2: function(index, layero){
				if(layero.find('.layui-layer-btn1').text() == '清除'){
					$("#${id}Id").val("");
					$("#${id}Name").val("");
				}
				layer.close(index);
			},btn3: function(index, layero){
				layer.close(index);
			}
		});
	});
	function ${id}okEvent(tree) {
		var ids = [], names = [], nodes = [];
		if ("${checked}" == "true"){
			nodes = tree.getCheckedNodes(true);
		}else{
			nodes = tree.getSelectedNodes();
		}
		for(var i=0; i<nodes.length; i++) {
			if(nodes[i].id == '1' && '${id}' == 'company' && !'${sysSelect}'){
				layer.msg("请选择分公司!");
				return false;
			}
			//<c:if test="${checked && notAllowSelectParent}">
			if (nodes[i].isParent){
				continue; // 如果为复选框选择，则过滤掉父节点
			}//</c:if><c:if test="${notAllowSelectRoot}">
			//if (nodes[i].level == 0){
				//layer.msg("不能选择根节点（"+nodes[i].name+"）请重新选择。");
				//return false;
			//}//</c:if><c:if test="${notAllowSelectParent}">
			if (nodes[i].isParent){
				layer.msg("不能选择父节点（"+nodes[i].name+"）请重新选择。");
				return false;
			}//</c:if><c:if test="${not empty module && selectScopeModule}">
			if (nodes[i].module == ""){
				layer.msg("不能选择公共模型（"+nodes[i].name+"）请重新选择。");
				return false;
			}else if (nodes[i].module != "${module}"){
				layer.msg("不能选择当前栏目以外的栏目模型，请重新选择。");
				return false;
			}//</c:if>
			ids.push(nodes[i].id);
			names.push(nodes[i].name);//<c:if test="${!checked}">
			break; // 如果为非复选框选择，则返回第一个选择  </c:if>
		}
		$("#${id}Id").val(ids.join(",").replace(/u_/ig,""));
		$("#${id}Name").val(names.join(","));
		if(typeof ${id}CallBack == 'function'){
			${id}CallBack(ids.join(",").replace(/u_/ig,""));
		}
		if(typeof ${callBack}Fun == 'function'){
			${callBack}Fun(ids.join(",").replace(/u_/ig,""),'${id}');
		}
		
	}
</script>