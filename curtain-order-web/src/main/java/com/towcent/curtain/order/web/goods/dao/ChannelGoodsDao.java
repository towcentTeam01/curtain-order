/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.towcent.curtain.order.web.goods.dao;

import java.util.List;

import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.goods.entity.ChannelGoods;

/**
 * 商品频道DAO接口
 *
 * @author alice
 * @version 2017-03-01
 */
@MyBatisDao
public interface ChannelGoodsDao {

  /**
   * 查询频道商品列表
   *
   * @param channelGoods
   * @return
   */
  List<ChannelGoods> findChannelGoodsPage(ChannelGoods channelGoods);
}
