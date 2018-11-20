<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>个人信息</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	
	function addTab($this, refresh){
		parent.parent.addTab($this,false);
	}
	
	function addToTab(_this,url){
		$this = $(_this);
		parent.addTab1($this,url,true);
	}
</script>

<style>
* {
	padding: 0;
	margin: 0;
	font-size: 12px;
}

div {
	float: left;
	width: 300px;
	height: 80px;
	margin: 10px;
	border: 2px solid #D0D0D0;
	line-height: 80px;
}

span {
	padding-left:10px;
	display: inline-block;
	vertical-align: middle;
	line-height: 22px;
	font-size: 15px;
}
</style>
</head>
<body>
	<form:form id="inputForm" modelAttribute="user"
		action="${ctx}/sys/user/info" method="post" class="form-horizontal">
		<table>
			<tr>
				<td colspan="3" height="30px;" align="left"
					style="font-size: 18px; font-weight: bold;">资料审核</td>
			</tr>
			<tr>
				<td align="conter">
					<div>
						<span> 小B_申请资料首次提交<br> <shiro:hasPermission
								name="member:memberApplyExt:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/member/memberApplyExt/list?statusx=0&type=1')" _value="申请资料首次提交">
							</shiro:hasPermission> 待审核：<font color="red">${pending.sctj}</font> <shiro:hasPermission
								name="member:memberApplyExt:view">
								</a>
							</shiro:hasPermission>
						</span>
					</div>
				</td>
				<td align="conter">
					<div>
						<span> 小B_申请资料修改审核<br> <shiro:hasPermission
								name="member:memberApplyExt:view">
								<a
									href="javascript:" onclick="addToTab(this,'${ctx}/member/memberApplyExt/againList?statusx=0&type=2')" _value="申请资料修改审核">
							</shiro:hasPermission> 待审核：<font color="red">${pending.zctj}</font> <shiro:hasPermission
								name="member:memberApplyExt:view">
								</a>
							</shiro:hasPermission>
						</span>
					</div>
				</td>
				<td align="conter">
					<div>
						<span> 店铺入驻申请<br> <shiro:hasPermission
								name="merchant:merchantApplyInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/merchant/merchantApplyInfo?statusx=0')"  _value="商家入驻申请列表">
							</shiro:hasPermission> 待审核：<font color="red">${pending.sjrz}</font> <shiro:hasPermission
								name="merchant:merchantApplyInfo:view">
								</a>
							</shiro:hasPermission>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" height="30px;" align="left"
					style="font-size: 18px; font-weight: bold;">商品</td>
			</tr>
			<tr>
				<td align="conter" colspan="3">

					<div style="width: 950px;">
						<span> 当日商家下架商品提醒<br> 
							<c:if test="${pending.offSaleList.size() > 0}">
							<c:forEach
								items="${pending.offSaleList}" var="offsale" varStatus="index">
								<shiro:hasPermission name="goods:goodsInfo:view">
									<a href="javascript:" onclick="addToTab(this,'${ctx}/goods/goodsInfo/list?merchantNo=${offsale.merchantNo}&goodsStatus=3&offSaleTimeQuery=${pending.offSaleTimeQuery}')" _value="商品列表">
								</shiro:hasPermission>
							  	 ${offsale.merchantName}：<font color="red">${offsale.goodsNum}</font>
								<shiro:hasPermission name="goods:goodsInfo:view">
									</a>
								</shiro:hasPermission>
								<c:if test="${index.index+1 < pending.offSaleList.size()}">
								  	|
							  	</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${pending.offSaleList.size() == 0}">
								<font color="blue">今日暂无商家下架商品</font>
							</c:if>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" height="30px;" align="left"
					style="font-size: 18px; font-weight: bold;">订单</td>
			</tr>
			<tr>
				<td align="conter">
					<div>
						<span> 批发订单<br> <shiro:hasPermission
								name="order:orderInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/order/orderInfo?status=2&channelType=0&refundStatus=-1')"  _value="订单列表">
							</shiro:hasPermission> 待发货：<font color="red">${pending.pfdddfh}</font> <shiro:hasPermission
								name="order:orderInfo:view"></a> </shiro:hasPermission>| <shiro:hasPermission
								name="order:orderInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/order/orderInfo?status=1&channelType=0')"  _value="订单列表">
							</shiro:hasPermission> 待付款：<font color="red">${pending.pfdddfk}</font> <shiro:hasPermission
								name="order:orderInfo:view"></a>
						</shiro:hasPermission>
						</span>
					</div>
				</td>
				<td align="conter" colspan="2">
					<div>
						<span> 零售订单<br> 
							<shiro:hasPermission name="order:orderInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/order/orderInfo?status=2&channelType=1&refundStatus=-1')"  _value="订单列表">
							</shiro:hasPermission> 待发货：<font color="red">${pending.lsdddfh}</font> <shiro:hasPermission
								name="order:orderInfo:view"></a>
						</shiro:hasPermission> | <shiro:hasPermission name="order:orderInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/order/orderInfo?status=1&channelType=1')"  _value="订单列表">
							</shiro:hasPermission> 待付款：<font color="red">${pending.lsdddfk}</font> <shiro:hasPermission
								name="order:orderInfo:view"></a>
						</shiro:hasPermission>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" height="30px;" align="left"
					style="font-size: 18px; font-weight: bold;">商圈</td>
			</tr>
			<tr>
				<td align="conter" colspan="3">
					<div>
						<span> 大B发布内容审核<br> <shiro:hasPermission
								name="topic:topicInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/topic/topicInfo/list?status=1')" _value="测评资讯列表">
							</shiro:hasPermission> 待审核：<font color="red">${pending.sqdsh}</font> <shiro:hasPermission
								name="topic:topicInfo:view">
								</a>
							</shiro:hasPermission>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" height="30px;" align="left"
					style="font-size: 18px; font-weight: bold;">财务</td>
			</tr>
			<tr>
				<td align="conter">
					<div>
						<span> 预存货款转账审核<br> <shiro:hasPermission
								name="finance:erpPrepayInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/finance/erpPrepayInfo/list?caiStatusx=0')" _value="预存货款转账审核">
							</shiro:hasPermission> 待审核：<font color="red">${pending.yfkdsh}</font> <shiro:hasPermission
								name="finance:erpPrepayInfo:view"></a>
						</shiro:hasPermission>| <shiro:hasPermission name="finance:erpPrepayInfo:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/finance/erpPrepayInfo/list?caiStatusx=3')" _value="预存货款转账审核">
							</shiro:hasPermission> 一审通过待复核：<font color="red">${pending.yfkdfh}</font> <shiro:hasPermission
								name="finance:erpPrepayInfo:view"></a>
						</shiro:hasPermission>
						</span>
					</div>
				</td>
				<td align="conter" colspan="2">
					<div>
						<span> 商家账单<br> <shiro:hasPermission
								name="finance:merchantBills:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/finance/merchantBills/list?statementStatus=0')" _value="账单列表">
							</shiro:hasPermission> 账单待付：<font color="red">${pending.sjzddf}</font> <shiro:hasPermission
								name="finance:merchantBills:view">
								</a>
							</shiro:hasPermission>| <shiro:hasPermission name="finance:merchantBills:view">
								<a href="javascript:" onclick="addToTab(this,'${ctx}/finance/merchantBills/list?financeStatus=1') "_value="账单列表">
							</shiro:hasPermission> 一审通过待复核：<font color="red">${pending.sjzddfh}</font> <shiro:hasPermission
								name="finance:merchantBills:view">
								</a>
							</shiro:hasPermission>
						</span>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>