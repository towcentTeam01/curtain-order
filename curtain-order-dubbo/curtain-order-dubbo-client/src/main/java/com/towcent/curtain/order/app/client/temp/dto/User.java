package com.towcent.curtain.order.app.client.temp.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 21:56:13
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class User implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * Id.
     */
	private String userId;
	
	/**
     * 用户名.
     */
	private String userName;
	
	/**
     * 0:管理员 1:普通用户.
     */
	private Integer userType;
	
	/**
     * 密码.
     */
	private String passwd;
	
	/**
     * 电子邮箱.
     */
	private String email;
	
	/**
     * 状态 0:创建 1:审核.
     */
	private Integer status;
	
	/**
     * 收货人姓名.
     */
	private String consigneeName;
	
	/**
     * 收货人地址.
     */
	private String consigneeAddress;
	
	/**
     * 收货人电话.
     */
	private String consigneePhone;
	
	/**
     * 创建时间.
     */
	private Date createTime;
	
	/**
     * 修改时间.
     */
	private Date updateTime;
	
	/**
     * 备注.
     */
	private String remark;
	
	
}