package com.towcent.curtain.order.web.goods.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.goods.entity.Goods;

/**
 * 商品DAO接口
 * @author Huangtao
 * @version 2018-07-15
 */
@MyBatisDao
public interface GoodsDao extends CrudDao<Goods> {
	
}