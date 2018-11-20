package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;

import lombok.Data;

/**
 * 1.0.6 查询认证状态
 * @author licheng
 * @version 0.0.1
 */
@Data
public class MemberAccountQueryCarrierStatusOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String status;		// 认证状态(0:未认证 1:已认证 2:认证不通过)	
	
}