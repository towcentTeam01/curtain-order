package com.towcent.curtain.order.portal.sys.biz;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.portal.sys.vo.input.AreaDescIn;
import com.towcent.curtain.order.portal.sys.vo.input.AreaListIn;

/**
 * AreaService
 * @author huangtao
 * @version 0.0.1
 */
public interface AreaService {

	ResultVo list(AreaListIn paramIn);

	ResultVo desc(AreaDescIn paramIn);
}