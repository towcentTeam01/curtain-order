package com.towcent.curtain.order.web.goods.entity;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 商品频道详情Entity
 * @author yxp
 * @version 2018-07-09
 */
public class GoodsChannelDtl extends DataEntity<GoodsChannelDtl> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 商品id
	private GoodsChannel channel;		// 频道id
	private String sort;		// 排序号
	private String img;		// 频道商品图片
	private Integer merchantId;		// 商户id
	
	public GoodsChannelDtl() {
		super();
	}

	public GoodsChannelDtl(String id){
		super(id);
	}

	@Length(min=0, max=11, message="排序号长度必须介于 0 和 11 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=200, message="频道商品图片长度必须介于 0 和 200 之间")
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	@Length(min=0, max=11, message="商户id长度必须介于 0 和 11 之间")
	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public GoodsChannel getChannel() {
		return channel;
	}

	public void setChannel(GoodsChannel channel) {
		this.channel = channel;
	}
}