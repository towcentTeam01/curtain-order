package com.towcent.curtain.order.web.sys.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;

/**
 * 商户管理DAO接口
 * @author Huangtao
 * @version 2018-08-03
 */
@MyBatisDao
public interface SysMerchantInfoDao extends CrudDao<SysMerchantInfo> {
	
}