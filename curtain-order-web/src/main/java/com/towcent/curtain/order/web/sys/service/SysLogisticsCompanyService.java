package com.towcent.curtain.order.web.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.sys.entity.SysLogisticsCompany;
import com.towcent.curtain.order.web.sys.dao.SysLogisticsCompanyDao;

/**
 * 系统物流公司Service
 * @author HuangTao
 * @version 2018-07-11
 */
@Service
@Transactional(readOnly = true)
public class SysLogisticsCompanyService extends CrudService<SysLogisticsCompanyDao, SysLogisticsCompany> {

	public SysLogisticsCompany get(String id) {
		return super.get(id);
	}
	
	public List<SysLogisticsCompany> findList(SysLogisticsCompany sysLogisticsCompany) {
		return super.findList(sysLogisticsCompany);
	}
	
	public Page<SysLogisticsCompany> findPage(Page<SysLogisticsCompany> page, SysLogisticsCompany sysLogisticsCompany) {
		return super.findPage(page, sysLogisticsCompany);
	}
	
	@Transactional(readOnly = false)
	public void save(SysLogisticsCompany sysLogisticsCompany) {
		super.save(sysLogisticsCompany);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysLogisticsCompany sysLogisticsCompany) {
		super.delete(sysLogisticsCompany);
	}
	
}