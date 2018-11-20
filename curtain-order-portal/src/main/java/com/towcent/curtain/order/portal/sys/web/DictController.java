package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.DictService;
import com.towcent.curtain.order.portal.sys.vo.input.DictListIn;

/**
 * DictController
 * @author huangtao
 * @version 0.0.1
 */
@RestController
@RequestMapping(value = "sys/dict", method = RequestMethod.POST)
public class DictController extends BaseController {

	@Resource
	private DictService dictService;

	// 1.5.1 数据字典接口
	@RequestMapping(value = "list") @Loggable
	public ResultVo list(@RequestBody DictListIn paramIn) {
		return dictService.list(paramIn);
	}
}