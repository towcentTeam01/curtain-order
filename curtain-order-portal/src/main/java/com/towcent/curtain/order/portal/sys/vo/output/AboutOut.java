package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;

import lombok.Data;

/**
 * 1.0.1 承运商APP关于我们
 * @author licheng
 * @version 0.0.1
 */
@Data
public class AboutOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String logo;		// APP logo	
	private String appName;		// APP名称	
	private String about;		// 关于我们	
	private String copyright;		// 版权信息	
	private String serviceAgreement;		// 软件服务协议	
	private String privacyPolicy;		// 隐私政策	
	private String userNotes;		// 用户须知	
	
}