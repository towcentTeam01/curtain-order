package com.towcent.curtain.order.web.config.entity;

import com.towcent.base.sc.web.common.persistence.DataEntity;
import com.towcent.curtain.order.web.sys.entity.SysLogisticsCompany;

/**
 * 商家物流配置Entity
 * @author HuangTao
 * @version 2018-07-11
 */
public class SysLogisticsCompanyMerchant extends DataEntity<SysLogisticsCompanyMerchant> {
	
	private static final long serialVersionUID = 1L;
	private SysLogisticsCompany company;		// 物流公司
	
	public SysLogisticsCompanyMerchant() {
		super();
	}

	public SysLogisticsCompanyMerchant(String id){
		super(id);
	}

	public SysLogisticsCompany getCompany() {
		return company;
	}

	public void setCompany(SysLogisticsCompany company) {
		this.company = company;
	}
	
}