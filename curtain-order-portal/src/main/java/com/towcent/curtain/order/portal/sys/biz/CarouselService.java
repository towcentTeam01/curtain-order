package com.towcent.curtain.order.portal.sys.biz;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.portal.sys.vo.input.CarouselListIn;

/**
 * CarouselService
 * @author licheng
 * @version 0.0.1
 */
public interface CarouselService {

	ResultVo list(CarouselListIn paramIn);
}