package com.towcent.curtain.order.portal.sys.vo.output;

import java.io.Serializable;

import lombok.Data;

/**
 * 1.0.6 地址列表
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class AreaListOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Integer id;		// 地址Id	
	private Integer parentId;		// 地址父Id	
	private String name;		// 地址名称	
	private String type;		// 类型(2:省 3:地市 4:区县)	
	
}