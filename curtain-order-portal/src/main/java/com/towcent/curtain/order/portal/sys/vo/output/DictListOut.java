package com.towcent.curtain.order.portal.sys.vo.output;

import java.io.Serializable;

import lombok.Data;

/**
 * 1.1.0 数据字典接口
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class DictListOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String code;		// 值	
	private String name;		// 名称	
	
}