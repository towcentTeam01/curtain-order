package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.SmsService;
import com.towcent.curtain.order.portal.sys.vo.input.SmsParamVo;
import com.towcent.curtain.order.portal.sys.vo.input.SmsSendParamVo;

/**
 * 客户端短信接口
 * 
 * @author huangtao
 *
 */
@RequestMapping(value = "sys/sms", method = RequestMethod.POST)
@RestController
public class SmsController extends BaseController {
	
	@Resource SmsService smsService;
	
	@RequestMapping(value = "verify") @Loggable
	public ResultVo verify(@RequestBody SmsParamVo paramVo) {
		return smsService.verify(paramVo);
	}
	
	@RequestMapping(value = "login/verify") @Loggable
	public ResultVo verifyForLogin(@RequestBody SmsParamVo paramVo) {
		return smsService.verifyForLogin(paramVo);
	}
	
	@RequestMapping(value = "send") @Loggable
	public ResultVo send(@RequestBody SmsSendParamVo paramVo) {
		return smsService.send(paramVo);
	}
}