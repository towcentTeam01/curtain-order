package com.towcent.curtain.order.portal.sys.biz;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.portal.sys.vo.input.AppFeedbackIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppTestFlagIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppValidateVersionIn;

/**
 * AppService
 * @author 
 * @version 0.0.2
 */
public interface AppService {

	ResultVo validateVersion(AppValidateVersionIn paramIn);

	ResultVo feedback(AppFeedbackIn paramIn);

	ResultVo testFlag(AppTestFlagIn paramIn);
}