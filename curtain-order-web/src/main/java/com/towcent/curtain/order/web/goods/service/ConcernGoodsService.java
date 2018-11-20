package com.towcent.curtain.order.web.goods.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.goods.entity.ConcernGoods;
import com.towcent.curtain.order.web.goods.dao.ConcernGoodsDao;

/**
 * 关注商品Service
 * @author HuangTao
 * @version 2018-07-19
 */
@Service
@Transactional(readOnly = true)
public class ConcernGoodsService extends CrudService<ConcernGoodsDao, ConcernGoods> {

	public ConcernGoods get(String id) {
		return super.get(id);
	}
	
	public List<ConcernGoods> findList(ConcernGoods concernGoods) {
		return super.findList(concernGoods);
	}
	
	public Page<ConcernGoods> findPage(Page<ConcernGoods> page, ConcernGoods concernGoods) {
		return super.findPage(page, concernGoods);
	}
	
	@Transactional(readOnly = false)
	public void save(ConcernGoods concernGoods) {
		super.save(concernGoods);
	}
	
	@Transactional(readOnly = false)
	public void delete(ConcernGoods concernGoods) {
		super.delete(concernGoods);
	}
	
}