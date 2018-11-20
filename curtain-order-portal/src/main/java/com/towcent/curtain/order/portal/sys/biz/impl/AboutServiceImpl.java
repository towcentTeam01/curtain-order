package com.towcent.curtain.order.portal.sys.biz.impl;

import static com.towcent.base.common.constants.BaseConstant.E_001;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SysAbout;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.portal.sys.biz.AboutService;
import com.towcent.curtain.order.portal.sys.vo.input.AboutIn;
import com.towcent.curtain.order.portal.sys.vo.output.AboutOut;

/**
 * AboutServiceImpl
 *
 * @author licheng
 * @version 0.0.1
 */
@Service
public class AboutServiceImpl extends BasePortalService implements AboutService {
    
	@Resource
    private SysCommonApi sysCommonApi;

    @Override
    public ResultVo about(AboutIn paramIn) {
        ResultVo resultVo = new ResultVo();
        if (!validationObj(paramIn, resultVo)) {
            return resultVo;
        }
        try {
            AboutOut outParam = new AboutOut();
            SysAbout about = sysCommonApi.getSysAboutByType(Constant.APP_TYPE_0);
            if (about == null) {
                assemblyVo(resultVo, E_001, "失败");
            } else {
                BeanUtils.copyProperties(about, outParam);
            }
            resultVo.setData(outParam);
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "失败");
            logger.error("", e);
        }
        return resultVo;
    }
    
}