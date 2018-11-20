package com.towcent.curtain.order.web.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.sys.entity.ConsigneeAddr;
import com.towcent.curtain.order.web.sys.dao.ConsigneeAddrDao;

/**
 * 收货地址Service
 * @author HuangTao
 * @version 2018-07-19
 */
@Service
@Transactional(readOnly = true)
public class ConsigneeAddrService extends CrudService<ConsigneeAddrDao, ConsigneeAddr> {

	public ConsigneeAddr get(String id) {
		return super.get(id);
	}
	
	public List<ConsigneeAddr> findList(ConsigneeAddr consigneeAddr) {
		return super.findList(consigneeAddr);
	}
	
	public Page<ConsigneeAddr> findPage(Page<ConsigneeAddr> page, ConsigneeAddr consigneeAddr) {
		return super.findPage(page, consigneeAddr);
	}
	
	@Transactional(readOnly = false)
	public void save(ConsigneeAddr consigneeAddr) {
		super.save(consigneeAddr);
	}
	
	@Transactional(readOnly = false)
	public void delete(ConsigneeAddr consigneeAddr) {
		super.delete(consigneeAddr);
	}
	
}