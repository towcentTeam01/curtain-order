package com.towcent.curtain.order.web.goods.entity;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 频道商品Entity
 * 
 * @author alice
 * @version 2017-03-01
 */
public class ChannelGoods extends DataEntity<ChannelGoods> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String goodsId;// 商品ID
	private String goodsName;// 商品名称
	private String goodsNo;// 商编码
	private String goodsStatus;// 商品状态
	private String structureName; // 结构体名称
	private Integer assigned = 0;// 该频道是否已分配//0：不确定 1分配 2：未分配
	private String channelId;// 频道ID
	private String goodsCategoryId;// 商品分类ID
	private String goodCategoryName;// 商品分类名称

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsStatus() {
		return goodsStatus;
	}

	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}

	public String getStructureName() {
		return structureName;
	}

	public void setStructureName(String structureName) {
		this.structureName = structureName;
	}

	public Integer getAssigned() {
		return assigned;
	}

	public void setAssigned(Integer assigned) {
		this.assigned = assigned;
	}

	public String getChannelId() {
		return channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public String getGoodsCategoryId() {
		return goodsCategoryId;
	}

	public void setGoodsCategoryId(String goodsCategoryId) {
		this.goodsCategoryId = goodsCategoryId;
	}

	public String getGoodsNo() {
		return goodsNo;
	}

	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}

	public String getGoodCategoryName() {
		return goodCategoryName;
	}

	public void setGoodCategoryName(String goodCategoryName) {
		this.goodCategoryName = goodCategoryName;
	}
}