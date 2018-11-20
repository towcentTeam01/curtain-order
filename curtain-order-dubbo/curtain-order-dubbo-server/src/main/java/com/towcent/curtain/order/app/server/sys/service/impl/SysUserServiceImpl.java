package com.towcent.curtain.order.app.server.sys.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.sys.dao.SysUserMapper;
import com.towcent.curtain.order.app.server.sys.service.SysUserService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 22:15:35
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("sysUserServiceImpl")
public class SysUserServiceImpl extends BaseCrudServiceImpl implements SysUserService {

    @Resource
    private SysUserMapper sysUserMapper;

    @Override
    public CrudMapper init() {
        return sysUserMapper;
    }

}