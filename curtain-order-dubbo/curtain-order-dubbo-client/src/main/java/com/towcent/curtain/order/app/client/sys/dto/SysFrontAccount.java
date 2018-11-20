package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2017-12-28 10:33:12
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class SysFrontAccount implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 主键Id.
     */
	private Integer id;
	
	/**
     * 帐号.
     */
	private String account;
	
	/**
     * 手机号.
     */
	private String mobile;
	
	/**
     * 邮箱.
     */
	private String email;
	
	/**
     * 密码.
     */
	private String password;
	
	/**
     * 交易密码.
     */
	private String tradePassword;
	
	/**
	 * 账户余额.
	 */
	private BigDecimal amount;
	
	/**
	 * 冻结余额.
	 */
	private BigDecimal freezeAmount;
	
	/**
	 * 保证金.
	 */
	private BigDecimal marginAmount;
	
	/**
	 * 性别(1:男 2:女).
	 */
	private String sex;
	
	/**
     * 昵称.
     */
	private String nickName;
	
	/**
     * 头像地址.
     */
	private String portrait;
	
	/**
     * 关注openid.
     */
	private String openId;
	
	/**
     * 绑定的微信号.
     */
	private String bindWx;
	
	/**
     * 绑定的微博号.
     */
	private String bindWeibo;
	
	/**
     * 绑定的QQ号.
     */
	private String bindQq;
	
	/**
     * 上次登录时间.
     */
	private Date lastLogintime;
	
	/**
     * 登录次数.
     */
	private Integer loginTimes;
	
	/**
     * 账号状态(0:正常 1:锁定).
     */
	private String status;
	
	/**
     * 用户类型(0:承运商 1:货主).
     */
	private String userType;
	
	/**
     * 备用字段.
     */
	private String remark;
	
	/**
     * 创建时间.
     */
	private Date createDate;
	
	/**
     * 删除标记(0:正常 1:删除).
     */
	private String delFlag;


}