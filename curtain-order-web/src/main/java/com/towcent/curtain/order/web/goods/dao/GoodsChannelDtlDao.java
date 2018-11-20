package com.towcent.curtain.order.web.goods.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.curtain.order.web.goods.entity.GoodsChannelDtl;

/**
 * 商品频道详情DAO接口
 *
 * @author yxp
 * @version 2018-07-09
 */
@MyBatisDao
public interface GoodsChannelDtlDao extends CrudDao<GoodsChannelDtl> {

  /**
   * 查询该频道下的商品树立
   *
   * @param channelId
   * @return
   */
  public Long countGoodsQty(@Param("channelId") String channelId);

  /**
   * 删除频道下的商品
   *
   * @param goodsId
   */
  public void deleteGoods(@Param("goodsId") String goodsId);

  /**
   * 删除频道下的商品
   *
   * @param channelId
   */
  public void deleteChannel(@Param("channelId") String channelId);

  /**
   * 获取该商品所在的频道ID数组
   *
   * @param goodsId
   * @return
   */
  public List<String> getChannelIds(@Param("goodsId") String goodsId);

  /**
   * 通过频道ID 和商品ID 获取数组对象
   *
   * @param channelId
   * @param goodsId
   * @return
   */
  public List<GoodsChannelDtl> getByChannelAndGoods(
      @Param("channelId") String channelId, @Param("goodsId") String goodsId);
}
