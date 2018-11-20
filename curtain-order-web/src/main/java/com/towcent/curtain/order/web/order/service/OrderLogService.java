package com.towcent.curtain.order.web.order.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.order.entity.OrderLog;
import com.towcent.curtain.order.web.order.dao.OrderLogDao;

/**
 * 订单日志Service
 * @author HuangTao
 * @version 2018-07-19
 */
@Service
@Transactional(readOnly = true)
public class OrderLogService extends CrudService<OrderLogDao, OrderLog> {

	public OrderLog get(String id) {
		return super.get(id);
	}
	
	public List<OrderLog> findList(OrderLog orderLog) {
		return super.findList(orderLog);
	}
	
	public Page<OrderLog> findPage(Page<OrderLog> page, OrderLog orderLog) {
		return super.findPage(page, orderLog);
	}
	
	@Transactional(readOnly = false)
	public void save(OrderLog orderLog) {
		super.save(orderLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(OrderLog orderLog) {
		super.delete(orderLog);
	}
	
}