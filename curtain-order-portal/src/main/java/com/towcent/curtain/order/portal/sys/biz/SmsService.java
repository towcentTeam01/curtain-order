package com.towcent.curtain.order.portal.sys.biz;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.portal.sys.vo.input.SmsParamVo;
import com.towcent.curtain.order.portal.sys.vo.input.SmsSendParamVo;

/**
 * 客户端短信相关接口
 * 
 * @author huangtao
 *
 */
public interface SmsService {
	
	/**
	 * 校验短信验证码
	 * @param paramVo
	 * @return
	 */
	ResultVo verify(SmsParamVo paramVo);
	
	/**
	 * 校验短信验证码(需要登录状态可用)
	 * @param paramVo
	 * @return
	 */
	ResultVo verifyForLogin(SmsParamVo paramVo);
	
	/**
	 * 发送短信接口<br>
	 * 主要针对发<b>验证码</b>
	 * @param paramVo
	 * @return
	 */
	ResultVo send(SmsSendParamVo paramVo);
}