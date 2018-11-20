package com.towcent.curtain.order.web.config.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.config.entity.SysLogisticsCompanyMerchant;

/**
 * 商家物流配置DAO接口
 * @author HuangTao
 * @version 2018-07-11
 */
@MyBatisDao
public interface SysLogisticsCompanyMerchantDao extends CrudDao<SysLogisticsCompanyMerchant> {
	
}