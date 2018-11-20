package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.10 修改绑定手机
原3.1.4.3
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MemberAccountUpdatePhoneIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	
	@NotBlank(message = "oldPhone不能为空.")
	private String oldPhone;		// 旧手机号
	
	@NotBlank(message = "newPhone不能为空.")
	private String newPhone;		// 新手机号
	
	@NotBlank(message = "loginPass不能为空.")
	private String loginPass;		// 登录密码（md5加密）
	
	@NotBlank(message = "securityCode不能为空.")
	private String securityCode;		// 手机验证码
	
}