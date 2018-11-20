package com.towcent.curtain.order.web.order.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 订单Entity
 * @author HuangTao
 * @version 2018-07-19
 */
public class OrderMain extends DataEntity<OrderMain> {
	
	private static final long serialVersionUID = 1L;
	private String orderType;		// 订单类型(0:普通订单)
	private String orderNo;		// 订单号
	private String orderStatus;		// 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成 8:取消)
	private String payStatus;		// 支付状态(0:未支付 1:已支付)
	private String payWay;		// 付款方式(1:在线支付 2:线下付款)
	private String totalAmount;		// 报价
	private String amount;		// 余额支付金额(暂时未使用)
	private String payAmount;		// 线上实付金额(暂时未使用)
	private String consigneeName;		// 收货人姓名
	private String consigneePhone;		// 收货人联系方式(手机或者电话至少填一项)
	private String consigneeAddress;		// 收货详细地址(收货地址)
	private String totalQty;		// 总米数(单位/米)
	private String freightFee;		// 运费(暂时未使用)
	private String freightNumber;		// 运单号
	private String logisticsNo;		// 物流公司编码
	private String logisticsName;		// 物流公司名称
	private String isEval;		// 是否评论(1:是0:否)(暂时未使用)
	private String saleAfterRemarks;		// 售后备注
	private Date saleAfterDate;		// 售后申请时间
	private Date payDate;		// 支付时间(暂时未使用)
	private Date deliveryTime;		// 发货时间
	private String isExport;		// 是否导出(0:未导出 1:已导出)
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	
	private List<OrderDtl> orderDtls;  // 订单明细列表
	private String merchantName;       // 商户名称
	private String ids;       // 购物车id集合，多个以;分隔
	private String consigneeId;		// 收货人地址id
	private String logisticsId;		// 物流公司id
	
	public OrderMain() {
		super();
	}

	public OrderMain(String id){
		super(id);
	}

	@Length(min=1, max=2, message="订单类型(0:普通订单)长度必须介于 1 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=0, max=20, message="订单号长度必须介于 0 和 20 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=2, message="订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成)长度必须介于 1 和 2 之间")
	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	@Length(min=1, max=1, message="支付状态(0:未支付 1:已支付)长度必须介于 1 和 1 之间")
	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	
	@Length(min=0, max=1, message="付款方式(1:在线支付 2:线下付款)长度必须介于 0 和 1 之间")
	public String getPayWay() {
		return payWay;
	}

	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	
	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	public String getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(String payAmount) {
		this.payAmount = payAmount;
	}
	
	@Length(min=0, max=20, message="收货人姓名长度必须介于 0 和 20 之间")
	public String getConsigneeName() {
		return consigneeName;
	}

	public void setConsigneeName(String consigneeName) {
		this.consigneeName = consigneeName;
	}
	
	@Length(min=0, max=20, message="收货人联系方式(手机或者电话至少填一项)长度必须介于 0 和 20 之间")
	public String getConsigneePhone() {
		return consigneePhone;
	}

	public void setConsigneePhone(String consigneePhone) {
		this.consigneePhone = consigneePhone;
	}
	
	@Length(min=0, max=200, message="收货详细地址(收货地址)长度必须介于 0 和 200 之间")
	public String getConsigneeAddress() {
		return consigneeAddress;
	}

	public void setConsigneeAddress(String consigneeAddress) {
		this.consigneeAddress = consigneeAddress;
	}
	
	public String getTotalQty() {
		return totalQty;
	}

	public void setTotalQty(String totalQty) {
		this.totalQty = totalQty;
	}
	
	public String getFreightFee() {
		return freightFee;
	}

	public void setFreightFee(String freightFee) {
		this.freightFee = freightFee;
	}
	
	@Length(min=0, max=50, message="运单号长度必须介于 0 和 50 之间")
	public String getFreightNumber() {
		return freightNumber;
	}

	public void setFreightNumber(String freightNumber) {
		this.freightNumber = freightNumber;
	}
	
	@Length(min=0, max=20, message="物流公司编码长度必须介于 0 和 20 之间")
	public String getLogisticsNo() {
		return logisticsNo;
	}

	public void setLogisticsNo(String logisticsNo) {
		this.logisticsNo = logisticsNo;
	}
	
	@Length(min=0, max=200, message="物流公司名称长度必须介于 0 和 200 之间")
	public String getLogisticsName() {
		return logisticsName;
	}

	public void setLogisticsName(String logisticsName) {
		this.logisticsName = logisticsName;
	}
	
	@Length(min=0, max=1, message="是否评论(1:是0:否)(暂时未使用)长度必须介于 0 和 1 之间")
	public String getIsEval() {
		return isEval;
	}

	public void setIsEval(String isEval) {
		this.isEval = isEval;
	}
	
	@Length(min=0, max=2000, message="售后备注长度必须介于 0 和 2000 之间")
	public String getSaleAfterRemarks() {
		return saleAfterRemarks;
	}

	public void setSaleAfterRemarks(String saleAfterRemarks) {
		this.saleAfterRemarks = saleAfterRemarks;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSaleAfterDate() {
		return saleAfterDate;
	}

	public void setSaleAfterDate(Date saleAfterDate) {
		this.saleAfterDate = saleAfterDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(Date deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	
	@Length(min=0, max=2, message="是否导出(0:未导出 1:已导出)长度必须介于 0 和 2 之间")
	public String getIsExport() {
		return isExport;
	}

	public void setIsExport(String isExport) {
		this.isExport = isExport;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
	
	public List<OrderDtl> getOrderDtls() {
		return orderDtls;
	}

	public void setOrderDtls(List<OrderDtl> orderDtls) {
		this.orderDtls = orderDtls;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getConsigneeId() {
		return consigneeId;
	}

	public void setConsigneeId(String consigneeId) {
		this.consigneeId = consigneeId;
	}

	public String getLogisticsId() {
		return logisticsId;
	}

	public void setLogisticsId(String logisticsId) {
		this.logisticsId = logisticsId;
	}
}