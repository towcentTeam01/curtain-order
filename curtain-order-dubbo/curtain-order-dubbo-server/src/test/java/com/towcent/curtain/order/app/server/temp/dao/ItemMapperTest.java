package com.towcent.curtain.order.app.server.temp.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.curtain.order.app.client.temp.dto.Item;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.temp.dao.ItemMapper;
import java.math.BigDecimal;
import java.util.Date;

/**
 * item 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-15 16:01:32
 * @version 1.0
 * @copyright facegarden.com
 */
public class ItemMapperTest extends BaseServiceTest {
	
	@Resource
	private ItemMapper mapper;
	
	@Test
	public void insertSelective() {
		Item entity = new Item();
		// Id
		entity.setId("");
		// 型号
		entity.setItemNo("");
		// 商品名称
		entity.setItemName("");
		// 品牌
		entity.setBrandName("");
		// 分类编码
		entity.setCateNo("");
		// 分类名称
		entity.setCateName("");
		// 图片地址
		entity.setPicUrl("");
		// 库存(单位:M)
		entity.setQty(BigDecimal.ONE);
		// 单价
		entity.setPrice(BigDecimal.ONE);
		// 门幅
		entity.setLarghezza("");
		// 风格
		entity.setStyle("");
		// 材质
		entity.setMaterial("");
		// 规格
		entity.setSpecification("");
		// 描述
		entity.setDescription("");
		// 销售米数（单位:M）
		entity.setSaleLength(BigDecimal.ONE);
		// 销售次数
		entity.setSaleNum(1);
		// 创建时间
		entity.setCreateTime(new Date());
		// 修改时间
		entity.setUpdateTime(new Date());
		// 创建用户
		entity.setCreator("");
		// 修改用户
		entity.setUpdator("");
		// 标签类别
		entity.setLabelType("");
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
		Item entity = new Item();
		// Id
		entity.setId("");
		// 型号
		entity.setItemNo("");
		// 商品名称
		entity.setItemName("");
		// 品牌
		entity.setBrandName("");
		// 分类编码
		entity.setCateNo("");
		// 分类名称
		entity.setCateName("");
		// 图片地址
		entity.setPicUrl("");
		// 库存(单位:M)
		entity.setQty(BigDecimal.ONE);
		// 单价
		entity.setPrice(BigDecimal.ONE);
		// 门幅
		entity.setLarghezza("");
		// 风格
		entity.setStyle("");
		// 材质
		entity.setMaterial("");
		// 规格
		entity.setSpecification("");
		// 描述
		entity.setDescription("");
		// 销售米数（单位:M）
		entity.setSaleLength(BigDecimal.ONE);
		// 销售次数
		entity.setSaleNum(1);
		// 创建时间
		entity.setCreateTime(new Date());
		// 修改时间
		entity.setUpdateTime(new Date());
		// 创建用户
		entity.setCreator("");
		// 修改用户
		entity.setUpdator("");
		// 标签类别
		entity.setLabelType("");
		int count = mapper.updateByPrimaryKeySelective(entity);
		System.out.println(count);
	}
	
	@Test
	public void selectByPrimaryKey() {
		Item entity = new Item();
		entity.setId("1");
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}