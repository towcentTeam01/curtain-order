package com.towcent.curtain.order.portal.sys.biz.impl;

import static com.towcent.base.common.constants.BaseConstant.E_001;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Lists;
import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SysArea;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.curtain.order.portal.sys.biz.AreaService;
import com.towcent.curtain.order.portal.sys.vo.input.AreaDescIn;
import com.towcent.curtain.order.portal.sys.vo.input.AreaListIn;
import com.towcent.curtain.order.portal.sys.vo.output.AreaDescOut;
import com.towcent.curtain.order.portal.sys.vo.output.AreaListOut;

/**
 * AreaServiceImpl
 * @author huangtao
 * @version 0.0.1
 */
@Service
public class AreaServiceImpl extends BasePortalService implements AreaService {
	
	@Resource 
	private SysCommonApi sysCommonApi;
	
	@Override
	public ResultVo list(AreaListIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			List<AreaListOut> list = Lists.newArrayList();
			
			List<SysArea> alist = sysCommonApi.getAreaListByParentId(paramIn.getParentId());
			if (!CollectionUtils.isEmpty(alist)) {
				AreaListOut out = null;
				for (SysArea sysArea : alist) {
					out = new AreaListOut();
					out.setId(sysArea.getId());
					out.setName(sysArea.getName());
					out.setParentId(sysArea.getParentId());
					out.setType(sysArea.getType());
					list.add(out);
				}
			}
			
			resultVo.setData(list);
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		} 
		return resultVo;
	}

	
	@Override
	public ResultVo desc(AreaDescIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			AreaDescOut outParam = new AreaDescOut();
			outParam.setDesc(
					sysCommonApi.getAreaDesc(paramIn.getProvinceId(), paramIn.getCityId(), paramIn.getAreaId()));
			resultVo.setData(outParam);
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		}
		return resultVo;
	}
}