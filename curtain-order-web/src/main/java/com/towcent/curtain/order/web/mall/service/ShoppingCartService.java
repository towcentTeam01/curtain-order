package com.towcent.curtain.order.web.mall.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;
import com.towcent.curtain.order.web.mall.dao.ShoppingCartDao;

/**
 * 购物车Service
 * @author yxp
 * @version 2018-10-17
 */
@Service
@Transactional(readOnly = true)
public class ShoppingCartService extends CrudService<ShoppingCartDao, ShoppingCart> {

	public ShoppingCart get(String id) {
		return super.get(id);
	}
	
	public List<ShoppingCart> findList(ShoppingCart shoppingCart) {
		return super.findList(shoppingCart);
	}
	
	public Page<ShoppingCart> findPage(Page<ShoppingCart> page, ShoppingCart shoppingCart) {
		return super.findPage(page, shoppingCart);
	}
	
	@Transactional(readOnly = false)
	public void save(ShoppingCart shoppingCart) {
		super.save(shoppingCart);
	}
	
	@Transactional(readOnly = false)
	public void delete(ShoppingCart shoppingCart) {
		super.delete(shoppingCart);
	}


}