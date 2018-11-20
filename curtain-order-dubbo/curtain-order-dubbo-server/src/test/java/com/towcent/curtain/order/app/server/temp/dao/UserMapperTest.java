package com.towcent.curtain.order.app.server.temp.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.temp.dto.User;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.temp.dao.UserMapper;
import java.util.Date;

/**
 * user 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-15 21:56:13
 * @version 1.0
 * @copyright facegarden.com
 */
public class UserMapperTest extends BaseServiceTest {
	
	@Resource
	private UserMapper mapper;
	
	@Test
	public void insertSelective() {
		User entity = new User();
		// Id
		entity.setUserId("");
		// 用户名
		entity.setUserName("");
		// 0:管理员 1:普通用户
		entity.setUserType(1);
		// 密码
		entity.setPasswd("");
		// 电子邮箱
		entity.setEmail("");
		// 状态 0:创建 1:审核
		entity.setStatus(1);
		// 收货人姓名
		entity.setConsigneeName("");
		// 收货人地址
		entity.setConsigneeAddress("");
		// 收货人电话
		entity.setConsigneePhone("");
		// 创建时间
		entity.setCreateTime(new Date());
		// 修改时间
		entity.setUpdateTime(new Date());
		// 备注
		entity.setRemark("");
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
		User entity = new User();
		// Id
		entity.setUserId("");
		// 用户名
		entity.setUserName("");
		// 0:管理员 1:普通用户
		entity.setUserType(1);
		// 密码
		entity.setPasswd("");
		// 电子邮箱
		entity.setEmail("");
		// 状态 0:创建 1:审核
		entity.setStatus(1);
		// 收货人姓名
		entity.setConsigneeName("");
		// 收货人地址
		entity.setConsigneeAddress("");
		// 收货人电话
		entity.setConsigneePhone("");
		// 创建时间
		entity.setCreateTime(new Date());
		// 修改时间
		entity.setUpdateTime(new Date());
		// 备注
		entity.setRemark("");
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		User entity = new User();
		// entity.setId("1");
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}