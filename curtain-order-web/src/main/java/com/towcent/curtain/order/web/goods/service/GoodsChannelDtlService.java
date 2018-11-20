package com.towcent.curtain.order.web.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.goods.dao.ChannelGoodsDao;
import com.towcent.curtain.order.web.goods.dao.GoodsChannelDao;
import com.towcent.curtain.order.web.goods.dao.GoodsChannelDtlDao;
import com.towcent.curtain.order.web.goods.entity.ChannelGoods;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.goods.entity.GoodsChannel;
import com.towcent.curtain.order.web.goods.entity.GoodsChannelDtl;

/**
 * 商品频道详情Service
 *
 * @author yxp
 * @version 2018-07-09
 */
@Service
@Transactional(readOnly = true)
public class GoodsChannelDtlService extends CrudService<GoodsChannelDtlDao, GoodsChannelDtl> {

  @Autowired private GoodsChannelDao goodsChannelDao;

  @Autowired private ChannelGoodsDao channelGoodsDao;

  public GoodsChannelDtl get(String id) {
    return super.get(id);
  }

  public List<GoodsChannelDtl> findList(GoodsChannelDtl goodsChannelDtl) {
    return super.findList(goodsChannelDtl);
  }

  public Page<GoodsChannelDtl> findPage(
      Page<GoodsChannelDtl> page, GoodsChannelDtl goodsChannelDtl) {
    return super.findPage(page, goodsChannelDtl);
  }

  @Transactional(readOnly = false)
  public void save(GoodsChannelDtl goodsChannelDtl) {
    super.save(goodsChannelDtl);
  }

  @Transactional(readOnly = false)
  public void delete(GoodsChannelDtl goodsChannelDtl) {
    super.delete(goodsChannelDtl);
  }

  /**
   * 频道分配商品操作
   *
   * @param goodsIds 商品ID字符串 英文逗号分割
   * @param channelId 频道ID
   * @param assigned 是否分配
   */
  @Transactional(readOnly = false)
  public void assign(String[] goodsIds, String channelId, Boolean assigned) {
    GoodsChannel goodsChannel = new GoodsChannel(channelId);
    for (String goodsId : goodsIds) {
      GoodsChannelDtl dtl = null;
      List<GoodsChannelDtl> arr = dao.getByChannelAndGoods(channelId, goodsId);
      if (arr.size() == 1) {
        dtl = arr.get(0);
      } else {
        for (int i = 1; i < arr.size(); i++) {
          dao.delete(arr.get(0));
        }
      }
      if (dtl == null && !assigned) return;
      if (dtl == null) dtl = new GoodsChannelDtl();
      if (assigned) {
        dtl.setChannel(goodsChannel);
        dtl.setGoods(new Goods(goodsId));
        save(dtl);
      } else {
        delete(dtl);
      }
      // 更新频道中的商品数量
      updateGoodsQty(channelId);
    }
  }

  /**
   * 删除频道下的商品 更新该商品所有所在频道的商品数量
   *
   * @param goodsId
   */
  @Transactional(readOnly = false)
  public void deleteGoods(String goodsId) {
    List<String> channelIds = dao.getChannelIds(goodsId);
    dao.deleteGoods(goodsId);
    for (String channelId : channelIds) {
      updateGoodsQty(channelId);
    }
  }

  /** 更新频道下的商品数量 */
  @Transactional(readOnly = false)
  public void updateGoodsQty(String channelId) {
    Long goodsQty = dao.countGoodsQty(channelId);
    GoodsChannel goodsChannel = new GoodsChannel();
    goodsChannel.setId(channelId);
    goodsChannel = goodsChannelDao.get(goodsChannel);
    goodsChannel.setGoodsQty(goodsQty.intValue());
    goodsChannelDao.updateSelective(goodsChannel);
  }

  public Page<ChannelGoods> findChannelGoodsPage(
      Page<ChannelGoods> page, ChannelGoods channelGoods) {
    channelGoods.setPage(page);
    List<ChannelGoods> list = channelGoodsDao.findChannelGoodsPage(channelGoods);
    page.setList(list);
    return page;
  }
}
