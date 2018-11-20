package com.towcent.curtain.order.app.server.sys.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.sys.dto.ConsigneeAddr;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.sys.dao.ConsigneeAddrMapper;
import java.util.Date;

/**
 * consignee_addr 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-18 12:50:47
 * @version 1.0
 * @copyright facegarden.com
 */
public class ConsigneeAddrMapperTest extends BaseServiceTest {
	
	@Resource
	private ConsigneeAddrMapper mapper;
	
	@Test
	public void insertSelective() {
		ConsigneeAddr entity = new ConsigneeAddr();
		// 主键id
		entity.setId(1);
		// 收货人姓名
		entity.setConsigneeName("");
		// 省
		entity.setProvince(1);
		// 市
		entity.setCity(1);
		// 区
		entity.setDistrict(1);
		// 详细地址
		entity.setDetailAddr("");
		// 全地址
		entity.setAddress("");
		// 手机号码(手机或者电话至少填一项)
		entity.setMobilePhone("");
		// 电话号码(手机或者电话至少填一项)
		entity.setTelephone("");
		// 是否默认地址(1:是 0:否) yes_no
		entity.setDefaultFlag("");
		// 会员id
		entity.setUserId(1);
		// 标签（如：家，公司）
		entity.setRemarks("");
		// 创建者
		entity.setCreateBy(1);
		// 创建时间
		entity.setCreateDate(new Date());
		// 更新者
		entity.setUpdateBy(1);
		// 更新时间
		entity.setUpdateDate(new Date());
		// 删除标记(0:正常1:删除)
		entity.setDelFlag("");
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
		ConsigneeAddr entity = new ConsigneeAddr();
		// 主键id
		entity.setId(1);
		// 收货人姓名
		entity.setConsigneeName("");
		// 省
		entity.setProvince(1);
		// 市
		entity.setCity(1);
		// 区
		entity.setDistrict(1);
		// 详细地址
		entity.setDetailAddr("");
		// 全地址
		entity.setAddress("");
		// 手机号码(手机或者电话至少填一项)
		entity.setMobilePhone("");
		// 电话号码(手机或者电话至少填一项)
		entity.setTelephone("");
		// 是否默认地址(1:是 0:否) yes_no
		entity.setDefaultFlag("");
		// 会员id
		entity.setUserId(1);
		// 标签（如：家，公司）
		entity.setRemarks("");
		// 创建者
		entity.setCreateBy(1);
		// 创建时间
		entity.setCreateDate(new Date());
		// 更新者
		entity.setUpdateBy(1);
		// 更新时间
		entity.setUpdateDate(new Date());
		// 删除标记(0:正常1:删除)
		entity.setDelFlag("");
		// 商户id
		entity.setMerchantId(1);
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		ConsigneeAddr entity = new ConsigneeAddr();
		entity.setId(1);
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}