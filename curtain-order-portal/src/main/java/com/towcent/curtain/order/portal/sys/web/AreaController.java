package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.AreaService;
import com.towcent.curtain.order.portal.sys.vo.input.AreaDescIn;
import com.towcent.curtain.order.portal.sys.vo.input.AreaListIn;

/**
 * AreaController
 * @author huangtao
 * @version 0.0.1
 */
@RestController
@RequestMapping(value = "sys/area", method = RequestMethod.POST)
public class AreaController extends BaseController {

	@Resource
	private AreaService areaService;

	// 1.2.1 地址列表
	@RequestMapping(value = "list") @Loggable
	public ResultVo list(@RequestBody AreaListIn paramIn) {
		return areaService.list(paramIn);
	}

	// 1.2.2 获取地址名称
	@RequestMapping(value = "desc") @Loggable
	public ResultVo desc(@RequestBody AreaDescIn paramIn) {
		return areaService.desc(paramIn);
	}
}