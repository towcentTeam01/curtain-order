package com.towcent.curtain.order.web.order.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.order.entity.OrderDtl;

/**
 * 订单明细DAO接口
 * @author HuangTao
 * @version 2018-07-19
 */
@MyBatisDao
public interface OrderDtlDao extends CrudDao<OrderDtl> {
	
}