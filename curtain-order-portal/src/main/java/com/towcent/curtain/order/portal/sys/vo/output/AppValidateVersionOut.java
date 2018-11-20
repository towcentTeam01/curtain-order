package com.towcent.curtain.order.portal.sys.vo.output;
import java.io.Serializable;

import lombok.Data;

/**
 * 2.3.2 验证App版本信息
 * @author 
 * @version 0.0.2
 */
@Data
public class AppValidateVersionOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Integer isUpgrade = 2;		// 是否需要升级（1：是 2：否）	
	private Integer enforceFlag = 2;		// 是否强制升级（1：是 2：否）	
	private String versionName;		// 最新版本号名称	
	private String url;		// 最新版本下载地址	
	private String updateContent;		//版本更新记录
	private Integer version; //	最新版本号

}