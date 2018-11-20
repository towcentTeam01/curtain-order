package com.towcent.curtain.order.web.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.goods.dao.GoodsChannelDao;
import com.towcent.curtain.order.web.goods.dao.GoodsChannelDtlDao;
import com.towcent.curtain.order.web.goods.entity.GoodsChannel;

/**
 * 商品频道Service
 *
 * @author yxp
 * @version 2018-07-09
 */
@Service
@Transactional(readOnly = true)
public class GoodsChannelService extends CrudService<GoodsChannelDao, GoodsChannel> {

  @Autowired private GoodsChannelDtlDao goodsChannelDtlDao;

  public GoodsChannel get(String id) {
    return super.get(id);
  }

  public List<GoodsChannel> findList(GoodsChannel goodsChannel) {
    return super.findList(goodsChannel);
  }

  public Page<GoodsChannel> findPage(Page<GoodsChannel> page, GoodsChannel goodsChannel) {
    return super.findPage(page, goodsChannel);
  }

  @Transactional(readOnly = false)
  public void save(GoodsChannel goodsChannel) {
    super.save(goodsChannel);
  }

  @Transactional(readOnly = false)
  public void delete(GoodsChannel goodsChannel) {
    super.delete(goodsChannel);
    goodsChannelDtlDao.deleteChannel(goodsChannel.getId());
  }
}
