package com.towcent.curtain.order.app.server.sys.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.sys.dao.ConsigneeAddrMapper;
import com.towcent.curtain.order.app.server.sys.service.ConsigneeAddrService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 12:50:47
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("consigneeAddrServiceImpl")
public class ConsigneeAddrServiceImpl extends BaseCrudServiceImpl implements ConsigneeAddrService {

    @Resource
    private ConsigneeAddrMapper consigneeAddrMapper;

    @Override
    public CrudMapper init() {
        return consigneeAddrMapper;
    }

}