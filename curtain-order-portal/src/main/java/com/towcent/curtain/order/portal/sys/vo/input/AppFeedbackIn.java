package com.towcent.curtain.order.portal.sys.vo.input;

import org.hibernate.validator.constraints.NotBlank;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

import lombok.Data;

/**
 * 1.6.1 意见反馈
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class AppFeedbackIn extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	
	@NotBlank(message = "type不能为空.")
	private String type;		// 类型(1:内容意见 2:产品建议 3:技术问题 4:其他)
	
	@NotBlank(message = "appVersion不能为空.")
	private String appVersion;		// APP版本
	
	private String images;		// 图片(多张用分号分隔)
	
	@NotBlank(message = "content不能为空.")
	private String content;		// 反馈内容
	
	@NotBlank(message = "contactInfo不能为空.")
	private String contactInfo;		// 联系信息
	
	
}