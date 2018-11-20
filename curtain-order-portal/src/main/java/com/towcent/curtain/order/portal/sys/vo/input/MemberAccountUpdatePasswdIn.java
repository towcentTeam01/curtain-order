package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.7 修改密码
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MemberAccountUpdatePasswdIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	@NotBlank(message = "oldPass不能为空.")
	private String oldPass;		// 旧密码
	
	@NotBlank(message = "newPass不能为空.")
	private String newPass;		// 新密码
	
	
}