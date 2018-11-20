package com.towcent.curtain.order.web.sys.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.sys.entity.ConsigneeAddr;

/**
 * 收货地址DAO接口
 * @author HuangTao
 * @version 2018-07-19
 */
@MyBatisDao
public interface ConsigneeAddrDao extends CrudDao<ConsigneeAddr> {
	
}