package com.towcent.curtain.order.web.mall.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;

/**
 * 购物车DAO接口
 * @author yxp
 * @version 2018-10-17
 */
@MyBatisDao
public interface ShoppingCartDao extends CrudDao<ShoppingCart> {
	
}