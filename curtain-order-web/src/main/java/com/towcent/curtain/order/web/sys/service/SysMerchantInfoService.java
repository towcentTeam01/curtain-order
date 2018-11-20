package com.towcent.curtain.order.web.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.dao.SysMerchantInfoDao;
import org.springframework.util.CollectionUtils;

/**
 * 商户管理Service
 *
 * @author Huangtao
 * @version 2018-08-03
 */
@Service
@Transactional(readOnly = true)
public class SysMerchantInfoService extends CrudService<SysMerchantInfoDao, SysMerchantInfo> {

    public SysMerchantInfo get(String id) {
        return super.get(id);
    }

    public List<SysMerchantInfo> findList(SysMerchantInfo sysMerchantInfo) {
        return super.findList(sysMerchantInfo);
    }

    public Page<SysMerchantInfo> findPage(Page<SysMerchantInfo> page, SysMerchantInfo sysMerchantInfo) {
        return super.findPage(page, sysMerchantInfo);
    }

    @Transactional(readOnly = false)
    public void save(SysMerchantInfo sysMerchantInfo) {
        super.save(sysMerchantInfo);
    }

    @Transactional(readOnly = false)
    public void delete(SysMerchantInfo sysMerchantInfo) {
        super.delete(sysMerchantInfo);
    }

    public SysMerchantInfo getMerchantInfo(String key) {
        SysMerchantInfo sysMerchantInfo = new SysMerchantInfo();
        sysMerchantInfo.setQrCode(key);
        List<SysMerchantInfo> list = super.findList(sysMerchantInfo);
        return CollectionUtils.isEmpty(list) ? null : list.get(0);
    }

    public String getMerchantId(String key) {
        SysMerchantInfo sysMerchantInfo = getMerchantInfo(key);
        return null != sysMerchantInfo ? sysMerchantInfo.getId() : null;
    }

}