package com.towcent.curtain.order.portal.sys.vo.input;


import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 6.0.2 重置密码
 * @author licheng
 * @version 0.0.1
 */
@Data
public class MemberAccountResetIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotNull(message = "phone不能为空.")
	private String phone;		// 手机号码
	
	@NotBlank(message = "password不能为空.")
	private String password;		// 新密码
	
	@NotBlank(message = "securityCode不能为空.")
	private String securityCode;		// 验证码
	
}