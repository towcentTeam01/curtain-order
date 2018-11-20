package com.towcent.curtain.order.app.server.sys.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.util.CollectionUtils;

import com.towcent.base.common.exception.ServiceException;
import com.towcent.curtain.order.app.client.sys.dto.ConsigneeAddr;
import com.towcent.curtain.order.app.client.sys.dto.SysUser;
import com.towcent.curtain.order.app.client.sys.dto.SysUserMerchant;
import com.towcent.curtain.order.app.client.sys.dto.SysUserRole;
import com.towcent.curtain.order.app.client.temp.dto.User;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.temp.service.UserService;

public class SysUserServiceTest extends BaseServiceTest {
	
	@Resource SysUserService userService;
	@Resource UserService tempUserService;
	@Resource SysUserRoleService sysUserRoleService;
	@Resource ConsigneeAddrService consigneeService;
	@Resource SysUserMerchantService userMerchantService;
	
	// 迁移用户数据
	@Test
	public void graftingData() throws ServiceException {
		List<User> tempList = tempUserService.findByBiz(null);
		if (CollectionUtils.isEmpty(tempList)) return;
		
		SysUser sysUser = null;
		for (User user : tempList) {
			sysUser = new SysUser();
			sysUser.setCompanyId(1);
			sysUser.setOfficeId(1);
			sysUser.setLoginName(user.getUserName());
			sysUser.setPassword(user.getPasswd());
			// sysUser.setPhone(phone);
			sysUser.setMobile(user.getConsigneePhone());
			sysUser.setEmail(user.getEmail());
			sysUser.setName(user.getUserName());
			sysUser.setRemarks(user.getUserId());
			sysUser.setCreateDate(user.getCreateTime());
			sysUser.setUpdateDate(user.getUpdateTime());
			sysUser.setJob(user.getStatus() + "");    // 0:创建 1:审核
			sysUser.setUserType("3");   // 3：普通用户
			
			sysUser.setCreateBy(1 + "");
			sysUser.setCreateDate(new Date());
			sysUser.setUpdateBy(sysUser.getCreateBy());
			sysUser.setUpdateDate(sysUser.getCreateDate());
			
			// sys
			userService.add(sysUser);
			
			// 收货地址
			ConsigneeAddr addr = new ConsigneeAddr();
			addr.setUserId(sysUser.getId());
			addr.setConsigneeName(user.getConsigneeName());
			// addr.setProvince(province);
			// addr.setCity(city);
			// addr.setDistrict(district);
			// addr.setDetailAddr(detailAddr);
			addr.setAddress(user.getConsigneeAddress());
			addr.setMobilePhone(user.getConsigneePhone());
			// addr.setTelephone(telephone);
			addr.setDefaultFlag("1");   // 是否默认(1:默认 0:否)
			addr.setCreateBy(1);
			addr.setCreateDate(new Date());
			addr.setUpdateBy(addr.getCreateBy());
			addr.setUpdateDate(addr.getCreateDate());
			addr.setMerchantId(0);
			consigneeService.add(addr);            // 0:罗琦
			
			// 默认角色
			SysUserRole userRole = new SysUserRole();
			userRole.setMerchantId(0);             // 0:罗琦
			userRole.setRoleId(2);                 // 2:普通商户
			userRole.setUserId(sysUser.getId());   // 
			sysUserRoleService.add(userRole);
			
			// 商家关系
			SysUserMerchant entity = new SysUserMerchant();
			entity.setUserId(sysUser.getId());
			entity.setMerchantId(0);
			userMerchantService.add(entity);
		}
	}
	
	@Test public void findByKeyVal() throws ServiceException {
		List<SysUser> list = userService.findByKeyVal("id", 1);
		
		Assert.assertEquals(1, list.size());
	}
	
	@Test public void findByKeyValSingle() throws ServiceException {
		SysUser user = userService.findByKeyValSingle("id", 1);
		
		Assert.assertEquals("admin", user.getLoginName());
		System.out.println("===>");
	}
}