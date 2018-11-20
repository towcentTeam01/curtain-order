package com.towcent.curtain.order.web.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;
import com.towcent.base.sc.web.modules.sys.entity.User;

/**
 * 收货地址Entity
 * @author HuangTao
 * @version 2018-07-19
 */
public class ConsigneeAddr extends DataEntity<ConsigneeAddr> {
	
	private static final long serialVersionUID = 1L;
	private String consigneeName;		// 收货人姓名
	private String province;		// 省
	private String city;		// 市
	private String district;		// 区
	private String detailAddr;		// 详细地址
	private String address;		// 全地址
	private String mobilePhone;		// 手机号码(手机或者电话至少填一项)
	private String telephone;		// 电话号码(手机或者电话至少填一项)
	private String defaultFlag;		// 是否默认地址(1:是 0:否) yes_no
	private User user;		// 会员id
	
	public ConsigneeAddr() {
		super();
	}

	public ConsigneeAddr(String id){
		super(id);
	}

	@Length(min=0, max=20, message="收货人姓名长度必须介于 0 和 20 之间")
	public String getConsigneeName() {
		return consigneeName;
	}

	public void setConsigneeName(String consigneeName) {
		this.consigneeName = consigneeName;
	}
	
	@Length(min=0, max=11, message="省长度必须介于 0 和 11 之间")
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}
	
	@Length(min=0, max=11, message="市长度必须介于 0 和 11 之间")
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	@Length(min=0, max=11, message="区长度必须介于 0 和 11 之间")
	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}
	
	@Length(min=0, max=200, message="详细地址长度必须介于 0 和 200 之间")
	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}
	
	@Length(min=0, max=200, message="全地址长度必须介于 0 和 200 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=200, message="手机号码(手机或者电话至少填一项)长度必须介于 0 和 200 之间")
	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	
	@Length(min=0, max=20, message="电话号码(手机或者电话至少填一项)长度必须介于 0 和 20 之间")
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@Length(min=0, max=1, message="是否默认地址(1:是 0:否) yes_no长度必须介于 0 和 1 之间")
	public String getDefaultFlag() {
		return defaultFlag;
	}

	public void setDefaultFlag(String defaultFlag) {
		this.defaultFlag = defaultFlag;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}