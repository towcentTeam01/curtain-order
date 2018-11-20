package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.AboutIn;

public class AboutControllerTest extends BaseAppTest {

	static {
		descMap.put("sys/app/about", "APP关于我们");

	}


	@Test
	public void about() throws IOException {
		String path = "sys/app/about";
		AboutIn paramVo = new AboutIn();
		this.setCommonParam(paramVo);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}