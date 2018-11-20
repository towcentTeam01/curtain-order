package com.towcent.curtain.order.portal.sys.vo.output;

import java.io.Serializable;

import lombok.Data;

/**
 * 1.1.4 获取地址名称
 * @author HuangTao
 * @version 0.0.1
 */
@Data
public class AreaDescOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String desc;		// 区域描述	
	
}