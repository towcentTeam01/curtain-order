package com.towcent.curtain.order.portal.sys.vo.output;

import java.io.Serializable;

import lombok.Data;

/**
 * 1.0.9 用户基本信息
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MemberAccountBaseInfoOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String name;		// 要显示到首页的名字	
	private String nickName;		// 昵称	
	private String portrait;		// 头像	
	private String appType;         // 账号类型(0:承运商 1:货主)
	
}