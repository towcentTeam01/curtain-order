<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title id="titleId">${fns:getConfig('productName')}</title>
<meta name="decorator" content="blank"/>
<c:set var="tabmode" value="${empty cookie.tabmode.value ? '1' : cookie.tabmode.value}"/>
<c:if test="${tabmode eq '1'}">
	<link rel="Stylesheet" href="${ctxStatic}/jquery/plugin/jerichotab/css/jquery.jerichotab.min.css" />
	<script type="text/javascript" src="${ctxStatic}/jquery/plugin/jerichotab/js/jquery.jerichotab.min.js"></script>
</c:if>
<script src="${ctxStatic}/jquery/plugin/messager/jquery.messager.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css" media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
<style type="text/css">
	#main {padding:0;margin:0;} #main .container-fluid{padding:0 4px 0 6px;}
	#header {margin:0 0 8px;position:static;} #header li {font-size:14px;_font-size:12px;}
	#header .navbar-brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:33px;}
	#footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
	#footer, #footer a {color:#999;} #left{overflow-x:hidden;overflow-y:auto;} #left .collapse{position:static;}
	#userControl>li>a{/*color:#fff;*/text-shadow:none;} #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
	#content {margin-right: 0px;margin-left: 0px;}
	#userIcon {width:30px;height:30px;-moz-border-radius: 50px;-webkit-border-radius: 50px;border-radius: 50px;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		// <c:if test="${tabmode eq '1'}"> 初始化页签
		$.fn.initJerichoTab({
               renderTo: '#right', uniqueId: 'jerichotab',
               contentCss: { 'height': $('#right').height() - tabTitleHeight },
               tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
           });//</c:if>
		// 绑定菜单单击事件
		$("#menu a.menu").click(function(){
			// 一级菜单焦点
			$("#menu li.menu").removeClass("active");
			$(this).parent().addClass("active");
			// 左侧区域隐藏
			if ($(this).attr("target") == "mainFrame"){
				$("#left,#openClose").hide();
				wSizeWidth();
				// <c:if test="${tabmode eq '1'}"> 隐藏页签
				$(".jericho_tab").hide();
				$("#mainFrame").show();//</c:if>
				return true;
			}
			// 左侧区域显示
			$("#left,#openClose").show();
			if(!$("#openClose").hasClass("close")){
				$("#openClose").click();
			}
			// 显示二级菜单
			var menuId = "#menu-" + $(this).attr("data-id");
			if ($(menuId).length > 0){
				$("#left .accordion").hide();
				$(menuId).show();
				// 初始化点击第一个二级菜单
				if (!$(menuId + " .accordion-body:first").hasClass('in')){
					$(menuId + " .accordion-heading:first a").click();
				}
				if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
					$(menuId + " .accordion-body a:first i").click();
				}
				// 初始化点击第一个三级菜单
				$(menuId + " .accordion-body li:first li:first a:first i").click();
			}else{
				// 获取二级菜单数据
				$.get($(this).attr("data-href"), function(data){
					if (data.indexOf("id=\"loginForm\"") != -1){
						alert('未登录或登录超时。请重新登录，谢谢！');
						top.location = "${ctx}";
						return false;
					}
					$("#left .accordion").hide();
					$("#left").append(data);
					// 链接去掉虚框
					$(menuId + " a").bind("focus",function() {
						if(this.blur) {this.blur()};
					});
					// 二级标题
					$(menuId + " .accordion-heading a").click(function(){
						$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
						if(!$($(this).attr('data-href')).hasClass('in')){
							$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
						}
					});
					// 二级内容
					$(menuId + " .accordion-body a").click(function(){
						$(menuId + " li").removeClass("active");
						$(menuId + " li i").removeClass("icon-white");
						$(this).parent().addClass("active");
						$(this).children("i").addClass("icon-white");
					});
					// 展现三级
					$(menuId + " .accordion-inner a").click(function(){
						var href = $(this).attr("data-href");
						if($(href).length > 0){
							$(href).toggle().parent().toggle();
							return false;
						}
						// <c:if test="${tabmode eq '1'}"> 打开显示页签
						return addTab($(this)); // </c:if>
					});
					// 默认选中第一个菜单
					$(menuId + " .accordion-body a:first i").click();
					$(menuId + " .accordion-body li:first li:first a:first i").click();
				});
			}
			// 大小宽度调整
			wSizeWidth();
			return false;
		});
		// 初始化点击第一个一级菜单
		$("#menu a.menu:first span").click();
		// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
		$("#userInfo .dropdown-menu a").mouseup(function(){
			return addTab($(this), true);
		});// </c:if>
		
		$('#toMessage12').on('click',function(){
			return addTab($(this), true);
		});
		
		// 鼠标移动到边界自动弹出左侧菜单
		$("#openClose").mouseover(function(){
			if($(this).hasClass("open")){
				$(this).click();
			}
		});
		// 获取通知数目  
		<c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
		/* var mindNum = 0;
		function getNotifyNum(){
			$.get("${ctx}/mail/notifyMail/count?updateSession=0&t="+new Date().getTime(),function(data){
				var num = parseFloat(data);
				if (num > 0){
					$("#notifyNum,#notifyNum2").show().html("("+num+")");
					if(mindNum == 0){
						mindNum++;
						$.messager.lays(300, 200);
						var html = '您有'+num+'个未读消息，<a href="${ctx}/mail/notifyMail?appType=2&isRead=0" id="toMessage12" target="mainFrame">点击这里</a>查看'
						$.messager.show('新消息通知', html, 3000);
					}
				}else{
					$("#notifyNum,#notifyNum2").hide()
				}
			});
		}
		getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
		setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if> */

		// 判断用户是否有通过审核
        $.get("${ctx}/general/user/checkLoginNameStatus",function(data){
		    if ("false" == data) {
		    alert("账号没有通过审核，请联系商务进行开通。");
		    window.location.href = "${ctx}/logout";
		    }
		});
	});
	// <c:if test="${tabmode eq '1'}"> 添加一个页签
	function addTab($this, refresh){
		$(".jericho_tab").show();
		$("#mainFrame").hide();
		$.fn.jerichoTab.addTab({
               tabFirer: $this,
               title: $this.text() == '点击这里' ? '我的通知' : $this.text(),
               closeable: true,
               data: {
                   dataType: 'iframe',
                   dataLink: $this.attr('href')
               }
           }).loadData(refresh);
		return false;
	}// </c:if>
