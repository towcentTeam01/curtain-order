package com.towcent.curtain.order.web.order.entity;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 订单日志Entity
 * @author HuangTao
 * @version 2018-07-19
 */
public class OrderLog extends DataEntity<OrderLog> {
	
	private static final long serialVersionUID = 1L;
	private String orderId;		// 订单Id
	private String content;		// 操作内容
	
	public OrderLog() {
		super();
	}

	public OrderLog(String id){
		super(id);
	}

	@Length(min=1, max=11, message="订单Id长度必须介于 1 和 11 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=500, message="操作内容长度必须介于 0 和 500 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}