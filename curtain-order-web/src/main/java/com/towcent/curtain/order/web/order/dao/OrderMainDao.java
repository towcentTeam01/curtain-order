package com.towcent.curtain.order.web.order.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.order.entity.OrderMain;

/**
 * 订单DAO接口
 * @author HuangTao
 * @version 2018-07-19
 */
@MyBatisDao
public interface OrderMainDao extends CrudDao<OrderMain> {
	
}