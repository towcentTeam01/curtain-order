package com.towcent.curtain.order.app.server.sys.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.sys.dao.SysUserRoleMapper;
import com.towcent.curtain.order.app.server.sys.service.SysUserRoleService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-18 12:29:59
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("sysUserRoleServiceImpl")
public class SysUserRoleServiceImpl extends BaseCrudServiceImpl implements SysUserRoleService {

    @Resource
    private SysUserRoleMapper sysUserRoleMapper;

    @Override
    public CrudMapper init() {
        return sysUserRoleMapper;
    }

}