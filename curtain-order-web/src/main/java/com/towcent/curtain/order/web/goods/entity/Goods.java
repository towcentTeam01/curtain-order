package com.towcent.curtain.order.web.goods.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 商品Entity
 * @author Huangtao
 * @version 2018-07-15
 */
public class Goods extends DataEntity<Goods> {
	
	private static final long serialVersionUID = 1L;
	private String cateNo;		// 分类编码(数据字典goods_category)
	private String cateName;		// 分类名称
	private String goodsNo;		// 商品编码
	private String goodsName;		// 商品名称
	private String goodsType;		// 商品类型(0:普通商品)
	private String goodsBarcode;		// 商品条形码
	private String goodsStatus;		// 商品状态(1:未发布 2:上架 3:下架)
	private String brandName;		// 商品品牌
	private String larghezza;		// 门幅
	private String style;		// 风格
	private String material;		// 材质
	private String specification;		// 规格
	private String price;		// 商品单价
	private String costPrice;		// 商品成本价
	private String mainUrls;		// 商品图片url(多个;分割)
	private String description;		// 商品简介
	private String descPic;		// 商品图片描述
	private String descPicV;		// 图片版本
	private String qty;		// 库存(单位/米)
	private String saleNum;		// 销量
	private String saleLength;		// 销售米数(单位/米)
	private String labelType;		// 标签类别
	private String evaNum;		// 评价数量
	private String goodEvalRate;		// 好评率
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private String goodsPicUrl;		// 商品图片url
	private List<String> goodsImgList;


	public Goods() {
		super();
	}

	public Goods(String id){
		super(id);
	}

	@Length(min=1, max=100, message="分类编码(数据字典goods_category)长度必须介于 1 和 100 之间")
	public String getCateNo() {
		return cateNo;
	}

	public void setCateNo(String cateNo) {
		this.cateNo = cateNo;
	}
	
	@Length(min=1, max=500, message="分类名称长度必须介于 1 和 500 之间")
	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	
	@Length(min=1, max=50, message="商品编码长度必须介于 1 和 50 之间")
	public String getGoodsNo() {
		return goodsNo;
	}

	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	@Length(min=1, max=100, message="商品名称长度必须介于 1 和 100 之间")
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	@Length(min=0, max=2, message="商品类型(0:普通商品)长度必须介于 0 和 2 之间")
	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}
	
	@Length(min=0, max=50, message="商品条形码长度必须介于 0 和 50 之间")
	public String getGoodsBarcode() {
		return goodsBarcode;
	}

	public void setGoodsBarcode(String goodsBarcode) {
		this.goodsBarcode = goodsBarcode;
	}
	
	@Length(min=0, max=1, message="商品状态(1:未发布 2:上架 3:下架)长度必须介于 0 和 1 之间")
	public String getGoodsStatus() {
		return goodsStatus;
	}

	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}
	
	@Length(min=0, max=100, message="商品品牌长度必须介于 0 和 100 之间")
	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	
	@Length(min=0, max=100, message="门幅长度必须介于 0 和 100 之间")
	public String getLarghezza() {
		return larghezza;
	}

	public void setLarghezza(String larghezza) {
		this.larghezza = larghezza;
	}
	
	@Length(min=0, max=100, message="风格长度必须介于 0 和 100 之间")
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}
	
	@Length(min=0, max=100, message="材质长度必须介于 0 和 100 之间")
	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}
	
	@Length(min=0, max=100, message="规格长度必须介于 0 和 100 之间")
	public String getSpecification() {
		return specification;
	}

	public void setSpecification(String specification) {
		this.specification = specification;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	public String getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(String costPrice) {
		this.costPrice = costPrice;
	}
	
	@Length(min=0, max=1000, message="商品图片url(多个;分割)长度必须介于 0 和 1000 之间")
	public String getMainUrls() {
		return mainUrls;
	}

	public void setMainUrls(String mainUrls) {
		this.mainUrls = mainUrls;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescPic() {
		return descPic;
	}

	public void setDescPic(String descPic) {
		this.descPic = descPic;
	}
	
	@Length(min=0, max=11, message="图片版本长度必须介于 0 和 11 之间")
	public String getDescPicV() {
		return descPicV;
	}

	public void setDescPicV(String descPicV) {
		this.descPicV = descPicV;
	}
	
	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}
	
	@Length(min=0, max=11, message="销量长度必须介于 0 和 11 之间")
	public String getSaleNum() {
		return saleNum;
	}

	public void setSaleNum(String saleNum) {
		this.saleNum = saleNum;
	}
	
	public String getSaleLength() {
		return saleLength;
	}

	public void setSaleLength(String saleLength) {
		this.saleLength = saleLength;
	}
	
	@Length(min=0, max=50, message="标签类别长度必须介于 0 和 50 之间")
	public String getLabelType() {
		return labelType;
	}

	public void setLabelType(String labelType) {
		this.labelType = labelType;
	}
	
	@Length(min=0, max=11, message="评价数量长度必须介于 0 和 11 之间")
	public String getEvaNum() {
		return evaNum;
	}

	public void setEvaNum(String evaNum) {
		this.evaNum = evaNum;
	}
	
	public String getGoodEvalRate() {
		return goodEvalRate;
	}

	public void setGoodEvalRate(String goodEvalRate) {
		this.goodEvalRate = goodEvalRate;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getGoodsPicUrl() {
		return goodsPicUrl;
	}

	public void setGoodsPicUrl(String goodsPicUrl) {
		this.goodsPicUrl = goodsPicUrl;
	}

	public List<String> getGoodsImgList() {
		return goodsImgList;
	}

	public void setGoodsImgList(List<String> goodsImgList) {
		this.goodsImgList = goodsImgList;
	}
}