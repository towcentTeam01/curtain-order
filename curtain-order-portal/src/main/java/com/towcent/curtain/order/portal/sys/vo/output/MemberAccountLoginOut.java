package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;

import lombok.Data;

/**
 * 1.0.1 登录接口
 * @author huangtao
 * @version 0.0.3
 */
@Data
public class MemberAccountLoginOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String tokenId;		// 用户登录标识	
	private String nickName;		// 昵称	
	private String realName;		// 真实姓名	
	private String icon;       // 头像
	private Integer userId;
	private String openId;
	
}