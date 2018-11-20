package com.towcent.curtain.order.portal.sys.vo.input;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 发送短信参数Vo
 * 
 * @author huangtao
 * @date 2017年3月17日 下午11:12:56
 * @version 0.1.0 
 * @copyright towcent.com
 */
public class SmsSendParamVo extends BaseParam {

	private static final long serialVersionUID = 1L;
	
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
	
}