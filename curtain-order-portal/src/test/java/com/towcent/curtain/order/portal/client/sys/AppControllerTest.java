package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.AppFeedbackIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppTestFlagIn;
import com.towcent.curtain.order.portal.sys.vo.input.AppValidateVersionIn;

public class AppControllerTest extends BaseAppTest {

	static {
		descMap.put("sys/app/feedback", "意见反馈");
		descMap.put("sys/app/version", "1.3.1 验证App版本信息");
		descMap.put("sys/env/testFlag", "测试环境判断接口");
	}
	
	@Test
	public void validateVersion() throws IOException {
		String path = "sys/app/version";
		AppValidateVersionIn paramVo = new AppValidateVersionIn();
		this.setCommonParam(paramVo);
		paramVo.setCurrentVersion(1);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	

	@Test
	public void feedback() throws IOException {
		String path = "sys/app/feedback";
		AppFeedbackIn paramVo = new AppFeedbackIn();
		this.setCommonParam(paramVo);
		paramVo.setType("");
		paramVo.setAppVersion("");
		paramVo.setImages("");
		paramVo.setContent("");
		paramVo.setContactInfo("");
		this.setLoginFlag(paramVo);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	
	@Test
	public void testFlag() throws IOException {
		String path = "sys/env/testFlag";
		AppTestFlagIn paramVo = new AppTestFlagIn();
		this.setCommonParam(paramVo);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}