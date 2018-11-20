package com.towcent.curtain.order.portal.common.vo;

import java.io.Serializable;

import com.towcent.base.common.vo.BaseCommonParam;

import lombok.Getter;
import lombok.Setter;

/**
 * protal公共查询参数
 * 
 * @author huangtao
 * @date 2015年6月25日 下午1:38:21
 * @version 0.1.0 
 */
@Setter @Getter
public class BaseParam extends BaseCommonParam implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Integer merchantId;
}