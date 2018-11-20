package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.11 修改提现密码
原3.1.4.4
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MemberAccountUpdateWithdrawPassIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	private String oldPass;		// 登密码（md5加密） 如果第一次设置，则置为空
	
	@NotBlank(message = "newPass不能为空.")
	private String newPass;		// 新密码（md5加密）
	
}