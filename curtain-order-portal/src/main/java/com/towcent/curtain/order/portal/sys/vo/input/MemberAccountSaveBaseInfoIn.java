package com.towcent.curtain.order.portal.sys.vo.input;


import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.0.8 账号基本信息保存
 * @author licheng
 * @version 0.0.1
 */
@Data
public class MemberAccountSaveBaseInfoIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	private String account;		// 账号
	
	private String sex;		// 性别
	
	private String nickName;		// 昵称
	
	private String portrait;		// 头像地址
	
	
}