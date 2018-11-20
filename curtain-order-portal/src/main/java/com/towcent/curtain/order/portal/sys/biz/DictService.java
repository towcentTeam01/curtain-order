package com.towcent.curtain.order.portal.sys.biz;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.portal.sys.vo.input.DictListIn;

/**
 * DictService
 * @author huangtao
 * @version 0.0.1
 */
public interface DictService {

	ResultVo list(DictListIn paramIn);
}