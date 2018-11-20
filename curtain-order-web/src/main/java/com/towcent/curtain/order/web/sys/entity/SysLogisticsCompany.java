package com.towcent.curtain.order.web.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.towcent.base.sc.web.common.persistence.DataEntity;

/**
 * 系统物流公司Entity
 * @author HuangTao
 * @version 2018-07-11
 */
public class SysLogisticsCompany extends DataEntity<SysLogisticsCompany> {
	
	private static final long serialVersionUID = 1L;
	private String companyNo;		// 物流公司编码
	private String companyName;		// 物流公司名称
	
	public SysLogisticsCompany() {
		super();
	}

	public SysLogisticsCompany(String id){
		super(id);
	}

	@Length(min=0, max=100, message="物流公司编码长度必须介于 0 和 100 之间")
	public String getCompanyNo() {
		return companyNo;
	}

	public void setCompanyNo(String companyNo) {
		this.companyNo = companyNo;
	}
	
	@Length(min=0, max=200, message="物流公司名称长度必须介于 0 和 200 之间")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
}