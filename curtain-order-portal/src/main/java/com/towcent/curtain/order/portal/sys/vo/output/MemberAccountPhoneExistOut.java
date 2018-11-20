package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;

import lombok.Data;

/**
 * 1.1.2 手机号是否存在
 * @author HuangTao
 * @version 0.0.1
 */
@Data
public class MemberAccountPhoneExistOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Boolean exist;		// 手机号码是否存在	
	
}