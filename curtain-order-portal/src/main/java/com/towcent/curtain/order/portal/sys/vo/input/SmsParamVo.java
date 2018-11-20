package com.towcent.curtain.order.portal.sys.vo.input;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 短信参数Vo
 * 
 * @author huangtao
 *
 */
public class SmsParamVo extends BaseParam {
	
	private static final long serialVersionUID = 6024394763898611734L;
	
	/**
	 * 短信类型
	 */
	@NotNull(message="短信类型不能为空")
	private Byte type;
	
	/**
	 * 手机号码
	 */
	@NotBlank(message="手机号码不能为空")
	private String phone;

	/**
	 * 短信校验码
	 */
	@NotBlank(message="校验码不能为空")
	private String securityCode;

	public Byte getType() {
		return type;
	}
	public void setType(Byte type) {
		this.type = type;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getSecurityCode() {
		return securityCode;
	}
	public void setSecurityCode(String securityCode) {
		this.securityCode = securityCode;
	}

}