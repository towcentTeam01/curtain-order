package com.towcent.curtain.order.app.server.sys.dao;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;

import com.towcent.curtain.order.app.client.sys.dto.SysUser;
import com.towcent.curtain.order.app.server.BaseServiceTest;

public class SysUserTest extends BaseServiceTest {
	
	@Resource SysUserMapper mapper;
	
	@Test public void getById() {
		SysUser user = new SysUser();
		user.setId(1);
		SysUser sysUser = mapper.selectByPrimaryKey(user);
		Assert.assertEquals("admin", sysUser.getLoginName());
	}
	
}