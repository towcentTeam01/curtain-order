package com.towcent.curtain.order.portal.sys.vo.input;


import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.7.1 消息中心
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MessageListIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotBlank(message = "type不能为空.")
	private String type;		// 消息类型(0:系统消息 1:交易消息 2:活动消息 3:资产变更)
	
	
	
	
}