package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;

import lombok.Data;

/**
 * 1.8.1 测试环境判断接口
 * @author licheng
 * @version 0.0.1
 */
@Data
public class AppTestFlagOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String isTestEnv;		// 是否是测试环境(1:是 0:不是)	
	
}