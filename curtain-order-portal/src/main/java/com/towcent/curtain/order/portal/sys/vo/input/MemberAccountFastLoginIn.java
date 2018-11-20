package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Getter;
import lombok.Setter;

/**
 * 1.0.2 快捷登录接口
 * @author huangtao
 * @version 0.0.3
 */
@Setter @Getter
public class MemberAccountFastLoginIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	@NotBlank(message = "account不能为空.")
	private String account;		// 账号(手机号码)
	
	@NotBlank(message = "securityCode不能为空.")
	private String securityCode;// 短信验证码
	
	private String code;
}