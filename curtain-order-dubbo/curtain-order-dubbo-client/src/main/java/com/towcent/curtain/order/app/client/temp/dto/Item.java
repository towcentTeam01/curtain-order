package com.towcent.curtain.order.app.client.temp.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 16:01:32
 * @version 1.0
 * @copyright facegarden.com
 */
@Setter @Getter
public class Item implements Serializable {

    private static final long serialVersionUID = 1L;
	
	/**
     * Id.
     */
	private String id;
	
	/**
     * 型号.
     */
	private String itemNo;
	
	/**
     * 商品名称.
     */
	private String itemName;
	
	/**
     * 品牌.
     */
	private String brandName;
	
	/**
     * 分类编码.
     */
	private String cateNo;
	
	/**
     * 分类名称.
     */
	private String cateName;
	
	/**
     * 图片地址.
     */
	private String picUrl;
	
	/**
     * 库存(单位:M).
     */
	private BigDecimal qty;
	
	/**
     * 单价.
     */
	private BigDecimal price;
	
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
     * 描述.
     */
	private String description;
	
	/**
     * 销售米数（单位:M）.
     */
	private BigDecimal saleLength;
	
	/**
     * 销售次数.
     */
	private Integer saleNum;
	
	/**
     * 创建时间.
     */
	private Date createTime;
	
	/**
     * 修改时间.
     */
	private Date updateTime;
	
	/**
     * 创建用户.
     */
	private String creator;
	
	/**
     * 修改用户.
     */
	private String updator;
	
	/**
     * 标签类别.
     */
	private String labelType;
	
	
}