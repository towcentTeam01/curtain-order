package com.towcent.curtain.order.app.server.sys.service.impl;

import static com.towcent.curtain.order.common.Constant.ID;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Maps;
import com.towcent.base.common.exception.ServiceException;
import com.towcent.base.dal.db.CrudMapper;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.server.sys.dao.SysFrontAccountMapper;
import com.towcent.curtain.order.app.server.sys.service.SysFrontAccountService;
import com.towcent.base.service.impl.BaseCrudServiceImpl;

/**
 * 
 * @author huangtao
 * @date 2017-12-28 10:33:12
 * @version 1.0
 * @copyright facegarden.com
 */
@Service("sysFrontAccountServiceImpl")
public class SysFrontAccountServiceImpl extends BaseCrudServiceImpl implements SysFrontAccountService {

    @Resource
    private SysFrontAccountMapper sysFrontAccountMapper;
    
    @Override
    public CrudMapper init() {
        return sysFrontAccountMapper;
    }
    
    @Override
    public SysFrontAccount getAccountByParams(Map<String, Object> params) throws ServiceException {
		List<SysFrontAccount> list = this.findByBiz(params);
		SysFrontAccount account = CollectionUtils.isEmpty(list) ? null : list.get(0); 
		return account;
    }
    
    @Override
    public SysFrontAccount getAccountById(Integer id) throws ServiceException {
    	Map<String, Object> params = Maps.newHashMap();
		params.put(ID, id);
		// TODO Redis缓存
		return this.getAccountByParams(params);
    }
    
}