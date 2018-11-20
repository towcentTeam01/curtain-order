package com.towcent.curtain.order.portal.sys.vo.input;


import javax.validation.constraints.NotNull;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.1.4 获取地址名称
 * @author HuangTao
 * @version 0.0.1
 */
@Data
public class AreaDescIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotNull(message = "provinceId不能为空.")
	private Integer provinceId;		// 省ID
	
	private Integer cityId;		// 市ID
	
	private Integer areaId;		// 区ID
	
}