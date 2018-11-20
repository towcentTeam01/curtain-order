package com.towcent.curtain.order.app.server.sys.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.sys.dao.SysUserMerchantMapper;
import com.towcent.curtain.order.app.server.sys.service.SysUserMerchantService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 15:04:18
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("sysUserMerchantServiceImpl")
public class SysUserMerchantServiceImpl extends BaseCrudServiceImpl implements SysUserMerchantService {

    @Resource
    private SysUserMerchantMapper sysUserMerchantMapper;

    @Override
    public CrudMapper init() {
        return sysUserMerchantMapper;
    }

}