<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
		.ztree li span.button.add {
			margin-left: 2px;
			margin-right: -1px;
			background-position: -144px 0;
			vertical-align: top;
			*vertical-align: middle
		}
	</style>
</head>
<body>
	<sys:message content="${message}"/>
	<div id="content" class="row-fluid">
		<div id="left" class="accordion-group panel panel-default">
			<div class="accordion-heading panel-heading">
		    	<a class="accordion-toggle">数据字典分类<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
		    </div>
			<div id="ztree" class="ztree"></div>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="officeContent" src="${ctx}/sys/sysDictDtl/list?dictId=" width="100%" height="91%" frameborder="0"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {
			data : {
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "pId",
					rootPId : '0'
				}
			},
			view : {
				showIcon : false,
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom
			},
			edit: {
				enable: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},
			callback : {
				beforeRemove: beforeRemove,
				beforeEditName: beforeEditName,
				onClick : function(event, treeId, treeNode) {
					var id = treeNode.id == '0' ? '' : treeNode.id;
					$('#officeContent').attr("src",
							"${ctx}/sys/sysDictDtl/list?dictId=" + id);
				}
			}
		};

		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.id
				+ "' title='add' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.id);
			if (btn) btn.bind("click", function(){
				toAddMdict(treeNode,'add');
				return false;
			});
		};
		
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.id).unbind().remove();
		};
		
		function showRemoveBtn(treeId, treeNode) {
			if(treeNode.children && treeNode.children.length >= 1)return false;
			if(treeNode.structureNo == 'top')return false;
			return true;
		}
		
		function showRenameBtn(treeId, treeNode) {
			if (treeNode.id == '0') return false;
			return true;
		}
		
		function beforeRemove(treeId, treeNode) {
			confirmx("确认删除 ：" + treeNode.name + " 吗？",function(){
				$.ajax({
					url:"${ctx}/sys/sysDictMain/delete",
					dataType:"json",
					data:{id:treeNode.id},
					success:function(rs){
						if(rs.code == -1){
							alertx(rs.msg);
						}else{
							refreshTree();
						}
					}
				});
				return false;
			});
			return false;
		}
		
		/**分类修改*/
		function beforeEditName(treeId, treeNode) {
			toAddMdict(treeNode,'update');
			return false;
		}
		
		/**
		 * 添加数据字典分类			
		 */
		function toAddMdict(treeNode,type){
			var params = '';
			var title = '';
			var id;
			var pId = '';
			if('update' == type){
				pId = treeNode.pId;
				id = treeNode.id;
				params = '?id='+id;
				title = '修改字典分类';
			}else{
				pId = treeNode.id;
				title = '新增字典分类';
			}
			layer.open({
				title: title,
				type: 2, 
				area:['335px','305px'],
				// offset: [${id}tops, ${id}left],
				btn: ['保存', '关闭'],
				content: "${ctx}/sys/sysDictMain/loadAddRootMdict"+params,
				yes: function(index, layero){
					var name = layero.find("iframe")[0].contentWindow.$("input[name=name]").val();
		        	var shortName = layero.find("iframe")[0].contentWindow.$("input[name=shortName]").val();
		        	var code = layero.find("iframe")[0].contentWindow.$("input[name=code]").val();
		        	var description = layero.find("iframe")[0].contentWindow.$("input[name=description]").val();
		        	var systemFlag = layero.find("iframe")[0].contentWindow.$("input[name=systemFlag]").val();
		        	if(CUtils.objNull(name)){
		        		alertx("分类名称不能为空!");
		        		return false;
		        	}else if(name.length > 50){
		        		alertx("分类名称长度不能超过50!");
		        		return false;
		        	}
		        	if(shortName.length > 50) {
		        		alertx('分类简称不能超过50！');
		        		return false;
		        	}
		        	if(CUtils.objNull(code)){
		        		alertx("分类代码不能为空!");
		        		return false;
		        	}else if(code.length > 50){
		        		alertx("分类代码不能超过50!");
		        		return false;
		        	}			        	
		        	if(treeNode != null){
		        		var sort = 1;
		        		var childList = treeNode.children;
		        		if(childList != null && childList.length >0){
		        			sort = childList.length;
		        		}
		        		addGoodsCategory(treeNode,id,name,shortName,code,description,systemFlag,pId,++sort);
		        	}
					layer.close(index);
				},
				btn2: function(index, layero){
					layer.close(index);
				}
			});
		}
		
		function addGoodsCategory(treeNode,id,name,shortName,code,description,systemFlag,parentId,sort){
			var data = {id:id,name:name,shortName:shortName,code:code,description:description,systemFlag:systemFlag,"parent.id":parentId,sort:sort};
			$.ajax({
				url:"${ctx}/sys/sysDictMain/save",
				dataType:"json",
				data:data,
				success:function(rs){
					if(id == null){
						id = rs.mId;
						addTreeNode(treeNode,{id:id,name:name,"pId":parentId});
					}else{
						updateTreeNode(treeNode,name);
					}
				}
			});
		}
		
		function addTreeNode(treeNode, data) {
			var newNodes = [ data ];
			newNodes = myTree.addNodes(treeNode, [ data ]);
		}

		function updateTreeNode(treeNode, name) {
			treeNode.name = name;
			myTree.updateNode(treeNode);
		}

		var myTree;
		function refreshTree() {
			$.getJSON("${ctx}/sys/sysDictMain/treeData", function(data) {
				closeTip();
				data.push({
					"id" : 0,
					"pid" : -1,
					"name" : "系统"
				})
				myTree = $.fn.zTree.init($("#ztree"), setting, data);
				var node = myTree.getNodeByParam("id", 0, null);
				myTree.expandNode(node, true, false, true);
			});
		}
		refreshTree();

		var leftWidth = 180; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize() {
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({
				"overflow-x" : "hidden",
				"overflow-y" : "hidden"
			});
			mainObj.css("width", "auto");
			frameObj.height(strs[0] - 5);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width(
					$("#content").width() - leftWidth - $("#openClose").width()
							- 5);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/common/common.utils.js" type="text/javascript"></script>
</body>
</html>