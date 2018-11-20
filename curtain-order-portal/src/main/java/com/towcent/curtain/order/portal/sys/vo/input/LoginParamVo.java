package com.towcent.curtain.order.portal.sys.vo.input;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 登录参数Vo
 * @author huangtao
 *
 */
public class LoginParamVo extends BaseParam implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 登录账号
	 */
	@NotBlank(message="登录账号不能为空")
	private String account;
	
	/**
	 * 登录密码
	 */
//	@NotBlank(message="密码不能为空")
	private String password;
	
	/**
	 * 验证码
	 */
	private String verificationCode;
	
	/**
	 * 登录账号类型 0 会员 1商户
	 */ 
	private String accountType="0";

	public String getVerificationCode() {
		return verificationCode;
	}

	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}