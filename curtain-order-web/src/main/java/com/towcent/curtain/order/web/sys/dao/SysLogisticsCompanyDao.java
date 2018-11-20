package com.towcent.curtain.order.web.sys.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.sys.entity.SysLogisticsCompany;

/**
 * 系统物流公司DAO接口
 * @author HuangTao
 * @version 2018-07-11
 */
@MyBatisDao
public interface SysLogisticsCompanyDao extends CrudDao<SysLogisticsCompany> {
	
}