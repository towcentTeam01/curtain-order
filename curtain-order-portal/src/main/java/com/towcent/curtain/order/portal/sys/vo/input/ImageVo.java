package com.towcent.curtain.order.portal.sys.vo.input;

import javax.validation.constraints.NotNull;

import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 图片参数Vo
 * 
 * @author huangtao
 * @date 2015年7月6日 下午2:35:03
 * @version 0.1.0 
 * @copyright zuojian.com
 */
public class ImageVo extends BaseParam {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * 图片类型 (0:头像)
	 */
	@NotNull(message="图片类型不能为空")
	private Integer imageType;
	
	/**
	 * base64
	 */
	private String imageData;
	
	/**
	 * 是否微信上传 0：否   1是
	 */
	private Integer isWeixin = 0;
	
	public Integer getImageType() {
		return imageType;
	}

	public void setImageType(Integer imageType) {
		this.imageType = imageType;
	}
	
	/**
	 * imageData.
	 *
	 * @return the imageData
	 */
	public String getImageData() {
		return imageData;
	}

	/**
	 * imageData.
	 *
	 * @param imageData the imageData to set
	 */
	public void setImageData(String imageData) {
		this.imageData = imageData;
	}

	public Integer getIsWeixin() {
		return isWeixin;
	}

	public void setIsWeixin(Integer isWeixin) {
		this.isWeixin = isWeixin;
	}
}