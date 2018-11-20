package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.1.2 手机号是否存在
 * @author HuangTao
 * @version 0.0.1
 */
@Data
public class MemberAccountPhoneExistIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotBlank(message = "phone不能为空.")
	private String phone;		// 手机号码
	
}