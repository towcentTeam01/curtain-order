package com.towcent.curtain.order.app.client.goods.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 16:03:54
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class Goods implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * 主键id.
     */
	private Integer id;
	
	/**
     * 分类编码(数据字典goods_category).
     */
	private String cateNo;
	
	/**
     * 分类名称.
     */
	private String cateName;
	
	/**
     * 商品编码.
     */
	private String goodsNo;
	
	/**
     * 商品名称.
     */
	private String goodsName;
	
	/**
     * 商品类型(0:普通商品).
     */
	private String goodsType;
	
	/**
     * 商品条形码.
     */
	private String goodsBarcode;
	
	/**
     * 商品状态(1:未发布 2:上架 3:下架).
     */
	private String goodsStatus;
	
	/**
     * 商品品牌.
     */
	private String brandName;
	
	/**
     * 门幅.
     */
	private String larghezza;
	
	/**
     * 风格.
     */
	private String style;
	
	/**
     * 材质.
     */
	private String material;
	
	/**
     * 规格.
     */
	private String specification;
	
	/**
     * 商品单价.
     */
	private BigDecimal price;
	
	/**
     * 商品成本价.
     */
	private BigDecimal costPrice;
	
	/**
     * 商品图片url(多个;分割).
     */
	private String mainUrls;
	
	/**
     * 商品简介.
     */
	private String description;
	
	/**
     * 商品图片描述.
     */
	private String descPic;
	
	/**
     * 图片版本.
     */
	private Integer descPicV;
	
	/**
     * 库存(单位/米).
     */
	private BigDecimal qty;
	
	/**
     * 销量.
     */
	private Integer saleNum;
	
	/**
     * 销售米数(单位/米).
     */
	private BigDecimal saleLength;
	
	/**
     * 标签类别.
     */
	private String labelType;
	
	/**
     * 评价数量.
     */
	private Integer evaNum;
	
	/**
     * 好评率.
     */
	private BigDecimal goodEvalRate;
	
	/**
     * 注备.
     */
	private String remarks;
	
	/**
     * 创建者.
     */
	private Integer createBy;
	
	/**
     * 创建时间.
     */
	private Date createDate;
	
	/**
     * 更新者.
     */
	private Integer updateBy;
	
	/**
     * 更新时间.
     */
	private Date updateDate;
	
	/**
     * 删除标记(0:正常1:删除).
     */
	private String delFlag;
	
	/**
     * 商户id.
     */
	private Integer merchantId;
	
	
}