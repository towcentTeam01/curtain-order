package com.towcent.curtain.order.app.server.sys.service;

import java.util.Map;

import com.towcent.base.common.exception.ServiceException;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.base.service.BaseCrudService;

/**
 * sys_front_account 数据库操作Service接口
 * 
 * @author huangtao
 * @date 2017-12-28 10:33:12
 * @version 1.0
 * @copyright facegarden.com
 */
public interface SysFrontAccountService extends BaseCrudService {
	
	/**
	 * 通过参数查询账户对象.
	 * @Title getAccountByParams
	 * @param params
	 * @return
	 * @throws ServiceException
	 */
	SysFrontAccount getAccountByParams(Map<String, Object> params) throws ServiceException;
	
	/**
	 * 通过参数查询账户对象.
	 * @Title getAccountById
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	SysFrontAccount getAccountById(Integer id) throws ServiceException;
		
    
}