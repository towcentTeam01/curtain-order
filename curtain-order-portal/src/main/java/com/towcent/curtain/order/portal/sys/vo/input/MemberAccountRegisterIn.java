package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.1.1 注册
 * @author HuangTao
 * @version 0.0.1
 */
@Data
public class MemberAccountRegisterIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotBlank(message = "phone不能为空.")
	private String phone;		// 手机号
	
	@NotBlank(message = "securityCode不能为空.")
	private String securityCode;		// 手机验证码
	
	@NotBlank(message = "password不能为空.")
	private String password;		// 密码(MD5加密)
	
	private String code;
}