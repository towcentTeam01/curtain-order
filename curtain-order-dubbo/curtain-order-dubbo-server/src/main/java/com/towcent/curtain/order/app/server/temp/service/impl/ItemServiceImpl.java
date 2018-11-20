package com.towcent.curtain.order.app.server.temp.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.temp.dao.ItemMapper;
import com.towcent.curtain.order.app.server.temp.service.ItemService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 16:01:32
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("itemServiceImpl")
public class ItemServiceImpl extends BaseCrudServiceImpl implements ItemService {

    @Resource
    private ItemMapper itemMapper;

    @Override
    public CrudMapper init() {
        return itemMapper;
    }

}