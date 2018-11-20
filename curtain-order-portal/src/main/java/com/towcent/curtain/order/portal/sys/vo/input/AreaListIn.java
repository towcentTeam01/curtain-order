package com.towcent.curtain.order.portal.sys.vo.input;



import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.6 地址列表
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class AreaListIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	private Integer parentId;		// 地址父Id(根节点为0)
	
}