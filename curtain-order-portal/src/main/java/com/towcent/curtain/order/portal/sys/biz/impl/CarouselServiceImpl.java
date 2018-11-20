package com.towcent.curtain.order.portal.sys.biz.impl;


import static com.towcent.base.common.constants.BaseConstant.E_001;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Service;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SysCarouselConf;
import com.towcent.base.common.model.SysDictDtl;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.manager.BaseCommonApi;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.curtain.order.portal.sys.biz.CarouselService;
import com.towcent.curtain.order.portal.sys.vo.input.CarouselListIn;
import com.towcent.curtain.order.portal.sys.vo.output.CarouselListOut;

/**
 * CarouselServiceImpl
 *
 * @author licheng
 * @version 0.0.1
 */
@Service
public class CarouselServiceImpl extends BasePortalService implements CarouselService {
    @Resource
    private SysCommonApi sysCommonApi;
    @Resource
    private BaseCommonApi baseCommonApi;

    @Override
    public ResultVo list(CarouselListIn paramIn) {
        ResultVo resultVo = new ResultVo();
        if (!validationObj(paramIn, resultVo)) {
            return resultVo;
        }
        try {
            List<CarouselListOut> res = new ArrayList<>();
            CarouselListOut item;
            List<SysCarouselConf> list = sysCommonApi.getCarouselList(paramIn.getCarouselType());
            if (list != null) {
                for (SysCarouselConf sysCarouselConf : list) {
                    item = new CarouselListOut();
                    item.setTitle(sysCarouselConf.getTitle());
                    item.setCarouselType(sysCarouselConf.getCarouselType());
                    item.setCarouselTypeDesc(getCarouselTypeDesc(paramIn.getMerchantId(), sysCarouselConf.getCarouselType()));
                    item.setIsHref(sysCarouselConf.getIsHref());
                    item.setTargetUrl(sysCarouselConf.getTargetUrl());
                    item.setUrl(sysCarouselConf.getUrl());
                    item.setRemark(sysCarouselConf.getRemark());
                    res.add(item);
                }
            }
            resultVo.setData(res);
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "失败");
            logger.error("", e);
        }
        return resultVo;
    }

    private String getCarouselTypeDesc(Integer merchantId, String carouselType) throws RpcException {
        Map<String, SysDictDtl> dictMap = baseCommonApi.getDictMapByKey(merchantId, "carousel_type");
        SysDictDtl dtl = (SysDictDtl) MapUtils.getObject(dictMap, carouselType);
        return dtl != null ? dtl.getName() : "";
    }
}