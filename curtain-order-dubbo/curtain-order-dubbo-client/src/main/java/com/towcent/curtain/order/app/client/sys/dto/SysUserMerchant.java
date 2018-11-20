package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 15:04:18
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class SysUserMerchant implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 主键Id.
     */
	private Integer id;
	
	/**
     * 用户Id.
     */
	private Integer userId;
	
	/**
     * 商户Id.
     */
	private Integer merchantId;
	
	
}