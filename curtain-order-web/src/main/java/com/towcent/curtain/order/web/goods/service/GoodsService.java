package com.towcent.curtain.order.web.goods.service;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.goods.dao.GoodsDao;
import org.springframework.util.CollectionUtils;

/**
 * 商品Service
 *
 * @author Huangtao
 * @version 2018-07-15
 */
@Service
@Transactional(readOnly = true)
public class GoodsService extends CrudService<GoodsDao, Goods> {

    public Goods get(String id) {
        Goods entity = super.get(id);
        if (null != entity) {
            if (StringUtils.isNotBlank(entity.getMainUrls())) {
                String[] imgs = StringUtils.split(entity.getMainUrls(), ";");
                entity.setGoodsPicUrl(imgs[0]);
                entity.setGoodsImgList(Arrays.asList(imgs));
            }
        }
        return entity;
    }

    public List<Goods> findList(Goods goods) {
        return super.findList(goods);
    }

    public Page<Goods> findPage(Page<Goods> page, Goods goods) {
        Page<Goods> p = super.findPage(page, goods);
        if (null != p && !CollectionUtils.isEmpty(p.getList())) {
            for (Goods entity : p.getList()) {
                if (StringUtils.isNotBlank(entity.getMainUrls())) {
                    String[] imgs = StringUtils.split(entity.getMainUrls(), ";");
                    entity.setGoodsPicUrl(imgs[0].replaceAll(".jpg", "_300.jpg"));
                }
            }
        }
        return p;
    }

    @Transactional(readOnly = false)
    public void save(Goods goods) {
        super.save(goods);
    }

    @Transactional(readOnly = false)
    public void delete(Goods goods) {
        super.delete(goods);
    }

}