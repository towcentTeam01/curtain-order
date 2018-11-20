package com.towcent.curtain.order.app.server.sys.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.sys.dto.SysUserRole;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.sys.dao.SysUserRoleMapper;

/**
 * sys_user_role 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-18 12:29:59
 * @version 1.0
 * @copyright facegarden.com
 */
public class SysUserRoleMapperTest extends BaseServiceTest {
	
	@Resource
	private SysUserRoleMapper mapper;
	
	@Test
	public void insertSelective() {
		SysUserRole entity = new SysUserRole();
		// 用户编号
		entity.setUserId(1);
		// 角色编号
		entity.setRoleId(1);
		// 商户id
		entity.setMerchantId(1);
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
		SysUserRole entity = new SysUserRole();
		// 用户编号
		entity.setUserId(1);
		// 角色编号
		entity.setRoleId(1);
		// 商户id
		entity.setMerchantId(1);
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		SysUserRole entity = new SysUserRole();
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}