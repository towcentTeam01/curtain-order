package com.towcent.curtain.order.web.order.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.dao.OrderDtlDao;

/**
 * 订单明细Service
 * @author HuangTao
 * @version 2018-07-19
 */
@Service
@Transactional(readOnly = true)
public class OrderDtlService extends CrudService<OrderDtlDao, OrderDtl> {

	public OrderDtl get(String id) {
		return super.get(id);
	}
	
	public List<OrderDtl> findList(OrderDtl orderDtl) {
		return super.findList(orderDtl);
	}
	
	public Page<OrderDtl> findPage(Page<OrderDtl> page, OrderDtl orderDtl) {
		return super.findPage(page, orderDtl);
	}
	
	@Transactional(readOnly = false)
	public void save(OrderDtl orderDtl) {
		super.save(orderDtl);
	}
	
	@Transactional(readOnly = false)
	public void delete(OrderDtl orderDtl) {
		super.delete(orderDtl);
	}
	
}