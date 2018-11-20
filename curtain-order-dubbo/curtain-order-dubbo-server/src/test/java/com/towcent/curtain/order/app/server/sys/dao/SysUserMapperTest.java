package com.towcent.curtain.order.app.server.sys.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.sys.dto.SysUser;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.sys.dao.SysUserMapper;
import java.util.Date;

/**
 * sys_user 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-15 22:15:35
 * @version 1.0
 * @copyright facegarden.com
 */
public class SysUserMapperTest extends BaseServiceTest {
	
	@Resource
	private SysUserMapper mapper;
	
	@Test
	public void insertSelective() {
		SysUser entity = new SysUser();
		// 编号
		entity.setId(1);
		// 归属公司
		entity.setCompanyId(1);
		// 归属部门
		entity.setOfficeId(1);
		// 登录名
		entity.setLoginName("");
		// 密码
		entity.setPassword("");
		// 工号
		entity.setNo("");
		// 姓名
		entity.setName("");
		// 邮箱
		entity.setEmail("");
		// 电话
		entity.setPhone("");
		// 手机
		entity.setMobile("");
		// 用户类型
		entity.setUserType("");
		// 用户头像
		entity.setPhoto("");
		// 最后登陆IP
		entity.setLoginIp("");
		// 最后登陆时间
		entity.setLoginDate(new Date());
		// 是否可登录
		entity.setLoginFlag("");
		// 创建者
		entity.setCreateBy("");
		// 创建时间
		entity.setCreateDate(new Date());
		// 更新者
		entity.setUpdateBy("");
		// 更新时间
		entity.setUpdateDate(new Date());
		// 备注信息
		entity.setRemarks("");
		// 删除标记
		entity.setDelFlag("");
		// 性别(0:女 1:男)
		entity.setSex("");
		// 职务
		entity.setJob("");
		// 入职时间
		entity.setEntryDate(new Date());
		// 生日
		entity.setBirthday(new Date());
		int count = mapper.insertSelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void deleteByPrimaryKey() {
		int count = mapper.deleteByPrimaryKey(1 + "");
		System.out.println(count);
	}
	
	@Test
	public void updateByPrimaryKeySelective() {
		SysUser entity = new SysUser();
		// 编号
		entity.setId(1);
		// 归属公司
		entity.setCompanyId(1);
		// 归属部门
		entity.setOfficeId(1);
		// 登录名
		entity.setLoginName("");
		// 密码
		entity.setPassword("");
		// 工号
		entity.setNo("");
		// 姓名
		entity.setName("");
		// 邮箱
		entity.setEmail("");
		// 电话
		entity.setPhone("");
		// 手机
		entity.setMobile("");
		// 用户类型
		entity.setUserType("");
		// 用户头像
		entity.setPhoto("");
		// 最后登陆IP
		entity.setLoginIp("");
		// 最后登陆时间
		entity.setLoginDate(new Date());
		// 是否可登录
		entity.setLoginFlag("");
		// 创建者
		entity.setCreateBy("");
		// 创建时间
		entity.setCreateDate(new Date());
		// 更新者
		entity.setUpdateBy("");
		// 更新时间
		entity.setUpdateDate(new Date());
		// 备注信息
		entity.setRemarks("");
		// 删除标记
		entity.setDelFlag("");
		// 性别(0:女 1:男)
		entity.setSex("");
		// 职务
		entity.setJob("");
		// 入职时间
		entity.setEntryDate(new Date());
		// 生日
		entity.setBirthday(new Date());
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		SysUser entity = new SysUser();
		entity.setId(1);
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}