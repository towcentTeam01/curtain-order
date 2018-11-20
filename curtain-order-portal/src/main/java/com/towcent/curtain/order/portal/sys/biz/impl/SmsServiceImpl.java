package com.towcent.curtain.order.portal.sys.biz.impl;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.E_001;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SmsParamDto;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.manager.SmsNotifyApi;
import com.towcent.curtain.order.portal.sys.biz.SmsService;
import com.towcent.curtain.order.portal.sys.vo.input.SmsParamVo;
import com.towcent.curtain.order.portal.sys.vo.input.SmsSendParamVo;

@Service
public class SmsServiceImpl extends BasePortalService implements SmsService {
	
	@Resource SmsNotifyApi notifyApi;
	
	@Override
	public ResultVo verify(SmsParamVo paramVo) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramVo, resultVo)) {
			return resultVo;
		}
		// TODO 继续对短信类型做校验
		
		try {
			boolean result = notifyApi.verifySmsCode(transformDto(paramVo));
			if (result) {
				assemblyVo(resultVo, E_000, "成功");
			} else {
				assemblyVo(resultVo, E_001, "失败");
			}
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "验证失败");
			logger.error("", e);
		}
		
		return resultVo;
	}
	
	@Override
	public ResultVo verifyForLogin(SmsParamVo paramVo) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramVo, resultVo)) {
			return resultVo;
		}
		// TODO 继续对短信类型做校验
		
		try {
			boolean result = notifyApi.verifySmsCode(transformDto(paramVo));
			if (result) {
				assemblyVo(resultVo, E_000, "成功");
			} else {
				assemblyVo(resultVo, E_001, "失败");
			}
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "验证失败");
			logger.error("", e);
		}
		
		return resultVo;
	}
	
	private SmsParamDto transformDto(SmsParamVo paramVo) {
		SmsParamDto dto = new SmsParamDto();
		dto.setMobile(paramVo.getPhone());
		dto.setSmsType(paramVo.getType());
		dto.setSecurityCode(paramVo.getSecurityCode());
		return dto;
	}
	
	@Override
	public ResultVo send(SmsSendParamVo paramVo) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramVo, resultVo)) {
			return resultVo;
		}
		try {
			SmsParamDto param = new SmsParamDto(paramVo.getPhone(), paramVo.getType());
			boolean result = notifyApi.sendSms(param);
			if (result) {
				assemblyVo(resultVo, E_000, "发送成功");
			} else {
				assemblyVo(resultVo, E_001, "发送失败");
			}
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "发送失败");
			logger.error("", e);
		}
		return resultVo;
	}
}