package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 12:50:47
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class ConsigneeAddr implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 主键id.
     */
	private Integer id;
	
	/**
     * 收货人姓名.
     */
	private String consigneeName;
	
	/**
     * 省.
     */
	private Integer province;
	
	/**
     * 市.
     */
	private Integer city;
	
	/**
     * 区.
     */
	private Integer district;
	
	/**
     * 详细地址.
     */
	private String detailAddr;
	
	/**
     * 全地址.
     */
	private String address;
	
	/**
     * 手机号码(手机或者电话至少填一项).
     */
	private String mobilePhone;
	
	/**
     * 电话号码(手机或者电话至少填一项).
     */
	private String telephone;
	
	/**
     * 是否默认地址(1:是 0:否) yes_no.
     */
	private String defaultFlag;
	
	/**
     * 会员id.
     */
	private Integer userId;
	
	/**
     * 标签（如：家，公司）.
     */
	private String remarks;
	
	/**
     * 创建者.
     */
	private Integer createBy;
	
	/**
     * 创建时间.
     */
	private Date createDate;
	
	/**
     * 更新者.
     */
	private Integer updateBy;
	
	/**
     * 更新时间.
     */
	private Date updateDate;
	
	/**
     * 删除标记(0:正常1:删除).
     */
	private String delFlag;
	
	/**
     * 商户id.
     */
	private Integer merchantId;
	
	
}