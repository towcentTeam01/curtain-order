package com.towcent.curtain.order.web.order.entity;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;
import com.towcent.curtain.order.web.goods.entity.Goods;

/**
 * 订单明细Entity
 * @author HuangTao
 * @version 2018-07-19
 */
public class OrderDtl extends DataEntity<OrderDtl> {
	
	private static final long serialVersionUID = 1L;
	private String orderId;		// 订单id
	private Goods goods;		// 商品对象
	private String goodsName;		// 商品名称
	private String goodsPicUrl;		// 商品图片
	private BigDecimal length;		// 成品宽(单位/米)
	private BigDecimal high;		// 成品高(单位/米)
	private BigDecimal multiple;		// 褶数(倍)
	private Integer num;		// 数量
	private BigDecimal qty;		// 总米数
	private BigDecimal price;		// 单价/米(元)
	private BigDecimal amount;		// 金额=数量*单价(元)
	private String param1;		// 辅料铅线、铅块、底边花边
	private String param2;		// 里衬/造型(返幔、帘头)
	private String param3;		// 对/单开
	private String param4;		// 打孔/捏褶(对花)
	private String param5;		// 环、S钩(不要可不填)
	private String evalFlag;		// 评价标识(0:未评价 1:已评价) yes_no
	private String isFinalize;   // 是否定型（1:是 0:否）
	
	public OrderDtl() {
		super();
	}

	public OrderDtl(String id){
		super(id);
	}

	@Length(min=0, max=11, message="订单id长度必须介于 0 和 11 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	@Length(min=0, max=100, message="商品名称长度必须介于 0 和 100 之间")
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	@Length(min=0, max=100, message="商品图片长度必须介于 0 和 100 之间")
	public String getGoodsPicUrl() {
		return goodsPicUrl;
	}

	public void setGoodsPicUrl(String goodsPicUrl) {
		this.goodsPicUrl = goodsPicUrl;
	}
	
	public BigDecimal getLength() {
		return length;
	}

	public void setLength(BigDecimal length) {
		this.length = length;
	}
	
	public BigDecimal getHigh() {
		return high;
	}

	public void setHigh(BigDecimal high) {
		this.high = high;
	}
	
	public BigDecimal getMultiple() {
		return multiple;
	}

	public void setMultiple(BigDecimal multiple) {
		this.multiple = multiple;
	}
	
	// @Length(min=0, max=11, message="数量长度必须介于 0 和 11 之间")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	public BigDecimal getQty() {
		return qty;
	}

	public void setQty(BigDecimal qty) {
		this.qty = qty;
	}
	
	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	
	@Length(min=0, max=50, message="辅料铅线、铅块、底边花边长度必须介于 0 和 50 之间")
	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}
	
	@Length(min=0, max=50, message="里衬/造型(返幔、帘头)长度必须介于 0 和 50 之间")
	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2;
	}
	
	@Length(min=0, max=50, message="对/单开长度必须介于 0 和 50 之间")
	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3;
	}
	
	@Length(min=0, max=50, message="打孔/捏褶(对花)长度必须介于 0 和 50 之间")
	public String getParam4() {
		return param4;
	}

	public void setParam4(String param4) {
		this.param4 = param4;
	}
	
	@Length(min=0, max=50, message="环、S钩(不要可不填)长度必须介于 0 和 50 之间")
	public String getParam5() {
		return param5;
	}

	public void setParam5(String param5) {
		this.param5 = param5;
	}
	
	@Length(min=0, max=1, message="评价标识(0:未评价 1:已评价) yes_no长度必须介于 0 和 1 之间")
	public String getEvalFlag() {
		return evalFlag;
	}

	public void setEvalFlag(String evalFlag) {
		this.evalFlag = evalFlag;
	}

	public String getIsFinalize() {
		return isFinalize;
	}

	public void setIsFinalize(String isFinalize) {
		this.isFinalize = isFinalize;
	}
}