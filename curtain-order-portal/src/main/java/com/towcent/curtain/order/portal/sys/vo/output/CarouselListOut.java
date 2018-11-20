package com.towcent.curtain.order.portal.sys.vo.output;

import java.io.Serializable;

import lombok.Data;

/**
 * 1.9.1 获取轮播图列表
 * @author licheng
 * @version 0.0.1
 */
@Data
public class CarouselListOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String title;		// 标题	
	private String carouselType;		// 轮播图类型	
	private String carouselTypeDesc;		// 轮播图类型描述	
	private String url;		// 轮播图链接	
	private String isHref;		// 是否需要点击跳转(0:不需要 1:需要)	
	private String targetUrl;		// 跳转的链接	
	private String remark;		// 备注	
	
}