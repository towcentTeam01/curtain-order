package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 22:15:35
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 编号.
     */
	private Integer id;
	
	/**
     * 归属公司.
     */
	private Integer companyId;
	
	/**
     * 归属部门.
     */
	private Integer officeId;
	
	/**
     * 登录名.
     */
	private String loginName;
	
	/**
     * 密码.
     */
	private String password;
	
	/**
     * 工号.
     */
	private String no;
	
	/**
     * 姓名.
     */
	private String name;
	
	/**
     * 邮箱.
     */
	private String email;
	
	/**
     * 电话.
     */
	private String phone;
	
	/**
     * 手机.
     */
	private String mobile;
	
	/**
     * 用户类型.
     */
	private String userType;
	
	/**
     * 用户头像.
     */
	private String photo;
	
	/**
     * 最后登陆IP.
     */
	private String loginIp;
	
	/**
     * 最后登陆时间.
     */
	private Date loginDate;
	
	/**
     * 是否可登录.
     */
	private String loginFlag;
	
	/**
     * 创建者.
     */
	private String createBy;
	
	/**
     * 创建时间.
     */
	private Date createDate;
	
	/**
     * 更新者.
     */
	private String updateBy;
	
	/**
     * 更新时间.
     */
	private Date updateDate;
	
	/**
     * 备注信息.
     */
	private String remarks;
	
	/**
     * 删除标记.
     */
	private String delFlag;
	
	/**
     * 性别(0:女 1:男).
     */
	private String sex;
	
	/**
     * 职务.
     */
	private String job;
	
	/**
     * 入职时间.
     */
	private Date entryDate;
	
	/**
     * 生日.
     */
	private Date birthday;
	
	
}