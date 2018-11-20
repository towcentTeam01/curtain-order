package com.towcent.curtain.order.web.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.sys.entity.SysUserMerchantRel;
import com.towcent.curtain.order.web.sys.dao.SysUserMerchantRelDao;

/**
 * 商户用户关系Service
 * @author HuangTao
 * @version 2018-08-03
 */
@Service
@Transactional(readOnly = true)
public class SysUserMerchantRelService extends CrudService<SysUserMerchantRelDao, SysUserMerchantRel> {

	public SysUserMerchantRel get(String id) {
		return super.get(id);
	}
	
	public List<SysUserMerchantRel> findList(SysUserMerchantRel sysUserMerchantRel) {
		return super.findList(sysUserMerchantRel);
	}
	
	public Page<SysUserMerchantRel> findPage(Page<SysUserMerchantRel> page, SysUserMerchantRel sysUserMerchantRel) {
		return super.findPage(page, sysUserMerchantRel);
	}
	
	@Transactional(readOnly = false)
	public void save(SysUserMerchantRel sysUserMerchantRel) {
		super.save(sysUserMerchantRel);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysUserMerchantRel sysUserMerchantRel) {
		super.delete(sysUserMerchantRel);
	}
	
}