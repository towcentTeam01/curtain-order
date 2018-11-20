package com.towcent.curtain.order.web.sys.dao;

import com.towcent.base.sc.web.common.persistence.CrudDao;
import com.towcent.base.common.annotation.MyBatisDao;
import com.towcent.curtain.order.web.sys.entity.SysUserMerchantRel;

/**
 * 商户用户关系DAO接口
 * @author HuangTao
 * @version 2018-08-03
 */
@MyBatisDao
public interface SysUserMerchantRelDao extends CrudDao<SysUserMerchantRel> {
	
}