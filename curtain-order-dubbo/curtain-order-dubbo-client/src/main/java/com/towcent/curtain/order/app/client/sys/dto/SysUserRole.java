package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 12:29:59
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class SysUserRole implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 用户编号.
     */
	private Integer userId;
	
	/**
     * 角色编号.
     */
	private Integer roleId;
	
	/**
     * 商户id.
     */
	private Integer merchantId;
	
	
}