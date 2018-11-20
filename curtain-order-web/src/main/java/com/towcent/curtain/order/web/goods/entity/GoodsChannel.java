package com.towcent.curtain.order.web.goods.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 商品频道Entity
 * @author yxp
 * @version 2018-07-09
 */
public class GoodsChannel extends DataEntity<GoodsChannel> {
	
	private static final long serialVersionUID = 1L;
	private String channelName;		// 频道名称
	private String channelType;		// 频道类型
	private String channelAlias;		// 频道别名
	private Integer goodsQty = 0;		// 频道商品数
	private String channelStatus;		// 是否开启
	private Integer sort;		// 排序
	private Date startTime;		// 开始时间
	private Date endTime;		// 结束时间
	private String channelImg;		// 频道图片
	private String channelUrl;		// 链接
	private Integer merchantId;		// 商户id
	
	public GoodsChannel() {
		super();
	}

	public GoodsChannel(String id){
		super(id);
	}

	@Length(min=0, max=30, message="频道名称长度必须介于 0 和 30 之间")
	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}
	
	@Length(min=0, max=2, message="频道类型长度必须介于 0 和 2 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=30, message="频道别名长度必须介于 0 和 30 之间")
	public String getChannelAlias() {
		return channelAlias;
	}

	public void setChannelAlias(String channelAlias) {
		this.channelAlias = channelAlias;
	}
	
	public Integer getGoodsQty() {
		return goodsQty;
	}

	public void setGoodsQty(Integer goodsQty) {
		this.goodsQty = goodsQty;
	}
	
	@Length(min=0, max=1, message="是否开启长度必须介于 0 和 1 之间")
	public String getChannelStatus() {
		return channelStatus;
	}

	public void setChannelStatus(String channelStatus) {
		this.channelStatus = channelStatus;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=0, max=300, message="频道图片长度必须介于 0 和 300 之间")
	public String getChannelImg() {
		return channelImg;
	}

	public void setChannelImg(String channelImg) {
		this.channelImg = channelImg;
	}
	
	@Length(min=0, max=200, message="链接长度必须介于 0 和 200 之间")
	public String getChannelUrl() {
		return channelUrl;
	}

	public void setChannelUrl(String channelUrl) {
		this.channelUrl = channelUrl;
	}

	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}
}