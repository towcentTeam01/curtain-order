package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.1 登录接口
 * @author huangtao
 * @version 0.0.3
 */
@Data
public class MemberAccountLoginIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	@NotBlank(message = "account不能为空.")
	private String account;		// 账号
	
	@NotBlank(message = "password不能为空.")
	private String password;		// 密码(MD5加密)
	
	private String code;
	
}