</script>
</head>
<body>
	<div id="main">
		<div id="header" class="navbar navbar-fixed-top">
			<div class="navbar-inverse">
				<div class="navbar-brand"><span id="productName">${fns:getConfig('productName')}</span></div>
				<ul id="userControl" class="nav navbar-nav pull-right">
					<!--<li id="themeSwitch" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
						<ul class="dropdown-menu">
							<c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
							<li><a href="javascript:cookie('tabmode','${tabmode eq '1' ? '0' : '1'}');location=location.href">${tabmode eq '1' ? '关闭' : '开启'}页签模式</a></li>
						</ul>-->
						<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
				 	<!--</li>-->
				 	<%--<li><a href="javascript:void(0);" onclick="getMerchantListFun()">切换商户</a></li>--%>
					<li style="line-height:50px;">
						<img id="userIcon" src='<c:choose><c:when test="${fns:getUserThumbUrl()==null}">${ctxStatic}/images/face_default.png</c:when><c:otherwise>${fns:getUserThumbUrl()}</c:otherwise></c:choose>'/>					
					</li>
					<li id="userInfo" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好, ${fns:getUser().loginName}(${fns:getUser().name})&nbsp;<span id="notifyNum" class="label label-info hide"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
							<li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
							<!--
							<li><a href="${ctx}/mail/notifyMail" target="mainFrame"><i class="icon-bell"></i>&nbsp;  我的通知 <span id="notifyNum2" class="label label-info hide"></span></a></li>
							<li><a href="${ctx}/mail/notifyMail?read=1" target="mainFrame">&nbsp; &nbsp;&nbsp; 全部标记已读 </a></li>
						    -->
						</ul>
					</li>
					<li><a href="${ctx}/logout" title="退出登录">退出</a></li>
					<li>&nbsp;</li>
				</ul>
				<%-- <c:if test="${cookie.theme.value eq 'cerulean'}">
					<div id="user" style="position:absolute;top:0;right:0;"></div>
					<div id="logo" style="background:url(${ctxStatic}/images/logo_bg.jpg) right repeat-x;width:100%;">
						<div style="background:url(${ctxStatic}/images/logo.jpg) left no-repeat;width:100%;height:70px;"></div>
					</div>
					<script type="text/javascript">
						$("#productName").hide();$("#user").html($("#userControl"));$("#header").prepend($("#user, #logo"));
					</script>
				</c:if> --%>
				<div class="navbar-collapse">
					<ul id="menu" class="nav navbar-nav" style="*white-space:nowrap;float:none;">
						<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<li class="menu ${not empty firstMenu && firstMenu ? ' active' : ''}">
									<c:if test="${empty menu.href}">
										<a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
									</c:if>
									<c:if test="${not empty menu.href}">
										<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
									</c:if>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
	    </div>
	    <div class="container-fluid">
			<div id="content" class="row">
				<div id="left">
					<%-- 
					<iframe id="menuFrame" name="menuFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650"></iframe> 
					--%>
				</div>
				<div id="openClose" class="close">&nbsp;</div>
				<div id="right" style="width:100%;-webkit-overflow-scrolling:touch;overflow:auto;"> <!-- style="overflow:visible;" -->
					<iframe id="mainFrame" name="mainFrame" src=""  scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
			</div>
		    <div id="footer" class="row">
	            Copyright &copy; 2017-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - ${fns:getConfig('version')}
			</div>
		</div>
	</div>
