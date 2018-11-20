<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<%@include file="/WEB-INF/views/include/treeview.jsp"%>
	<style type="text/css">
.ztree li span.button.add {
	margin-left: 2px;
	margin-right: -1px;
	background-position: -144px 0;
	vertical-align: top;
	*vertical-align: middle
}
</style>
<script type="text/javascript">
var setting = {
	view:{
		addHoverDom: addHoverDom,
		removeHoverDom: removeHoverDom
	},
	edit: {
		enable: true,
		showRemoveBtn: showRemoveBtn,
		showRenameBtn: true,
		drag:{
			isMove:true,
			prev:true,
			next:true,
			inner:false
		}
	},
	data: {
		simpleData: {
			enable: true,
			idKey:"id",
			pIdKey:"parentId",
			rootPId: 0
		},
		key : {
			name : "name",
			title : "name"
		}
	},
	callback: {
		beforeRemove: beforeRemove,
		beforeDrag: beforeDrag,
		onDrop:onDrop,
		beforeDrop: beforeDrop,
		beforeEditName: beforeEditName
	}
};

/**拖拽判断*/
function beforeDrag(treeId, treeNodes) {
	for (var i=0,l=treeNodes.length; i<l; i++) {
		if (treeNodes[i].drag === false) {
			return false;
		}
	}
	return true;
}

/**拖拽判断*/
function beforeDrop(treeId, treeNodes, targetNode, moveType) {
	var moveNode = treeNodes[0];
	if(moveNode.parentId != targetNode.parentId){
		return false;
	}
	return targetNode ? targetNode.drop !== false : true;
}

/**排序*/
function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
	var moveNode = treeNodes[0];
	var parentNode = moveNode.getParentNode();
	var childNodes = null;
	if(parentNode == null && moveNode.isParent == true){
		childNodes = tree.getNodesByParam("parentId", "0", null);
	}else{
		childNodes = parentNode.children;
	}
	
	var ids = "";
	for(var i=0;i<childNodes.length;i++){
		ids += childNodes[i].id + ",";
	}
	
	if(ids.length > 0){
		ids = ids.substring(0,ids.length-1);
	}
	$.ajax({
		url:"${ctx}/sys/area/updateSort",
		dataType:"json",
		data:{ids:ids},
		success:function(rs){
			
		}
	});
}

function showRemoveBtn(treeId, treeNode) {
	if(treeNode.children && treeNode.children.length >= 1)return false;
	return true;
}

function addHoverDom(treeId, treeNode) {
	if(treeNode.level == 2)return false;
	var sObj = $("#" + treeNode.tId + "_span");
	if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
	var addStr = "<span class='button add' id='addBtn_" + treeNode.id
		+ "' title='add' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	var btn = $("#addBtn_"+treeNode.id);
	if (btn) btn.bind("click", function(){
		location.href = '${ctx}/sys/area/form';
		return false;
	});
};

function removeHoverDom(treeId, treeNode) {
	$("#addBtn_"+treeNode.id).unbind().remove();
};

function beforeRemove(treeId, treeNode) {
	if(confirm("确认删除 区域：" + treeNode.name + " 吗？")){
		$.ajax({
			url:"${ctx}/sys/area/delete",
			dataType:"json",
			data:{id:treeNode.id},
			success:function(rs){
				refreshTree();
			}
		});
		return false;
	};
	return false;
}

/**分类修改*/
function beforeEditName(treeId, treeNode) {
	location.href = '${ctx}/sys/area/form?id='+treeNode.id;
	return false;
}

var tree;
$(document).ready(function(){
	var data = ${fns:toJson(list)}
	tree = $.fn.zTree.init($("#treeAreaList"), setting, data);
	
	$('#areaName').keypress(function(event){
		var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
		if(keyCode==13){
			search();
		}
	});
});

function search(){
	var name = $('#areaName').val();
	if(name == null || name == ''){
		//alertx('请输入名称');
		return false;
	}
	var nodes = tree.getNodesByParamFuzzy("name", name, null);
	if(nodes.length <= 0){
		alertx('未搜到任何结果!');
		return false;
	}
	tree.selectNode(nodes[0]);
	tree.expandNode(nodes[0].getParentNode(), true,true,true); 
}

function refreshTree(){
	loading('正在刷新...');
	$.getJSON("${ctx}/sys/area/getLoadAreaList",function(data){
		closeTip();
		tree = $.fn.zTree.init($("#treeAreaList"), setting,data);
	});
}
</script>
</head>
<body>
	<div id="searchForm" class="navbar-form form-search">
		<ul class="ul-form">
			<li><label>区域名称：</label>
				<input id="areaName" name="areaName" htmlEscape="false" maxlength="20" class="form-control"/>
			</li>
			<li class="btns"><input onclick="search()" id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
		</ul>
	</div>
	<div id="left" class="accordion-group" style="min-width: 250px;">
		<div class="accordion-heading">
	    	<a class="accordion-toggle">区域分类
	    	<i title="刷新" class="icon-refresh" onclick="refreshTree();" style="float:right;margin-left:100px;"></i>
	    	</a>
	    </div>
		<div id="treeAreaList" class="ztree" style="margin-top: 40px;"></div>
	</div>
	<%-- <sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>区域名称</th><th>区域编码</th><th>区域类型</th><th>备注</th><shiro:hasPermission name="sys:area:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/sys/area/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<shiro:hasPermission name="sys:area:edit"><td>
				<a href="${ctx}/sys/area/form?id={{row.id}}">修改</a>
				<a href="${ctx}/sys/area/delete?id={{row.id}}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				<a href="${ctx}/sys/area/form?parent.id={{row.id}}">添加下级区域</a> 
			</td></shiro:hasPermission>
		</tr>
	</script> --%>
</body>
</html>