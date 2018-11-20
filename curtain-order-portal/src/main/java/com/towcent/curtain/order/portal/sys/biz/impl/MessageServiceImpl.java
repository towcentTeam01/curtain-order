package com.towcent.curtain.order.portal.sys.biz.impl;

import static com.towcent.base.common.constants.BaseConstant.E_001;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.MessageMailVo;
import com.towcent.base.common.page.PaginationDto;
import com.towcent.base.common.page.SimplePageDto;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.curtain.order.portal.common.utils.UserUtils;
import com.towcent.curtain.order.portal.sys.biz.MessageService;
import com.towcent.curtain.order.portal.sys.vo.input.MessageListIn;
import com.towcent.curtain.order.portal.sys.vo.input.MessageReadIn;

/**
 * MessageServiceImpl
 * @author huangtao
 * @version 0.0.1
 */
@Service
public class MessageServiceImpl extends BasePortalService implements MessageService {
	
	@Resource
	private SysCommonApi sysCommonApi;
	
	@Override
	public ResultVo list(MessageListIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			SysFrontAccount account = UserUtils.getUserAccount(paramIn);
			SimplePageDto page = new SimplePageDto();
			page.setPageNo(paramIn.getPageNo());
			page.setPageSize(paramIn.getPageSize());
			PaginationDto<MessageMailVo> outPage = sysCommonApi.getMessageMailByPage(account.getId(), paramIn.getType(),
					paramIn.getAppType(), page); 
			resultVo.setData(outPage);
			resultVo.setErrorMessage("成功");
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		}
		return resultVo;
	}

	
	@Override
	public ResultVo read(MessageReadIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			sysCommonApi.readMessage(paramIn.getIds(), paramIn.getType());
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		}
		return resultVo;
	}
}