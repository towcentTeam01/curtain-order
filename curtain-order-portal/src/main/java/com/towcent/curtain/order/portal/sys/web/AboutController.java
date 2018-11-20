package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.AboutService;
import com.towcent.curtain.order.portal.sys.vo.input.AboutIn;

/**
 * AboutController
 * @author licheng
 * @version 0.0.1
 */
@RestController
@RequestMapping(value = "sys/app", method = RequestMethod.POST)
public class AboutController extends BaseController {

	@Resource
	private AboutService aboutService;

	// 1.0.1 承运商APP关于我们
	@RequestMapping(value = "about") @Loggable
	public ResultVo about(@RequestBody AboutIn paramIn) {
		return aboutService.about(paramIn);
	}
}