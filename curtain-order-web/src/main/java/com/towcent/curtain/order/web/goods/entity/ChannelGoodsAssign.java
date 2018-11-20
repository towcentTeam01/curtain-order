/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.towcent.curtain.order.web.goods.entity;


import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 频道商品Entity
 * @author alice
 * @version 2017-03-01
 */
public class ChannelGoodsAssign extends DataEntity<ChannelGoodsAssign> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Goods searchGoods;// 商品查询条件
	private Integer assigned = 0 ;//是否分配
	private GoodsChannel goodsChannel;//商品频道
	
	public ChannelGoodsAssign() {
		super();
	}

	public ChannelGoodsAssign(String id){
		super(id);
	}

	public Goods getSearchGoods() {
		return searchGoods;
	}

	public void setSearchGoods(Goods searchGoods) {
		this.searchGoods = searchGoods;
	}

	public Integer getAssigned() {
		return assigned;
	}

	public void setAssigned(Integer assigned) {
		this.assigned = assigned;
	}

	public GoodsChannel getGoodsChannel() {
		return goodsChannel;
	}

	public void setGoodsChannel(GoodsChannel goodsChannel) {
		this.goodsChannel = goodsChannel;
	}
}