<script type="text/javascript"> 
	var leftWidth = 160; // 左侧窗口大小
	var tabTitleHeight = 33; // 页签的高度
	var htmlObj = $("html"), mainObj = $("#main");
	var headerObj = $("#header"), footerObj = $("#footer");
	var frameObj = $("#left, #openClose, #right, #right iframe");
	function wSize(){
		var minHeight = 500, minWidth = 980;
		var strs = getWindowSize().toString().split(",");
		htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
		mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
		frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
		$("#openClose").height($("#openClose").height() - 5);// <c:if test="${tabmode eq '1'}"> 
		$(".jericho_tab iframe").height($("#right").height() - tabTitleHeight); // </c:if>
		wSizeWidth();
	}
	function wSizeWidth(){
		if (!$("#openClose").is(":hidden")){
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
		}else{
			$("#right").width("100%");
		}
	}// <c:if test="${tabmode eq '1'}"> 
	function openCloseClickCallBack(b){
		$.fn.jerichoTab.resize();
	} // </c:if>
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>

<script type="text/javascript">
    function getMerchantListHtml(content) {
        window.sgSpan = layui.layer.open({
            type: 1,
            title: '切换商户',
            area: ['50%', '50%'],
            content: content,
            btns: 2,
            btnAlign: 'c',
            btn: ['确定', '取消'],
            success: function (layero, index) {
            },
            yes: function (index, layero) {
                var merchantId = $(layero).find('input[name=merchantId]:checked').val();
                if (merchantId) {
                    changeBindShop(merchantId, function () {
                        layui.layer.close(index);
                    });
                }

            },
            no: function (index, layero) {
            }
        });
    }

    function changeBindShop(merchantId, callback) {
        ajaxFun("${ctx}/sys/sysUserMerchantRel/changeBindShop", {merchantId: merchantId}, function (data) {
            if (data) {
                layui.layer.msg(data.errorMessage);
                if (callback) callback(data);
            }
        });
    }

    function getMerchantListFun(flag) {
        ajaxFun("${ctx}/sys/sysUserMerchantRel/getMerchantList", {}, function (data) {
            if (data) {
                var content = [];
                var num = 0;
                content.push('<ul style="margin: 20px;height: auto;text-align: center;">');
                $.each(data, function (i, obj) {
                    var sel = obj.sel ? 'checked=""checked' : '';
                    if (sel) {
                        num++;
                    }
                    content.push('<li style="float: left;height: 150px;width: 120px;margin: 0 10px;padding: 10px;    border: 1px solid #ccc;">');
                    content.push('<img style="object-fit: contain;;width: 100px;height: 100px;" src="' + obj.logo + '"/>');
                    content.push('<div style="display: none"></div>');
                    content.push('<div style="padding: 10px 0px;"><input type="radio" ' + sel + ' name="merchantId" value="' + obj.id + '" />' + obj.name + '</div>');
                    content.push('</li>');
                });
                content.push('</ul>');
                content = content.join('').toString();
                if (flag) flag = num > 0 ? true : false;
                if (content.length > 0 && !flag) {
                    getMerchantListHtml(content);
                }
            }
        });
    }

    function ajaxFun(url, params, callback) {
        $.ajax({
            type: "POST",
            url: url,
            data: params,
            dataType: "json",
            async: false,
            success: function (data) {
                if (callback) callback(data);
            }
        });
    }
    // getMerchantListFun(true)

    function getMerchantInfo() {
        ajaxFun("${ctx}/getMerchantInfo", {}, function (data) {
            if (data && data.data) {
                var title = $('#productName').text();
                if(data.data.merchantName){
                    $('#productName').html(data.data.merchantName+title);
                    $('#footer').html(data.data.qq + "  © 2018 " + data.data.wxCode + "版权所有 地址:" + data.data.address);
                    $('#titleId').html(data.data.merchantName + $('#titleId').text());
                }
            }
        });
    }

    getMerchantInfo();
</script>
</body>
</html>