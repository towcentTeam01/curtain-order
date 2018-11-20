package com.towcent.curtain.order.portal.sys.biz.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Lists;
import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SysDictDtl;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.manager.BaseCommonApi;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.portal.sys.biz.DictService;
import com.towcent.curtain.order.portal.sys.vo.input.DictListIn;
import com.towcent.curtain.order.portal.sys.vo.output.DictListOut;

/**
 * DictServiceImpl
 * @author huangtao
 * @version 0.0.1
 */
@Service
public class DictServiceImpl extends BasePortalService implements DictService {
	
	@Resource 
	private BaseCommonApi commonApi;
	
	@Override
	public ResultVo list(DictListIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			List<DictListOut> list = Lists.newArrayList();
			List<SysDictDtl> slist = commonApi.getDictListByKey(paramIn.getMerchantId(), paramIn.getKey());
			if (!CollectionUtils.isEmpty(slist)) {
				DictListOut out = null;
				for (SysDictDtl sysDictDtl : slist) {
					out = new DictListOut();
					out.setCode(sysDictDtl.getCode());
					out.setName(sysDictDtl.getName());
					list.add(out);
				}
			}
			resultVo.setData(list);
		} catch (RpcException e) {
			assemblyVo(resultVo, Constant.E_001, "失败");
			logger.error("", e);
		} 
		return resultVo;
	}
}