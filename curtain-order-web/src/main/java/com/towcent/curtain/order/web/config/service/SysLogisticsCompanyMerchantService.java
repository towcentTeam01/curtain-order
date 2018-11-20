package com.towcent.curtain.order.web.config.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.config.entity.SysLogisticsCompanyMerchant;
import com.towcent.curtain.order.web.config.dao.SysLogisticsCompanyMerchantDao;

/**
 * 商家物流配置Service
 * @author HuangTao
 * @version 2018-07-11
 */
@Service
@Transactional(readOnly = true)
public class SysLogisticsCompanyMerchantService extends CrudService<SysLogisticsCompanyMerchantDao, SysLogisticsCompanyMerchant> {

	public SysLogisticsCompanyMerchant get(String id) {
		return super.get(id);
	}
	
	public List<SysLogisticsCompanyMerchant> findList(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant) {
		return super.findList(sysLogisticsCompanyMerchant);
	}
	
	public Page<SysLogisticsCompanyMerchant> findPage(Page<SysLogisticsCompanyMerchant> page, SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant) {
		return super.findPage(page, sysLogisticsCompanyMerchant);
	}
	
	@Transactional(readOnly = false)
	public void save(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant) {
		super.save(sysLogisticsCompanyMerchant);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant) {
		super.delete(sysLogisticsCompanyMerchant);
	}
	
}