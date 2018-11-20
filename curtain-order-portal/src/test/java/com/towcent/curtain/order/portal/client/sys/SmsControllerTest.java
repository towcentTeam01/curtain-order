package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.SmsParamVo;
import com.towcent.curtain.order.portal.sys.vo.input.SmsSendParamVo;

public class SmsControllerTest extends BaseAppTest {

	static {
		descMap.put("sample/user/login", "模拟用户登录");
		descMap.put("sample/sms/verify", "3.8.2短信码验证接口(不需要登录)");
		descMap.put("sample/sms/login/verify", "3.8.3短信码验证接口(需要登录)");
		descMap.put("sample/sms/send", "3.6.27发送验证码");
	}
	
	@Test
	public void verify() throws IOException {
		String path = "sample/sms/verify";
		SmsParamVo paramVo = new SmsParamVo();
		this.setCommonParam(paramVo);
		paramVo.setPhone("18666296035");
		paramVo.setType((byte) 1);  // 1:用户注册 2:忘记密码 
		paramVo.setSecurityCode("4214");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	
	@Test
	public void verifyForLogin() throws IOException {
		String path = "sample/sms/login/verify";
		SmsParamVo paramVo = new SmsParamVo();
		this.setCommonParam(paramVo);
		this.setLoginFlag(paramVo);
		paramVo.setPhone("13640919463");
		paramVo.setType((byte) 4);  // 4:修改支付密码
		paramVo.setSecurityCode("0309");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	
	@Test
	public void send() throws IOException {
		String path = "sample/sms/send";
		SmsSendParamVo paramVo = new SmsSendParamVo();
		this.setCommonParam(paramVo);
		paramVo.setPhone("15814658588");
		paramVo.setType((byte) 1);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}