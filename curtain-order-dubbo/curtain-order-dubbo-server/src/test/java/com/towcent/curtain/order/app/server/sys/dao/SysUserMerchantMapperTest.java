package com.towcent.curtain.order.app.server.sys.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.sys.dto.SysUserMerchant;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.sys.dao.SysUserMerchantMapper;

/**
 * sys_user_merchant 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-18 15:04:18
 * @version 1.0
 * @copyright facegarden.com
 */
public class SysUserMerchantMapperTest extends BaseServiceTest {
	
	@Resource
	private SysUserMerchantMapper mapper;
	
	@Test
	public void insertSelective() {
		SysUserMerchant entity = new SysUserMerchant();
		// 主键Id
		entity.setId(1);
		// 用户Id
		entity.setUserId(1);
		// 商户Id
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
		SysUserMerchant entity = new SysUserMerchant();
		// 主键Id
		entity.setId(1);
		// 用户Id
		entity.setUserId(1);
		// 商户Id
		entity.setMerchantId(1);
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		SysUserMerchant entity = new SysUserMerchant();
		entity.setId(1);
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}