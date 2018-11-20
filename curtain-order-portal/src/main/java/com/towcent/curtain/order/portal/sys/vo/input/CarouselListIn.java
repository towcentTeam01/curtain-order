package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.9.1 获取轮播图列表
 * @author licheng
 * @version 0.0.1
 */
@Data
public class CarouselListIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotBlank(message = "轮播图类型不能为空.")
	private String carouselType;		// 轮播图类型
	
}