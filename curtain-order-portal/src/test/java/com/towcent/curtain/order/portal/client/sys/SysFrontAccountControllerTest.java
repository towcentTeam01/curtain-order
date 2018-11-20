package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.base.common.utils.Md5Utils;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountLoginIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountFastLoginIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountResetIn;


public class SysFrontAccountControllerTest extends BaseAppTest {

	static {
		descMap.put("member/memberAccount/login", "登录接口");
		descMap.put("member/memberAccount/fastLogin", "快捷登录接口");
		descMap.put("member/memberAccount/reset", "重置密码接口");

	}

	@Test
	public void login() throws IOException {
		String path = "member/memberAccount/login";
		MemberAccountLoginIn paramVo = new MemberAccountLoginIn();
		this.setCommonParam(paramVo);
		paramVo.setAccount(ACCOUNT);
		paramVo.setPassword(Md5Utils.encryption(PASSWD));
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	
	@Test
	public void fastLogin() throws IOException {		
		String path = "member/memberAccount/fastLogin";
		MemberAccountFastLoginIn paramVo = new MemberAccountFastLoginIn();
		this.setCommonParam(paramVo);
		paramVo.setAccount(ACCOUNT);
		// 模拟获取短信验证码
		String securityCode = this.simulationSendSms(paramVo.getAccount(), Constant.SMS_TYPE_2);
		paramVo.setSecurityCode(securityCode);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}

	@Test
	public void reset() throws IOException {
		String path = "member/memberAccount/reset";
		MemberAccountResetIn paramVo = new MemberAccountResetIn();
		this.setCommonParam(paramVo);
		paramVo.setPhone("18777694578");
		paramVo.setPassword("123456");
		String securityCode = simulationSendSms(paramVo.getPhone(), Constant.SMS_TYPE_3);
		paramVo.setSecurityCode(securityCode);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}