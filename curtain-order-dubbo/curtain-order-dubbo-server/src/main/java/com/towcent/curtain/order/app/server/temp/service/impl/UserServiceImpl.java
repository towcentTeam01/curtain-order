package com.towcent.curtain.order.app.server.temp.service.impl;

import com.towcent.base.dal.db.CrudMapper;
import com.towcent.base.service.impl.BaseCrudServiceImpl;
import com.towcent.curtain.order.app.server.temp.dao.UserMapper;
import com.towcent.curtain.order.app.server.temp.service.UserService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * 
 * @author huangtao
 * @date 2018-07-15 21:56:13
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("userServiceImpl")
public class UserServiceImpl extends BaseCrudServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public CrudMapper init() {
        return userMapper;
    }

}