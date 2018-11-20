package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.CarouselService;
import com.towcent.curtain.order.portal.sys.vo.input.CarouselListIn;

/**
 * CarouselController
 * @author licheng
 * @version 0.0.1
 */
@RestController
@RequestMapping(value = "sys/carousel", method = RequestMethod.POST)
public class CarouselController extends BaseController {

	@Resource
	private CarouselService carouselService;

	// 1.9.1 获取轮播图列表
	@RequestMapping(value = "list") @Loggable
	public ResultVo list(@RequestBody CarouselListIn paramIn) {
		return carouselService.list(paramIn);
	}
}