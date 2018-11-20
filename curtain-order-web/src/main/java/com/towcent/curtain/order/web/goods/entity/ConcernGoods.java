package com.towcent.curtain.order.web.goods.entity;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 关注商品Entity
 * @author HuangTao
 * @version 2018-07-19
 */
public class ConcernGoods extends DataEntity<ConcernGoods> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 商品对象
	
	private String picUrl;      // 列表图片
	
	public ConcernGoods() {
		super();
	}

	public ConcernGoods(String id){
		super(id);
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
}