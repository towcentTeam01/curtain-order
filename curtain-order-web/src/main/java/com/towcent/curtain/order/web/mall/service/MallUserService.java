package com.towcent.curtain.order.web.mall.service;

import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.base.sc.web.modules.sys.dao.UserDao;
import com.towcent.base.sc.web.modules.sys.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 购物车Service
 * @author yxp
 * @version 2018-10-17
 */
@Service
@Transactional(readOnly = true)
public class MallUserService extends CrudService<UserDao, User> {

	@Autowired
	private UserDao userDao;

	public List<User> findUser(User user) {
		List<User> list = this.userDao.findList(user);
		return list;
	}


}