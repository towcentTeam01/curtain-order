package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.AppService;
import com.towcent.curtain.order.portal.sys.vo.input.AppFeedbackIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppTestFlagIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppValidateVersionIn;

/**
 * AppController
 * @author 
 * @version 0.0.2
 */
@RestController
@RequestMapping(value = "sys/app", method = RequestMethod.POST)
public class AppController extends BaseController {

	@Resource
	private AppService appService;

	// 1.3.1 验证App版本信息
	@RequestMapping(value = "version") @Loggable
	public ResultVo validateVersion(@RequestBody AppValidateVersionIn paramIn) {
		return appService.validateVersion(paramIn);
	}

	// 1.6.1 意见反馈
	@RequestMapping(value = "feedback") @Loggable
	public ResultVo feedback(@RequestBody AppFeedbackIn paramIn) {
		return appService.feedback(paramIn);
	}

	// 1.8.1 测试环境判断接口
	@RequestMapping(value = "testFlag") @Loggable
	public ResultVo testFlag(@RequestBody AppTestFlagIn paramIn) {
		return appService.testFlag(paramIn);
	}
}