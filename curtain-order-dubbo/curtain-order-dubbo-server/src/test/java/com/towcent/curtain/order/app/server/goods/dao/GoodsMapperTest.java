package com.towcent.curtain.order.app.server.goods.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Lists;
import com.towcent.curtain.order.app.client.goods.dto.Goods;
import com.towcent.curtain.order.app.client.temp.dto.Item;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.curtain.order.app.server.temp.dao.ItemMapper;

/**
 * goods 数据库操作接口测试用例
 * 
 * @author huangtao
 * @date 2018-07-15 16:03:54
 * @version 1.0
 * @copyright facegarden.com
 */
public class GoodsMapperTest extends BaseServiceTest {
	
	@Resource
	private GoodsMapper mapper;
	
	@Resource
	private ItemMapper itemMapper;
	
	@Test
	public void graftingData() {
		// 原表数据列表
		List<Item> list = itemMapper.selectByParams(null);
		if (CollectionUtils.isEmpty(list)) {
			return;
		}
		
		// List<Goods> goodsList = Lists.newArrayList();
		Goods goods = null;
		for (Item item : list) {
			goods = new Goods();
			goods.setGoodsNo(item.getItemNo());
			goods.setGoodsName(item.getItemName());
			goods.setCateNo("C20140917a310".equals(item.getCateNo()) ? "0" : "1");
			goods.setCateName(item.getCateName());
			goods.setBrandName(item.getBrandName());
			goods.setQty(item.getQty());
			goods.setPrice(item.getPrice());
			goods.setLarghezza(item.getLarghezza());
			goods.setStyle(item.getStyle());
			goods.setMaterial(item.getMaterial());
			goods.setSpecification(item.getSpecification());
			goods.setLabelType(item.getLabelType());
			goods.setDescPicV(1);
			goods.setSaleLength(item.getSaleLength());
			goods.setSaleNum(item.getSaleNum());
			goods.setMainUrls("http://localhost:81/" + item.getPicUrl());
			goods.setDescPic("http://localhost:81/" + item.getPicUrl());
			goods.setDescription(item.getDescription());
			goods.setCreateDate(item.getCreateTime());
			goods.setUpdateDate(null == item.getUpdateTime() ? new Date() : item.getUpdateTime());
			
			mapper.insertSelective(goods);
			// goodsList.add(goods);
		}
		
	}
	
	@Test
	public void insertSelective() {
		Goods entity = new Goods();
		// 主键id
		entity.setId(1);
		// 分类编码(数据字典goods_category)
		entity.setCateNo("");
		// 分类名称
		entity.setCateName("");
		// 商品编码
		entity.setGoodsNo("");
		// 商品名称
		entity.setGoodsName("");
		// 商品类型(0:普通商品)
		entity.setGoodsType("");
		// 商品条形码
		entity.setGoodsBarcode("");
		// 商品状态(1:未发布 2:上架 3:下架)
		entity.setGoodsStatus("");
		// 商品品牌
		entity.setBrandName("");
		// 门幅
		entity.setLarghezza("");
		// 风格
		entity.setStyle("");
		// 材质
		entity.setMaterial("");
		// 规格
		entity.setSpecification("");
		// 商品单价
		entity.setPrice(BigDecimal.ONE);
		// 商品成本价
		entity.setCostPrice(BigDecimal.ONE);
		// 商品图片url(多个;分割)
		entity.setMainUrls("");
		// 商品简介
		entity.setDescription("");
		// 商品图片描述
		entity.setDescPic("");
		// 图片版本
		entity.setDescPicV(1);
		// 库存(单位/米)
		entity.setQty(BigDecimal.ONE);
		// 销量
		entity.setSaleNum(1);
		// 销售米数(单位/米)
		entity.setSaleLength(BigDecimal.ONE);
		// 标签类别
		entity.setLabelType("");
		// 评价数量
		entity.setEvaNum(1);
		// 好评率
		entity.setGoodEvalRate(BigDecimal.ONE);
		// 注备
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
		Goods entity = new Goods();
		// 主键id
		entity.setId(1);
		// 分类编码(数据字典goods_category)
		entity.setCateNo("");
		// 分类名称
		entity.setCateName("");
		// 商品编码
		entity.setGoodsNo("");
		// 商品名称
		entity.setGoodsName("");
		// 商品类型(0:普通商品)
		entity.setGoodsType("");
		// 商品条形码
		entity.setGoodsBarcode("");
		// 商品状态(1:未发布 2:上架 3:下架)
		entity.setGoodsStatus("");
		// 商品品牌
		entity.setBrandName("");
		// 门幅
		entity.setLarghezza("");
		// 风格
		entity.setStyle("");
		// 材质
		entity.setMaterial("");
		// 规格
		entity.setSpecification("");
		// 商品单价
		entity.setPrice(BigDecimal.ONE);
		// 商品成本价
		entity.setCostPrice(BigDecimal.ONE);
		// 商品图片url(多个;分割)
		entity.setMainUrls("");
		// 商品简介
		entity.setDescription("");
		// 商品图片描述
		entity.setDescPic("");
		// 图片版本
		entity.setDescPicV(1);
		// 库存(单位/米)
		entity.setQty(BigDecimal.ONE);
		// 销量
		entity.setSaleNum(1);
		// 销售米数(单位/米)
		entity.setSaleLength(BigDecimal.ONE);
		// 标签类别
		entity.setLabelType("");
		// 评价数量
		entity.setEvaNum(1);
		// 好评率
		entity.setGoodEvalRate(BigDecimal.ONE);
		// 注备
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
		Goods entity = new Goods();
		entity.setId(1);
		entity = mapper.selectByPrimaryKey(entity);
		System.out.println(entity);
	}
	
}