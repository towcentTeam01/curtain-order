package com.towcent.curtain.order.web.goods.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.goods.entity.ConcernGoods;

/**
 * 关注商品DAO接口
 * @author HuangTao
 * @version 2018-07-19
 */
@MyBatisDao
public interface ConcernGoodsDao extends CrudDao<ConcernGoods> {
	
}