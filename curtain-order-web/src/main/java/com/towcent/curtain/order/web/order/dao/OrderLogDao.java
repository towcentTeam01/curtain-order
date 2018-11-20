package com.towcent.curtain.order.web.order.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.order.entity.OrderLog;

/**
 * 订单日志DAO接口
 * @author HuangTao
 * @version 2018-07-19
 */
@MyBatisDao
public interface OrderLogDao extends CrudDao<OrderLog> {
	
}