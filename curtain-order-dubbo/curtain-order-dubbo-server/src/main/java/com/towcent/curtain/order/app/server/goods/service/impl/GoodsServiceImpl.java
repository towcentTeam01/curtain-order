package com.towcent.curtain.order.app.server.goods.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.goods.dao.GoodsMapper;
import com.towcent.curtain.order.app.server.goods.service.GoodsService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 16:03:54
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("goodsServiceImpl")
public class GoodsServiceImpl extends BaseCrudServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;

    @Override
    public CrudMapper init() {
        return goodsMapper;
    }

}